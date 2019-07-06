//
// Shave and a Haircut
// Copyright Joe Alter, Inc., 2003, all rights reserved.
// US Patent #6,720,962
//
#include <iostream>

#include "shaveEngine.h"

using namespace std;


int main(int argc, char* argv[])
{
	if (argc < 2)
	{
		cerr << "Usage: " << argv[0] << " archiveFile [nodeName]" << endl;
		return 1;
	}

	//
	// Get the command line parameters.
	//
	char*	archiveFile = argv[1];
	char*	nodeName = (argc > 2 ? argv[2] : NULL);

	//
	// Grab a Shave license.
	//
	if (!PRIMlogin())
	{
		cerr << "Could not get Shave license." << endl;
		return 2;
	}

	//
	// Load in the archive file.
	//
	int	numVoxels = PRIMinit_hairstack(archiveFile);

	cout << archiveFile << " contains " << numVoxels << " voxels." << endl;

	//
	// Display some information about the first 10 voxels (if there are
	// that many).
	//
	int	i;
	int	j;
	int	numVoxelsToShow = (numVoxels > 10 ? 10 : numVoxels);

	for (i = 0; i < numVoxelsToShow; i++)
	{
		//
		// Fetch the hairs in the voxel.
		//
		// If a node name was given on the command line, then only fetch
		// hairs from that node.
		//
		HAIRTYPE	hair;
		UVSETS		uvs;

		if (nodeName)
		{
			PRIMfetch_voxel_by_name2(i, nodeName, &hair, &uvs, false);

			cout << "Voxel " << i << " contains " << hair.totalfaces
				<< " hairs with " << (int)uvs.totalUVSets
				<< " uvs per hair, for node '" << nodeName << "'." << endl;
		}
		else
		{
			PRIMfetch_voxel(i, &hair, false);

			cout << "Voxel " << i << " contains " << hair.totalfaces
				<< " hairs." << endl;
		}

		//
		// If there are some hairs in the voxel then dump out more
		// information about the voxel.
		//
		if (hair.totalfaces > 0)
		{
			//
			// Display the voxel's bounding box.
			//
			VERT	minBound;
			VERT	maxBound;

			PRIMfetch_bbox(i, &minBound, &maxBound);

			cout << "  bounding box is ("
				<< minBound.x << ", " << minBound.y << ", " << minBound.z
				<< ") to ( "
				<< maxBound.x << ", " << maxBound.y << ", " << maxBound.z
				<< ")" << endl;

			//
			// Display the vertices of the first hair in the voxel.
			//
			int	startOfHairVertIndices = hair.face_start[0];
			int	endOfHairVertIndices = hair.face_end[0];

			cout << "  first hair has "
				<< (endOfHairVertIndices - startOfHairVertIndices)
				<< " vertices:" << endl;

			for (j = startOfHairVertIndices; j < endOfHairVertIndices; j++)
			{
				int		vertIndex = hair.facelist[j];
				VERT&	vert = hair.v[vertIndex];

				cout << "    (" << vert.x << ", " << vert.y << ", " << vert.z
					<< ")" << endl;
			}

			//
			// Display the uvs for the root of the first hair in the voxel.
			//
			if (nodeName && (uvs.totalUVSets > 0) && (uvs.totalRoots > 0))
			{
				cout << "  first hair's uvs are:";

				for (j = 0; j < (int)uvs.totalUVSets; j++)
				{
					cout << " (" << uvs.uvRoot[j].x << ", " << uvs.uvRoot[j].y
						<< "," << uvs.uvRoot[j].z << ")" << endl;
				}
			}
			else
				cout << "  (no UV info available)" << endl;
		}

		//
		// We're done with 'hair' and 'uvs' so free up their memory.
		//
		PRIMfree_hairtype(&hair);

		if (nodeName) PRIMfree_uvset(&uvs);
	}

	//
	// Let Shave clean up its internals.
	//
	// We really don't need to do this in this case since we're about to
	// exit, but it doesn't hurt.
	//
	PRIMclear_hairstack();

	//
	// Release the Shave license.
	//
	PRIMlogout();

	return 0;
}
