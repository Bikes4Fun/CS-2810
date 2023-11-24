#include <stdio.h>
#include "wordle.h"

int main(void) {
    char **word_list = read_word_list(WORD_LIST_FILENAME);

    printf("printing every 1000th word from the list\n");
    for (int i = 0; word_list[i]; i++) {
        if (i % 1000 == 0) {
            printf("word %d: %s\n", i, word_list[i]);
        }
    }

    free_word_list(word_list);
    return 0;
}
