#include "func.h"
#include "util.h"

void func0(double *weights, double *arrayX, double *arrayY, int xr, int yr, int n)
{
    int i;
    double dx, dy, weight;
    weight = 1 / ((double)(n));
    dx = xr;
    dy = yr;
    
#pragma omp parallel for num_threads(30) firstprivate (n, weights, weight, arrayX, arrayY, dx, dy) private(i)
    for(i = 0; i < n; i++)
    {
        weights[i] = weight;
        arrayX[i] = dx;
        arrayY[i] = dy;
    }
}

void func1(int *seed, int *array, double *arrayX, double *arrayY,
           double *probability, double *objxy, int *index,
           int Ones, int iter, int X, int Y, int Z, int n)
{
    int i, j, k;
   	int index_X, index_Y;
    int arrayIndex, arrayValue, indexValue;
    double prob, one;
    int max_size = X * Y * Z;
    one = (double) Ones;
    
#pragma omp parallel for num_threads(30) firstprivate(n, seed, arrayX, arrayY) private(i)
   	for(i = 0; i < n; i++)
    {
        arrayX[i] += 1 + 5 * rand2(seed, i);
        arrayY[i] += -2 + 2 * rand2(seed, i);
   	}
    
#pragma omp parallel for num_threads(30) firstprivate(Ones, n, iter, Y, Z, max_size, arrayX, arrayY, objxy, index, array) private(i, j, k, index_X, index_Y, arrayIndex, arrayValue, indexValue)
    for(i = 0; i < n; i++)
    {
        arrayIndex = i * Ones;
        for(j = 0; j < Ones; j++)
        {
            k = j * 2;
            index_X = round(arrayX[i]) + objxy[k + 1];
            index_Y = round(arrayY[i]) + objxy[k];
            arrayValue = fabs(index_X * Y * Z + index_Y * Z + iter);
            index[arrayIndex + j] = (arrayValue >= max_size) ? 0 : arrayValue;
        }
        prob = 0;
        
        for(j = 0; j < Ones; j++)
        {
            indexValue = array[index[arrayIndex + j]];
            prob += (pow((indexValue - 100), 2) -
                     pow((indexValue - 228), 2)) / 50.0;
        }
        probability[i] = prob / one;
    }
}

void func2(double *weights, double *probability, int n)
{
    int i;
    double weight;
    double sumWeights = 0;
    
#pragma omp parallel for num_threads(30) firstprivate(n, weights, probability) private(i, weight) reduction(+:sumWeights)
    for(i = 0; i < n; i++)
    {
        weight = weights[i] * exp(probability[i]);
        weights[i] = weight;
        sumWeights += weight;
    }
    
#pragma omp parallel for num_threads(30) firstprivate(n, weights, sumWeights) private(i)
    for(i = 0; i < n; i++)
        weights[i] /= sumWeights;
}

void func3(double *arrayX, double *arrayY, double *weights, double *x_e, double *y_e, int n)
{
    double weight;
    double estimate_x = 0.0;
    double estimate_y = 0.0;
    int i;
    
#pragma omp parallel for num_threads(30) firstprivate(n, arrayX, arrayY, weights) private(i, weight) reduction(+:estimate_x, estimate_y)
    
    for(i = 0; i < n; i++)
    {
        weight = weights[i];
        estimate_x += arrayX[i] * weight;
        estimate_y += arrayY[i] * weight;
   	}
    
    *x_e = estimate_x;
    *y_e = estimate_y;
    
}

void func4(double *u, double u1, int n)
{
    int i;
    double m = (double) n;
    
#pragma omp parallel for num_threads(30) firstprivate(n, u, u1, m) private(i)
    for(i = 0; i < n; i++)
    {
        u[i] = u1 + i / m;
   	}
}

void func5(double *x_j, double *y_j, double *arrayX, double *arrayY, double *weights, double *cfd, double *u, int n)
{
    int i, j, m;
    double weight = 1 / ((double)(n));
    m = n - 1;
    
#pragma omp parallel for num_threads(30) firstprivate(n, m, cfd, u, arrayX, arrayY, x_j, y_j) private(i, j)
    for(j = 0; j < n; j++)
    {
        //i = findIndex(cfd, n, u[j]);
        i = findIndexBin(cfd, 0, n, u[j]);
        if(i == -1)
            i = m;
        x_j[j] = arrayX[i];
        y_j[j] = arrayY[i];
   	}
    
#pragma omp parallel for num_threads(30) firstprivate(n, weight, arrayX, arrayY, weights, x_j, y_j) private(i)
    for(i = 0; i < n; i++)
    {
        arrayX[i] = x_j[i];
        arrayY[i] = y_j[i];
        weights[i] = weight;
    }
}
