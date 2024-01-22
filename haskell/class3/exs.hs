{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Use foldl1" #-}
{-# HLINT ignore "Use elem" #-}

import Data.List
import Data.Char

-- 3.1
-- map (f) (filter p xs)
-- (map f . filter p) xs

-- 3.2
dec2int :: [Int] -> Int
dec2int l = foldl (\acc n -> acc*10 + n) 0 l

{- Point-free programming (magia)
dec2int = foldl (\acc n -> acc*10 + n) 0
dec2int = foldl (\acc n -> (+) (acc*10) n) 0
dec2int = foldl (\acc -> (+) (acc*10)) 0
dec2int = foldl (\acc -> (+) ((10*)acc)) 0
dec2int = foldl (\acc -> ((+) . (10*)) acc) 0
dec2Int =  foldl ((+) . (10*)) 0
-}

-- 3.3
recZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
recZipWith _ [] _ = []
recZipWith _ _ [] = []
recZipWith f (h1:t1) (h2:t2) = f h1 h2 : recZipWith f t1 t2

-- 3.4
isort :: Ord a => [a] -> [a]
isort l = foldr (\x acc -> insert x acc) [] l

-- 3.5 a)
myMaximum :: Ord a => [a] -> a
myMaximum = foldl1 max

myMinimum :: Ord a => [a] -> a
myMinimum = foldl1 min

-- 3.5 b) (f o g) (x)
myfoldl1 :: (a -> a -> a) -> [a] -> a
myfoldl1 f l = foldl f (head l) (tail l)

myfoldr1 :: (a -> a -> a) -> [a] -> a
myfoldr1 f l = foldr f (last l) (init l)

-- 3.6
mdc :: Integral a => a -> a -> a
mdc a b = fst (until (\(x, y) -> y == 0) (\(x, y) -> (y, x `mod` y)) (a, b))

-- 3.7 a)
(+++) :: [a] -> [a] -> [a]
(+++) l1 l2 = foldr (:) l2 l1

-- 3.7 b)
myConcat :: [[a]] -> [a]
myConcat l = foldr (++) [] l

-- 3.7 c)
myReverse :: [a] -> [a]
myReverse = foldl (\acc x -> x:acc) []

{- Eta reduction
    myReverse = foldl (\acc x -> (:) x acc) [] Oh não o acc está em último e não o 'x'
    myReverse = foldl (\acc x -> flip (:) acc x) [] sike
    myReverse = foldl (\acc -> flip (:) acc) []
    myReverse = foldl (\ -> flip (:)) []
    myReverse = foldl (flip (:)) []
-}

-- 3.7 d)
myReverse' :: [a] -> [a]
myReverse' = foldr (\x acc ->  acc ++ [x]) []

-- 3.7 e)
myElem :: Eq a => a -> [a] -> Bool
myElem el l = any (== el) l

-- 3.8 a)
palavras :: String -> [String]
palavras str = getWords (dropWhile isSpace str)

getWords :: String -> [String]
getWords "" = []
getWords str = takeWhile isLetter str : getWords ((dropWhile isSpace . dropWhile isLetter) str)

-- 3.8 b)
despalavras :: [String] -> String
despalavras [] = ""
despalavras strs = foldl1 (\acc curr -> acc ++ " " ++ curr) strs

-- 3.9
myScanl :: (b -> a -> b) -> b -> [a] -> [b]
myScanl _ el [] = [el]
myScanl f el (x:xs) = el : myScanl f (f el x) xs