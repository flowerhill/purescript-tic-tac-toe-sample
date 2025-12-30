module Main where

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Tuple (Tuple(..))
import Prelude (class Eq, Unit, bind, unit, when, (&&), (<>), (==), (||), class Show, show)

import Data.Map as M
import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.VDom.Driver (runUI)

type Position = Tuple Int Int

data Player = O | X

derive instance eqPlayer :: Eq Player

instance showPlayer :: Show Player where
  show O = "o"
  show X = "x"

type Board = M.Map Coord (Maybe Player)

type Coord = Tuple Int Int

type State = {
  board :: Board,
  turn :: Player,
  winner :: Maybe Player
}

data Action = Click Int Int | Reset

next :: Player -> Player
next O = X
next X = O

init :: State
init = {
  board : M.empty,
  turn: O,
  winner: Nothing
}

getCell :: Board -> Int -> Int -> Maybe Player
getCell board row col =
  fromMaybe Nothing (M.lookup (Tuple row col) board)

setCell :: Board -> Int -> Int -> Maybe Player -> Board
setCell board row col value =
  M.insert (Tuple row col) value board

isWin :: Board -> Player -> Boolean
isWin board p =
  row 0 || row 1 || row 2 ||
  col 0 || col 1 || col 2 ||
  diag1 || diag2
  where
    is r c = getCell board r c == Just p
    row r = is r 0 && is r 1 && is r 2
    col c = is 0 c && is 1 c && is 2 c
    diag1 = is 0 0 && is 1 1 && is 2 2
    diag2 = is 0 2 && is 1 1 && is 2 0

component :: forall q i o m. H.Component q i o m
component = H.mkComponent
  {
    initialState : \_ -> init,
    render,
    eval: H.mkEval H.defaultEval { handleAction = handle }
  }

render :: forall m. State -> H.ComponentHTML Action () m
render state =
  HH.div_
    [
      HH.h1_ [ HH.text "三目並べ"],
      HH.div_
        [
          HH.text case state.winner of
            Just p -> show p <> " の勝ち！"
            Nothing -> "次: " <> show state.turn
        ],
      HH.div_
        [
          HH.table_
            [
              HH.tr_ [ cell 0 0, cell 0 1, cell 0 2],
              HH.tr_ [ cell 1 0, cell 1 1, cell 1 2],
              HH.tr_ [ cell 2 0, cell 2 1, cell 2 2]
            ]
        ],
      HH.button
        [ HE.onClick \_ -> Reset ]
        [ HH.text "リセット" ],
      HH.style_ [ HH.text css ]
    ]
    where
      cell row col =
        let val = getCell state.board row col
        in HH.td
            [
              HE.onClick \_ -> Click row col
            ]
            [
              HH.text case val of
                Just p -> show p
                Nothing -> ""
            ]

css :: String
css = """
  body { 
    text-align: center;
    font-family: sans-serif;
    margin: 50px;
  }
  h1 { color: #333; }
  table { 
    margin: 20px auto; 
    border-collapse: collapse; 
  }
  td {
    width: 80px;
    height: 80px;
    border: 2px solid #333;
    font-size: 40px;
    cursor: pointer;
    background: white;
  }
  td:hover { background: #f0f0f0; }
  button {
    padding: 10px 20px;
    font-size: 16px;
    margin: 10px;
  }
"""

handle :: forall o m. Action -> H.HalogenM State Action () o m Unit
handle = case _ of
  Click row col -> do
    state <- H.get
    when (state.winner == Nothing && getCell state.board row col == Nothing) do
      let newBoard = setCell state.board row col (Just state.turn)
          w = if isWin newBoard state.turn
              then Just state.turn
              else Nothing
      H.put {
        board: newBoard,
        turn: next state.turn,
        winner: w
      }
  Reset -> H.put init

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body
