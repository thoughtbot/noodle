module Noodle.Costs where

type Invocation = String

data Cost = Cost
    { commandCount  :: Int
    , commandLength :: Int
    } deriving Show

type InvocationWithCost = (Invocation, Cost)

costs :: [Invocation] -> [InvocationWithCost]
costs = foldl addCosts []

compareCosts :: Cost -> Cost -> Ordering
compareCosts c1 c2 = compare (weight c1) (weight c2)

weight :: Cost -> Int
weight (Cost cnt len) = cnt * len

addCosts :: [InvocationWithCost] -> Invocation -> [InvocationWithCost]
addCosts invocations invocation = updateCosts newCost
    where
        newCost :: Cost
        newCost = incrementCost currentCost

        currentCost :: Cost
        currentCost = findCost invocations invocation

        updateCosts :: Cost -> [InvocationWithCost]
        updateCosts cost = (invocation, cost) : (dropInvocation invocation invocations)

        dropInvocation :: Invocation -> [InvocationWithCost] -> [InvocationWithCost]
        dropInvocation _ [] = []
        dropInvocation invocation (x@(i,_):rest)
            | i == invocation = rest
            | otherwise = x : dropInvocation invocation rest

incrementCost :: Cost -> Cost
incrementCost cost = cost { commandCount = commandCount cost + 1 }

findCost :: [InvocationWithCost] -> Invocation -> Cost
findCost [] invocation = Cost 0 (length invocation)
findCost ((i, c):rest) invocation
    | i == invocation = c
    | otherwise = findCost rest invocation
