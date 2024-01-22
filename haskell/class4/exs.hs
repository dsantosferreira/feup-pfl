{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Stack
import Data.Char

exampleStk1 :: Stack Float
exampleStk1 = push 2 $ push 12.4 empty

exampleStk2 :: Stack Float
exampleStk2 = push 1 empty

-- 5.1
parent :: String -> Bool
parent str = parentAux str empty

parentAux :: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (x:xs) stk
    | x == '{' || x == '(' || x == '[' = parentAux xs (push x stk)
    | x == '}' && not emptyStack && topval == '{' = parentAux xs (pop stk)
    | x == ']' && not emptyStack && topval == '[' = parentAux xs (pop stk)
    | x == ')' && not emptyStack && topval == '(' = parentAux xs (pop stk)
    | otherwise = False
    where topval = top stk
          emptyStack = isEmpty stk

-- 5.2 a)
calc :: Stack Float -> String -> Stack Float
calc stk op
    | ismyNumber op = push (read op::Float) stk 
    | op == "+" = push (el1 + el2) newstk
    | op == "-" = push (el1 - el2) newstk
    | op == "*" = push (el1 * el2) newstk
    | op == "/" = push (el1 / el2) newstk
    | otherwise = error "Bad input"
    where   el2 = top stk
            el1 = top (pop stk)
            newstk = pop $ pop stk


ismyNumber :: String -> Bool
ismyNumber str
    | str == "" = False
    | str == "." = False
    | sndpart == "" = True
    | sndpart == ('.':sndnum) = all isDigit sndnum
    | otherwise = False
    where sndpart = dropWhile isDigit str
          sndnum = drop 1 sndpart

-- 5.2 b)
calcular :: String -> Float
calcular str = calcularAux (words str) empty

calcularAux :: [String] -> Stack Float -> Float
calcularAux [] stk | isEmpty $ pop stk = top stk
calcularAux (x:xs) stk = calcularAux xs (calc stk x)
calcularAux _ _ = error "Bad input"

-- 5.2 c)
calcularpn :: IO ()
calcularpn = do
    exp <- getLine
    print $ calcular exp

-- 5.3 done in conjunto.hs

-- 5.4 and 5.5 done in set.hs

-- 5.6
-- Done in map.hs