#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "wordle.h"

// a convenient struct to store a potential guess along with its score
struct recommendation {
    int score;
    char word[6];
};

void recommend(char **word_list, guess *guesses, int guess_count) {
    struct recommendation recommendations[RECOMMENDATION_COUNT + 1];
    int num_recommendations = 0;

    for (int i = 0; word_list[i] != NULL; i++) {
        char *word = word_list[i];

        if (!is_viable_candidate(word, guesses, guess_count)) {
            continue;
        }

        int word_score = score(word_list, word, guesses, guess_count);

        // Add to recommendations
        recommendations[num_recommendations].score = word_score;
        strcpy(recommendations[num_recommendations].word, word);
        num_recommendations++;

        // Bubble up the new recommendation to its correct position
        for (int j = num_recommendations - 1; j > 0; j--) {
            if (recommendations[j].score > recommendations[j - 1].score ||
                (recommendations[j].score == recommendations[j - 1].score && strcmp(recommendations[j].word, recommendations[j - 1].word) < 0)) {
                struct recommendation temp = recommendations[j];
                recommendations[j] = recommendations[j - 1];
                recommendations[j - 1] = temp;
            } else {
                break;
            }
        }

        // Limit the list to RECOMMENDATION_COUNT
        if (num_recommendations > RECOMMENDATION_COUNT) {
            num_recommendations = RECOMMENDATION_COUNT;
        }
    }

    // Print top recommendations
    for (int i = 0; i < num_recommendations; i++) {
        printf("%d: %s\n", recommendations[i].score, recommendations[i].word);
    }

}
