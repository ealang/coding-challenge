module FindTriplet (findTriplet) where
import FindPair (findPairBounded, maxCost)
import Data.Maybe (mapMaybe)
import Data.Vector (Vector, (!))
import qualified Data.Vector as Vector

-- Find three items that together are as close to the target price
-- as possible, but never more. Returns `Just [index1, index2, index3]` if
-- items were found, otherwise `Nothing`.
findTriplet :: Vector Int -> Int -> Maybe [Int]
findTriplet prices targetPrice = foldl (maxCost prices) Nothing solutions
  where n = Vector.length prices
        withFirstItem index  = (index:) <$>
                               findPairBounded (index + 1) (n - 1) prices (targetPrice - prices ! index)
        solutions = mapMaybe withFirstItem [0..n - 3]
