#include <stdio.h>
#include <stdlib.h>

void print_diamond(int n){
    if (n == 1){
        printf("*\n");
        printf("");
    }
    else {
        //char *star = malloc(n+1);
        char *spaces = malloc(n+1);
        for (int i = 0; i < n; i++){
            spaces[i] = ' ';
            //printf("%s\n", spaces);
        }
        spaces[n]='\0';
        for (int i = 0; i < n; i++){
            spaces[n-i-1] = '*';
            spaces[n+i] = '*';
            printf("%s\n", spaces);
        }
        //printf("\n");
        free(spaces);
    }
}

