module Mango.Helpers where
    
import Mango.Value
import Mango.Exception

expectArgs0     :: [MangoValue] -> IO ()
expectArgs0     []              = return ()
expectArgs0     xs              = mangoError $ "Expected no arguments, received " ++ show (length xs)

expectArgs1     :: [MangoValue] -> IO (MangoValue)
expectArgs1     [a]             = return (a)
expectArgs1     xs              = mangoError $ "Expected 1 argument, received " ++ show (length xs)

expectArgs2     :: [MangoValue] -> IO (MangoValue, MangoValue)
expectArgs2     [a,b]           = return (a,b)
expectArgs2     xs              = mangoError $ "Expected 2 arguments, received " ++ show (length xs)

expectArgs3     :: [MangoValue] -> IO (MangoValue, MangoValue, MangoValue)
expectArgs3     [a,b,c]         = return (a,b,c)
expectArgs3     xs              = mangoError $ "Expected 3 arguments, received " ++ show (length xs)

expectVArgs1    :: [MangoValue] -> IO (MangoValue, [MangoValue])
expectVArgs1    (a:rest)        = return (a,rest)
expectVArgs1    xs              = mangoError $ "Expected >= 1 arguments, received " ++ show (length xs)

expectVArgs2    :: [MangoValue] -> IO (MangoValue, MangoValue, [MangoValue])
expectVArgs2    (a:b:rest)      = return (a,b,rest)
expectVArgs2    xs              = mangoError $ "Expected >= 2 arguments, received " ++ show (length xs)

expectVArgs3    :: [MangoValue] -> IO (MangoValue, MangoValue, MangoValue, [MangoValue])
expectVArgs3    (a:b:c:rest)    = return (a,b,c,rest)
expectVArgs3    xs              = mangoError $ "Expected >= 3 arguments, received " ++ show (length xs)

expectList      :: MangoValue -> IO [MangoValue]
expectList      (MangoList x)   = return x
expectList      x               = mangoError $ "Expected list, received " ++ show x

expectNumber    :: MangoValue -> IO Double
expectNumber    (MangoNumber x) = return x
expectNumber    x               = mangoError $ "Expected number, received " ++ show x

expectSymbol    :: MangoValue -> IO String
expectSymbol    (MangoSymbol x) = return x
expectSymbol    x               = mangoError $ "Expected symbol, received " ++ show x