module Main where

import Noodle.Costs
import Data.List (sortBy)
import Data.Function (on)

main :: IO ()
main = do
    lns <- fmap lines getContents

    mapM_ putStrLn $ prettyPrint $ topTen $ costs $ map toInvocation lns

toInvocation :: String -> Invocation
toInvocation = head . words

topTen :: [InvocationWithCost] -> [InvocationWithCost]
topTen = take 10
       . reverse
       . sortBy (compareCosts `on` snd)

prettyPrint :: [InvocationWithCost] -> [String]
prettyPrint = map show
