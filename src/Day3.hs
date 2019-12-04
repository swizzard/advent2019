{-# LANGUAGE BangPatterns, DeriveGeneric #-}
module Day3 where

import Data.Function (on)
import Data.Hashable (Hashable)
import Data.HashSet (delete, fromList, toList, intersection, HashSet)
import qualified Data.HashSet as H
import Data.List (intersect, minimumBy)
import Data.List.Split (splitOn)
import Data.Maybe (fromJust)
import qualified Data.Vector as V
import GHC.Generics (Generic)
import System.IO (readFile)

data Point = Point { x :: !Int, y :: !Int } deriving (Eq, Show, Generic)

instance Hashable Point

instance Ord Point where
  compare = compare `on` mhdist

type Path = [Point]

data Dir = U | D | L | R deriving (Eq, Show)

data Move = Move { dir :: Dir, dist :: !Int } deriving (Eq, Show)

type Moves = [Move]

mhdist :: Point -> Int
mhdist (Point x y) = abs (x - 0) + abs (y - 0)

start :: Point
start = Point 0 0

type MvF = Point -> Int -> Point

moveUp :: MvF
moveUp p d = p { y = y p + d }

moveDown :: MvF
moveDown p d = p { y = y p - d }

moveLeft :: MvF
moveLeft p d = p { x = x p - d }

moveRight :: MvF
moveRight p d = p { x = x p + d }

dirToMF :: Dir -> MvF
dirToMF U = moveUp
dirToMF D = moveDown
dirToMF L = moveLeft
dirToMF R = moveRight

move :: Move -> Point -> Path
move (Move dir dist) sp = let mf = dirToMF dir in zipWith mf (repeat sp) [dist, dist - 1..1]

parseMoves :: String -> Moves
parseMoves = (fmap pm) . splitOn "," where
  pm (dirs:dists) = let dir = case dirs of
                                'U' -> U
                                'D' -> D
                                'L' -> L
                                'R' -> R
                     in Move dir (read dists)

getPath :: Moves -> Path
getPath ms = go ms [start] where
  go [] pth = pth
  go (m:ms) pth@(cp:_) = go ms (move m cp) ++ pth

getIntersections :: Path -> Path -> HashSet Point
getIntersections p1 p2 = delete start $ intersection (fromList p1) (fromList p2)

minIntersectionDist :: Path -> Path -> Int
minIntersectionDist p1 p2 = mhdist . minimumBy (compare `on` mhdist) $ toList $ getIntersections p1 p2

getInput :: IO [Moves]
getInput = fmap parseMoves <$> lines <$> readFile "day3.txt"

part1 :: IO Int
part1 = do
  (p1:p2:_) <- getInput
  return $ minIntersectionDist (getPath p1) (getPath p2)


toV :: Path -> V.Vector Point
toV = V.reverse . V.fromList

getSteps :: Point -> V.Vector Point -> V.Vector Point -> Int
getSteps p v1 v2 = getS p v1 + getS p v2 where
  getS p v = fromJust $ V.elemIndex p v

minIntersectionIndex :: HashSet Point -> V.Vector Point -> V.Vector Point -> Int
minIntersectionIndex h p1 p2 = H.foldl' f maxBound h where
  f x i = let s = getSteps i p1 p2
           in if s < x then s else x


part2 :: IO Int
part2 = do
  (p1:p2:_) <- getInput
  let path1 = getPath p1
  let path2 = getPath p2
  let intersections = getIntersections path1 path2
  return $ minIntersectionIndex intersections (toV path1) (toV path2)
