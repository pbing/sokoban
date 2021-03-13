module Main where

import Data.Array
import System.Environment
import System.IO

import Board
import Levels
import Sokoban

main :: IO ()
main = do
  prog <- getProgName
  args <- getArgs
  if null args then
    usage prog
    else do
      lvls <- levelsFromXSBFile "levels/sokoban_levels.xsb"
      let n = max (read $ head args) 1
      hSetBuffering stdin NoBuffering
      hSetEcho stdin False
      playLoop $ lvls !! (n - 1)

usage :: String -> IO ()
usage prg = do
  putStrLn "Usage"
  putStrLn $ "  " ++ prg ++ " <level>\n"
  putStrLn "Tiles\n\
  \    @       man\n\
  \    +       man on goal\n\
  \    $       box\n\
  \    *       box on goal\n\
  \    #       wall\n\
  \    .       goal\n\
  \    <space> floor\n\n\
  \Control\n\
  \    w       up\n\
  \    a       left\n\
  \    s       down\n\
  \    d       right\n\
  \    q       quit game\n"

playLoop :: Board -> IO ()
playLoop brd = do
  putStr "\ESC[2J" -- clear screen
  print brd
  if isFinished brd then
    print "You won this level!"
    else do
    c <- getChar
    case c of
      'a' -> playLoop $ move (0, -1) brd
      's' -> playLoop $ move (1, 0) brd
      'd' -> playLoop $ move (0, 1) brd
      'w' -> playLoop $ move (-1, 0) brd
      'q' -> return ()
      _   -> playLoop brd

isFinished :: Board -> Bool
isFinished (Board brd) = '$' `notElem` elems brd
