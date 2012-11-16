module Mango.Value where

import qualified Mango.MutableMap as M

data Scope
    = RootScope
    | Scope { parent :: Scope, vars :: M.MutableMap String MangoValue }

data MangoValue = MangoList     [MangoValue]
                | MangoNumber   Double
                | MangoSymbol   String
                | MangoString   String
                | MangoFunction ([MangoValue] -> IO MangoValue)
                | MangoSpecial  (Scope -> [MangoValue] -> IO MangoValue)
                | MangoQuote    MangoValue
                | MangoTrue

instance Show MangoValue where
    show (MangoList     xs)     = "(" ++ unwords (map show xs) ++ ")"
    show (MangoNumber   num)    = show num
    show (MangoSymbol   sym)    = sym
    show (MangoString   str)    = show str
    show (MangoFunction fun)    = "<function>"
    show (MangoSpecial  spec)   = "<special>"
    show (MangoQuote    val)    = '\'' : show val
    show MangoTrue              = "#t"

instance Eq MangoValue where
    (==) (MangoList     xs) (MangoList      ys) = xs == ys
    (==) (MangoNumber   a)  (MangoNumber    b)  = a == b
    (==) (MangoSymbol   a)  (MangoSymbol    b)  = a == b
    (==) (MangoString   a)  (MangoString    b)  = a == b
    -- functions in haskell are not instances of Eq so we can't check equality
    (==) (MangoFunction _)  (MangoFunction  _)  = False
    (==) (MangoSpecial  _)  (MangoSpecial   _)  = False
    (==) (MangoQuote    a)  (MangoQuote     b)  = a == b
    (==) MangoTrue          MangoTrue           = True
    (==) _                  _                   = False

isTruthy :: MangoValue -> Bool
isTruthy (MangoList []) = False
isTruthy _              = True

fromBool :: Bool -> MangoValue
fromBool True   = MangoTrue
fromBool False  = MangoList []
