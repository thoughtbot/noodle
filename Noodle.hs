module Noodle where

type Invocation = String

data Cost = Cost
    { commandCount  :: Int
    , commandLength :: Int
    }

type InvocationWithCost = (Invocation, Cost)

costs :: [Invocation] -> [InvocationWithCost]
costs = foldl addCosts []

addCosts :: [InvocationWithCost] -> Invocation -> [InvocationWithCost]
addCosts invocations invocation = updateCost newCost
    where
        newCost :: Cost
        newCost = incrementCost currentCost

        currentCost :: Cost
        currentCost = findCost invocations invocation

        updateCost :: Cost -> [InvocationWithCost]
        updateCost = undefined

incrementCost :: Cost -> Cost
incrementCost cost = cost { commandCount = commandCount cost + 1 }

findCost :: [InvocationWithCost] -> Invocation -> Cost
findCost [] invocation = Cost 0 (length invocation)
findCost ((i, c):rest) invocation
    | i == invocation = c
    | otherwise = findCost rest invocation
