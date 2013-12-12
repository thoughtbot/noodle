module Main where

import Data.Function (on)
import Data.List (sortBy)
import System.Environment (getArgs)

import qualified Data.Map as M

parse :: String -> [String]
parse = map (lastOr "" . take 2 . words) . lines
    where
        lastOr v [] = v
        lastOr _ xs = last xs

costs :: [String] -> [(String, Int)]
costs commands = M.toList . M.mapWithKey toWeight
               $ M.fromListWith (+) [(command, 1) | command <- commands]

    where
        toWeight :: String -> Int -> Int
        toWeight command count = count * (length command)

top :: Int -> [(String, Int)] -> [(String, Int)]
top n = take n . reverse . sortBy (compare `on` snd)

prettyPrint :: (String, Int) -> String
prettyPrint (command, weight) = command ++ ": " ++ show weight

main :: IO ()
main = do
    lim <- fmap (readFirstOr 10) getArgs
    commands <- fmap parse getContents

    mapM_ putStrLn $ map prettyPrint $ top lim $ costs commands

    where
        readFirstOr v []    = v
        readFirstOr _ (x:_) = read x
