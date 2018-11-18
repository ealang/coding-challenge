-- UI for find-triplet
module Main where
import CommonMain (commonMain)
import FindTriplet (findTriplet)

main :: IO ()
main = commonMain findTriplet
