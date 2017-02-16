# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================


from  SCons.Environment import *
from  SCons.Builder import *
from  SCons.Defaults import *
from devRoot import *
from genericBuilders import *
import pipe
import os,sys



class make(generic):
    ''' a class to handle make installs '''
    src = 'Makefile'
    cmd = 'make -j $DCORES && make install'


class cmake(make):
    ''' a class to handle cmake installs '''
    src = 'CMakeLists.txt'
    cmd = [
        'cmake $SOURCE_FOLDER && '
        'make -j $DCORES VERBOSE=1 && make install'
    ]
    flags = [
            '-Wno-dev',
            '-DUSE_SIMD=0',
            '-DUSE_FFMPEG=0',
            '-DUSE_OPENCV=0',
            '-DCMAKE_INSTALL_PREFIX=$TARGET_FOLDER',
#            '-DCMAKE_CC_COMPILER=$CC',
#            '-DCMAKE_CXX_COMPILER=$CXX',
#            '-DCMAKE_CPP_COMPILER=$CPP',
#            '-DCMAKE_CC_LINKER_PREFERENCE=$LD',
#            '-DCMAKE_CXX_LINKER_PREFERENCE=$LD',
#            '-DCMAKE_LINKER=$LD',
            '-DOPENIMAGEIOHOME=$OIIO_TARGET_FOLDER',
            '-DOIIO_INCLUDES=$OIIO_TARGET_FOLDER/include/',
            '-DOIIO_LIBRARIES=$OIIO_TARGET_FOLDER/lib/libOpenImageIO.so',
            '-DSTOP_ON_WARNING=0',
            '-DBoost_NO_SYSTEM_PATHS=1',
            '-DBoost_DETAILED_FAILURE_MSG=1',
            '-DBoost_USE_STATIC_LIBS=false',
#            '-DBoost_USE_MULTITHREADED=false',
#            '-DBoost_USE_STATIC_RUNTIME=false',
            '-DLIBPYTHON_VERSION=$PYTHON_VERSION_MAJOR',
            '-DPYTHON_ROOT=$PYTHON_TARGET_FOLDER',
            '-DPYTHON_INCLUDE_DIR=$PYTHON_TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/',
            '-DPYTHON_LIBRARY=$PYTHON_TARGET_FOLDER/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DBOOST_HOME=$BOOST_TARGET_FOLDER',
            '-DBOOST_ROOT=$BOOST_TARGET_FOLDER',
            '-DBOOST_INCLUDEDIR=$BOOST_TARGET_FOLDER/include',
            '-DBOOST_LIBRARYDIR=$( if [ "$(ls -l $BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ 2>/dev/null)" == "" ] ; then ls -d  $BOOST_TARGET_FOLDER/lib/python* 2>/dev/null | tail -1 ; else echo "$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/" ; fi)/',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '-DVERBOSE=1',
            # '-DMAYA_ROOT=$MAYA_ROOT',
            # '-DARNOLD_ROOT=$ARNOLD_ROOT',
            # '-DPRMAN_ROOT=$PRMAN_ROOT',
            '-DOPENEXR_ROOT=$OPENEXR_TARGET_FOLDER',
            '-DILMBASE_HOME=$ILMBASE_TARGET_FOLDER',
            '-DILMBASE_ROOT=$ILMBASE_TARGET_FOLDER',
            '-DILMBASE_LIBRARIES=\\"$ILMBASE_TARGET_FOLDER/lib/libImath.so;$ILMBASE_TARGET_FOLDER/lib/libIex.so;$ILMBASE_TARGET_FOLDER/lib/libHalf.so;$ILMBASE_TARGET_FOLDER/lib/libIlmThread.so;-lpthread\\" '
            '-DPYILMBASE_ROOT=$PYILMBASE_TARGET_FOLDER',
            '-DPYILMBASE_LIBRARY_DIR=$PYILMBASE_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/',
            # '-DGCC_VERSION=%s' % pipe.build.distro.split('-')[-1],
            '-DGCC_VERSION=$GCC_VERSION',
            # we need libXmi and libXi from the main system
            "-DGLUT_Xmu_LIBRARY=$(echo $(ldconfig -p | grep 'libXmu.so ' | cut -d'>' -f2))",
            "-DGLUT_Xi_LIBRARY=$(echo $(ldconfig -p | grep 'libXi.so ' | cut -d'>' -f2))",
        ]


    def fixCMD(self, cmd, environ=[]):
        ''' cmake is kindy picky with environment variables and has lots of
        variables override to force it to find packages in non-usual places.
        So here we force some env vars and command line overrides to make sure
        cmake finds pipeVFX packages first!'''
        environ += [
            'export HDF5_ROOT=$HDF5_TARGET_FOLDER',
            'export HDF5_INCLUDE_DIR=$HDF5_TARGET_FOLDER/include',
            'export HDF5_LIBRARIES=$HDF5_TARGET_FOLDER/lib/libhdf5.so',
            'export OPENEXR_INCLUDE_PATHS=$OPENEXR_TARGET_FOLDER/include',
            'export OPENEXR_LIBRARIES=$OPENEXR_TARGET_FOLDER/lib/libIlmImf.so',
            'export OPENIMAGEHOME=$OIIO_TARGET_FOLDER',
        ]
        for each in self.flags:
            if 'cmake' in cmd and each.split('=')[0] not in cmd:
                cmd = cmd.replace('cmake','cmake '+each+' ')

        if 'cmake' in cmd and os.environ.has_key('CMAKE_TARGET_FOLDER'):
            cmd = cmd.replace('cmake','$CMAKE_TARGET_FOLDER/bin/cmake')

        cmd = ' && '.join(environ)+" && "+cmd
        #cmd = 'find ./ -name CMakeCache.txt -exec rm -rf {} \; && '+cmd
        print
        return cmd


