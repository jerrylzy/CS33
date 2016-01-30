#include "util.h"
#include "func.h"
#ifdef MTRACE
#include <mcheck.h>
#endif

int main(int argc, char * argv[]){
	long long start = get_time();
#ifdef MTRACE
	setenv("MALLOC_TRACE", "mtrace.out", 0);
	mtrace();
#endif

	int X=512, Y=512, Z=16, N=32768;
	int *seed = (int *)malloc(sizeof(int)*N);

	FILE *ifp, *ofp;
	ifp=fopen("seed.txt", "r");
	ofp=fopen("output.txt", "w");
	if(ifp==NULL || ofp==NULL) {
		fprintf(stderr, "ERROR: Can't open files.\n");
		exit(1);
	}

	int seed_item, i=0;
	while(fscanf(ifp, "%d\n", &seed_item)!=EOF) {
		seed[i] = seed_item;
		i++;
		if(i==N)
			break;
	}

	// malloc array
	int *array = (int *)malloc(sizeof(int)*X*Y*Z);

	// initialize array
	sequence(array, X, Y, Z, seed);

	filter(array, X, Y, Z, seed, N, ofp);

	for(i=0; i<X*Y*Z; i++) {
		fprintf(ofp, "%d\n", array[i]);
	}

	fclose(ifp);
	fclose(ofp);
	free(seed);
	free(array);

#ifdef MTRACE
	muntrace();
#endif
	long long end = get_time();
	printf("TOTAL TIME : %f\n", elapsed_time(start, end));
	return 0;
}
