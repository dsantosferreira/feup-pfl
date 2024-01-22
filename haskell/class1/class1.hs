-- 1.1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use splitAt" #-}
{-# HLINT ignore "Use last" #-}
{-# HLINT ignore "Use !!" #-}
{-# HLINT ignore "Use init" #-}
{-# HLINT ignore "Use guards" #-}
{-# HLINT ignore "Eta reduce" #-}

testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = a + b > c && b + c > a && a + c > b

-- 1.2

areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s * (s-a) * (s - b) * (s - c))
    where s = (a + b + c) / 2

-- 1.3

metades :: [a] -> ([a], [a])
metades l = (take metade l, drop metade l)
    where metade = div (length l) 2

-- 1.4 a)

last1 :: [a] -> a
last1 l = head $ reverse l

last2 :: [a] -> a
last2 l = head (drop (length l - 1) l)

-- 1.4 b)

init1 :: [a] -> [a]
init1 l = take (length l - 1) l

init2 :: [a] -> [a]
init2 l = reverse (tail (reverse l))

-- 1.5 a)

binom :: Integer -> Integer -> Integer
binom n k = product [1 .. n] `div` (product [1 .. k] * product[1 .. n-k])

-- 1.5 b)

binom' :: Integer -> Integer -> Integer
binom' n k  | k > n - k = product [k + 1 .. n] `div` product [1 .. n-k]
            | k <= n - k = product [n - k + 1 .. n] `div` product [1 .. k]

-- 1.6


raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c    | delta > 0 = ((-b + sqrt delta) / 2*a, (-b - sqrt delta) / 2*a)
                | delta == 0 = (-b / (2 * a), 0)
                | otherwise = (0, 0)
                where delta = b * b - 4 * a * c

-- 1.7 (use :t to check the solution)
-- a) [Char]
-- b) (Char, Char, Char)
-- c) [(Bool, Char)]
-- d) ([Bool], [Char])
-- e) [[a] -> [a]]
-- f) [Bool -> Bool]

-- 1.8
-- a) segundo :: [a] -> a
-- b) trocar :: (a, b) -> (b, a)
-- c) par :: a -> b -> (a, b)
-- d) dobro :: Num a => a -> a
-- e) metade :: Fractional a => a -> a
-- f) minuscula :: Char a => a -> Bool
-- g) intervalo :: Ord a => a -> a -> a -> Bool
-- h) palindromo :: Eq a => [a] -> Bool
-- i) twice :: (a -> a) -> a -> a

-- 1.9
classifica :: Int -> String
classifica nota = if nota <= 9 then "reprovado" else
                    if nota >= 10 && nota <= 12 then "suficiente" else
                    if nota >= 13 && nota <= 15 then "bom" else
                    if nota >= 16 && nota <= 18 then "muito bom" else
                    if nota >= 19 && nota <= 20 then "muito bom com distincao" else
                    "Invalido"

classifica' :: Int -> String
classifica' nota    | nota <= 9 = "reprovado"
                    | nota >= 10 && nota <= 12 = "suficiente"
                    | nota >= 13 && nota <= 15 = "bom"
                    | nota >= 16 && nota <= 18 = "muito bom"
                    | nota >= 19 && nota <= 20 = "muito bom com distincao"
                    | otherwise = "Invalido"

-- 1.10
classificaImc :: Float -> Float -> String
classificaImc peso altura   | imc < 18.5 = "baixo peso"
                            | imc >= 18.5 && imc < 25 = "peso normal"
                            | imc >= 25 && imc < 30 = "excesso de peso"
                            | otherwise = "obesidade"
                            where imc = peso / altura^2

-- 1.11 a)
max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z =    if x >= y && x >= z then x else
                if y >= x && y >= z then y else z

min3 x y z =    if x <= y && x <= z then x else
                if y <= x && y <= z then y else z

