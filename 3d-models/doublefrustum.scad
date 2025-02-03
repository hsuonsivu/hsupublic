//	  Last Modification : 01:57 Feb 20 2022 kivinen
//	  Last check in     : $Date: $
//	  Revision number   : $Revision: $
//	  State             : $State: $
//	  Version	    : 1.2
//	  Edit time	    : 5 min

// Make double frustum, i.e, three squares at z locations z0, z1, z2
// so that first square is +-x0, +-y0 etc.
module doublefrustum(z0, z1, z2, x0, y0, x1, y1, x2, y2) {
  POINTS=[[-x0, -y0, z0],
	  [x0, -y0, z0],
	  [x0, y0, z0],
	  [-x0, y0, z0],
	  [-x1, -y1, z1],
	  [x1, -y1, z1],
	  [x1, y1, z1],
	  [-x1, y1, z1],	  
	  [-x2, -y2, z2],
	  [x2, -y2, z2],
	  [x2, y2, z2],
	  [-x2, y2, z2]];
  FACES = [ [ 0, 1, 2, 3 ], // Bottom
	    [ 0, 4, 5, 1 ], // Bottom front
	    [ 1, 5, 6, 2 ], // Bottom right
	    [ 0, 3, 7, 4 ], // Bottom left
	    [ 3, 2, 6, 7 ], // Bottom back
	    [ 4, 8, 9, 5 ], // Top front
	    [ 5, 9, 10, 6 ], // Top right
	    [ 4, 7, 11, 8 ], // Top left
	    [ 6, 10, 11, 7 ], // Top back
	    [ 8, 11, 10, 9 ] ];
  polyhedron(points = POINTS, faces = FACES, convexity = 2);
}
