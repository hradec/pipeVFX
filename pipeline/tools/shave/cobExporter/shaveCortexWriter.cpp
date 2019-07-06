//
// Shave and a Haircut
// Copyright Joe Alter, Inc., 2003, all rights reserved.
// US Patent #6,720,962
//
#include <maya/MFnPlugin.h>
#include <maya/MFStream.h>
#include <maya/MGlobal.h>
#include <maya/MIOStream.h>
#include <maya/MPxCommand.h>
#include <maya/MString.h>
#include <maya/MSyntax.h>
#include <maya/MTypes.h>
#include <maya/MArgList.h>
#include <maya/MObjectArray.h>
#include <maya/MObject.h>
#include <maya/MSelectionList.h>
#include <maya/MDagPath.h>

#include <maya/shaveAPI.h>
#include <maya/shaveItHair.h>



// #include "IECoreMaya/MArrayIter.h"
// #include "IECoreMaya/VectorTraits.h"
// #include "IECoreMaya/Convert.h"

#include "IECore/CurvesPrimitive.h"
// #include "IECore/VectorOps.h"
// #include "IECore/Exception.h"
// #include "IECore/CompoundParameter.h"
#include "IECore/Writer.h"
#include "IECore/Group.h"

// #include "IECore/CurvesPrimitive.h"
// #include "IECore/SimpleTypedData.h"
// #include "IECore/VectorTypedData.h"
// #include "IECore/ByteOrder.h"
// #include "IECore/MessageHandler.h"
// #include "IECore/FileNameParameter.h"
// #include "IECore/CompoundParameter.h"
// #include "IECore/ObjectParameter.h"
// #include "IECore/NullObject.h"
// #include "IECore/Timer.h"

#include "OpenEXR/ImathRandom.h"

#include <algorithm>
#include <fstream>
#include <cassert>


#include <algorithm>

// using namespace IECoreMaya;

using namespace IECore;
// using namespace boost;
using namespace Imath;
using namespace std;


class shaveAPITestCmd : public MPxCommand
{
public:
    static MSyntax createSyntax();

                 shaveAPITestCmd();
    virtual      ~shaveAPITestCmd();

    void         displayGeomInfo(MString name, shaveAPI::SceneGeom& geom) const;

    void         displayHairInfo(
                     shaveAPI::HairInfo* hairInfo, bool instances, MString fileName, MString command
                 ) const;

    MStatus      doIt(const MArgList&);
    bool         isUndoable() const;

    static void* creator();

private:
};


void* shaveAPITestCmd::creator()
{
    return new shaveAPITestCmd();
}


shaveAPITestCmd::shaveAPITestCmd()
{
}


shaveAPITestCmd::~shaveAPITestCmd()
{
}


bool shaveAPITestCmd::isUndoable() const
{
    return false;
}


