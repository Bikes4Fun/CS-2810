#include <stdio.h>
#include "wordle.h"

int main(void) {
    //char **word_list = read_word_list(WORD_LIST_FILENAME);
    int guess_count = 0;
    guess guesses[6];

    char line[32];
    while (guess_count < 6 && fgets(line, 32, stdin) != NULL) {
        guesses[guess_count++] = parse_guess(line);
    }

    printf("Here are the %d guesses that I read:\n", guess_count);
    for (int i = 0; i < guess_count; i++) {
        for (int j = 0; j < 5; j++) {
            switch (guesses[i].feedback[j]) {
            case MISS:
                printf("%c", guesses[i].letters[j]);
                break;
            case EXACT_HIT:
                printf("[%c]", guesses[i].letters[j]);
                break;
            case PARTIAL_HIT:
                printf("(%c)", guesses[i].letters[j]);
                break;
            default:
                printf("?");
            }
        }
        if (guesses[i].letters[5] != '\0')
            printf("{missing terminating null}");
        printf("\n");
    }

    //free_word_list(word_list);
    return 0;
}
