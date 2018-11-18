import FindPair (findPair)
import System.Exit
import Test.HUnit
import qualified Data.Vector as Vector

testExactMatch = TestCase $
  assertEqual "Should return indexes of prices for a perfect match"
              (Just [1, 2])
              (findPair (Vector.fromList [1, 5, 10, 12]) 15)

testBestMatch = TestCase $
  assertEqual "Should return indexes of prices for a best match"
              (Just [0, 3])
              (findPair (Vector.fromList [1, 5, 10, 12]) 13)

testMultiplePurchasesDisallowed = TestCase $
  assertEqual "Should not try to purchase the same item twice"
              (Just [0, 2])
              (findPair (Vector.fromList [1, 5, 8]) 10)

testNoMatchPossible  = TestCase $
  assertEqual "Should return Nothing if no match is possible"
              Nothing
              (findPair (Vector.fromList [5, 6, 10]) 4)

testTooFewPrices  = TestCase $
  assertEqual "Should return Nothing if there are not enough items provided"
              Nothing
              (findPair (Vector.fromList [100]) 100)

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
