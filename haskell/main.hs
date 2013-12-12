module Main where

import Noodle.Costs
import Data.List (sortBy)
import Data.Function (on)
import System.Environment (getArgs)

main :: IO ()
main = do
    lns <- fmap lines getContents

    args <- getArgs

    let n = read $ if null args then "10" else head args

    mapM_ putStrLn $ map prettyPrint $ top n $ costs $ map toInvocation lns

toInvocation :: String -> Invocation
toInvocation = last . take 2 . words

top :: Int -> [InvocationWithCost] -> [InvocationWithCost]
top n = take n . reverse
      . sortBy (compareCosts `on` snd)

prettyPrint :: InvocationWithCost -> String
prettyPrint (i,c) = i ++ ": " ++ show (weight c)
