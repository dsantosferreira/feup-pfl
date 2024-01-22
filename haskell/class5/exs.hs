{--

ioSucc :: IO ()
ioSucc = do
    putStrLn "Write an integer:"
    input <- getLine
    let num = read input :: Integer
    putStrLn $ "The successor is " ++ show (succ num)

myGetLine :: IO String
myGetLine = do
    x <- getChar
    if x == '\n'
        then return []
        else do
            xs <- myGetLine
            return (x:xs)

--}

-- 4.1 a 4.6 em binTree.hs

-- 4.7

