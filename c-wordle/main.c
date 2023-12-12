#include <stdio.h>
#include "wordle.h"

int main(void) {
    char **word_list = read_word_list(WORD_LIST_FILENAME);
    int guess_count = 0;
    guess guesses[6];

    char line[32];
    while (guess_count < 6 && fgets(line, 32, stdin) != NULL) {
        guesses[guess_count++] = parse_guess(line);
    }

    for (char **words = word_list; *words; words++) {
        if (is_viable_candidate(*words, guesses, guess_count))
            printf("candidate \"%s\" has score %d\n", *words, score(word_list, *words, guesses, guess_count));
    }

    free_word_list(word_list);
    return 0;
}
