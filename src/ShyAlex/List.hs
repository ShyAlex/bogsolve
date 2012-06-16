module ShyAlex.List
(mapi
,removeAt
,groupN) where

import System.Random(RandomGen, randomR)

mapi :: (Int -> a -> b) -> [a] -> [b]
mapi f = zipWith f [0..]

removeAt :: Int -> [a] -> [a]
removeAt _ [] = []
removeAt 0 (x:xs) = xs
removeAt i (x:xs) = x : removeAt (i - 1) xs

groupN :: Int -> [a] -> [[a]]
groupN i l = groupN' i 0 l [[]]

groupN' :: Int -> Int -> [a] -> [[a]] -> [[a]]
groupN' _ _ [] acc = acc
groupN' i i' (x:xs) (ys:yss) | i' < i = groupN' i (i' + 1) xs $ (x : ys) : yss
	                         | otherwise = groupN' i 1 xs $ [x] : ys : yss