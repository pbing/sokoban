module Board where

import Data.Array

type Position  = (Int, Int) -- (y, x)
type Direction = (Int, Int) -- (dy, dx)
newtype Board = Board (Array Position Char)

instance Show Board where
  show (Board brd) = unlines $ rows $ elems brd
    where
      rows :: String -> [String]
      rows xs | null xs   = []
              | otherwise = first : rows rest
        where
          (_, (_, cols)) = bounds brd
          (first, rest)  = splitAt cols xs
