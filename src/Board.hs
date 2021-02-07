module Board where

import Data.Array

type Position  = (Int, Int) -- (y, x)
type Direction = (Int, Int) -- (dy, dx)
newtype Board = Board (Array Position Char)

instance Show Board where
  show (Board brd) = unlines $ go $ elems brd
    where
      go xs | null xs   = []
            | otherwise = first : go rest
        where
          (_, (_, cols)) = bounds brd
          (first, rest)  = splitAt cols xs
