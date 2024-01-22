module Bintree(Bintree, empty, isEmpty, insert, member, delete) where

data Bintree a = Empty | Node a (Bintree a) (Bintree a) deriving Show

empty :: Bintree a
empty = Empty

isEmpty :: Bintree a -> Bool
isEmpty Empty = True
isEmpty _ = False

insert :: Ord a => a -> Bintree a -> Bintree a
insert el Empty = Node el Empty Empty
insert el (Node x l r)
    | el == x = Node x l r
    | el < x = Node x (insert el l) r
    | el > x = Node x l (insert el r)

member :: Ord a => a -> Bintree a -> Bool
member _ Empty = False
member el (Node x l r)
    | el == x = True
    | el < x = member el l
    | el > x = member el r

delete :: Ord a => a -> Bintree a -> Bintree a
delete _ Empty = Empty
delete el (Node x l Empty) | el == x = l
delete el (Node x Empty r) | el == x = r
delete el (Node x l r) | el == x = let newEl = mostLeft r
                                   in Node newEl l (delete newEl r)
                       | otherwise = Node x (delete el l) (delete el r)

mostLeft :: Bintree a -> a
mostLeft Empty = error "No element in empty Bintree"
mostLeft (Node el Empty _) = el
mostLeft (Node el l _) = mostLeft l

-- 4.1
sumArv :: Num a =>  Bintree a -> a
sumArv Empty = 0
sumArv (Node x l r) = x + sumArv l + sumArv r

-- 4.2
listarRev :: Bintree a -> [a]
listarRev Empty = []
listarRev (Node x l r) = listarRev r ++ [x] ++ listarRev l

-- 4.3
nivel :: Int -> Bintree a -> [a]
nivel n _ | n < 0 = []
nivel _ Empty = []
nivel 0 (Node el _ _) = [el]
nivel n (Node el l r) = nivel (n - 1) l ++ nivel (n - 1) r

-- 4.4 a) Árvore equilibrada
-- 4.4 b) Pior árvore possível, uma lista ligada

-- 4.5
mapArv :: (a -> b) -> Bintree a -> Bintree b
mapArv _ Empty = Empty
mapArv f (Node x l r) =  Node (f x) (mapArv f l)  (mapArv f r)

-- 4.6
delete' :: Ord a => a -> Bintree a -> Bintree a
delete' _ Empty = Empty
delete' el (Node x l Empty) | el == x = l
delete' el (Node x Empty r) | el == x = r
delete' el (Node x l r) | el == x = let newEl = mostRight l
                                   in Node newEl (delete' newEl l) r
                       | otherwise = Node x (delete' el l) (delete' el r)

mostRight :: Bintree a -> a
mostRight Empty = error "No element in empty Bintree"
mostRight (Node el _ Empty) = el
mostRight (Node el _ r) = mostRight r