MStatus shaveAPITestCmd::doIt(const MArgList& argList)
{
    MStatus  status;
    char     msg[200];

    // MGlobal::displayInfo("Test 1: export all shaveHairShapes...");

    shaveAPI::HairInfo hairInfo;

    // status = shaveAPI::exportAllHair(&hairInfo);
    //
    // if (status == MS::kNotFound)
    // {
    //     MGlobal::displayInfo(
    //         "  exportAllHair says there are no shaveHairShapes in the scene."
    //     );
    // }
    // else if (!status)
    // {
    //     MGlobal::displayError(
    //         MString("  we got back the following unexpected error: ")
    //         + status.errorString()
    //     );
    // }
    // else
    // {
    //     MGlobal::displayInfo("  Scene contains...");
    //     displayHairInfo(&hairInfo, false);
    // }
    //
    //
    MStatus ret;
    MGlobal::displayInfo("Export renderable shaveHairShapes...");
    MString value = argList.asString(1, &ret);
    if ( ret != MS::kSuccess ) value ="/tmp/shave.cob";
    // cout << value << "\n";

    MString command = argList.asString(0, &ret);
    MString nodeArg = argList.asString(2, &ret);
    if ( nodeArg == "" ){
      cout << "=======>" << argList.asString(0, &ret) << "\n";
      cout << "=======>" << argList.asString(1, &ret) << "\n";
      status = shaveAPI::exportAllHair(&hairInfo, true);


    } else {
      MObjectArray shaveNodes;
      MStringArray nodes;
      nodeArg.split(',', nodes);
      for( int n=0; n< nodes.length(); n++){
        MSelectionList sList;
        MString toMatch (nodes[n]);
        MGlobal::getSelectionListByName(toMatch, sList);
        unsigned int ii = 0;
        unsigned int nMatches = sList.length();
        for (ii = 0; ii < nMatches; ++ii) {
            MDagPath dp;
            MObject object;
            sList.getDagPath(ii, dp);
            cout << "------->" << dp.fullPathName() << endl;
            sList.getDependNode(ii, object);
            shaveNodes.append( object );
        }
      }
      status = shaveAPI::exportHair( shaveNodes, &hairInfo );
    }


    if (status == MS::kNotFound)
    {
        MGlobal::displayInfo(
            "  exportAllHair says there are no renderable shaveHairShapes"
			" in the scene."
        );

        status = MS::kSuccess;
    }
    else
    {
        MGlobal::displayInfo("  Renderable shaveHairShapes contain...");
        displayHairInfo(&hairInfo, false, value, command);
    }


    // MGlobal::displayInfo("Test 3: iterate through non-instanced hairs...");

    // status = shaveItHair::init(false, true);
    //
    // if (status == MS::kNotFound)
    // {
    //     MGlobal::displayInfo(
    //         "  shaveItHair::init says there are no renderable, non-instanced"
    //         " shaveHairShapes in the scene."
    //     );
    // }
    // else
    // {
    //     int  hairNum = 0;
    //
    //     while (shaveItHair::nextHair(&hairInfo))
    //     {
	//     sprintf(msg, "  Hair %d contains...", hairNum);
    //         MGlobal::displayInfo(msg);
    //         displayHairInfo(&hairInfo, false);
    //
    //         if (++hairNum >= 3) break;
    //     }
    // }
    //
    //
    // MGlobal::displayInfo("Test 4: iterate through instanced hairs...");
    //
    // status = shaveItHair::init(true, true);
    //
    // if (status == MS::kNotFound)
    // {
    //     MGlobal::displayInfo(
    //         "  shaveItHair::init says there are no renderable, instanced"
    //         " shaveHairShapes in the scene."
    //     );
    // }
    // else
    // {
    //     int  hairNum = 0;
    //
    //     while (shaveItHair::nextHair(&hairInfo))
    //     {
	//     sprintf(msg, "  Hair %d contains...", hairNum);
    //         MGlobal::displayInfo(msg);
    //         displayHairInfo(&hairInfo, true);
    //
    //         if (++hairNum >= 3) break;
    //     }
    // }
    //
    //
    // MGlobal::displayInfo("Test 5: get occlusion geometry...");
    //
    // shaveAPI::SceneGeom   hairOcclusions;
    // shaveAPI::SceneGeom   shadowOcclusions;
    //
    // status = shaveAPI::exportOcclusions(&hairOcclusions, &shadowOcclusions);
    //
    // if ((status != MS::kSuccess) && (status != MS::kUnknownParameter))
    // {
    //     MGlobal::displayError(
    //         MString("  we got back the following unexpected error: ")
    //         + status.errorString()
    //     );
    // }
    // else
    // {
    //     if (status == MS::kUnknownParameter)
    //     {
    //         MGlobal::displayWarning(
    //             "  motion blur is on but no renderable camera could be found,"
    //             " so geometry velocities will all be zero."
    //         );
    //     }

    //     displayGeomInfo("Hair occlusions", hairOcclusions);
    //     displayGeomInfo("Shadow occlusions", shadowOcclusions);
    // }

    //
    // Free up all the memory allocated to 'hairInfo'.
    //
    // This call is provided just as an example.  In this particular case
    // it is unnecessary because 'hairInfo' will go out of scope at the end
    // of the function and be destroyed, along with all of its storage.
    //
    // However, if you were planning on doing some other processing in this
    // function, then it might make sense to clear 'hairInfo's storage
    // first so that that memory was available for other uses.
    //
    hairInfo.clear();

    return MS::kSuccess;
}


