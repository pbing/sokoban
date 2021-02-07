module Levels (levelsFromFile) where

import Data.Array

import Board

levelsFromFile :: FilePath -> IO [Board]
levelsFromFile fp = do
  lns <- lines <$> readFile fp
  return $ map mkLevel (lvls lns)
  where
    lvls [""] = [[""]]
    lvls s    = let (x, xs) = break null s
                in x : lvls (tail xs)

mkLevel :: [String] -> Board
mkLevel xs = Board (array ((1, 1), (rows, cols)) $ zip idx ys)
  where
    cols = maximum $ map length xs
    rows = length xs
    idx  = [(y, x) | y <- [1..rows], x <- [1..cols]]
    ys   = concatMap (untrim cols) xs

-- append spaces to the end of a string until it is n characters long
untrim :: Int -> String -> String
untrim n s = s ++ t
  where t = replicate (n - length s) ' '
