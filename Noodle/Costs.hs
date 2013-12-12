module Noodle.Costs (costs) where

type Invocation = String

data Cost = Cost
    { commandCount  :: Int
    , commandLength :: Int
    } deriving Show

type InvocationWithCost = (Invocation, Cost)

costs :: [Invocation] -> [InvocationWithCost]
costs = foldl addCosts []

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
