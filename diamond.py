#include <stdio.h>
#include <stdlib.h>

def print_diamond(n):
    if (n == 1):
        print("*\n")
    else:
        spaces = []
        for i in range(n):
            spaces.append(' ')
        spaces[n-1]='*'
        spaces.append('\0')         #spaces[n] = '\0'
        print("%s\n", spaces)
        while (spaces[0] != '*'):
            spaces.append('*', [n-1-i])  #spaces[n-1-i] = '*'
            spaces.append('*', [n+i+1]) #spaces[n+i+1] = '*'
            print("%s\n", spaces)
            i+=1
        while (spaces[n] != '\n'): 
            pass

print_diamond(3)