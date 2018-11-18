-- Common UI for find-pair and find-triplet
module CommonMain (commonMain) where
import Data.List (intercalate)
import Data.List.Split (splitOn)
import Data.Vector ((!), Vector)
import System.Environment (getArgs)
import Text.Printf (printf)
import qualified Data.Vector as Vector

-- Parse a single line from prices file into a name, price tuple
parseItem :: String -> (String, Int)
parseItem input = (item, price)
  where [item, priceStr] = splitOn "," input
        price = read priceStr :: Int

type Solution = Vector Int -> Int -> Maybe [Int] 

mainWithArgs :: Solution -> String -> Int -> IO ()
mainWithArgs solution pricesFile targetPrice = do
    items <- Vector.fromList .
             map parseItem .
             takeWhile (/= "") .
             lines <$> readFile pricesFile
    let prices = fmap snd items

    putStrLn $ case solution prices targetPrice of
      Nothing -> "Not possible"
      Just indexes -> let formatItem index = printf "%s %d" name price
                            where (name, price) = items ! index
                      in intercalate ", " $ map formatItem indexes

commonMain :: Solution -> IO ()
commonMain solution = do 
  args <- getArgs
  case args of
    [file, targetPrice] -> mainWithArgs solution file (read targetPrice :: Int)
    _ -> putStrLn "Arguments: [prices file name] [target price]"
