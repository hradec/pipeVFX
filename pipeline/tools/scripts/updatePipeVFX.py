#!/bin/python3
# ==============================================================================
#
# nightwatch 0.0.5
#
#		monitors folder and subfolders using kernel inotify and uses
# 		rsync to update the modified/created files in
# 		other folders/hosts
#
#		if the folder has a .gitignore file, it will use to avoid syncing
#		files the same way got does.
#
# ==============================================================================


# ==============================================================================
# CONFIGURATION SECTION
# ==============================================================================
# the path to monitor
path="/mnt/nvme/nfs-pool/dev/pipevfx-atomo-git/"
# folders/hosts to sync to
hosts = [
	'root@10.144.0.10:/root/dev/pipevfx-git/',
	'root@10.144.0.10:/frankbarton/jobs/9990.rnd/shots/rnd/users/rhradec/pipevfx-git/',
	'root@192.168.0.196:/root/dev/pipevfx-atomo-git/',
	'root@192.168.0.16:/BTRFS10TB/dev/pipevfx-atomo-git/',
	'/ST16TB/fedora_frankbarton_devteam/pipevfx/',
]
# the rsync command used to sync up
rsync = "rsync -avpP --no-perms --no-owner --no-group %s %s %s & "
# the rsync command used to sync up using pipe (not working)
rsync_pipe = "rsync -avpP --no-perms --no-owner --no-group --files-from=%s / %s"
# exclude these files/folders at startup, when the first rsync runs (besides what's in .gitignore)
exclude_first_sync = ['.git','licenses', '/apps', 'wxmaya', 'mayaLibrary', '.mayaSwatches', 'hosts', 'tags', 'init']
# ignore syncing these files/folders at runtime (besides what's in .gitignore)
exclude_runtime = ['versions.py', 'licenses.py', 'job_config.py','*pipeline/tools/init/*']
# ==============================================================================

import os, sys
import fnmatch
import hashlib
import subprocess
import string
import random
try:
	from inotifyrecursive import INotify, flags
except:
	os.system("/bin/python3 -m pip install --upgrade inotifyrecursive")
	sys.exit(0)

if len(sys.argv) > 1:
	path = sys.argv[1]

path = path.rstrip('/')
print(path)

