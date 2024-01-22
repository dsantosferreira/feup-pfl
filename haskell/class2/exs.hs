{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
import Data.Char
{-# HLINT ignore "Use foldr" #-}

-- 2.1 a)
myand :: [Bool] -> Bool
myand [] = True
myand (x : xs) = x && myand xs

-- 2.1 b)
myor :: [Bool] -> Bool
myor [] = False
myor (x : xs) = x || myor xs

-- 2.1 c)
myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (x : xs) = x ++ myconcat xs

-- 2.1 d)
myreplicate :: Int -> a -> [a]
myreplicate 0 x = []
myreplicate n x = x : myreplicate (n - 1) x

-- 2.1 e)
myselect :: [a] -> Int -> a
myselect [] _ = error "Invalid index"
myselect xs 0 = head xs
myselect (x : xs) n = myselect xs (n - 1)

-- 2.1 f)
myelem :: Eq a => a -> [a] -> Bool
myelem _ [] = False
myelem x (y : ys)
    | x == y  = True
    | otherwise = myelem x ys

-- 2.2
myintersperse :: a -> [a] -> [a]
myintersperse _ [] = []
myintersperse _ [y] = [y]
myintersperse x (y : ys) = y : x : myintersperse x ys

-- 2.3
mdc :: Integer -> Integer -> Integer
mdc a 0 = a
mdc a b = mdc b (a `mod` b)

-- 2.4 a)
myinsert :: Ord a => a -> [a] -> [a]
myinsert el [] = [el]
myinsert el (x : xs)
    | el <= x = el : x : xs
    | otherwise = x : myinsert el xs

-- 2.4 b)
isort :: Ord a => [a] -> [a]
isort [] = []
isort (x : xs) = myinsert x (isort xs)

-- 2.5 a)
myminimum :: Ord a => [a] -> a
myminimum [] = error "empty list"
myminimum [x] = x
myminimum (x : xs) = min x (myminimum xs)

-- 2.5 b)
mydelete :: Eq a => a -> [a] -> [a]
mydelete _ [] = []
mydelete el (x : xs)
    | el == x = xs
    | otherwise = x : mydelete el xs

-- 2.5 c)
ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort xs = minxs : ssort (mydelete minxs xs)
    where minxs = minimum xs

-- 2.6
sumsquares :: Int
sumsquares = sum [x^2 | x <- [1..100]]

-- 2.7 a)
aprox :: Int -> Double
aprox n = sum [(-1)^k / (2 * fromIntegral k + 1) | k <- [0 .. n-1]] * 4

-- 2.7 b)
aprox' :: Int -> Double
aprox' n = sqrt(sum [(-1)^k / (fromIntegral k + 1)^2 | k <- [0 .. n-1]] * 12)

-- 2.8
dotprod :: [Float] -> [Float] -> Float
dotprod xs ys
    | length xs == length ys = sum [x * y | (x, y) <- zip xs ys]
    | otherwise = error "lists of different sizes"

-- 2.9
divprop :: Integer -> [Integer]
divprop n = [i | i <- [1 .. n - 1], n `mod` i == 0]

-- 2.10
perfeitos :: Integer -> [Integer]
perfeitos n = [i | i <- [1 .. n], sum (divprop i) == i]

-- 2.11
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x, y, z) | z <- [1 .. n], y <- [1 .. n], x <- [1 .. n], x^2 + y^2 == z^2]

-- 2.12
primo :: Integer -> Bool
primo n = divprop n == [1]

-- 2.13
mersennes :: [Int]
mersennes = [2^i - 1 | i <- [0 .. 30], primo (2^i - 1)]

-- 2.14
binom :: Integer -> Integer -> Integer
binom n k  | k > n - k = product [k + 1 .. n] `div` product [1 .. n-k]
            | k <= n - k = product [n - k + 1 .. n] `div` product [1 .. k]

pascal :: Integer -> [[Integer]]
pascal n = [[binom i el | el <- [0 .. i]] | i <- [0 .. n]]

-- 2.15
cifrar :: Int -> String -> String
cifrar dist str = [if letter /= ' ' then chr (65 + (dist + ord letter - 65) `mod` 26 ) else letter | letter <- str]

-- 2.16
myConcat :: [[a]] -> [a]
myConcat l = [el | alist <- l, el <- alist]

myReplicate :: Int -> a -> [a]
myReplicate n el = [el | _ <- [1 .. n]]

myIndex :: [a] -> Int -> a
myIndex l idx
    | idx < 0 = error "negative index"
    | idx > length l = error "index too large"
    | otherwise = head [el | (el, i) <- zip l [0 .. (length l - 1)], i == idx]

-- 2.17
forte :: String -> Bool
forte str = and [
        length str >= 8, 
        or [isLower char | char <- str], 
        or [isUpper char | char <- str], 
        or [isDigit char | char <- str]
    ]

-- 2.18 a)
mindiv :: Int -> Int
mindiv n = findFirstDiv 2 n

findFirstDiv :: Int -> Int -> Int
findFirstDiv curr limit
    | curr > floor (sqrt (fromIntegral limit)) = limit
    | otherwise = if limit `mod` curr == 0 then curr else findFirstDiv (curr + 1) limit

-- 2.18 b)
primo' :: Int -> Bool
primo' n = n > 1 && mindiv n == n

-- 2.19
nub :: Eq a => [a] -> [a]

nub [] = []
nub (curr:rest) = curr : nub [el | el <- rest, el /= curr]

-- 2.20
transpose :: [[a]] -> [[a]]
transpose lists =   [[list !! idx | list <- lists] | idx <- [0 .. cols]]
                    where cols = length (head lists) - 1

-- 2.21 Se quiser com tail recursion definir função auxiliar que faz a mesma coisa mas com tail recursion e dar reverse da lista no final
algarismos :: Int -> [Int]
algarismos n 
    | n < 10 = [n]
    | otherwise = algarismos (n `div` 10) ++ [n `mod` 10]

-- 2.22
toBits :: Int -> [Int]
toBits n 
    | n < 2 = [n]
    | otherwise = toBits (n `div` 2) ++ [n `mod` 2]

-- 2.23
fromBits :: [Int] -> Int
fromBits l = sum [2^n * digit| (digit, n) <- zip l [length l - 1, length l - 2 .. 0]]

-- 2.24 a)
merge :: Ord a => [a] -> [a] -> [a]
merge [] l2 = l2
merge l1 [] = l1
merge (curr1:rest1) (curr2:rest2)
    | curr1 < curr2 = curr1 : merge rest1 (curr2:rest2)
    | otherwise = curr2 : merge (curr1:rest1) rest2

-- 2.24 b)
msort :: Ord a => [a] -> [a]
msort [] = []
msort [el] = [el]
msort l = merge (msort (take (length l `div` 2) l)) (msort (drop (length l `div` 2) l))
