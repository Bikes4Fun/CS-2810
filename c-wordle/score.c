#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

int score(char **word_list, char *candidate, guess *guesses, int guess_count) {
    int total_score = 0;

    for (int i = 0; word_list[i] != NULL; i++) {
        char *word = word_list[i];

        if (!is_viable_candidate(word, guesses, guess_count)) {
            continue; // Skip non-viable words
        }

        int word_score = 0;
        char copy[6];
        strcpy(copy, word);

        // Check for exact hits
        for (int j = 0; j < 5; j++) {
            if (candidate[j] == copy[j]) {
                word_score += EXACT_HIT_POINTS;
                copy[j] = '_'; // Cross off the letter
            }
        }

        // Check for partial hits
        for (int j = 0; j < 5; j++) {
            for (int k = 0; k < 5; k++) {
                if (candidate[j] == copy[k]) {
                    word_score += PARTIAL_HIT_POINTS;
                    copy[k] = '_'; // Cross off the letter
                    break; // To avoid double counting
                }
            }
        }

        total_score += word_score;
    }

    return total_score;
}