class alembic(cmake):
    ''' a dedicated build class for alembic versions'''
    cmd = [
        'cmake $SOURCE_FOLDER && '
        'make -j $DCORES VERBOSE=1 && make install'
    ]
    # alembic has some hard-coded path to find python, and the only
    # way to make it respect the PYTHON related environment variables,
    # is to patch some files to force it!
    sed = {
        '1.5.0' : {
            'python/PyAbcOpenGL/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'python/PyAlembic/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'CMakeLists.txt' : [
                ('/alembic-${VERSION}',' '),
            ],
            'maya/AbcImport/CMakeLists.txt' : [
                ('maya/plug-ins', 'maya/$ENV{MAYA_VERSION}/plugins'),
            ],
            'maya/AbcExport/CMakeLists.txt' : [
                ('maya/plug-ins', 'maya/$ENV{MAYA_VERSION}/plugins'),
            ],
            'arnold/Procedural/CMakeLists.txt' : [
                ('arnold/procedurals', 'arnold/$ENV{ARNOLD_VERSION}/procedurals'),
            ],
            'prman/Procedural/CMakeLists.txt' : [
                ('prman/procedurals', 'prman/$ENV{PRMAN_VERSION}/procedurals'),
            ],

        },
        '1.6.0' : {
            'python/PyAlembic/CMakeLists.txt' : [
                ('SET(.*PYTHON_INCLUDE_DIR','#SET( PYTHON_INCLUDE_DIR'),
                ('SET(.*ALEMBIC_PYTHON_ROOT','#SET( ALEMBIC_PYTHON_ROOT'),
                ('/usr/include/python','${PYTHON_TARGET_FOLDER}/include/python'),
                ('/lib/libpython','${PYTHON_TARGET_FOLDER}/lib/libpython'),
            ],
            'CMakeLists.txt' : [
                ('/alembic-${VERSION}',' '),
            ],
        },
    }

    def preSED(self, pkgVersion, lastlog):
        if float( '.'.join(pkgVersion.split('.')[:2]) ) < 1.60:
            from subprocess import Popen
            cmd = 'python ./build/bootstrap/alembic_bootstrap.py . > %s 2>&1' % lastlog
            proc = Popen(cmd, bufsize=-1, shell=True, executable='/bin/sh', env=self.os_environ, close_fds=True)
            proc.wait()

    def fixCMD(self, cmd):
        # update the buld environment with all the enviroment variables
        # specified in apps argument!
        pipe.version.set(python=self.os_environ['PYTHON_VERSION'])
        pipe.versionLib.set(python=self.os_environ['PYTHON_VERSION'])
        print bcolors.WARNING+": ", bcolors.BLUE+"  apps: ",
        for (app, version) in self.apps:
            className = str(app).split('.')[-1].split("'")[0]
            pipe.version.set({className:version})
            app = app()
            app.fullEnvironment()
            print "%s(%s)" % (className, version),
            # get all vars from app class and add to cmd environ
            for each in app:
                if each not in ['LD_PRELOAD','PYTHON_VERSION','PYTHON_VERSION_MAJOR']:
                    v = app[each]
                    if type(v) == str:
                        v=[v]
                    if each not in self.os_environ:
                        self.os_environ[each] = ''
                    # if var value is paths
                    if 'ROOT' in each:
                        self.os_environ[each] = v[0]
                    elif '/' in str(v):
                        self.os_environ[each] = "%s:%s" % (self.os_environ[each], ':'.join(v))
                    else:
                        self.os_environ[each] = ' '.join(v)

        # remove python paths that are not the same version!
        for each in self.os_environ:
            if '/' in str(v):
                cleanSearchPath = []
                for path in self.os_environ[each].split(':'):
                    if not path.strip():
                        continue
                    if '/python' in path and self.os_environ['PYTHON_TARGET_FOLDER'] not in path:
                        pathVersion1 = path.split('/python/')[-1].split('/')[0].strip()
                        pathVersion2 = path.split('/python')[-1].split('/')[0].strip()
                        # print each, pathVersion1+'='+pathVersion2, path, self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python/')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR'], path.split('/python')[-1].split('/')[0] != self.os_environ['PYTHON_VERSION_MAJOR']
                        if pathVersion1:
                            if pathVersion1 != self.os_environ['PYTHON_VERSION']:
                                continue
                        if pathVersion2:
                            if pathVersion2 != self.os_environ['PYTHON_VERSION_MAJOR']:
                                continue
                    cleanSearchPath.append(path)
                self.os_environ[each] = ':'.join(cleanSearchPath)

        self.os_environ['LD_PRELOAD'] = ''.join(os.popen("ldconfig -p | grep libstdc++.so.6 | grep x86-64 | cut -d'>' -f2").readlines()).strip()
        self.os_environ['LD_PRELOAD'] += ':'+''.join(os.popen("ldconfig -p | grep libgcc_s.so.1 | grep x86-64 | cut -d'>' -f2").readlines()).strip()

        self.flags += [
            '-DUSE_PYALEMBIC=0', # disable python bindings
            '-DALEMBIC_PYTHON_ROOT=$PYTHON_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/config',
            '-DALEMBIC_PYTHON_LIBRARY=$PYTHON_TARGET_FOLDER/lib/libpython$PYTHON_VERSION_MAJOR.so',
            '-DALEMBIC_SHARED_LIBS=1',
            '-DUSE_PRMAN=1',
            '-DUSE_MAYA=1',
            '-DBUILD_SHARED_LIBS:BOOL="TRUE"',
            '-DBUILD_STATIC_LIBS:BOOL="FALSE" ',
        ]

        cmd = cmd.replace('cmake', 'cmake  -DBUILD_SHARED_LIBS:BOOL="TRUE"  -DBUILD_STATIC_LIBS:BOOL="FALSE" ')

        return cmake.fixCMD(self, cmd, [
            'export HDF5_ROOT=$HDF5_TARGET_FOLDER',
            'export HDF5_INCLUDE_DIR=$HDF5_TARGET_FOLDER/include',
            'export HDF5_LIBRARIES=$HDF5_TARGET_FOLDER/lib/libhdf5.so',
            'export OPENEXR_INCLUDE_PATHS=$OPENEXR_TARGET_FOLDER/include',
            'export OPENEXR_LIBRARIES=$OPENEXR_TARGET_FOLDER/lib/libIlmImf.so',
            'export OPENIMAGEHOME=$OIIO_TARGET_FOLDER',
            'export PRMAN_ROOT=$PRMAN_ROOT/RenderManProServer-$PRMAN_VERSION'
        ])


