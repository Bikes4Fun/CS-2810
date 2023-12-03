// wordle.h
// #pragma once

// #define WORD_LIST_FILENAME "words.txt"
// #define EXACT_HIT_POINTS 5
// #define PARTIAL_HIT_POINTS 1
// #define RECOMMENDATION_COUNT 20

// enum feedback { MISS, EXACT_HIT, PARTIAL_HIT };
// typedef struct {
//     char letters[6];
//     enum feedback feedback[5];
// } guess;

// char **read_word_list(char *filename);
// void free_word_list(char **list);
// guess parse_guess(char *line);
// bool is_viable_candidate(char *candidate, guess *guesses, int guess_count);
// int score(char **word_list, char *candidate, guess *guesses, int guess_count);
// void recommend(char **word_list, guess *guesses, int guess_count);

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "wordle.h"

char **read_word_list(char *filename) {
    //track three values: the array itself, the number of elements in the array, the maximum number of elements in array(capacity)
    int word_bytes = 16;
    char **word_list = malloc(32*word_bytes);       // allocate memory for array of pointers
    int num_word_elements = 0;                      // track number of word in array
    int word_list_capacity = 32*word_bytes;         // track amount of memory that was allocated for word_list array
    FILE *word_file = fopen(filename, "r");                // open file?
    //read file
    //for each line in file
    //check if num_word_elements < word_list_capacity
    if ((num_word_elements*word_bytes) < word_list_capacity) {
        ;
    }
    else {
        word_list_capacity *= 2;
        //realloc **word_list *= 2;
    }

    num_word_elements ++;
    fclose(word_file);
    return word_list;
}

void free_word_list(char **list) {
    //Call `free(str)` once each word pointer that you allocated space for using `malloc`).
    //Call `free` one last time on the array itself.;
    int i = 0;
    while (list[i] != NULL) {
        free(list[i]);
        i++;
    }
    free(list);
}
