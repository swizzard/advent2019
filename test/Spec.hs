import Data.Vector (freeze, fromList)
import Test.Hspec
import Day1
import Day2
import Day3

main :: IO ()
main = hspec $ do
  describe "day1" $ do
    describe "calcFuel" $ do
      it "calculates fuel based on mass" $ do
        calcFuel 12 `shouldBe` 2
        calcFuel 14 `shouldBe` 2
        calcFuel 1969 `shouldBe` 654
        calcFuel 100756 `shouldBe` 33583
      it "calculates fuel based on fuel mass" $ do
        calcF 14 `shouldBe` 2
        calcF 1969 `shouldBe` 966
        calcF 100756 `shouldBe` 50346
      it "calculates fuel based on fuel mass with unfoldr" $ do
        calcF' 14 `shouldBe` 2
        calcF' 1969 `shouldBe` 966
        calcF' 100756 `shouldBe` 50346
  describe "day2" $ do
    describe "calculate intcodes" $ do
      it "calculates intcodes correctly" $ do
        let t i e = (do
                        v <- newCode i
                        process 0 v
                        f <- freeze v
                        f `shouldBe` (fromList e))
        t [1, 0, 0, 0, 99] [2, 0, 0, 0, 99]
        t [2, 3, 0, 3, 99] [2, 3, 0, 6, 99]
        t [2, 4, 4, 5, 99, 0] [2, 4, 4, 5, 99, 9801]
        t [1, 1, 1, 4, 99, 5, 6, 0, 99] [30, 1, 1, 4, 2, 5, 6, 0, 99]
  describe "day3" $ do
    describe "parse" $ do
      it "parses moves" $ do
        parseMoves "U1" `shouldBe` [Move U 1]
        parseMoves "U2,R3" `shouldBe` [Move U 2, Move R 3]
      it "makes a move" $ do
        move (Move U 1) start `shouldBe` [Point 0 1]
        move (Move R 3) start `shouldBe` [Point 3 0, Point 2 0, Point 1 0]
      it "follows a path" $ do
        getPath [Move U 1, Move R 3] `shouldBe` [Point 3 1, Point 2 1, Point 1 1, Point 0 1, Point 0 0]
      it "gets intersections" $ do
        getIntersections [] [] `shouldBe` []
        getIntersections [] [Point 0 0] `shouldBe` []
        getIntersections [Point 1 2, Point 2 2, Point 2 3] [Point 0 2, Point 1 2, Point 2 3] `shouldBe` [Point 1 2, Point 2 3]
