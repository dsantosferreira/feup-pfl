{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# OPTIONS_GHC -Wno-duplicate-exports #-}

module Stack(Stack, empty, isEmpty, push, empty, pop, top) where

data Stack a = Stk [a] deriving Show

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk []) = True
isEmpty _ = False

push :: a -> Stack a -> Stack a
push a (Stk l) = Stk (a:l)

pop :: Stack a -> Stack a
pop (Stk (_:xs)) = Stk xs
pop _ = error "Tried to pop empty stack"

top :: Stack a -> a
top (Stk (x:_)) = x
top _ = error "Tried to access top of empty stack"