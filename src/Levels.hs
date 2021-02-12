module Levels (levelsFromXSBFile) where

import Data.Array

import Board

-- read a XSB file and return all of its level descriptions
levelsFromXSBFile :: FilePath -> IO [Board]
levelsFromXSBFile fp = do
  map mkBoard . splitLevels . lines . map floorTile <$> readFile fp

-- handle different floor tiles in XSB files
floorTile :: Char -> Char
floorTile '-' = ' '
floorTile '_' = ' '
floorTile x   = x

-- empty lines separate the levels
splitLevels :: [String] -> [[String]]
splitLevels [""] = [[""]]
splitLevels s    = let (x, xs) = break null s
                   in x : splitLevels (tail xs)

mkBoard :: [String] -> Board
mkBoard xs = Board (array ((1, 1), (rows, cols)) $ zip idx ys)
  where
    cols = maximum $ map length xs
    rows = length xs
    idx  = [(y, x) | y <- [1..rows], x <- [1..cols]]
    ys   = concatMap (untrim cols) xs

-- append spaces to the end of a string until it is n characters long
untrim :: Int -> String -> String
untrim n s = s ++ t
  where t = replicate (n - length s) ' '
