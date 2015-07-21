# -*- c -*-

#
# $Id: Inline.pm,v 2.35 2007/05/09 20:37:29 eserte Exp eserte $
# Author: Slaven Rezic
#
# Copyright (C) 2001,2003 Slaven Rezic. All rights reserved.
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License, see the file COPYING.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.de
#


package Strassen::Inline2;

require 5.005; # new semantics of hv_iterinit

BEGIN {
    $VERSION = sprintf("%d.%02d", q$Revision: 2.35 $ =~ /(\d+)\.(\d+)/);
}

use Cwd;
use File::Spec::Functions;

BEGIN {
    my $use_heap = 0; # XXX ist die Heap-Implementation korrekt? Siehe auch doc/misc/ChangeLog
    if ($use_heap) {
	$add_ccflags = '-DHAS_HEAP';
#	$add_libs = '-lisc';  # could be used on FreeBSD
	$add_libs = '';

	$add_myextlib = catfile(getcwd(), updir(), "Strassen-Inline", "heap.o");
	$add_inc = "-I".catfile(getcwd(), updir(), "Strassen-Inline");

    } else {
	$add_ccflags = '';
	$add_libs = '';
	$add_myextlib = '';
	$add_inc = '';
    }
}

use Inline 0.40; # because of API changes
use Config;
#use Inline Config => CLEAN_AFTER_BUILD => 0;   #XXX debugging, both needed
#use Inline C => Config => CCFLAGS => "-g -O2"; #XXX debugging
#use Inline C => Config => CCFLAGS => "-g"; #XXX debugging, faster
use Inline (C => DATA =>

	    NAME => 'Strassen::Inline2',
	    CCFLAGS => "$add_ccflags -DUSE_MMAP_IMPL $Config{'ccflags'}",

	    LIBS => "$add_libs",
	    MYEXTLIB => "$add_myextlib",
	    INC => "$add_inc",
	    VERSION => $VERSION,
	   );

1;

__DATA__
__C__

/* #define DEBUG_DUMP_NODES /* */
/* #define DEBUG_HEAP       /* */
/* #define DEBUG_MINNODE    /* */
/* #define DEBUG_SUCC       /* */
/* #define DEBUG_MMAP_IMPL  /* */
/* #define DEBUG_STRECKE    /* */

#include "ppport.h"

#ifdef HAS_HEAP
#include "heap.h"
#endif

/* XXX maybe use Strassen::Util::infinity */
#define INFINITY 40000000

typedef int dist_t;

typedef struct {
#ifdef USE_MMAP_IMPL
  long predecessor;
#else
  char* predecessor;
#endif
  dist_t dist;
  dist_t heuristic_dist;
} search_node;

#ifdef USE_MMAP_IMPL
inline dist_t _strecke(int x1, int y1, int x2, int y2) {
#ifdef DEBUG_STRECKE
  fprintf(stderr,"%s %s -> %d,%d %d,%d\n","","",x1,y1,x2,y2);
#endif
  return (dist_t)(hypot(x2-x1, y2-y1));
}
#else
inline dist_t _strecke(char* p1, char* p2) {
  int x1 = atoi(p1);
  int y1 = atoi(strchr(p1, ',')+1);
  int x2 = atoi(p2);
  int y2 = atoi(strchr(p2, ',')+1);
#ifdef DEBUG_STRECKE
  fprintf(stderr,"%s %s -> %d,%d %d,%d\n",p1,p2,x1,y1,x2,y2);
#endif
  return (dist_t)(hypot(x2-x1, y2-y1));
}
#endif

#ifdef USE_MMAP_IMPL
# define COORD_HV_VAL(x) ((char*)(&x))
# define COORD_HV_LEN(x) (sizeof(int))
# define DECLARE_HV_VAL(x) \
	long x = 0; \
	STRLEN x##_len = 0
# define PLACEHOLDER "%d"
#else
# define COORD_HV_VAL(x) (x)
# define COORD_HV_LEN(x) (strlen(x))
# define DECLARE_HV_VAL(x) \
	char* x = NULL; \
	STRLEN x##_len = 0
