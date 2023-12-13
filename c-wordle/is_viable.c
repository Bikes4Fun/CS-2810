#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

// Check if a candidate word is a viable option
bool is_viable_candidate (char *candidate, guess *guesses, int guess_count){
    for (int guess_index = 0; guess_index < guess_count; guess_index++){
        // Copy the candidate word
        char candidate_copy[6];
        strcpy(candidate_copy, candidate);

        // Check each letter
        for (int letter_index = 0; letter_index < 5; letter_index++){
            if (guesses[guess_index].feedback[letter_index] == EXACT_HIT){
                // Check letter for exact hit
                if (candidate_copy[letter_index] != guesses[guess_index].letters[letter_index]){
                    // if it's not the same, 
                    return false;
                }
                // else, mark the letter as "_"
                candidate_copy[letter_index] = '_';
            }
            for (int j = 0; j < 5; j++){
                // check if the letter is also a partial hit
                if (guesses[guess_index].feedback[j] == PARTIAL_HIT){
                    if (candidate_copy[j] == guesses[guess_index].letters[j]){
                        return false;
                    }
                }
            }
        }
        for (int j = 0; j < 5; j++){
            if (guesses[guess_index].feedback[j] == PARTIAL_HIT){
                int found = 0;
                for (int k = 0; k < 5; k++){
                    if (candidate_copy[k] == guesses[guess_index].letters[j]){
                        candidate_copy[k] = '_';
                        found = 1;
                        break;
                    }
                }
                // if no match, it's not viable.
                if(!found){
                    return false;
                }
            }
        }
        for (int j = 0; j < 5; j++){
            if (guesses[guess_index].feedback[j] == MISS){
                for (int k = 0; k < 5; k++){
                    if (candidate_copy[k] == guesses[guess_index].letters[j]){
                        return false;
                    }
                }
            }
        }
    }
    // if all checks were true, it's a viable option.
    return true;
}