class download(make):
    ''' a simple class to download and uncompress packages, so they can be used by other packages for building '''
    src='CMakeLists.txt'
    cmd=['echo Done']
    # as we want this packages just to be used for building other packages, we don't need a installation target_folder
#    def installer(self, target, source, env):
#        os.system("rm -rf %s" % os.path.abspath(os.path.dirname(os.path.dirname(str(target[0])))) )


class glew(make):
    ''' a make class to exclusively build glew package
    glew requires a bunch of make calls to construct the source and build.
    also, it install its libs in the lib64 folder, so we use a custom
    installer method to create a link lib -> lib64'''
    cmd = ' && '.join([
#        './cmake-testbuild.sh'
#        'cd auto && make destroy && make && cd ..',
        'make GLEW_DEST=$TARGET_FOLDER install.all',
    ])
    sed = {
        '0.0.0' : {
            'config/Makefile.linux' : [
                ('lib64','lib'),
            ],
        },
    }
    def installer(self, target, source, env):
        ''' just a small installation patch to link lib64 to lib, which is the
        expected shared library folder name, since pipeVFX organize packages in
        arch specific hierarchy - linux/x86_64/package '''
        ret = []
        targetFolder = os.path.dirname(str(target[0]))
        if not os.path.exists("%s/lib" % targetFolder):
            if os.path.exists("%s/lib64" % targetFolder):
                ret = os.popen("ln -s lib64 %s/lib" % targetFolder).readlines()
        return ret