# define PLACEHOLDER "%s"
#endif

static HV* NODES = Nullhv; /* should not be global, but is here because of heap_cmp ... */

#ifdef USE_MMAP_IMPL
inline search_node* get_search_node_from_key(int key) {
    SV** node = hv_fetch(NODES, COORD_HV_VAL(key), COORD_HV_LEN(key), 0);
    return (search_node*)SvIV(*node);
}
#else
inline search_node* get_search_node_from_key(char* key) {
    SV** node = hv_fetch(NODES, key, strlen(key), 0);
    return (search_node*)SvIV(*node);
}
#endif

#ifdef USE_MMAP_IMPL
/* The long output works only if the point has already an entry in NODES */
void _dump_ptr(long c_net_mmap, long ptr, int use_long_output) {
  int* mmap_ptr = (int*)(c_net_mmap+ptr);
  int x = *(mmap_ptr++);
  int y = *(mmap_ptr++);
  if (use_long_output) {
    search_node *sn = get_search_node_from_key(ptr);
    fprintf(stderr, "x,y=%d,%d dist=%d hdist=%d\n", x, y, sn->dist, sn->heuristic_dist);
  } else {
    fprintf(stderr, "x,y=%d,%d\n", x, y);
  }
}
/* empty implementation for Inline::C */
void _dump_node(char* node, int use_long_output) { }
#else
/* empty implementation for Inline::C */
void _dump_ptr(long d1, long d2, int use_long_output) { }
void _dump_node(char* node, int use_long_output) {
  if (use_long_output) {
    search_node *sn = get_search_node_from_key(node);
    fprintf(stderr, "x,y=%s dist=%d hdist=%d\n", node, sn->dist, sn->heuristic_dist);
  } else {
    fprintf(stderr, "x,y=%s\n", node);
  }
}
#endif

#ifdef DEBUG_HEAP
void walk_heap(void *node, void *c_net_mmap) {
#ifdef USE_MMAP_IMPL
  _dump_ptr((long)c_net_mmap, (long)node, 1);
#else
  _dump_node((char*)node, 1);
#endif
}
#else
/* empty implementation for Inline::C */
void walk_heap(void *node, void *c_net_mmap) { }
#endif

#ifdef HAS_HEAP
#define OPEN_empty   OPEN_heap->heap_size == 0
#else
#define OPEN_empty   hv_iterinit(OPEN) == 0
#endif

#ifdef HAS_HEAP
static int heap_cmp(void* a, void* b) {
  search_node *sn_a;
  search_node *sn_b;
#ifdef USE_MMAP_IMPL
  sn_a = get_search_node_from_key((int)a);
  sn_b = get_search_node_from_key((int)b);
#else
  sn_a = get_search_node_from_key((char*)a);
  sn_b = get_search_node_from_key((char*)b);
#endif
  return (sn_a->heuristic_dist < sn_b->heuristic_dist);
}
#endif /* HAS_HEAP */

