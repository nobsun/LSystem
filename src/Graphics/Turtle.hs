module Graphics.Turtle
    (
    ) where

import Data.Bool
import Graphics.Gloss

data TurtleState = TurtleState
    { tPos :: Position
    , tDir :: Direction
    , tPen :: Bool
    , tThc :: Float
    , tCol :: Color
    , tDsp :: Bool
    , tPic :: Picture
    }

type Position  = (Float, Float)
type Direction = Float
type Distance  = Float

--

torad :: Float -> Float
torad d = d * pi / 180

todeg :: Float -> Float
todeg r = r * 180 / pi

add :: Distance -> Direction -> Position -> Position
add dis dir (x,y) 
    = ( x + dis * cos (torad dir)
      , y + dis * sin (torad dir)
      )

normalize :: Float -> Float
normalize d = d - fromIntegral (floor (d / 360) * 360)

--

forward :: Distance -> TurtleState -> TurtleState
forward d state = case state of
    TurtleState pos dir pen thc col dsp pic
        -> state { tPos = pos'
                 , tPic = bool Blank (color (tCol state) (line [pos, pos'])) pen
                 } 
        where
            pos' = add d dir pos 

backward :: Distance -> TurtleState -> TurtleState
backward d state = case state of
    TurtleState pos dir pen thc col dsp pic
        -> state { tPos = pos'
                 , tPic = bool Blank (color (tCol state) (line [pos, pos'])) pen
                 }
        where
            pos' = add d (normalize (dir + 180)) pos

--

endSpot :: Float -> Position -> Picture
endSpot th (x,y) = translate x y $ circleSolid (th / 2)