MSyntax shaveAPITestCmd::createSyntax()
{
    MSyntax   syntax;

    syntax.enableQuery(false);
    syntax.enableEdit(false);

    return syntax;
}


void shaveAPITestCmd::displayGeomInfo(
        MString name, shaveAPI::SceneGeom& geom
) const
{
    MGlobal::displayInfo(MString("  ") + name + " consists of...");

    char msg[200];
    char     buff[200];

    sprintf(
	msg,
	"  %d faces\n  %d vertices\n  %d face vertices",
    	geom.numFaces,
    	geom.numVertices,
    	geom.numFaceVertices
    );

    MGlobal::displayInfo(msg);

    //
    // Dump out some details for the first three faces, if there are that
    // many.
    //
    int face;
    int i;

    for (face = 0; (face < 3) && (face < geom.numFaces); face++)
    {
	sprintf(msg, "  face %d", face);
        MGlobal::displayInfo(msg);

        for (i = geom.faceStartIndices[face];
             i < geom.faceEndIndices[face];
             i++)
        {
            int vert = geom.faceVertices[i];

	    sprintf(
		buff,
		"    vertex %d: position (%f, %f, %f)  velocity (%f, %f, %f)",
	    	i-geom.faceStartIndices[face],
            	geom.vertices[vert].x,
            	geom.vertices[vert].y,
            	geom.vertices[vert].z,
            	geom.velocities[vert].x,
            	geom.velocities[vert].y,
            	geom.velocities[vert].z
	    );

            MGlobal::displayInfo(buff);
        }
    }
}


