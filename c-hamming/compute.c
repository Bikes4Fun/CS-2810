#include "compute.h"

int compute(char *a, char *b){
    int count = 0;
    int i = 0;
    char ai =  a[i];
    char bi = b[i];

    while (ai != '\0' && bi != '\0') {
        int cond = ai != bi;
        count += cond;
        i++;
        ai = a[i];
        bi = b[i];
    }
    if ((bi | ai) != 0){
        return -1;
    }
    return count;
}
