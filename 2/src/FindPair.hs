module FindPair (findPair, findPairBounded, maxCost) where
import Data.Vector (Vector, (!))
import qualified Data.Vector as Vector

-- Find two items that together are as close to the target price
-- as possible, but never more. Returns `Just [index1, index2]` if
-- items were found, otherwise `Nothing`.
findPair :: Vector Int -> Int -> Maybe [Int]
findPair prices = findPairBounded 0 (Vector.length prices - 1) prices

-- Same as findPair, but impose upper and lower bounds on item access.
findPairBounded :: Int -> Int -> Vector Int -> Int -> Maybe [Int]
findPairBounded lowerBound upperBound prices targetPrice = findPair' lowerBound upperBound Nothing
  where findPair' left right bestCost
          | left >= right = bestCost
          | otherwise = if totalCost prices [left, right] > targetPrice
                        then findPair' left (right - 1) bestCost
                        else findPair' (left + 1) right $! maxCost prices bestCost [left, right]
 
-- Given a list of item indexes, return the total cost.
totalCost :: Vector Int -> [Int] -> Int
totalCost prices indexes = sum $ map (prices!) indexes

-- Given two sets of items, return the max cost set.
maxCost :: Vector Int -> Maybe [Int] -> [Int] -> Maybe [Int]
maxCost _ Nothing sample = Just sample
maxCost prices justSample1@(Just sample1) sample2 =
  if totalCost prices sample1 >= totalCost prices sample2
  then justSample1
  else Just sample2
