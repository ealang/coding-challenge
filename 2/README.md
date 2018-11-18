# challenge-2

## Requirements

Haskell (Cabal build tool) is required to run the programs and unit tests.

## Part 1

### Solution

The solution works by visiting pairs of items starting from the left and right side of the sorted list. If the pair forms a price that is too high, the right pointer will move left to decrease the price, or vice versa to increase the price.

The solution runs in O(n) time, since N pairs of items will be visited in total.

### Run Instructions

To find a match: `cabal run find-pair prices.txt 2500`
To run unit tests: `cabal test find-pair-test`

## Part 2 (Bonus)

### Solution

The solution here is to fix the first item, and let the solution to part 1 pick out the second and third items (with the first item subtracted from the target cost).

This solution runs in O(n^2) time since all n possible first items are tested, and the part 1 solution is O(n).

### Run Instructions

To find a match: `cabal run find-triplet prices.txt 2500`
To run unit tests: `cabal test find-triplet-test`
