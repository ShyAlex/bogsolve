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
groupN _ [] = []
groupN i l = let (grp, l') = splitAt i l in grp : (groupN i l')