/* Number of fixed arguments in search_c */
#define SEARCH_C_ARGS 3
void search_c(SV* self, char* from, char* to, ...) {
  HV* self_hash = Nullhv;

#ifdef USE_MMAP_IMPL
  long c_net_mmap = 0;
  HV* c_net_coord2ptr = Nullhv;
#else
  HV* net = Nullhv;
#endif
  HV* wegfuehrung = Nullhv;

#ifdef HAS_HEAP
  heap_context OPEN_heap = heap_new(heap_cmp, NULL, 0);
#else
  HV* OPEN   = newHV();
#endif

  HV* CLOSED = newHV();

#ifdef USE_MMAP_IMPL
  int from_ptr, to_ptr;
  int from_x, from_y;
  int to_x, to_y;
#endif

#ifdef USE_MMAP_IMPL
#define PTR_TO_X_COORD(ptr) \
	(*((int*)(c_net_mmap+ptr)))
#define PTR_TO_Y_COORD(ptr) \
	(*(((int*)(c_net_mmap+ptr))+1))
#endif

  SV* tmp;
  SV* penaltysub = Nullsv;

#ifdef USE_MMAP_IMPL
  long nearest_node = 0;
#else
  char* nearest_node = NULL;
#endif
  int nearest_node_dist = INFINITY;

  int i;
  Inline_Stack_Vars;

  NODES      = newHV(); /* declaration is global :-( */

  if ((Inline_Stack_Items-SEARCH_C_ARGS)%2 != 0)
    croak("usage: $net->search_c($from, $to, -opt => $val, ...) [%d items]", Inline_Stack_Items);
  for (i = SEARCH_C_ARGS; i < Inline_Stack_Items; i+=2) {
    char* opt = SvPV(Inline_Stack_Item(i), PL_na);
    if (strcmp(opt, "-penaltysub") == 0) {
      penaltysub = sv_2mortal(newSVsv(Inline_Stack_Item(i+1))); // XXX cleanup? newsvsv needed???
    } else {
      croak("Invalid option %s", opt);
    }
  }

  if (!sv_isobject(self) || !sv_derived_from(self, "StrassenNetz"))
    croak("Invalid object supplied to search_c");

  self_hash = (HV*)SvRV(self);

#ifdef USE_MMAP_IMPL
  {
    SV** tmp2 = hv_fetch(self_hash, "CNetMmap", strlen("CNetMmap"), 0);
    if (tmp2)
      c_net_mmap = SvIV(*tmp2);
    else
      croak("No CNetMmap element (or invalid type) in object hash");

    tmp2 = hv_fetch(self_hash, "CNetCoord2Ptr", strlen("CNetCoord2Ptr"), 0);
    if (tmp2 && SvTYPE(SvRV(*tmp2)) == SVt_PVHV)
      c_net_coord2ptr = (HV*)SvRV(*tmp2);
    else
      croak("No CNetCoord2Ptr element (or invalid type) in object hash");

    /* for checks whether from and to are valid see below */
  }
#else
  {
    SV** tmp2 = hv_fetch(self_hash, "Net", strlen("Net"), 0);
    if (tmp2 && SvTYPE(SvRV(*tmp2)) == SVt_PVHV)
      net = (HV*)SvRV(*tmp2);
    else
      croak("No Net element (or invalid type) in object hash");

    /* check whether from and to are valid */
    tmp2 = hv_fetch(net, from, strlen(from), 0);
    if (!tmp2)
      croak("from coordinate %s is not reachable in net", from);
    tmp2 = hv_fetch(net, to, strlen(to), 0);
    if (!tmp2)
      croak("to coordinate %s is not reachable in net", to);

  }
#endif

  {
    SV** tmp2 = hv_fetch(self_hash, "Wegfuehrung", strlen("Wegfuehrung"), 0);
    if (tmp2 && SvTYPE(SvRV(*tmp2)) == SVt_PVHV)
      wegfuehrung = (HV*)SvRV(*tmp2);
  }

#ifdef USE_MMAP_IMPL
  {
    /* check for validity and record <from> and <to> */
    SV** tmp2 = hv_fetch(c_net_coord2ptr, from, strlen(from), 0);
    if (tmp2 && SvGMAGICAL(*tmp2))
	mg_get(*tmp2);
    if (!tmp2 || !SvOK(*tmp2))
      croak("Cannot find start coordinate `%s' in net", from);
    from_ptr = SvIV(*tmp2);

    from_x = PTR_TO_X_COORD(from_ptr);
    from_y = PTR_TO_Y_COORD(from_ptr);

    tmp2 = hv_fetch(c_net_coord2ptr, to, strlen(to), 0);
    if (tmp2 && SvGMAGICAL(*tmp2))
	mg_get(*tmp2);
    if (!tmp2 || !SvOK(*tmp2))
      croak("Cannot find goal coordinate `%s' in net", to);
    to_ptr = SvIV(*tmp2);

    to_x = PTR_TO_X_COORD(to_ptr);
    to_y = PTR_TO_Y_COORD(to_ptr);
  }
#endif

  {
    search_node *first_node = malloc(sizeof(search_node));
    if (!first_node)
      croak("Can't malloc");
    first_node->predecessor = 0;
#ifdef USE_MMAP_IMPL
    first_node->heuristic_dist = _strecke(from_x, from_y, to_x, to_y);
#else
    first_node->heuristic_dist = _strecke(from, to);
#endif
    first_node->dist = 0;

#ifdef USE_MMAP_IMPL
#  ifdef HAS_HEAP
    heap_insert(OPEN_heap, (void*) from_ptr);
#  else
    hv_store(OPEN,  COORD_HV_VAL(from_ptr), COORD_HV_LEN(from_ptr), &PL_sv_yes, 0);
#  endif
    hv_store(NODES, COORD_HV_VAL(from_ptr), COORD_HV_LEN(from_ptr), newSViv((IV)first_node), 0);
#else
#  ifdef HAS_HEAP
    heap_insert(OPEN_heap, (void*) from);
#  else
    hv_store(OPEN,  COORD_HV_VAL(from), COORD_HV_LEN(from), &PL_sv_yes, 0);
#  endif
    hv_store(NODES, COORD_HV_VAL(from), COORD_HV_LEN(from), newSViv((IV)first_node), 0);
#endif
  }

  while(1) {
    if (OPEN_empty) {
      SV* nearest_node_sv;
#ifdef USE_MMAP_IMPL
      int *mmap_ptr = (int*)(c_net_mmap + nearest_node);
      SV* y_sv;
      nearest_node_sv = newSViv(*(mmap_ptr++));
      y_sv = newSViv(*mmap_ptr);
      sv_catpv(nearest_node_sv, ",");
      sv_catsv(nearest_node_sv, y_sv);
#else
      nearest_node_sv = newSVpv(nearest_node, 0);
#endif
      Inline_Stack_Reset;
      Inline_Stack_Push(&PL_sv_undef); /* RES_PATH */
      Inline_Stack_Push(&PL_sv_undef); /* RES_LEN */
      Inline_Stack_Push(&PL_sv_undef); /* 2 ??? */
      Inline_Stack_Push(&PL_sv_undef); /* RES_PENALTY */
      Inline_Stack_Push(&PL_sv_undef); /* RES_TRAFFICLIGHTS */
      Inline_Stack_Push(nearest_node_sv); /* RES_NEAREST_NODE */
      Inline_Stack_Done;
      goto done;
    }

    {
      DECLARE_HV_VAL(min_node);
      double min_node_f;
#ifdef HAS_HEAP
      {
	SV** node_sv;
	search_node* sn;
#ifdef USE_MMAP_IMPL
	min_node = (int)heap_element(OPEN_heap, 1);
	if (!min_node)
	  croak("Can't get minimum node from heap");
	node_sv = hv_fetch(NODES, COORD_HV_VAL(min_node), COORD_HV_LEN(min_node), 0);
#else
	min_node = (char*)heap_element(OPEN_heap, 1);
	if (!min_node)
	  croak("Can't get minimum node from heap");
	min_node_len = strlen(min_node);
	node_sv = hv_fetch(NODES, min_node, min_node_len, 0);
#endif
	sn = (search_node*)SvIV(*node_sv);
	min_node_f = sn->heuristic_dist;
      }

#ifdef DEBUG_HEAP
 	fprintf(stderr, "- dump heap ----------------------------\n");
#ifdef USE_MMAP_IMPL
	_dump_ptr(c_net_mmap, min_node, 1);
	heap_for_each(OPEN_heap, walk_heap, c_net_mmap);
#else
	_dump_node(min_node, 1);
	heap_for_each(OPEN_heap, walk_heap, NULL);
#endif
#endif

#else /* HAS_HEAP */
      HE* OPEN_he;
      while(OPEN_he = hv_iternext(OPEN)) {
	DECLARE_HV_VAL(key);
	search_node* sn;
	SV** node_sv;

#ifdef USE_MMAP_IMPL
	key = *((int*)(HePV(OPEN_he, key_len)));
	node_sv = hv_fetch(NODES, COORD_HV_VAL(key), COORD_HV_LEN(key), 0);
#else
	key = HePV(OPEN_he, key_len);
	node_sv = hv_fetch(NODES, COORD_HV_VAL(key), key_len, 0);
#endif /* USE_MMAP_IMPL */

	if (!node_sv)
	  croak("Can't get node for key <" PLACEHOLDER " >", key);
	sn = (search_node*)SvIV(*node_sv);
	if (min_node == 0 || sn->heuristic_dist < min_node_f) {
	  min_node = key;
	  min_node_len = key_len;
	  min_node_f = sn->heuristic_dist;
	}
      }
#endif /* HAS_HEAP */

      if (min_node == 0)
	  croak("No minimal node found");

      /* move min_node from OPEN to CLOSED */
      hv_store(CLOSED, COORD_HV_VAL(min_node), min_node_len, &PL_sv_yes, 0);
#ifdef HAS_HEAP
      heap_delete(OPEN_heap, 1);
#else
      tmp = hv_delete(OPEN, COORD_HV_VAL(min_node), min_node_len, G_DISCARD);
      if (tmp != Nullsv) SvREFCNT_dec(tmp);
#endif

      /* Route found? */
#ifdef USE_MMAP_IMPL
      if ((void*)min_node == to_ptr) {
#else
      if (strcmp(min_node, to) == 0) {
#endif

	AV* path = newAV();
	dist_t len = 0;
	SV* verbose = get_sv("StrassenNetz::VERBOSE", FALSE);
	if (verbose && SvTRUE(verbose))
	  fprintf(stderr, "Path found.\n");
	while(1) {
	  SV** tmp2;
	  search_node *sn;
	  AV* xy = newAV();
	  int x,y;
#ifdef USE_MMAP_IMPL
	  int *mmap_ptr = (int*)(c_net_mmap + min_node);
	  x = *(mmap_ptr++);
	  y = *mmap_ptr;
#else
	  x = atoi(min_node);
	  y = atoi(strchr(min_node,',')+1);
#endif
	  av_push(xy, newSViv(x));
	  av_push(xy, newSViv(y));

	  /*  fprintf(stderr,"<%s>\n", min_node); */
	  av_unshift(path, 1);
	  av_store(path, 0, newRV_noinc((SV*)xy));
	  tmp2 = hv_fetch(NODES, COORD_HV_VAL(min_node), COORD_HV_LEN(min_node), 0);
	  if (!tmp2) break;
	  sn = (search_node*)SvIV(*tmp2);
	  if (sn->predecessor == 0) break;
#ifdef USE_MMAP_IMPL
	  {
	    int x2,y2;
	    int *mmap_ptr = (int*)(c_net_mmap + sn->predecessor);
	    x2 = *(mmap_ptr++);
	    y2 = *mmap_ptr;
	    len += _strecke(x,y,x2,y2);
	  }
#else
	  len += _strecke(min_node, sn->predecessor);
#endif
	  min_node = sn->predecessor;
	}

	//XXX $visited_nodes = scalar(keys %OPEN) + scalar(keys %CLOSED);

	/* using sv_2mortal seems to be necessary */
	Inline_Stack_Reset;
	Inline_Stack_Push(sv_2mortal(newRV_noinc((SV*)path)));
	Inline_Stack_Push(sv_2mortal(newSViv((int)len)));
	Inline_Stack_Push(sv_2mortal(newSViv(0)));
	Inline_Stack_Push(sv_2mortal(newSViv(0)));
	Inline_Stack_Push(&PL_sv_undef);
	Inline_Stack_Done;

	goto done;
      }

#ifdef DEBUG_MINNODE
      fprintf(stderr, "- dump minnode ----------------------------\n");
#ifdef USE_MMAP_IMPL
      _dump_ptr(c_net_mmap, min_node, 1);
#else
      _dump_node(min_node, 1);
#endif
#endif

#ifdef DEBUG_SUCC
      fprintf(stderr, "----------\n"); /* mark start of next iteration */
#endif

      {
#ifdef USE_MMAP_IMPL
	int *mmap_ptr = (int*)(c_net_mmap + min_node);
	int no_succ;
	int succ_i;
	SV** node_sv = hv_fetch(NODES, COORD_HV_VAL(min_node), COORD_HV_LEN(min_node), 0);
	search_node* sn = (search_node*)SvIV(*node_sv);
# ifdef DEBUG_MMAP_IMPL
	fprintf(stderr, "<%ld><%d><%d>x=<%d> y=<%d> no=<%d> hdist=<%d>\n", (long)c_net_mmap, min_node,mmap_ptr, *mmap_ptr,*(mmap_ptr+1),*(mmap_ptr+2), sn->heuristic_dist );
# endif
	mmap_ptr+=2; /* skip x, y coordinate */
	no_succ = *(mmap_ptr++);
	for(succ_i=0; succ_i<no_succ; succ_i++) {
	  int succ_key = *(mmap_ptr++);
	  int succ_key_len = sizeof(int);
	  dist_t len_pen = *(mmap_ptr++);
#else /* USE_MMAP_IMPL */
	HE* succ_he;
	SV** tmp2 = hv_fetch(net, min_node, min_node_len, 0);
	HV* min_node_net = (HV*)SvRV(*tmp2);
	SV** node_sv = hv_fetch(NODES, min_node, min_node_len, 0);
	search_node* sn = (search_node*)SvIV(*node_sv);
	hv_iterinit(min_node_net);

	while(succ_he = hv_iternext(min_node_net)) {
	  STRLEN succ_key_len;
	  char* succ_key = HePV(succ_he, succ_key_len);
	  dist_t len_pen;
#endif /* USE_MMAP_IMPL */

	  /* do not check against the predecessor of this node */
#ifdef USE_MMAP_IMPL
	  if (sn->predecessor != 0 && sn->predecessor == succ_key)
	    continue;
#else
	  if (sn->predecessor != NULL && strcmp(sn->predecessor, succ_key) == 0)
	    continue;
#endif

	  if (wegfuehrung) {
	    SV** tmp2 = hv_fetch(wegfuehrung, COORD_HV_VAL(succ_key), succ_key_len, 0);
	    if (tmp2) {
	      int do_continue = 0;
	      AV* wegfuehrungen = (AV*)SvRV(*tmp2);
	      int j;
	      for(j=0; j<=av_len(wegfuehrungen); j++) {
		SV** tmp3 = av_fetch(wegfuehrungen, j, 0);
		AV* wegf = (AV*)SvRV(*tmp3);
#ifdef USE_MMAP_IMPL
		int this_node = min_node;
#else
		char* this_node = min_node;
#endif
		int same = 1;
		int i;
		for(i=av_len(wegf)-1; i>=0; i--) {
		  tmp3 = av_fetch(wegf, i, 0);
#ifdef USE_MMAP_IMPL
		  if (memcmp(SvPV(*tmp3, PL_na), COORD_HV_VAL(this_node),
			     sizeof(int)) != 0) {
#else
		  if (strcmp(SvPV(*tmp3, PL_na), this_node) != 0) {
#endif
		    same = 0;
		    break;
		  }
		  if (i > 0) {
		    search_node *this_sn;
		    tmp3 = hv_fetch(NODES, COORD_HV_VAL(this_node), COORD_HV_LEN(this_node), 0);
		    this_sn = (search_node*)SvIV(*tmp3);
		    if (this_sn->predecessor == 0) {
		      same = 0;
		      break;
		    }
		    this_node = this_sn->predecessor;
		  }
		}
		if (same) {
		  do_continue = 1;
		  break;
		}
	      }
	      if (do_continue) continue;
	    }
	  }

	  /* XXX statistics, canvas drawing etc. missing */

	  {
	    dist_t g, f;
	    dist_t remaining_dist;
#ifndef USE_MMAP_IMPL
	    len_pen = SvIV(HeVAL(succ_he));
#endif

	    if (penaltysub != Nullsv) {
	      /* call penaltysub with
	       * * succ_key = next_node
	       * * min_node = last_node
	       * * len_pen
	       * returned value is new len_pen
	       */

	      /* Using Inline_Stack_Reset et al. as advertised in
		 Inline::C-Cookbook does not work! */
	      ENTER;
	      SAVETMPS;

	      PUSHMARK(SP);
#ifdef USE_MMAP_IMPL
	      STMT_START {
		SV* succ_key_sv = newSVpvn("", 0);
		sv_catpvf(succ_key_sv, "%d,%d", 
			  *((int*)(c_net_mmap + succ_key)),
			  *(((int*)(c_net_mmap + succ_key))+1));
		Inline_Stack_Push(sv_2mortal(succ_key_sv));
	      } STMT_END;
	      STMT_START {
		SV* min_node_sv = newSVpvn("", 0);
		sv_catpvf(min_node_sv, "%d,%d", 
			  *((int*)(c_net_mmap + min_node)),
			  *(((int*)(c_net_mmap + min_node))+1));
		Inline_Stack_Push(sv_2mortal(min_node_sv));
	      } STMT_END;
#else
	      Inline_Stack_Push(sv_2mortal(newSVpvn(succ_key, succ_key_len)));
	      Inline_Stack_Push(sv_2mortal(newSVpvn(min_node, min_node_len)));
#endif
	      Inline_Stack_Push(sv_2mortal(newSViv(len_pen))); // XXX depends on dist_t!!!
	      PUTBACK;
	      if (call_sv(penaltysub, G_SCALAR) != 1)
		croak("call_sv return value should be 1");

	      SPAGAIN;
	      len_pen = POPi;

	      PUTBACK;
	      FREETMPS;
	      LEAVE;
	    }

#if 0
	    /* XXX Das hier macht
	     * den Unterschied aus.
	     * Wenn dieser Codeteil
	     * drinnen ist, dann
	     * verh�lt sich C-A*-2
	     * genau so falsch wie
	     * C-A*.
	     */
	    if (len_pen >= INFINITY) { /* INFINITY also means "blocked" */
	      continue;
	    }
#endif

	    g = sn->dist + len_pen;
#ifdef USE_MMAP_IMPL
	    {
	      int* mmap_ptr = (int*)(c_net_mmap+succ_key);
	      int succ_x = *(mmap_ptr++);
	      int succ_y = *(mmap_ptr++);
	      remaining_dist = _strecke(succ_x, succ_y, to_x, to_y);
	    }
#else
	    remaining_dist = _strecke(succ_key, to);
#endif
	    f = g + remaining_dist;

#ifdef DEBUG_SUCC
#ifdef USE_MMAP_IMPL
	    _dump_ptr(c_net_mmap, succ_key, 0);
#else
	    _dump_node(succ_key, 0);
#endif
	    fprintf(stderr, "this=%d f=%d g=%d\n", len_pen, f, g);
#endif

	    /* !exists in OPEN and !exists in CLOSED */
	    if (!hv_exists(NODES, COORD_HV_VAL(succ_key), succ_key_len)) {
	      search_node* new_sn = malloc(sizeof(search_node));
	      if (!new_sn) croak("Cannot malloc");
	      new_sn->predecessor = min_node;
	      new_sn->dist = g;
	      new_sn->heuristic_dist = f;
	      hv_store(NODES, COORD_HV_VAL(succ_key), succ_key_len, newSViv((IV)new_sn), 0);
#ifdef HAS_HEAP
	      heap_insert(OPEN_heap, (void*) succ_key);
#else
	      hv_store(OPEN, COORD_HV_VAL(succ_key), succ_key_len, &PL_sv_yes, 0);
#endif
	      if (remaining_dist < nearest_node_dist) {
		nearest_node_dist = remaining_dist;
		nearest_node = min_node;
	      }
	    } else {
	      SV** tmp2 = hv_fetch(NODES, COORD_HV_VAL(succ_key), succ_key_len, 0);
	      search_node* old_sn = (search_node*)SvIV(*tmp2);
	      if (f < old_sn->heuristic_dist) {
		old_sn->predecessor = min_node; /*XXX free old predecessor? */
		old_sn->dist = g;
		old_sn->heuristic_dist = f;
		if (hv_exists(CLOSED, COORD_HV_VAL(succ_key), succ_key_len)) {
#ifdef HAS_HEAP
		  heap_insert(OPEN_heap, (void*) succ_key);
#else
		  hv_store(OPEN, COORD_HV_VAL(succ_key), succ_key_len, &PL_sv_yes, 0);
#endif
		  tmp = hv_delete(CLOSED, COORD_HV_VAL(succ_key), succ_key_len, G_DISCARD);
		  if (tmp != Nullsv) SvREFCNT_dec(tmp);
		} else { /* exists in OPEN */
#ifdef HAS_HEAP
		  /* Delete old value from heap and insert new value.
		   * Unfortunately this is an expensive operation.
		   */
		  int i = 1;
		  void *heap_elem = heap_element(OPEN_heap, i);
		  for(; heap_elem != NULL; i++, heap_elem = heap_element(OPEN_heap, i)) {
		    //fprintf(stderr, "%d == %d?\n", heap_elem, succ_key);
		    if (heap_elem == (void*)succ_key) {
		      //fprintf(stderr, "Found at %d!\n", i);
		      heap_delete(OPEN_heap, i);
		      break;
		    }
		  }
		  heap_insert(OPEN_heap, (void*) succ_key);
		  //fprintf(stderr, "Expensive loop out!\n");
#endif
		}
	      }
	    }
	  }
	}
      }

    }

  }

done:
#ifdef HAS_HEAP
  if (OPEN_heap) {
    heap_free(OPEN_heap);
  }
#else
  SvREFCNT_dec(OPEN);
#endif
  SvREFCNT_dec(CLOSED);

#if defined(DEBUG_DUMP_NODES)
  {
#if defined(USE_MMAP_IMPL)
    HV* c_net_ptr2coord = newHV();
    hv_iterinit(c_net_coord2ptr);
    {
      HE* he;
      while(he = hv_iternext(c_net_coord2ptr)) {
	SV* key_sv = hv_iterkeysv(he);
	SV* val_sv = hv_iterval(c_net_coord2ptr, he);
	int val_len;
	char* val = SvPV(val_sv, val_len);
	hv_store(c_net_ptr2coord, val, val_len, key_sv, 0);
      }
    }
#endif

    if (!hv_iterinit(NODES))
      croak("Cannot iterate NODES");

    {
      HE* NODES_he;
      SV* ptrIV = sv_2mortal(newSViv(0));
      while(NODES_he = hv_iternext(NODES)) {
	SV* node_sv = hv_iterval(NODES, NODES_he);
	search_node* sn = (search_node*)SvIV(node_sv);
#ifdef USE_MMAP_IMPL
	int pred_x = *((int*)(c_net_mmap + sn->predecessor));
	int pred_y = *(((int*)(c_net_mmap + sn->predecessor))+1);
#else
	char* pred_node = sn->predecessor;
#endif

	I32 keylen;
	char* key = hv_iterkey(NODES_he, &keylen);
	char* coord_ch;
#ifdef USE_MMAP_IMPL
	SV** coord;
	int ptr = *(int*)key;
	char* ptrIVch;
	int ptrIVlen;
	sv_setiv(ptrIV, ptr);
	ptrIVch = SvPV(ptrIV, ptrIVlen);
	coord = hv_fetch(c_net_ptr2coord, ptrIVch, ptrIVlen, 0);
	coord_ch = (coord ? SvPV(*coord, PL_na) : "?");
#else
	coord_ch = key;
#endif

#ifdef USE_MMAP_IMPL
	warn("f=%d g=%d\tX; %d,%d %s\n", sn->dist, sn->heuristic_dist, pred_x, pred_y, coord_ch);
#else
	warn("f=%d g=%d\tX; %s %s\n", sn->dist, sn->heuristic_dist, pred_node, coord_ch);
#endif
      }
    }
  }
#endif

  if (hv_iterinit(NODES)) {
    HE* NODES_he;
    while(NODES_he = hv_iternext(NODES)) {
      SV* node_sv = hv_iterval(NODES, NODES_he);
      search_node* sn = (search_node*)SvIV(node_sv);
      free(sn);
    }
  }
  SvREFCNT_dec(NODES);

  return;

}
