//
//  arealloc.c
//  arealloc
//
//  Created by Jerry Liu on 10/1/15.
//  Copyright © 2015 Jerry Liu. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

void* arealloc(void* ptr, size_t nmemb, size_t size)
{
    if (size && (nmemb * size / size != nmemb))
    {
        errno = ENOMEM;
        return NULL;
    }
    return realloc(ptr, nmemb * size);
}