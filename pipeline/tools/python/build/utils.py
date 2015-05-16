
import os,glob

def globRecursive(file):
	files=file
	if type(file)==type(""):
		file = [file]
	if type(file)==type([]):
		if type(file[0])==type(""):
			files=[]
			for f in file:
				for each in glob.glob(f):
					if os.path.isfile(each):
						files.append(each)
					if os.path.isdir(each):
						files.extend( globRecursive(os.path.join(each,os.path.basename(f))) )

	return files

def expandVar(env):
	return os.popen('eval echo %s' % env).readlines()[0].strip()

def evalenv():
	for each in os.environ.keys():
		os.environ[each] = os.popen('eval echo $%s 2>/dev/null' % each).readlines()[0].strip()

def central(what, args={}, prefix=None):
	res=''
	if args.has_key('PREFIX'):
		res = args['PREFIX']
		#res = os.path.join( res, what )
	if prefix:
		res = prefix
		#res = os.path.join( res, what )
	else:
		res = os.popen('pp central %s' % what).readlines()[0].strip()

	return res