class tbb(make):
    ''' a make class to exclusively build intels TBB package
    since we need to handle the installation by ourselfs, we override
    installer() method'''
    cmd = ['make -j $DCORES ']

    def installer(self, target, source, env):
        '''we use this method to do a custom tbb install
        by copying files over.'''
        import build
        path = os.path.abspath( os.path.dirname(str(source[-1])) )
        target = os.path.abspath( os.path.dirname(str(target[0])) )
        for n in range(len(self.buildFolder)): #noqa
            lines = os.popen( "rsync -avWpP %s/include/* %s/include/ 2>&1" % (path, target)).readlines()
            for SHLIBEXT in build.SHLIBEXT:
                lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/lib/ 2>&1" % (path, SHLIBEXT, target) ).readlines()
                lines += os.popen( "rsync -aW --delete %s/build/*_release/*%s* %s/bin/ 2>&1" % (path, SHLIBEXT, target) ).readlines()
        return lines


class openvdb(make):
    ''' a make class to exclusively build OpenVDB package
    '''
    src = 'README.md'
    cmd = [
        '''export PYTHON_VERSION=$($MAYA_ROOT/bin/mayapy --version 2>&1 | awk '{split($2,a,"."); print a[1] "." a[2] "." a[3] }')''',
        '''export PYTHON_VERSION_MAJOR=$($MAYA_ROOT/bin/mayapy --version 2>&1 | awk '{split($2,a,"."); print a[1] "." a[2] }')''',
        'cd openvdb',
        'if [ ! -e $TARGET_FOLDER/lib/libopenvdb.so ] ; then make -j $DCORES lib install has_python=no '
            'DESTDIR=$TARGET_FOLDER '
            'PYTHON_INCL_DIR=$PYTHON_TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/ '
            'PYTHON_LIB_DIR=$PYTHON_TARGET_FOLDER/lib/ '
            'BOOST_INCL_DIR=$BOOST_TARGET_FOLDER/include '
            'BOOST_LIB_DIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
            'ILMBASE_INCL_DIR=$ILMBASE_TARGET_FOLDER/include '
            'ILMBASE_LIB_DIR=$ILMBASE_TARGET_FOLDER/lib '
            'EXR_INCL_DIR=$EXR_TARGET_FOLDER/include '
            'EXR_LIB_DIR=$EXR_TARGET_FOLDER/lib '
            'TBB_INCL_DIR=$TBB_TARGET_FOLDER/include '
            'TBB_LIB_DIR=$TBB_TARGET_FOLDER/lib '
            'LOG4CPLUS_INCL_DIR=$LOG4CPLUS_TARGET_FOLDER/include '
            'LOG4CPLUS_LIB_DIR=$LOG4CPLUS_TARGET_FOLDER/lib '
            'LOG4CPLUS_LIB=" -Wl,-rpath,$LOG4CPLUS_TARGET_FOLDER/lib -llog4cplus " '
            'BLOSC_INCL_DIR=/usr/include '
            'BLOSC_LIB_DIR=/usr/lib '
        ';fi',
        'cd ../openvdb_maya',
        'make -j $DCORES install '
            'DESTDIR=$TARGET_FOLDER '
            'OPENVDB_INCL_DIR=$TARGET_FOLDER/include '
            'OPENVDB_LIB_DIR=$TARGET_FOLDER/lib '
            'OPENVDB_LIB="-Wl,-rpath,$TARGET_FOLDER/lib/ -lopenvdb" '
            'PYTHON_INCL_DIR=$PYTHON_TARGET_FOLDER/include/python$PYTHON_VERSION_MAJOR/ '
            'PYTHON_LIB_DIR=$PYTHON_TARGET_FOLDER/lib/ '
            'BOOST_INCL_DIR=$BOOST_TARGET_FOLDER/include '
            'BOOST_LIB_DIR=$BOOST_TARGET_FOLDER/lib/python$PYTHON_VERSION_MAJOR/ '
            'ILMBASE_INCL_DIR=$ILMBASE_TARGET_FOLDER/include '
            'ILMBASE_LIB_DIR=$ILMBASE_TARGET_FOLDER/lib '
            'EXR_INCL_DIR=$EXR_TARGET_FOLDER/include '
            'EXR_LIB_DIR=$EXR_TARGET_FOLDER/lib '
            'TBB_INCL_DIR=$TBB_TARGET_FOLDER/include '
            'TBB_LIB_DIR=$TBB_TARGET_FOLDER/lib '
            'LOG4CPLUS_INCL_DIR=$LOG4CPLUS_TARGET_FOLDER/include '
            'LOG4CPLUS_LIB_DIR=$LOG4CPLUS_TARGET_FOLDER/lib '
            'BLOSC_INCL_DIR=/usr/include '
            'BLOSC_LIB_DIR=/usr/lib '
            'MAYA_DESTDIR=$TARGET_FOLDER/maya/$MAYA_VERSION/ '
            'MAYA_LOCATION=$MAYA_ROOT ',
    ]
    sed = {'0.0.0' : {
        # Patch openvdb maya plugin to FIX rendering in the farm, without a DISPLAY being set!
        'openvdb_maya/maya/OpenVDBVisualizeNode.cc' : [
            ('view.beginGL()', 'if(MGlobal::mayaState() == MGlobal::kBatch) return;\n\nview.beginGL()'),
            ('mSurfaceShader.setVertShader', 'if(MGlobal::mayaState() != MGlobal::kBatch) {\n\nmSurfaceShader.setVertShader'),
            ('mPointShader.build();', 'mPointShader.build();}'),
            ('return MBoundingBox(MPoint(-1.0, -1.0, -1.0), MPoint(1.0, 1.0, 1.0))', 'return mBBox'),
            ('if (plug == aCachedInternalNodes) {','''
                if(MGlobal::mayaState() == MGlobal::kBatch) {
                    MPoint pMin, pMax;
                    mBBoxBuffers.clear();
                    mBBoxBuffers.resize(grids.size());

                    for (size_t n = 0, N = grids.size(); n < N; ++n) {
                        mvdb::BoundingBoxGeo drawBBox(mBBoxBuffers[n]);
                        drawBBox(grids[n]);

                        for (int i = 0; i < 3; ++i) {
                            pMin[i] = drawBBox.min()[i];
                            pMax[i] = drawBBox.max()[i];
                        }
                    }
                    mBBox = MBoundingBox(pMin, pMax);

                    MDataHandle outHandle = data.outputValue(aCachedBBox);
                    outHandle.set(true);
                }

                if (plug == aCachedInternalNodes) {
            '''),
            ('stat = addAttribute(aIsovalue','''
                nAttr.setDefault(0.001);
                stat = addAttribute(aIsovalue
            ''')
        ],'openvdb_maya/maya/OpenVDBUtil.cc' : [
            # ('mProgram(0)', 'if(MGlobal::mayaState() == MGlobal::kBatch) return;mProgram(0)'),
            ('ShaderProgram() { clear()', 'ShaderProgram() { if(MGlobal::mayaState() != MGlobal::kBatch) clear()'),
            ('insertFrameNumber','''
                insertFrameNumberPrman(std::string& str, const MTime& time, int numberingScheme)
                {
                    size_t pos = str.find_first_of("$F");
                    if (pos != std::string::npos) {

                        size_t length = str.find_last_of(".") - pos;
                        size_t pad = atoi(str.substr(pos+2, length).c_str());

                        // Current frame value
                        double frame = time.as(MTime::uiUnit());

                        // Frames per second
                        const MTime dummy(1.0, MTime::kSeconds);
                        const double fps = dummy.as(MTime::uiUnit());

                        // Ticks per frame
                        const double tpf = 6000.0 / fps;
                        const int tpfDigits = int(std::log10(int(tpf)) + 1);

                        const int wholeFrame = int(frame);
                        std::stringstream ss;
                        ss << std::setw(int(pad)) << std::setfill('0');

                        if (numberingScheme == 1) { // Fractional frame values
                            ss << wholeFrame;

                            std::stringstream stream;
                            stream << frame;
                            std::string tmpStr = stream.str();;
                            tmpStr = tmpStr.substr(tmpStr.find('.'));
                            if (!tmpStr.empty()) ss << tmpStr;

                        } else if (numberingScheme == 2) { // Global ticks
                            int ticks = int(openvdb::math::Round(frame * tpf));
                            ss << ticks;
                        } else { // Frame.SubTick
                            ss << wholeFrame;
                            const int frameTick = (openvdb::math::Round(frame - double(wholeFrame)) * tpf);
                            if (frameTick > 0) {
                                ss << "." << std::setw(tpfDigits) << std::setfill('0') << frameTick;
                            }
                        }

                        str.replace(pos, length, ss.str());
                    }
                }
                void insertFrameNumber
            '''),
        ],'openvdb_maya/maya/OpenVDBUtil.h' : [
            ('<maya/MTime.h>', '<maya/MTime.h>\n#include <maya/MGlobal.h>'),
            ('mBuffer->genVertexBuffer(points)', 'if(MGlobal::mayaState() != MGlobal::kBatch) mBuffer->genVertexBuffer(points)'),
            ('mBuffer->genIndexBuffer(indices, GL_LINES)', 'if(MGlobal::mayaState() != MGlobal::kBatch) mBuffer->genIndexBuffer(indices, GL_LINES)'),
            ('insertFrameNumber',''' insertFrameNumberPrman(std::string& str, const MTime& time, int numberingScheme = 0); \nvoid\ninsertFrameNumber'''),
        ],'openvdb_maya/maya/OpenVDBReadNode.cc' : [
            ('insertFrameNumber','insertFrameNumberPrman'),
            ('MObject aNodeInfo','''
                MObject aNodeInfo;
                void postConstructor()
            '''),
            ('struct OpenVDBReadNode ','''
                #include <maya/MDGModifier.h>
                #include <maya/MSelectionList.h>

                static MStatus
                getObjectByName(const MString & name, MObject & object)
                {
                    object = MObject::kNullObj;

                    MSelectionList sList;
                    MStatus status = sList.add(name);
                    if (status == MS::kSuccess)
                    {
                        status = sList.getDependNode(0, object);
                    }

                    return status;
                }


                MStatus
                getPlugByName(const MString & objName, const MString & attrName, MPlug & plug)
                {
                    MObject object = MObject::kNullObj;
                    MStatus status = getObjectByName(objName, object);
                    if (status == MS::kSuccess)
                    {
                        MFnDependencyNode mFn(object, &status);
                        if (status == MS::kSuccess)
                            plug = mFn.findPlug(attrName, &status);
                    }

                    return status;
                }

                struct OpenVDBReadNode
            '''),
            ('MStatus OpenVDBReadNode::initialize','''
                void OpenVDBReadNode::postConstructor()
                {
                    MStatus status;
                    MObject thisNode = thisMObject();
                    MFnDependencyNode fnDN(thisNode);

                    MDGModifier modifier;
                    MPlug srcPlug, dstPlug;

                    // make connection: time1.outTime --> OpenVDBReadNode.time
                    dstPlug = fnDN.findPlug("inputTime", true, &status);
                    status = getPlugByName("time1", "outTime", srcPlug);
                    status = modifier.connect(srcPlug, dstPlug);
                    status = modifier.doIt();
                }

                MStatus OpenVDBReadNode::initialize
            '''),
        ],
    }}