-- 1.11 b)
max3', min3' :: Ord a => a -> a -> a -> a
max3' x y z = max (max x y) z
min3' x y z = min (min x y) z

-- 1.12
xor :: Bool -> Bool -> Bool
xor x y | x /= y = True
xor _ _ = False

-- 1.13
safetail :: [a] -> [a]
safetail xs = if null xs then [] else tail xs

safetail' :: [a] -> [a]
safetail' xs    | null xs = []
                | otherwise = tail xs

safetail'' :: [a] -> [a]
safetail'' (_ : xs) = xs
safetail'' _ = []

-- 1.14 a)
curta :: [a] -> Bool
curta xs = length xs < 3

-- 1.14 b)
curta' :: [a] -> Bool
curta' (x : y : z : _) = False
curta' _ = True

-- 1.15 a)
mediana :: Ord a => a -> a -> a -> a
mediana x y z   | x >= y && x <= z = x
                | x >= z && x <= y = x
                | y >= x && y <= z = y
                | y >= z && y <= x = y
                | z >= x && z <= y = z
                | z >= y && z <= x = z
-- 1.15 b) Porque é que dá erro se a documentação tiver Num a
mediana' :: (Num a, Ord a) => a -> a -> a -> a
mediana' x y z = x + y + z - maxEl - minEl
                where maxEl = max (max x y) z
                      minEl = min (min x y) z

-- 1.16
converte :: Int -> String
converte num
    | num == 0 = "zero"
    | num < 1000 = converteMenor1000 num
    | segundo < 100 || segundo `mod` 100 == 0 = converteMenor1000 primeiro ++ " mil e " ++ converteMenor1000 segundo
    | otherwise = converteMenor1000 primeiro ++ " mil " ++ converteMenor1000 segundo
    where segundo = num `mod` 1000
          primeiro = num `div` 1000



converteMenor1000 :: Int -> String
converteMenor1000 num
    | num == 100 = "cem"
    | num < 100 = converteMenor100 num
    | num `mod` 100 == 0 = converteBase centenas
    | otherwise = converteBase centenas ++ " e " ++ converteMenor100 resto
    where centenas = num - (num `mod` 100)
          resto = num `mod` 100 

converteMenor100 :: Int -> String
converteMenor100 num 
    | num < 20 || num `mod` 10 == 0 = converteBase num
    | otherwise = converteBase (num - num `mod` 10) ++ " e " ++ converteBase(num `mod` 10)


converteBase :: Int -> String
converteBase num
    | num == 0 = ""
    | num == 1 = "um"
    | num == 2 = "dois"
    | num == 3 = "tres"
    | num == 4 =  "quatro"
    | num == 5 = "cinco"
    | num == 6 = "seis"
    | num == 7 = "sete"
    | num == 8 = "oito"
    | num == 9 = "nove"
    | num == 10 = "dez"
    | num == 11 = "onze"
    | num == 12 = "doze"
    | num == 13 = "treze"
    | num == 14 = "catorze"
    | num == 15 = "quinze"
    | num == 16 = "dezasseis"
    | num == 17 = "dezassete"
    | num == 18 = "dezoito"
    | num == 19 = "dezanove"
    | num == 20 = "vinte"
    | num == 30 = "trinta"
    | num == 40 = "quarenta"
    | num == 50 = "cinquenta"
    | num == 60 = "sessenta"
    | num == 70 = "setenta"
    | num == 80 = "oitenta"
    | num == 90 = "noventa"
    | num == 100 = "cento"
    | num == 200 = "duzentos"
    | num == 300 = "trezentos"
    | num == 400 = "quatrocentos"
    | num == 500 = "quinhentos"
    | num == 600 = "seiscentos"
    | num == 700 = "setecentos"
    | num == 800 = "oitocentos"
    | num == 900 = "novecentos"

test :: (Foldable t, Num b, Num (b -> b -> b)) => t a -> b -> b -> b
test xs = foldr (\x acc -> (*) . (5+) acc) 5 xs