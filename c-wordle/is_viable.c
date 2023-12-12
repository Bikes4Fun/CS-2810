#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

bool is_viable_candidate (char *candidate, guess *guesses, int guess_count){
    for (int i = 0; i < guess_count; i++){
        char copy[6];
        strcpy(copy, candidate);

        for (int j = 0; j < 5; j++){
            if (guesses[i].feedback[j] == EXACT_HIT){
                if (copy[j] != guesses[i].letters[j]){
                    return false;
                }
                copy[j] = '_';
            }
            for (int j = 0; j < 5; j++){
                if (guesses[i].feedback[j] == PARTIAL_HIT){
                    if (copy[j] == guesses[i].letters[j]){
                        return false;
                    }
                }
            }   
        }   
        for (int j = 0; j < 5; j++){
            if (guesses[i].feedback[j] == PARTIAL_HIT){
                int a = 0;
                for (int k = 0; k < 5; k++){
                    if (copy[k] == guesses[i].letters[j]){
                        copy[k] = '_';
                        a = 1;
                        break;
                    }
                }
                if(!a){
                    return false;
                }
            }
        }
        for (int j = 0; j < 5; j++){
            if (guesses[i].feedback[j] == MISS){
                for (int k = 0; k < 5; k++){
                    if (copy[k] == guesses[i].letters[j]){
                        return false;
                    }
                }
            }
        }
    }
    return true;
}
