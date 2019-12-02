module Day1 where

import Data.List (unfoldr)
import System.IO

-- helper function
doSum :: (Int -> Int) -> [Int] -> Int
doSum f = foldl go 0 where
  go acc v = acc + f v

-- read the input
getNums :: IO [Int]
getNums = (fmap read) <$> lines <$> readFile "day1.txt"

-- basic fuel calculation
calcFuel :: Int -> Int
calcFuel = (\x -> x - 2) . (\x -> div x 3)

-- solution for part 1
calcTotal :: IO Int
calcTotal = (doSum calcFuel) <$> getNums

-- calculate fuel for part 2
calcF :: Int -> Int
calcF v = cf v 0 where
  cf x acc = let f' = calcFuel x in
                 if f' < 0 then acc else cf f' (acc + f')

-- solution for part 2 (fuel of fuel)
calcFoFTotal :: IO Int
calcFoFTotal = (doSum calcF) <$> getNums

-- fancier way of calculating fuel for part 2 using unfoldr
calcF' :: Int -> Int
calcF' v = sum $ unfoldr cf v where
  cf x = let f' = calcFuel x in
             if f' > 0 then Just (f', f') else Nothing

-- fancier solution for part 2
calcFoFTotal' :: IO Int
calcFoFTotal' = (doSum calcF') <$> getNums
