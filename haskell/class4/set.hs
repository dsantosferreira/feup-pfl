{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Set where

data Set a = Node a (Set a) (Set a) | Empty deriving Show

empty :: Set a
empty = Empty

insert :: Ord a => a -> Set a -> Set a
insert el Empty = Node el Empty Empty
insert el (Node x l r)
    | el == x = Node x l r
    | el < x = Node x (insert el l) r
    | el > x = Node x l (insert el r)

member :: Ord a => a -> Set a -> Bool
member _ Empty = False
member el (Node x l r)
    | el == x = True
    | el < x = member el l
    | el > x = member el r

toList :: Ord a => Set a -> [a]
toList Empty = []
toList (Node x l r) = toList l ++ [x] ++ toList r

fromList :: Ord a => [a] -> Set a
fromList xs = foldr insert empty xs

union :: Ord a => Set a -> Set a -> Set a
union setA setB = foldr insert setB (toList setA)

intersect :: Ord a => Set a -> Set a -> Set a
intersect setA setB = fromList [el | el <- toList setA, member el setB]

difference :: Ord a => Set a -> Set a -> Set a
difference setA setB = fromList [el | el <- toList setA, not $ member el setB]

