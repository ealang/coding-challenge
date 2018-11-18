-- UI for find-pair
module Main where
import CommonMain (commonMain)
import FindPair (findPair)

main :: IO ()
main = commonMain findPair