void shaveAPITestCmd::displayHairInfo(
        shaveAPI::HairInfo* hairInfo, bool instances, MString fileName, MString command
) const
{
    // cout << "BUM 1\n";
    const char *strandName = (instances ? "face" : "strand");
    // cout << "BUM 1\n";
    char     buff[200];
    // cout << hairInfo->numHairs << " BUM 1\n";

    sprintf(buff, "  %d %ss", hairInfo->numHairs, strandName);
    // MGlobal::displayInfo(buff);
    // cout << "BUM 1\n";
    // cout << buff << "\n";

    sprintf(buff, "  %d vertices", hairInfo->numVertices);
    // MGlobal::displayInfo(buff);
    // cout << buff << "\n";

    sprintf(buff, "  %d %s vertices", hairInfo->numHairVertices, strandName);
    // MGlobal::displayInfo(buff);
    // cout << buff << "\n";



    int numHairs = 0;
  	int numCVs = 0;
  	int positionCVs = 0;
  	bool havePosition = false;
  	IntVectorDataPtr vertsPerCurve( new IntVectorData );
  	V3fVectorDataPtr pData( new V3fVectorData );
    V3fVectorDataPtr vData( new V3fVectorData );
    V3fVectorDataPtr uvData( new V3fVectorData );
    V3fVectorDataPtr rootColorData( new V3fVectorData );
    V3fVectorDataPtr tipColorData( new V3fVectorData );
    V3fVectorDataPtr surfaceNormalData( new V3fVectorData );
    FloatVectorDataPtr widthData( new FloatVectorData );
    FloatVectorDataPtr rootRadiiData( new FloatVectorData );
    FloatVectorDataPtr tipRadiiData( new FloatVectorData );
    FloatVectorDataPtr ID( new FloatVectorData );
    FloatVectorDataPtr u( new FloatVectorData );


    // cout << "BUM 1\n";

    //
    // Dump out some details for the first three strands, if there are that
    // many.
    //
    int strand;
    int i;


    for (strand = 0; (strand < hairInfo->numHairs); strand++)
    {

    	// sprintf(
    	//     buff,
    	//     "  %s %d: root colour (%f, %f, %f)  tip colour (%f, %f, %f)"
    	// 	"  surface normal (%f, %f, %f)",
        //         strandName,
    	//     strand,
        //         hairInfo->rootColors[strand].r,
        //         hairInfo->rootColors[strand].g,
        //         hairInfo->rootColors[strand].b,
        //         hairInfo->tipColors[strand].r,
        //         hairInfo->tipColors[strand].g,
        //         hairInfo->tipColors[strand].b,
        //         hairInfo->surfaceNormals[strand].x,
        //         hairInfo->surfaceNormals[strand].y,
        //         hairInfo->surfaceNormals[strand].z
        //     );
    	// MGlobal::displayInfo(buff);

        numCVs = hairInfo->hairEndIndices[strand] - hairInfo->hairStartIndices[strand];


        rootColorData->writable().push_back( V3d(
            hairInfo->rootColors[strand].r,
            hairInfo->rootColors[strand].g,
            hairInfo->rootColors[strand].b
        ) );
        tipColorData->writable().push_back( V3d(
            hairInfo->tipColors[strand].r,
            hairInfo->tipColors[strand].g,
            hairInfo->tipColors[strand].b
        ) );
        surfaceNormalData->writable().push_back( V3d(
            hairInfo->surfaceNormals[strand].x,
            hairInfo->surfaceNormals[strand].y,
            hairInfo->surfaceNormals[strand].z
        ) );

        tipRadiiData->writable().push_back( hairInfo->tipRadii[strand] );

        rootRadiiData->writable().push_back( hairInfo->rootRadii[strand] );

        ID->writable().push_back( strand );


        // per vertex data
        #define addVertData(id)  vert = id;\
        pData->writable().push_back( V3d( \
            hairInfo->vertices[vert].x,\
            hairInfo->vertices[vert].y,\
            hairInfo->vertices[vert].z\
        ) );\
        vData->writable().push_back( V3d(\
            hairInfo->velocities[vert].x,\
            hairInfo->velocities[vert].y,\
            hairInfo->velocities[vert].z\
        ) );\
        uvData->writable().push_back( V3d(\
            hairInfo->uvws[vert].x,\
            hairInfo->uvws[vert].y,\
            hairInfo->uvws[vert].z\
        ) );\
        u->writable().push_back( hairInfo->uvws[vert].z );


        long cvCount = 0;
        int vert = 0;
        addVertData(  hairInfo->hairVertices[ hairInfo->hairStartIndices[strand] ]  );
        cvCount++;
        addVertData(  hairInfo->hairVertices[ hairInfo->hairStartIndices[strand] ]  );
        cvCount++;
        // addVertData(  hairInfo->hairVertices[ hairInfo->hairStartIndices[strand] ]  );
        // cvCount++;

        float multp=0.1;
        float step = ((hairInfo->rootRadii[strand]-hairInfo->tipRadii[strand])*multp) / (numCVs + 1.0);
        float width = hairInfo->rootRadii[strand];

        widthData->writable().push_back( width );

        for (i = hairInfo->hairStartIndices[strand]; i < hairInfo->hairEndIndices[strand]; i++)
        {
            vert = hairInfo->hairVertices[i];
            addVertData( vert )
            width -= step;
            widthData->writable().push_back( width );
            cvCount++;
        }

        // width -= step;
        // widthData->writable().push_back( width );
        //
        addVertData(  hairInfo->hairVertices[ hairInfo->hairEndIndices[strand] -1]  );
        cvCount++;
        addVertData(  hairInfo->hairVertices[ hairInfo->hairEndIndices[strand] -1]  );
        cvCount++;
        // addVertData(  hairInfo->hairVertices[ hairInfo->hairEndIndices[strand] -1]  );
        // cvCount++;
        vertsPerCurve->writable().push_back( cvCount );


    }

    CubicBasisf basis = IECore::CubicBasisf::bSpline();
    bool periodic = false;
    CurvesPrimitivePtr curves = new CurvesPrimitive( vertsPerCurve , basis, periodic, pData );
    curves->variables[ "U" ] = PrimitiveVariable( PrimitiveVariable::Vertex, u );
    if ( command != "-e" ){
      curves->variables[ "uv" ] = PrimitiveVariable( PrimitiveVariable::Vertex, uvData );
      curves->variables[ "velocity" ] = PrimitiveVariable( PrimitiveVariable::Vertex, vData );
      // curves->variables[ "P" ] = PrimitiveVariable( PrimitiveVariable::Vertex, pData );
      // curves->variables[ "tipRadii" ] = PrimitiveVariable( PrimitiveVariable::Varying, tipRadiiData );
      // curves->variables[ "rootRadii" ] = PrimitiveVariable( PrimitiveVariable::Varying, rootRadiiData );
      // curves->variables[ "width" ] = PrimitiveVariable( PrimitiveVariable::Varying, widthData );
    }
    curves->variables[ "rootColor" ] = PrimitiveVariable( PrimitiveVariable::Uniform, rootColorData );
    curves->variables[ "tipColor" ] = PrimitiveVariable( PrimitiveVariable::Uniform, tipColorData );
    curves->variables[ "surfaceN" ] = PrimitiveVariable( PrimitiveVariable::Uniform, surfaceNormalData );
    curves->variables[ "hairID" ]  = PrimitiveVariable( PrimitiveVariable::Uniform, ID );

    GroupPtr group = new Group();
    group->addChild(curves);

    WriterPtr writer = Writer::create( curves, fileName.asChar() );
    writer->write();
}


