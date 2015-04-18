
/* Author: Slaven Rezic */

/* Copyright (C) 2001,2003,2004,2011,2015 Slaven Rezic. All rights reserved. */
/* This is free software; you can redistribute it and/or modify it under the */
/* terms of the GNU General Public License, see the file COPYING. */

/* Mail: slaven@rezic.de */
/* WWW:  http://bbbike.sourceforge.net */


#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

typedef struct { int x; int y; } VUI_POINT;

#undef MIN
#undef MAX
#define MIN(x,y) (x < y ? x : y)
#define MAX(x,y) (x > y ? x : y)

#include <math.h>

/* Protect from floating point inaccuracies */
static double _pos_sqrt(double arg) {
    return(arg < 0 ? 0 : sqrt(arg));
}

int vector_in_grid(double x1, double y1, double x2, double y2,
		   double gridx1, double gridy1,
		   double gridx2, double gridy2) {
    int sgn;
    double ges_strecke;

    /* wenigstens ein Punkt ist innerhalb des Gitters */
    if (x1 >= gridx1 && x1 <= gridx2 &&
	y1 >= gridy1 && y1 <= gridy2)
	return 7;
    if (x2 >= gridx1 && x2 <= gridx2 &&
	y2 >= gridy1 && y2 <= gridy2)
	return 6;

    /* beide Punkte sind au�erhalb des Gitters */
    if (x1 < gridx1 && x2 < gridx1)
	return 0;
    if (x1 > gridx2 && x2 > gridx2)
	return 0;
    if (y1 < gridy1 && y2 < gridy1)
	return 0;
    if (y1 > gridy2 && y2 > gridy2)
	return 0;

    ges_strecke = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));

    if (x1 != x2) {
	/* Schnittpunkt-Test am rechten Rand */
	double d_x1_gridx1 = (gridx1 - x1);
	double a = d_x1_gridx1*ges_strecke/(x2-x1);
	double b = _pos_sqrt(a*a - d_x1_gridx1*d_x1_gridx1);
	double schnitt_y_gridx1;
	double d_x1_gridx2;
	double schnitt_y_gridx2;
	sgn = (y1 < y2 ? 1 : -1);
	if ((x1 < x2 && x1 > gridx1) ||
	    (x2 < x1 && x1 < gridx1)) {
	    sgn *= -1;
	}
	schnitt_y_gridx1 = y1 + sgn*b;

	if (schnitt_y_gridx1 >= gridy1 &&
	    schnitt_y_gridx1 <= gridy2) {
#ifdef VECTOR_UTIL_DEBUG
	    fprintf(stderr, "Gefunden: %f <= %f <= %f\n", gridy1, schnitt_y_gridx1, gridy2);
#endif
	    return 1;
	}

	/* Schnittpunkt-Test am linken Rand */
	d_x1_gridx2 = (gridx2 - x1);
	a = d_x1_gridx2*ges_strecke/(x2-x1);
	b = _pos_sqrt(a*a - d_x1_gridx2*d_x1_gridx2);
	sgn = (y1 < y2 ? 1 : -1);
	if ((x1 < x2 && x1 > gridx2) ||
	    (x2 < x1 && x1 < gridx2)) {
	    sgn *= -1;
	}
	schnitt_y_gridx2 = y1 + sgn*b;

	if (schnitt_y_gridx2 >= gridy1 &&
	    schnitt_y_gridx2 <= gridy2) {
#ifdef VECTOR_UTIL_DEBUG
	    fprintf(stderr, "Gefunden: %f <= %f <= %f\n", gridy1, schnitt_y_gridx2, gridy2);
#endif
	    return 2;
	}
    }

    if (y2 != y1) {
	/* Schnittpunkt-Test am oberen Rand (geometrisch unten) */
	double d_y1_gridy2 = (gridy2 - y1);
	double d_y1_gridy1;
	double a = d_y1_gridy2*ges_strecke/(y2-y1);
	double b = _pos_sqrt(a*a - d_y1_gridy2*d_y1_gridy2);
	double schnitt_x_gridy1;
	double schnitt_x_gridy2;
	sgn = (x1 < x2 ? 1 : -1);
	if ((y1 < y2 && y1 > gridy2) ||
	    (y2 < y1 && y1 < gridy2)) {
	    sgn *= -1;
	}
	schnitt_x_gridy2 = x1 + sgn*b;

	if (schnitt_x_gridy2 >= gridx1 &&
	    schnitt_x_gridy2 <= gridx2) {
#ifdef VECTOR_UTIL_DEBUG
	    fprintf(stderr, "Gefunden: %f <= %f <= %f\n", gridx1, schnitt_x_gridy2, gridx2);
#endif
	    return 4;
	}

	/* Schnittpunkt-Test am unteren Rand (geometrisch oben) */
	d_y1_gridy1 = (gridy1 - y1);
	a = d_y1_gridy1*ges_strecke/(y2-y1);
	b = _pos_sqrt(a*a - d_y1_gridy1*d_y1_gridy1);
	sgn = (x1 < x2 ? 1 : -1);
	if ((y1 < y2 && y1 > gridy1) ||
	    (y2 < y1 && y1 < gridy1)) {
	  sgn *= -1 ;
	}
	schnitt_x_gridy1 = x1 + sgn*b;

	if (schnitt_x_gridy1 >= gridx1 &&
	    schnitt_x_gridy1 <= gridx2) {
#ifdef VECTOR_UTIL_DEBUG
	    fprintf(stderr, "Gefunden: %f <= %f <= %f\n", gridx1, schnitt_x_gridy1, gridx2);
#endif
	    return 3;
	}
    }

    return 0;
}

