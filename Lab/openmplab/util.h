#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>
#include <limits.h>
#define PI acos(-1)

long long get_time();
float elapsed_time(long long start_time, long long end_time);
double round(double value);
double rand1(int * seed, int index);
double rand2(int * seed, int index);
void init(int test, int newValue, int *array, int *X, int *Y, int *Z);
void addSeed(int *array, int *X, int *Y, int *Z, int *seed);
void fillMatrix(int * disk, int radius);
void dilateMatrix(int *matrix, int pos_x, int pos_y, int pos_z, int dimX, int dimY, int dimZ, int error);
void imdilateDisk(int *matrix, int dimX, int dimY, int dimZ, int error, int *newMatrix);
void getNeighbors(int * se, int ones, double * neighbors, int radius);
void sequence(int *array, int X, int Y, int Z, int * seed);
double calcProbSum(int * array, int * index, int ones);
int findIndex(double * cdf, int lengthCDF, double value);
int findIndexBin(double * cdf, int beginIndex, int endIndex, double value);