MStatus initializePlugin(MObject obj)
{
    MStatus   status;
    MFnPlugin plugin(obj, "PipeVFX", "1.0", "Any");

    status = plugin.registerCommand(
                "shaveCortexWriter",
                shaveAPITestCmd::creator,
                shaveAPITestCmd::createSyntax
            );

    if (!status)
    {
        status.perror("registering shaveAPITest command");
        return status;
    }

    return status;
}


MStatus uninitializePlugin(MObject obj)
{
    MStatus   status;
    MFnPlugin plugin(obj);

    status = plugin.deregisterCommand("shaveCortexWriter");

    if (!status)
    {
        status.perror("deregistering shaveAPITest command");
        return status;
    }

    return status;
}

//
// bool periodic = false;
// bool duplicateEnds = true;
// IECore::CubicBasisf basis = IECore::CubicBasisf::linear();
// basis = IECore::CubicBasisf::b();
//
// IECore::V3fVectorDataPtr pointsData = new IECore::V3fVectorData;
// std::vector<Imath::V3f> &points = pointsData->writable();
// std::vector<Imath::V3f>::iterator transformDst;
// if( duplicateEnds )
// {
//     points.resize( mPoints.length() + 4 );
//     transformDst = points.begin();
//     *transformDst++ = IECore::convert<Imath::V3f>( mPoints[0] );
//     *transformDst++ = IECore::convert<Imath::V3f>( mPoints[0] );
// }
// else
// {
//     points.resize( mPoints.length() );
//     transformDst = points.begin();
// }
//
// std::transform( MArrayIter<MPointArray>::begin( mPoints ), MArrayIter<MPointArray>::end( mPoints ), transformDst, IECore::VecConvert<MPoint, V3f>() );
//
// if( duplicateEnds )
// {
//     points[points.size()-1] = IECore::convert<Imath::V3f>( mPoints[mPoints.length()-1] );
//     points[points.size()-2] = IECore::convert<Imath::V3f>( mPoints[mPoints.length()-1] );
// }
//
// // make and return the curve
// IECore::IntVectorDataPtr vertsPerCurve = new IECore::IntVectorData;
// vertsPerCurve->writable().push_back( points.size() );
//
// return new IECore::CurvesPrimitive( vertsPerCurve, basis, periodic, pointsData );
