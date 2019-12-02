import Test.Hspec
import Day1

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
