#include "util.h"
#include "func.h"

void filter(int *array, int X, int Y, int Z, int * seed, int N, FILE *ofp){
	long long func_start = get_time();
	double xr = round(Y/2.0);
	double yr = round(X/2.0);

	int radius = 5;
	int diameter = radius*2-1;
	int *radiusMatrix = (int *)malloc(diameter*diameter*sizeof(int));
	fillMatrix(radiusMatrix, radius);

	int Ones = 0;
	int x, y;
	for(x = 0; x < diameter; x++){
		for(y = 0; y < diameter; y++){
			if(radiusMatrix[x*diameter + y] == 1)
				Ones++;
		}
	}

	double * objxy = (double *)malloc(Ones*2*sizeof(double));
	getNeighbors(radiusMatrix, Ones, objxy, radius);

	double *weights = (double *)malloc(sizeof(double)*N);
	double *arrayX = (double *)malloc(sizeof(double)*N);
	double *arrayY = (double *)malloc(sizeof(double)*N);

	func0(weights, arrayX, arrayY, xr, yr, N);

	double * probability = (double *)malloc(sizeof(double)*N);
	double * x_j = (double *)malloc(sizeof(double)*N);
	double * y_j = (double *)malloc(sizeof(double)*N);
	double * cfd = (double *)malloc(sizeof(double)*N);
	double * u = (double *)malloc(sizeof(double)*N);
	int * index = (int*)malloc(sizeof(int)*Ones*N);

	int i, j;
	for(i = 1; i < Z; i++) {
		func1(seed, array, arrayX, arrayY, probability, objxy, index, Ones, i, X, Y, Z, N);

		func2(weights, probability, N);

		double x_e = 0;
		double y_e = 0;

		func3(arrayX, arrayY, weights, &x_e, &y_e, N);
		fprintf(ofp, "%f\n", x_e);
		fprintf(ofp, "%f\n", y_e);

		cfd[0] = weights[0];
		for(j = 1; j < N; j++){
			cfd[j] = weights[j] + cfd[j-1];
		}
		double u1 = (1/((double)(N)))*rand1(seed, 0);

		func4(u, u1, N);

		func5(x_j, y_j, arrayX, arrayY, weights, cfd, u, N);
	}

	long long func_end = get_time();
	printf("FUNC TIME : %f\n", elapsed_time(func_start, func_end));
	//fflush();

	for(i=0; i<Ones*2; i++) {
		fprintf(ofp, "%f\n", objxy[i]);
	}
	for(i=0; i<N; i++) {
		fprintf(ofp, "%f %f %f %f %f %f %f %f\n",
			weights[i], arrayX[i], arrayY[i],
			probability[i], x_j[i], y_j[i],
			cfd[i], u[i]);
	}
	for(i=0; i<Ones*N; i++) {
		fprintf(ofp, "%d\n", index[i]);
	}

	free(radiusMatrix);
	free(objxy);
	free(weights);
	free(probability);
	free(x_j);
	free(y_j);
	free(arrayX);
	free(arrayY);
	free(cfd);
	free(u);
	free(index);
}
