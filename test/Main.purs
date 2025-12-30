module Test.Main where

import Prelude

import Data.Map as Map
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Main (Player(..), getCell, setCell, isWin)
import Test.Spec (describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

-- 最小限のテストコード
main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "Tic-Tac-Toe" do
    
    -- 基本機能のテスト
    describe "getCell / setCell" do
      it "セルに値を設定して取得できる" do
        let board = Map.empty
            board1 = setCell board 0 0 (Just O)
        getCell board1 0 0 `shouldEqual` Just O

    -- 勝利判定のテスト
    describe "isWin" do
      it "横に3つ揃うと勝利" do
        let board = Map.empty
            board1 = setCell board 0 0 (Just O)
            board2 = setCell board1 0 1 (Just O)
            board3 = setCell board2 0 2 (Just O)
        isWin board3 O `shouldEqual` true

      it "縦に3つ揃うと勝利" do
        let board = Map.empty
            board1 = setCell board 0 0 (Just X)
            board2 = setCell board1 1 0 (Just X)
            board3 = setCell board2 2 0 (Just X)
        isWin board3 X `shouldEqual` true

      it "斜めに3つ揃うと勝利" do
        let board = Map.empty
            board1 = setCell board 0 0 (Just O)
            board2 = setCell board1 1 1 (Just O)
            board3 = setCell board2 2 2 (Just O)
        isWin board3 O `shouldEqual` true

      it "2つだけでは勝利しない" do
        let board = Map.empty
            board1 = setCell board 0 0 (Just O)
            board2 = setCell board1 0 1 (Just O)
        isWin board2 O `shouldEqual` false