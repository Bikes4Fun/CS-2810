Check board
===========

81.  The board is fully solved
-1.  The board is unsolvable (there are cells with no pencil marks left)
0-80.  The board is unsolved, but may still be solvable.

check_board(board):
    -1: board is unsolvable
    0-80: position of most-constrained cell
    81: board is solved

in the file `check_board.s`.

scan the entire board

count pencil marks in each cell.
If any cell has 0 pencil marks, return -1.
If all cells == 1 bit: board solved, return 81.

else: return index of the unsolved cell
    with the fewest pencil marks.
    
In the event of a tie:
    return the first index with the fewest pencil marks (0-80).

This function examines all positions of the board, but it does not
care about rows, columns, and boxes, so there is no need to use the
lookup table. You can just loop over the 81 positions of the board
in order.

I suggest the following approach:

*   Start with two variables, `most_constrained_index` and
    `most_constrained_count`. Set the initial value of
    `most_constrained_count` to 10 (a number larger than the highest
    possible number of pencil marks), and set the initial value of
    `most_constrained_index` to 81.

*   Examine each cell in order and count the pencil marks. If you
    find zero, return -1 immediately. If you find one, continue the
    loop. If you find more than one, check if this is the new winner
    (the number is less than `most_constrained_count`). If it is,
    record the index of current index in `most_constrained_index`
    and the pencil mark count in `most_constrained_count`.

*   If you reach the end of the loop, return
    `most_constrained_index`. Note that it will still be 81 (its
    initial value) if there were no unsolved squares, and it will be
    the index of the first cell with the lowest pencil mark count
    otherwise.
