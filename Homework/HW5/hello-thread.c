#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
void* thread(void* vargp);

int main(int argc, char** argv)
{
    int i, nthreads;
    pthread_t* tid;

    if (argc != 2)
    {
        printf("Wrong Number of Arguments! \n");
        exit(1);
    }
    nthreads = atoi(argv[1]);
    tid = malloc(nthreads * sizeof(pthread_t));
    if (tid == NULL)
    {
        printf("Error Allocating Memory. \n");
        exit(1);
    }
    
    for (i = 0; i < nthreads; i++)
        pthread_create(&tid[i], NULL, thread, NULL);
    for (i = 0; i < nthreads; i++)
        pthread_join(tid[i], NULL);

    free(tid);
    exit(0);
}

void* thread(void* vargp) /* Thread routine */
{
    printf("Hello, world!\n");
    return NULL;
}
