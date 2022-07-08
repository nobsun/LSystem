{-# LANGUAGE NPlusKPatterns #-}
module Main where

import System.Environment
import Control.Monad.State
import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort
import Turtle

type Order = Int

data L = F | M | P deriving Eq

type LSystem = [L] -> [L]

instance Show L where
  show F = "F"
  show M = "-"
  show P = "+"

p,m :: LSystem
f = (F:)
p = (P:)
m = (M:)

_A, _B :: Order -> LSystem
_A 0     = f
_A (n+1) = _B n . m . _A n . m . _B n

_B 0 = f
_B (n+1) = _A n . p . _B n . p . _A n

interp :: Distance -> L -> Turtle Picture
interp d F = forward d
interp _ P = left 60
interp _ M = right 60

sierpinski :: Order -> Picture
sierpinski n = translate (negate (2.0 ^ (n - 1))) (negate (2.0 ^ (n - 1)))
             $ mconcat
             $ evalState (sequence $ map (interp 1) (_A n []))
             $ TurtleState (0.5, 0.5) 0 True black

main :: IO ()
main = do
  { o <- read . head <$> getArgs
  ; let fac = 2 ^^ (9 - o)
  ; display window white $ scale fac fac $ sierpinski o
  }

window :: Display
window = InWindow "Hilbert curve" (800, 800) (100, 100)
