#include <stdio.h>
#include <stdlib.h>

void print_diamond(int n){
    if (n == 1){
        printf("*\n");
        printf("");
    }
    else {
        //char *star = malloc(n+1);
        char *spaces = malloc(n+n+1);
        for (int i = 0; i < n; i++){
            spaces[i] = ' ';
            //printf("%s\n", spaces);
        }
        spaces[n-1]='*';
        printf("%s\n", spaces);
        spaces[n]= '*';
        int i = 1;
        do {
            spaces[n-1-i] = '*';
            spaces[n+i+1] = '*';
            i++;
            printf("%s\n", spaces);
        } while(spaces[0] != '*');
        for (i = n; i > 0; i--) {
            spaces[n-i] = ' ';
            spaces[n+i] = '\n'; 
            
            printf("%s", spaces);
        }


        //printf("\n");
        free(spaces);
    }
}