double distance_point_line(double px, double py,
			   double s0x, double s0y,
			   double s1x, double s1y) {
    double sxd = s1x-s0x;
    double syd = s1y-s0y;
    double tf, nx, ny;
    if (sxd+syd==0) { /* line is really a point */
	return hypot(px-s0x, py-s0y);
    }
    tf = ((px-s0x)*(s1x-s0x) + (py-s0y)*(s1y-s0y)) /
	(sxd*sxd + syd*syd);
    /* nx/ny: nearest point on line */
    nx = s0x+tf*sxd;
    ny = s0y+tf*syd;
    if (((nx >= s0x && nx <= s1x) || (nx >= s1x && nx <= s0x))
	&&
	((ny >= s0y && ny <= s1y) || (ny >= s1y && ny <= s0y))
       ) {
	return hypot(s0x-px+tf*sxd, s0y-py+tf*syd);
    } else {
	/* nearest point is out of line ... check the endpoints of the line */
	double dist0 = hypot(s0x-px, s0y-py);
	double dist1 = hypot(s1x-px, s1y-py);
	if (dist0 < dist1) {
	    return dist0;
	} else {
	    return dist1;
	}
    }
}

int sizeof_POINT() {
  return sizeof(VUI_POINT);
}

/* http://www.exaflop.org/docs/naifgfx/naifpip.html */
/* cannot handle convex polygons */
int point_in_poly( char *poly_verts_c, int num_verts, char *test_point_c ) {
  int nx, ny, loop;
  int x, y;
  VUI_POINT *poly_verts = (VUI_POINT*)poly_verts_c;
  VUI_POINT *test_point = (VUI_POINT*)test_point_c;

  /* Clockwise order. */

  for ( loop = 0; loop < num_verts; loop++ ) {
    /*	generate a 2d normal ( no need to normalise ). */
    nx = poly_verts[ ( loop + 1 ) % num_verts ].y - poly_verts[ loop ].y;
    ny = poly_verts[ loop ].x - poly_verts[ ( loop + 1 ) % num_verts ].x;

    x = test_point->x - poly_verts[ loop ].x;
    y = test_point->y - poly_verts[ loop ].y;

    /*	Dot with edge normal to find side. */
    if ( ( x * nx ) + ( y * ny ) > 0 )
      return 0;
  }

  return 1;
}

