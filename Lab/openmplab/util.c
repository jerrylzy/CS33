#include "util.h"

// get time
long long get_time() {
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (tv.tv_sec * 1000000) + tv.tv_usec;
}

// returns elapsed time
float elapsed_time(long long start_time, long long end_time) {
        return (float) (end_time - start_time) / (1000 * 1000);
}

// return rounded value
double round(double value){
	int newValue = (int)(value);
	if(value - newValue < .5)
	return newValue;
	else
	return newValue++;
}

// random number generator
double rand1(int * seed, int index)
{
	int num = 1102415245*seed[index] + 12346;
	seed[index] = num % INT_MAX;
	return fabs(seed[index]/((double) INT_MAX));
}

// random number generator
double rand2(int * seed, int index){
	double u = rand1(seed, index);
	double v = rand1(seed, index);
	double cosine = cos(2*PI*v);
	double rt = -2*log(u);
	return sqrt(rt)*cosine;
}

// initialize the 3 dimentional array
void init(int test, int newValue, int *array, int *X, int *Y, int *Z){
	int x, y, z;
	for(x = 0; x < *X; x++){
		for(y = 0; y < *Y; y++){
			for(z = 0; z < *Z; z++){
				if(array[x * *Y * *Z+y * *Z + z] == test)
				array[x * *Y * *Z + y * *Z + z] = newValue;
			}
		}
	}
}


// Add seed
void addSeed(int *array, int *X, int *Y, int *Z, int *seed){
	int x, y, z;
	for(x = 0; x < *X; x++){
		for(y = 0; y < *Y; y++){
			for(z = 0; z < *Z; z++){
				array[x * *Y * *Z + y * *Z + z] = array[x * *Y * *Z + y * *Z + z] + (int)(5*rand2(seed, 0));
			}
		}
	}
}

void fillMatrix(int * disk, int radius)
{
	int diameter = radius*2 - 1;
	int x, y;
	for(x = 0; x < diameter; x++){
		for(y = 0; y < diameter; y++){
			double distance = sqrt(pow((double)(x-radius+1),2) + pow((double)(y-radius+1),2));
			if(distance < radius)
			disk[x*diameter + y] = 1;
		}
	}
}

void dilateMatrix(int *matrix, int pos_x, int pos_y, int pos_z, int dimX, int dimY, int dimZ, int error)
{
	int beginX = pos_x - error;
	while(beginX < 0)
	beginX++;
	int beginY = pos_y - error;
	while(beginY < 0)
	beginY++;
	int endX = pos_x + error;
	while(endX > dimX)
	endX--;
	int endY = pos_y + error;
	while(endY > dimY)
	endY--;
	int x,y;
	for(x = beginX; x < endX; x++){
		for(y = beginY; y < endY; y++){
			double distance = sqrt( pow((double)(x-pos_x),2) + pow((double)(y-pos_y),2) );
			if(distance < error)
			matrix[x*dimY*dimZ + y*dimZ + pos_z] = 1;
		}
	}
}

void imdilateDisk(int *matrix, int dimX, int dimY, int dimZ, int error, int *newMatrix)
{
	int x, y, z;
	for(z = 0; z < dimZ; z++){
		for(x = 0; x < dimX; x++){
			for(y = 0; y < dimY; y++){
				if(matrix[x*dimY*dimZ + y*dimZ + z] == 1){
					dilateMatrix(newMatrix, x, y, z, dimX, dimY, dimZ, error);
				}
			}
		}
	}
}

void getNeighbors(int * se, int ones, double * neighbors, int radius){
	int x, y;
	int neighY = 0;
	int center = radius - 1;
	int diameter = radius*2 -1;
	for(x = 0; x < diameter; x++){
		for(y = 0; y < diameter; y++){
			if(se[x*diameter + y]){
				neighbors[neighY*2] = (int)(y - center);
				neighbors[neighY*2 + 1] = (int)(x - center);
				neighY++;
			}
		}
	}
}

void sequence(int *array, int X, int Y, int Z, int * seed){
	int k;
	int max_size = X*Y*Z;

	int x0 = (int)round(Y/2.0);
	int y0 = (int)round(X/2.0);
	array[x0 *Y *Z + y0 * Z  + 0] = 1;

	int xk, yk, pos;
	for(k = 1; k < Z; k++){
		xk = abs(x0 + (k-1));
		yk = abs(y0 - 2*(k-1));
		pos = yk * Y * Z + xk *Z + k;
		if(pos >= max_size)
		pos = 0;
		array[pos] = 1;
	}

	int * newMatrix = (int *)malloc(sizeof(int)*X*Y*Z);
	imdilateDisk(array, X, Y, Z, 5, newMatrix);
	int x, y;
	for(x = 0; x < X; x++){
		for(y = 0; y < Y; y++){
			for(k = 0; k < Z; k++){
				array[x*Y*Z + y*Z + k] = newMatrix[x*Y*Z + y*Z + k];
			}
		}
	}
	free(newMatrix);

	/*define background, add noise*/
	init(0, 100, array, &X, &Y, &Z);
	init(1, 228, array, &X, &Y, &Z);
	/*add noise*/
	addSeed(array, &X, &Y, &Z, seed);
}

double calcProbSum(int * array, int * index, int ones){
	double probSum = 0.0;
	int y;
	for(y = 0; y < ones; y++)
		probSum += (pow((array[index[y]] - 100),2) - pow((array[index[y]]-228),2))/50.0;
	return 	probSum;
}

int findIndex(double * cdf, int lengthCDF, double value){
	int index = -1;
	int x;
	for(x = 0; x < lengthCDF; x++){
		if(cdf[x] >= value){
			index = x;
			break;
		}
	}
	if(index == -1){
		return lengthCDF-1;
	}
	return index;
}

int findIndexBin(double * cdf, int beginIndex, int endIndex, double value){
	if(endIndex < beginIndex)
	return -1;
	int middleIndex = beginIndex + ((endIndex - beginIndex)/2);
	if(cdf[middleIndex] >= value)
	{
		if(middleIndex == 0)
		return middleIndex;
		else if(cdf[middleIndex-1] < value)
		return middleIndex;
		else if(cdf[middleIndex-1] == value)
		{
			while(middleIndex > 0 && cdf[middleIndex-1] == value)
			middleIndex--;
			return middleIndex;
		}
	}
	if(cdf[middleIndex] > value)
	return findIndexBin(cdf, beginIndex, middleIndex+1, value);
	return findIndexBin(cdf, middleIndex-1, endIndex, value);
}
