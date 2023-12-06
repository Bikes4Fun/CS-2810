#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

guess parse_guess(char *line) {
        guess guess;
        char *arrow = line;

        for(int i = 0; i < 5; i++){
              char meme = *arrow;
              if(meme == '['){
                     //Exact hit
                     guess.letters[i] = *(arrow =1);
                     guess.feedback[i] = EXACT_HIT;
                     arrow += 3;
              }
              else if(meme == '('){
                     //Partial hit
                     guess.letters[i] = *(arrow +1);
                     guess.feedback[i] = PARTIAL_HIT;
                     arrow += 3;
              }
              else{
                     //Miss
                     guess.letters[i] = meme;
                     guess.feedback[i] = MISS;
                     arrow += 1;
              }
       }
      guess.letters[5] = '\0';
      return guess;
}
