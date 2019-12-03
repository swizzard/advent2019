module Day2 where

import Control.Monad (filterM)
import Data.List.Split (splitOn)
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as MV
import System.IO (readFile)


type Intcode = MV.IOVector Int


newCode :: [Int] -> IO Intcode
newCode xs = V.unsafeThaw $ V.fromList xs

getInput :: IO Intcode
getInput = do
  s <- readFile "day2.txt"
  newCode $ fmap read $ splitOn "," s

vop :: (Int -> Int -> Int) -> Int -> Int -> Int -> Intcode -> IO ()
vop op a b dest v = do
  va <- MV.read v a
  vb <- MV.read v b
  let res = op va vb
  MV.write v dest res

fx f ix v = do
  ax <- MV.read v (ix + 1)
  bx <- MV.read v (ix + 2)
  dx <- MV.read v (ix + 3)
  vop f ax bx dx v

process :: Int -> Intcode -> IO ()
process ix v = do
  val <- MV.read v ix
  case val of
    99 -> return ()
    1 -> do
      fx (+) ix v
      process (ix + 4) v
    2 -> do
      fx (*) ix v
      process (ix + 4) v
    _ -> error "something went wrong"


setup :: Int -> Int -> Intcode -> IO ()
setup noun verb v = do
  MV.write v 1 noun
  MV.write v 2 verb


part1 :: IO Int
part1 = do
  ic <- getInput
  setup 12 2 ic
  process 0 ic
  MV.read ic 0


p2Check :: (Int, Int) -> Int -> Intcode -> IO Bool
p2Check (noun, verb) target ic = do
  ic' <- MV.clone ic
  setup noun verb ic'
  process 0 ic'
  res <- MV.read ic' 0
  return $ res == target

part2 :: IO Int
part2 = do
  let target = 19690720
  let opts = [(x, y) | x <- [0..99], y <- [0..99]]
  ic <- getInput
  ((n, v):_) <- filterM (\v -> p2Check v target ic) opts
  return $ 100 * n + v
