module Sokoban where

import Data.Array
import Data.List
import Data.Maybe

import Board

move :: Direction -> Board -> Board
move (dy, dx) brd@(Board brd') = Board (accum (const id) brd' (alist curr nxt1 nxt2))
  where
    (pos@(y, x), curr) = findPlayer brd
    pos1 = (y + dy, x + dx)
    pos2 = (y + 2 * dy, x + 2 * dx)
    nxt1 = brd'!pos1
    nxt2 = brd'!pos2

    alist :: Char -> Char -> Char -> [(Position, Char)]
    alist '@' ' ' _   = [(pos, ' '), (pos1, '@')]
    alist '@' '.' _   = [(pos, ' '), (pos1, '+')]
    alist '+' ' ' _   = [(pos, '.'), (pos1, '@')]
    alist '+' '.' _   = [(pos, '.'), (pos1, '+')]
    alist '@' '$' ' ' = [(pos, ' '), (pos1, '@'), (pos2, '$')]
    alist '@' '$' '.' = [(pos, ' '), (pos1, '@'), (pos2, '*')]
    alist '@' '*' ' ' = [(pos, ' '), (pos1, '+'), (pos2, '$')]
    alist '@' '*' '.' = [(pos, ' '), (pos1, '+'), (pos2, '*')]
    alist '+' '$' ' ' = [(pos, '.'), (pos1, '@'), (pos2, '$')]
    alist '+' '$' '.' = [(pos, '.'), (pos1, '@'), (pos2, '*')]
    alist '+' '*' ' ' = [(pos, '.'), (pos1, '+'), (pos2, '$')]
    alist '+' '*' '.' = [(pos, '.'), (pos1, '+'), (pos2, '*')]
    alist _ _ _       = []

findPlayer :: Board -> (Position, Char)
findPlayer (Board brd) = fromJust . find p $ assocs brd
  where p (_, e) = e == '@' || e == '+'
