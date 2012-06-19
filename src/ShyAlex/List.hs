module ShyAlex.List
(filterSorted
,groupN
,mapi
,padr
,startsWith) where

filterSorted :: (a -> Bool) -> [a] -> [a]
filterSorted fil = takeWhile fil . dropWhile (not . fil)

groupN :: Int -> [a] -> [[a]]
groupN _ [] = []
groupN i l = let (grp, l') = splitAt i l in grp : (groupN i l')

mapi :: (Int -> a -> b) -> [a] -> [b]
mapi f = zipWith f [0..]

padr :: Int -> a -> [a] -> [a]
padr n x xs = xs ++ replicate (n - length xs) x

startsWith :: Eq a => [a] -> [a] -> Bool
startsWith xs ys = (length xs <= length ys) && (all id $ zipWith (==) xs ys)