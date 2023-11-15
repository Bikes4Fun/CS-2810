#include "difference_of_squares.h"
#include <stdio.h>
#include <math.h>

unsigned int sum_of_squares(unsigned int number)
{
    int sum = 0;
    int sq = 0;
    for (unsigned int i = 0; i < number; i++)    
        {
            sq = pow((number-i), 2);
            sum += sq;
        }
    return sum;
}

unsigned int square_of_sum(unsigned int number)
{
    return number*number;
}

unsigned int difference_of_squares(unsigned int number)
{
    return square_of_sum(number) - sum_of_squares(number);
}
