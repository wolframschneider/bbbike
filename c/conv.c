/*
 * $Id: conv.c,v 1.1 2001/05/20 11:01:05 eserte Exp $
 * Author: Slaven Rezic
 *
 * Copyright (C) 1999 Slaven Rezic. All rights reserved.
 *
 * Mail: eserte@cs.tu-berlin.de
 * WWW:  http://user.cs.tu-berlin.de/~eserte/
 *
 */

#include "bbbike.h"

// XXX verwenden!

void cp850_iso(char *s) {
  while(*s) {
    switch (*s) {
    case '\204': *s = '�'; break;
    case '\224': *s = '�'; break;
    case '\201': *s = '�'; break;
    case '\216': *s = '�'; break;
    case '\231': *s = '�'; break;
    case '\232': *s = '�'; break;
    case '\341': *s = '�'; break;
    case '\202': *s = '�'; break;
    case '\370': *s = '�'; break;
    }
    s++;
  }
}

void iso_cp850(char *s) {
  while(*s) {
    switch (*s) {
    case '�': *s = '\204'; break;
    case '�': *s = '\224'; break;
    case '�': *s = '\201'; break;
    case '�': *s = '\216'; break;
    case '�': *s = '\231'; break;
    case '�': *s = '\232'; break;
    case '�': *s = '\341'; break;
    case '�': *s = '\202'; break;
    case '�': *s = '\370'; break;
    }
    s++;
  }
}
