import FindTriplet (findTriplet)
import System.Exit
import Test.HUnit
import qualified Data.Vector as Vector

testExactMatch = TestCase $
  assertEqual "Should return indexes of prices for a perfect match"
              (Just [2, 3, 4])
              (findTriplet (Vector.fromList [1, 5, 20, 30, 50, 80, 100]) 100)

testBestMatch = TestCase $
  assertEqual "Should return indexes of prices for a best match"
              (Just [0, 1, 3])
              (findTriplet (Vector.fromList [1, 5, 20, 30, 50, 80, 100]) 50)

testMultiplePurchasesDisallowed = TestCase $
  assertEqual "Should not try to purchase the same item multiple times"
              (Just [0, 1, 2])
              (findTriplet (Vector.fromList [1, 5, 8]) 15)

testNoMatchPossible  = TestCase $
  assertEqual "Should return Nothing if no match is possible"
              Nothing
              (findTriplet (Vector.fromList [5, 6, 10]) 4)

testTooFewPrices  = TestCase $
  assertEqual "Should return Nothing if there are not enough items provided"
              Nothing
              (findTriplet (Vector.fromList [100, 200]) 100)

main :: IO ()
main = do
  let cases = [
                testExactMatch,
                testBestMatch,
                testMultiplePurchasesDisallowed,
                testNoMatchPossible,
                testTooFewPrices
              ]
  result <- runTestTT $ TestList cases
  if failures result == 0 then exitSuccess
  else exitFailure
