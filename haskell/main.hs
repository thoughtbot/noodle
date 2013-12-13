module Main where

import Data.Function (on)
import Data.List (sort)
import System.Environment (getArgs)

import qualified Data.Map as M

data CommandCount = CommandCount String Int deriving Eq

instance Show CommandCount where
    show (CommandCount command count) =
        command ++ ": " ++ show count ++ " times"

instance Ord CommandCount where
    compare = compare `on` weight

main :: IO ()
main = do
    lim <- fmap (readFirstOr 10) getArgs

    mapM_ print . top lim . counts . parse =<< getContents

    where
        readFirstOr v []    = v
        readFirstOr _ (x:_) = read x

parse :: String -> [String]
parse = map (lastOr "" . take 2 . words) . lines
    where
        lastOr v [] = v
        lastOr _ xs = last xs

counts :: [String] -> [CommandCount]
counts = map (uncurry CommandCount) . M.toList . countsMap

weight :: CommandCount -> Int
weight (CommandCount command count) = count * (length command)

top :: Ord a => Int -> [a] -> [a]
top n = take n . reverse . sort

countsMap :: (Num a, Ord k) => [k] -> M.Map k a
countsMap = foldr increment M.empty

increment :: (Num a, Ord k) => k -> M.Map k a -> M.Map k a
increment c = M.insertWith (+) c 1
