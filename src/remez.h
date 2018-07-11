#ifndef _SCIPY_PRIVATE_SIGNAL_SIGTOOLS_H_
#define _SCIPY_PRIVATE_SIGNAL_SIGTOOLS_H_

/*

#define BOUNDARY_MASK 12
#define OUTSIZE_MASK 3
#define FLIP_MASK  16
#define TYPE_MASK  (32+64+128+256+512)
#define TYPE_SHIFT 5

#define FULL  2
#define SAME  1
#define VALID 0

#define CIRCULAR 8
#define REFLECT  4
#define PAD      0 

#define MAXTYPES 21



typedef int intp;
typedef unsigned int uintp;

typedef struct {
  char *data;
  int elsize;
} Generic_ptr;

typedef struct {
  char *data;
  intp numels;
  int elsize;
  char *zero;        
} Generic_Vector;

typedef struct {
  char *data;
  int  nd;
  intp  *dimensions;
  int  elsize;
  intp  *strides;
  char *zero;       
} Generic_Array;

typedef void (MultAddFunction) (char *, intp, char *, intp, char *, intp *, intp *, int, intp, int, intp *, intp *, uintp *);

*/

void
scipy_signal_sigtools_linear_filter_module_init(void);

int pre_remez(double *h2, int numtaps, int numbands, double *bands,
              double *response, double *weight, int type, int maxiter,
              int grid_density);

#endif
