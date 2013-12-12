module Main where

import Data.Function (on)
import Data.List (sortBy)
import System.Environment (getArgs)

import qualified Data.Map as M

data CommandCount = CommandCount String Int

instance Show CommandCount where
    show (CommandCount command count) =
        command ++ ": " ++ show count ++ " times"

parse :: String -> [String]
parse = map (lastOr "" . take 2 . words) . lines
    where
        lastOr v [] = v
        lastOr _ xs = last xs

costs :: [String] -> [CommandCount]
costs commands = map (uncurry CommandCount) $ M.toList
               $ M.fromListWith (+) [(command, 1) | command <- commands]

toWeight :: CommandCount -> Int
toWeight (CommandCount command count) = count * (length command)

top :: Int -> [CommandCount] -> [CommandCount]
top n = take n . reverse . sortBy (compare `on` toWeight)

main :: IO ()
main = do
    lim <- fmap (readFirstOr 10) getArgs
    commands <- fmap parse getContents

    mapM_ print $ top lim $ costs commands

    where
        readFirstOr v []    = v
        readFirstOr _ (x:_) = read x
