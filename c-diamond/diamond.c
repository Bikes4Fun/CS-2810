#include <stdio.h>
#include <stdlib.h>


void print_line(int space, int star){
    for (int i = 0; i < space; i++) {
        printf(" ");
    }
    for (int i = 0; i < star; i++){
        printf("*");
    }
    printf("\n");
}

void print_diamond(int n){
    if (n == 1){
        printf("*\n");
    }
    else {
        int spaces = n-1;
        int stars = 1;
        do {
            //calculate stars, start with 1, increment by 2.
            //calculate spaces, start with n-1, decrement by 1.
        
            print_line(spaces, stars);
            spaces --; 
            stars += 2;
        } while (stars < n+n);
        spaces = 0;
        stars = n+n-1;
        do {
            spaces ++;
            stars = stars - 2;
            print_line(spaces, stars);
        } while (spaces < n-1);
    }

}