/* http://astronomy.swin.edu.au/~pbourke/geometry/insidepoly/ */
int InsidePolygon(char *polygon_c,int N,char *p_c)
{
  int counter = 0;
  int i;
  double xinters;
  VUI_POINT p1,p2;
  VUI_POINT* polygon = (VUI_POINT*)polygon_c;
  VUI_POINT* p = (VUI_POINT*)p_c;

  p1 = polygon[0];
  for (i=1;i<=N;i++) {
    p2 = polygon[i % N];
    if (p->y > MIN(p1.y,p2.y)) {
      if (p->y <= MAX(p1.y,p2.y)) {
        if (p->x <= MAX(p1.x,p2.x)) {
          if (p1.y != p2.y) {
            xinters = (p->y-p1.y)*(p2.x-p1.x)/(p2.y-p1.y)+p1.x;
            if (p1.x == p2.x || p->x <= xinters)
              counter++;
          }
        }
      }
    }
    p1 = p2;
  }

  if (counter % 2 == 0)
    return 0;
  else
    return 1;
}

int pnpoly(char *polygon_c,int npol,char *p_c) {
  int i, j, c = 0;
  VUI_POINT* pg = (VUI_POINT*)polygon_c;
  VUI_POINT* p = (VUI_POINT*)p_c;
  int x = p->x;
  int y = p->y;
  for (i = 0, j = npol-1; i < npol; j = i++) {
    if ((((pg[i].y <= y) && (y < pg[j].y)) ||
	 ((pg[j].y <= y) && (y < pg[i].y))) &&
	(x < (pg[j].x - pg[i].x) * (y - pg[i].y) / (pg[j].y - pg[i].y) + pg[i].x))
      c = !c;
  }
  return c;
}

#define PI 3.141592653
#define TWOPI PI*2

/*
   Return the angle between two vectors on a plane
   The angle is from vector 1 to vector 2, positive anticlockwise
   The result is between -pi -> pi
*/
static double Angle2D(double x1, double y1, double x2, double y2)
{
   double dtheta,theta1,theta2;

   theta1 = atan2(y1,x1);
   theta2 = atan2(y2,x2);
   dtheta = theta2 - theta1;
   while (dtheta > PI)
      dtheta -= TWOPI;
   while (dtheta < -PI)
      dtheta += TWOPI;

   return(dtheta);
}

int InsidePolygon2(char *polygon_c,int n,char *p_c)
{
   int i;
   double angle=0;
   VUI_POINT p1,p2;
   VUI_POINT* polygon = (VUI_POINT*)polygon_c;
   VUI_POINT* p = (VUI_POINT*)p_c;

   for (i=0;i<n;i++) {
      p1.x = polygon[i].x - p->x;
      p1.y = polygon[i].y - p->y;
      p2.x = polygon[(i+1)%n].x - p->x;
      p2.y = polygon[(i+1)%n].y - p->y;
      angle += Angle2D(p1.x,p1.y,p2.x,p2.y);
   }

   if (abs(angle) < PI)
      return 0;
   else
      return 1;
}


MODULE = VectorUtil::Inline	PACKAGE = VectorUtil::Inline	

PROTOTYPES: DISABLE


int
vector_in_grid (x1, y1, x2, y2, gridx1, gridy1, gridx2, gridy2)
	double	x1
	double	y1
	double	x2
	double	y2
	double	gridx1
	double	gridy1
	double	gridx2
	double	gridy2

double
distance_point_line (px, py, s0x, s0y, s1x, s1y)
	double	px
	double	py
	double	s0x
	double	s0y
	double	s1x
	double	s1y

int
sizeof_POINT ()

int
point_in_poly (poly_verts_c, num_verts, test_point_c)
	char *	poly_verts_c
	int	num_verts
	char *	test_point_c

int
InsidePolygon (polygon_c, N, p_c)
	char *	polygon_c
	int	N
	char *	p_c

int
pnpoly (polygon_c, npol, p_c)
	char *	polygon_c
	int	npol
	char *	p_c

int
InsidePolygon2 (polygon_c, n, p_c)
	char *	polygon_c
	int	n
	char *	p_c

