module Main where

import Noodle.Costs
import System.Environment (getArgs)

main :: IO ()
main = do
    lim <- fmap (readFirstOr 10) getArgs
    commands <- fmap parse getContents

    mapM_ putStrLn $ map prettyPrint $ top lim $ costs commands

    where
        readFirstOr v []     = v
        readFirstOr _ (x:xs) = read x

        parse = map (last . take 2 . words) . lines

        prettyPrint (command,cost) = command ++ ": " ++ show (weight cost)
