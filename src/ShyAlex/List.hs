module ShyAlex.List
(filterSorted
,groupn
,mapi
,padr) where

filterSorted :: (a -> Bool) -> [a] -> [a]
filterSorted fil = takeWhile fil . dropWhile (not . fil)

groupn :: Int -> [a] -> [[a]]
groupn _ [] = []
groupn i l = let (grp, l') = splitAt i l in grp : (groupn i l')

mapi :: (Int -> a -> b) -> [a] -> [b]
mapi f = zipWith f [0..]

padr :: Int -> a -> [a] -> [a]
padr n x xs = xs ++ replicate (n - length xs) x