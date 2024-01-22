{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# HLINT ignore "Eta reduce" #-}
module Conjunto where

data Conjunto a = Conj [a] deriving Show

empty :: Conjunto a
empty = Conj []

isEmpty :: Conjunto a -> Bool
isEmpty (Conj []) = True
isEmpty _ = False

member :: Eq a => a -> Conjunto a -> Bool
member _ (Conj []) = False
member el (Conj (x:xs))
    | el == x = True
    | otherwise = member el (Conj xs)

insert :: Eq a => a -> Conjunto a -> Conjunto a
insert el (Conj conj)
    | member el (Conj conj) = Conj conj
    | otherwise = Conj (el:conj)

delete :: Eq a => a -> Conjunto a -> Conjunto a
delete el (Conj conj) = Conj (filter (/= el) conj)

union :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
union (Conj c1) (Conj c2) = Conj (c1 ++ [el | el <- c2, not $ member el (Conj c1)])

intersection :: Eq a => Conjunto a -> Conjunto a -> Conjunto a
intersection (Conj c1) (Conj c2) = Conj ([el | el <- c2, member el (Conj c1)])

fromList :: Eq a => [a] -> Conjunto a
fromList xs = foldr insert empty xs

toList :: Eq a => Conjunto a -> [a]
toList (Conj xs) = xs