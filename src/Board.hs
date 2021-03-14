module Board where

import Data.Array

type Position  = (Int, Int) -- (y, x)
type Direction = (Int, Int) -- (dy, dx)

newtype Board = Board (Array Position Char)

instance Show Board where
  show = unlines . boardRows
      
boardRows :: Board -> [String]
boardRows (Board brd) = [row r | r <- [rmin..rmax]]
  where
    ((rmin, cmin), (rmax, cmax)) = bounds brd
    row r = [brd ! (r, c) | c <- [cmin..cmax]]