class nightwatch:
	''' it watches a folder, and when a file is modified it automatically calls rsync to sync the file to the list of hosts! '''
	BS = '\033[1D'
	HEADER = '\033[95m'
	BLUE = '\033[1;34m'
	BLUE_DARK = '\033[0;34m'
	GREEN = '\033[1;32m'
	GREEN_DARK = '\033[0;32m'
	WARNING = '\033[1;33m'
	WARNING_DARK = '\033[0;33m'
	RED = FAIL = '\033[1;31m'
	FAIL_DARK = '\033[0;31m'
	END = '\033[0m'
	BOLD = '\033[1m'
	def __init__(self, path, exclude_first_sync = exclude_first_sync, exclude_runtime=exclude_runtime, pipe=False):
		self.path = path
		self.inotify = INotify()
		self.hashCache = {}
		self.popen = {}
		self.pipe = pipe
		self.fifo = None
		self.FIFO = {}
		self.FIFOstream = {}
		watch_flags = 	flags.CREATE | \
				flags.DELETE | \
				flags.MODIFY | \
				flags.DELETE_SELF

		# reads .gitignore if one exists at path
		gitignore = [ '.git' ]
		if os.path.exists(self.path+'/.gitignore'):
			gitignore += [ x.strip() for x in open(self.path+'/.gitignore','r').readlines() if '#' not in x.strip() ]

		# initial update
		print( "does a initial update, to garantee all is in sync from the beginning..." )
		self.updateHosts( self.path, rsync_extra=''.join([ ' --exclude "%s" ' % x for x in gitignore+exclude_first_sync]) )

		# the filter function called by add_watch_recursive
		# to filter what to monitor
		def filter(basename, parent, boolean):
			''' add_watch_recursive calls this function to know what to watch
			this function ignores wildcards that are in .gitignore '''
			ret = True
			if parent != -1:
				name = '/'.join([ self.inotify.get_path(parent), basename ])
				name = name.split(self.path)[-1].lstrip('/')
				for pattern in gitignore+exclude_runtime:
					if '/' in pattern:
						if fnmatch.fnmatch( name, pattern ):
							ret = False
							break
					else:
						if fnmatch.fnmatch( basename, pattern ):
							ret = False
							break
			# if not ret:
			# 	print(name)
			return ret
		wd = self.inotify.add_watch_recursive(self.path, watch_flags, filter)
		print("finished setup watcher.")

	def hash(self, file):
		''' calculate a md5 hash for a give file.
		used everytime a file change is detected, to keep track if the
		file actually changed or it's just the same content'''
		return hashlib.md5(open(file,'rb').read()).hexdigest()

	def run(self):
		''' the main loop!
		it calls self.updateHosts when a file is modified/created'''
		while True:
			for event in self.inotify.read(read_delay=10):
				file = '/'.join([ self.inotify.get_path(event.wd), event.name ])
				for flag in flags.from_mask(event.mask):
					# print('    ' + str(flag))
					if flag not in [flags.DELETE, flags.DELETE_SELF]:
						self.updateHosts(file)
					else:
						print(event, [ str(x) for x in flags.from_mask(event.mask) ], file)
						# TODO: delete
						pass

	def updateHosts(self, file, rsync_extra=''):
		''' rsync files that are changed, on the fly
		called by self.run and by init for the initial sync up'''
		if os.path.isdir( file ):
			for host in hosts:
				cmd = rsync % ( rsync_extra, file.rstrip('/')+'/', host.rstrip('/')+'/'+file.split(self.path)[-1].strip('/')+'/' )
				print( '\t'+self.WARNING+cmd+self.END )
				sys.stdout.flush()
				os.system( cmd )
		else:
			file_hash = self.hash(file)
			# check and cache md5 of the file, so we update just once.
			if file not in self.hashCache or file_hash != self.hashCache[file]:
				self.hashCache[file] = file_hash
				print(self.RED+file_hash+self.END)
				for host in hosts:
					if self.pipe:
						self.rsync_send_file(file)
					else:
						cmd = rsync % ( rsync_extra, file, host.rstrip('/')+'/'+file.split(self.path)[-1].lstrip('/') )
						print( '\t'+self.WARNING+cmd+self.END )
						sys.stdout.flush()
						os.system( cmd )
			else:
				print(self.GREEN+file_hash+self.END)


	# ==========================================================================
	# WIP - not working
	# keep a connection open with hosts so file copy is almost instantaneous.
	# ==========================================================================
	def rsync_pipe_create(self):
		''' a first draft of using fifo to send files on an live rsync connection
		doesnt work!! '''
		if self.pipe and not self.fifo:
			for host in hosts:
				if host not in self.popen or self.popen[host].poll()!=None:
					letters = string.ascii_uppercase
					tmp = ''.join(random.choice(letters) for i in range(10))
					self.FIFO[host] = '/dev/shm/%s' % tmp
					os.system('rm -rf %s' % self.FIFO[host])
					os.mkfifo(self.FIFO[host])

					cmd = rsync_pipe % (self.FIFO[host], host)
					self.popen[host] = subprocess.Popen( cmd.split(), stdin=subprocess.PIPE )


					print( 'start rsync:', host, self.popen[host].poll() )

	def rsync_send_file(self, file):
		''' send a file by writing to a fifo pipe, and another process will
		transfer the file '''
		self.rsync_pipe_create()
		for host in hosts:
			if not host in self.FIFOstream:
				self.FIFOstream[host] = open(self.FIFO[host],'w')
			self.FIFOstream[host].write(file+'\n')
	# ==========================================================================


# nightwatch(path, pipe=True).run()
nightwatch(path).run()
