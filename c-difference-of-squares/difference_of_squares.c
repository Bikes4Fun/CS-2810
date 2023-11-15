#include "difference_of_squares.h"
#include <stdio.h>
#include <math.h>

// def sum_of_squares(n):
//     sum_ = 0
//     for i in range(n):
//         sq=(n-i)**2
//         sum_+=sq
//     return sum_

unsigned int sum_of_squares(unsigned int number)
{
    int sum = 0;
    int sq = 0;
    for (unsigned int i = 0; i <= number; i++)    
        {
            sq = pow((number-i), 2);
            sum += sq;
        }
    return sum;
}

// def square_of_sum(n):
//     sum_ = 0
//     for i in range(n):
//         sum_ += (n-i)
//     sq = sum_ * sum_
//     return sq

unsigned int square_of_sum(unsigned int number)
{
    int sum = 0;
    for (unsigned int i = 0; i <= number; i++)    
        {
            sum += (number-i);
        }
    return pow((sum), 2);
}

unsigned int difference_of_squares(unsigned int number)
{
    return square_of_sum(number) - sum_of_squares(number);
}
