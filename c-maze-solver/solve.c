#include <stdio.h>
#include "solve.h"
#include <stdbool.h>

// write your code here
// note that solve.h is included. Look at that file
// to see what values are already defined for you and
// what your function signatures should match. You do not
// need to copy anything from main.c or solve.h into this file.

void print_maze(char field[SIZE_Y][SIZE_X]){
    for (int y = 0; y < SIZE_Y; y++){
        for (int x = 0; x < SIZE_X; x++){
            char current_char = field[y][x];
            putchar(current_char);
        }
        putchar('\n');
    }
}

void solve_maze(char field[SIZE_Y][SIZE_X]){
    bool changes = true;
    while (changes){
        changes = false;
        int y = 1;
        int x = 1;
        for (y=1; y < SIZE_Y-1; y++){
            for (x=1; x < SIZE_X-1; x++){
                if (field[y][x] == '.'){
                    int walls = 0;
                    if (field[y-1][x] == '@'){
                        walls++;
                    }
                    if (field[y+1][x] == '@'){
                        walls++;
                    }
                    if (field[y][x-1] == '@'){
                        walls++;
                    }
                    if (field[y][x+1] == '@'){
                        walls++;
                    }
                    if (walls >= 3){
                        changes = true;
                        field[y][x] = '@';
                    }
                }
            }
        }
    }
}
