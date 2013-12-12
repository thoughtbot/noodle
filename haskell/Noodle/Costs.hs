module Noodle.Costs where

import Data.Function (on)
import Data.List (sortBy)

import qualified Data.Map as M

data Cost = Cost
    { commandCount  :: Int
    , commandLength :: Int
    } deriving Show

costs :: [String] -> [(String, Cost)]
costs commands = M.toList . M.mapWithKey toCost
               $ M.fromListWith (+) [(command, 1) | command <- commands]

    where
        toCost :: String -> Int -> Cost
        toCost command count = Cost count (length command)

top :: Int -> [(String, Cost)] -> [(String, Cost)]
top n = take n . reverse . sortBy (compareCosts `on` snd)

    where
        compareCosts :: Cost -> Cost -> Ordering
        compareCosts = compare `on` weight

weight :: Cost -> Int
weight (Cost cnt len) = cnt * len
