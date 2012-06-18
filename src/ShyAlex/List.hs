module ShyAlex.List
(groupN
,mapi
,padr
,startsWith) where

mapi :: (Int -> a -> b) -> [a] -> [b]
mapi f = zipWith f [0..]

padr :: Int -> a -> [a] -> [a]
padr n x xs = xs ++ replicate (n - length xs) x

groupN :: Int -> [a] -> [[a]]
groupN _ [] = []
groupN i l = let (grp, l') = splitAt i l in grp : (groupN i l')

startsWith :: Eq a => [a] -> [a] -> Bool
startsWith xs ys = all id $ zipWith (==) xs ys