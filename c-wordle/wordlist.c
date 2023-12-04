#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

char **read_word_list(char *filename) {
    int num_word_elements = 0;                          // track number of word in array
    int word_list_capacity = 32;             // track amount of memory that was allocated for word_list array
    char line[16];
    char **word_list = malloc(32* sizeof(char*));           // allocate memory for array of pointers

    FILE *word_file = fopen(filename, "r");             // open file?
    if (!word_file) {
        //handle file opening error
        printf("!word_list: ret NULL");
        return NULL;
    }

    while (fgets(line, 16, word_file) != NULL) {
        if ((strlen(line) != 6) || (line[5] != '\n')) continue;

        if (num_word_elements >= word_list_capacity) {
            char **new_list = realloc(word_list, (word_list_capacity*2 * (sizeof(char*))));
            if (!new_list) {
                // handle memory reallocation error
                free_word_list(word_list);              // Remember to free previously allocated memory
                fclose(word_file);
                return NULL;
            }
            word_list = new_list;
            word_list_capacity *= 2;
        }

        line[5] = '\0';                  // remove \n and replace with \0
        char *word = malloc(6 * sizeof(char));
        strcpy(word, line);
        word_list[num_word_elements++] = word;
    }
    fclose(word_file);
    return word_list;
}

void free_word_list(char **list) {
    int i = 0;
    while (list[i] != NULL) {
        free(list[i]);
        i++;
    }
    free(list);
}
