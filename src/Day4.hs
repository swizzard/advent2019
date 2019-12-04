module Day4 where

import Data.List (group)

range = [124075..580769]

ri :: Char -> Int
ri = read . pure

criteria (c1:c2:cs) hd res | c1 == c2 = criteria (c2:cs) True True
                           | ri c1 < ri c2 = criteria (c2:cs) hd True
                           | ri c1 > ri c2 = False
criteria _ hd res = hd

testNum :: Int -> Bool
testNum n = criteria (show n) False True

part1 :: Int
part1 = length $ filter testNum range

p2Test :: String -> Bool
p2Test s = any (== 2) (map length $ group s)

p2Filter :: Int -> Bool
p2Filter i = let s = show i in (criteria s False True) && p2Test s

part2 :: Int
part2 = length $ filter p2Filter range
