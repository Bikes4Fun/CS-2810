// The Sieve of Eratosthenes
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

bool calc_is_prime(int num);

void sieve(bool *array, int size){
    for (int i = 0; i < size; i++){
        array[i] = true;
    }
    int int_check = 1;
    bool is_prime = false;
    while (int_check * int_check <= size){
        int_check++;
        //calculate prime number
        if (array[int_check]){
            is_prime = calc_is_prime(int_check);
            if (is_prime){
                int multiple_of_prime = int_check;
                multiple_of_prime += int_check; 
                while (multiple_of_prime <= size){
                    array[multiple_of_prime] = false;
                    multiple_of_prime += int_check;
                }
            }
        }
    }
    return;
}

bool calc_is_prime(int num){
    if (num <= 3) {
        return true;
    }
    else if (num == 4){
        return false;
    }
    int i = 5;
    while (i * i <= num) {
        if (num - i * (num / i) == 0) {
            return false;
        }
        i += 2;
    }
    return true;
}

//     |--------------------TLDR----------------|
//     Variables:
//         * 'array'; an empty pointer. Initiate all to True
//         * 'size'; size of array. 
//     Goal:
//          * cross off non-prime values.
//          * ignore elements 0 and 1.
//          * check up to the square root of the largest vallue.
//          * do not use multiplication, division, or modulo
//     Return:
//          nothing; modify array in place.

//     |-----------------Details and tips--------------|
// *   You will be given a pointer to an array 'array' of a size given in variable 'size'.

// *   Initialize all elements of the array to true:
//          assume every number is prime (true)
//          cross off values (mark as false) that are not non-prime.
// *   You can ignore elements 0 and 1.# why

//     The approach is to iterate the list starting at 2, up to size.# why
//     By the time your iteration gets to a number: 
//        the list has #already #calculated it as prime or non-prime.

// *   You only need to check up to the square root of the largest number.
//     Any number larger than it's square roote has already been checked.
//          to test this, instead of taking the square root of size, 
//          try squaring your counter and compare that with size

// *   If the number is non-prime:
//          immediately skip to the next iteration.
//          # mark false??
// *   When you find a prime number:
//          every larger multiple of a prime number can not be prime     

//     You should not use multiplication, division, or modulo (remainder). 
//     The only exception is when testing if the outer loop is finished
//          (squaring the counter to compare it with the size of the list).

//     Each non-prime number may be crossed off multiple times.
//     but only once for each unique prime factor # what
//          that tends to be a small number.
//     This is much more efficient than testing each number individually.

//     You do not need to print or return anything.
//     When modifying an array in place, `main` will see the results.

//     Read through `main` to see how an array can be allocated and freed.
