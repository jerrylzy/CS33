//
//  main.c
//  arealloc
//
//  Created by Jerry Liu on 10/1/15.
//  Copyright © 2015 Jerry Liu. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void* arealloc(void* ptr, size_t nmemb, size_t size);

int main(void) {
    
    char* p = (char*) malloc(sizeof(char) * 10);
    p = (char*) arealloc(p, 0xffffffffffffffff, sizeof(char));
    if (p == NULL)
        printf("%s \n", "Looks good!!!");
    else
        printf("%s \n", "Something's wrong!!!");
    
    free(p);

    p = (char*) arealloc(p, 10, sizeof(char));
    if (p != NULL)
        printf("%s \n", "Looks good!!!");
    else
        printf("%s \n", "Something's wrong!!!");
    
    free(p);
    return 0;
}

void* arealloc(void* ptr, size_t nmemb, size_t size)
{
    if (size && (nmemb * size / size != nmemb))
    {
        errno = ENOMEM;
        return NULL;
    }
    return realloc(ptr, nmemb * size);
}