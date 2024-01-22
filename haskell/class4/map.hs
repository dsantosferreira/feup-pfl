module Map where

data Map k v = Empty | Node (k, v) (Map k v) (Map k v) deriving Show

empty :: Map k a
empty = Empty

insert :: Ord k => k -> a -> Map k a -> Map k a
insert k v Empty = Node (k, v) Empty Empty
insert k v (Node (ck, cv) l r)
    | k < ck = Node (ck, cv) (insert k v l) r
    | k > ck = Node (ck, cv) l (insert k v r)
    | otherwise = Node (k, v) l r

myLookup :: Ord k => k -> Map k a -> Maybe a
myLookup k Empty = Nothing
myLookup k (Node (ck, v) l r)
    | k == ck = Just v
    | k < ck = myLookup k l
    | k > ck = myLookup k r

myTree :: Map Integer Integer
myTree = Node (5, 3) (Node (3, 2) (Node (1, 1) Empty Empty) (Node (4, 6) Empty Empty)) (Node (7, 2) Empty Empty)