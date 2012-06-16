module ShyAlex.List
(groupN
,mapi) where

mapi :: (Int -> a -> b) -> [a] -> [b]
mapi f = zipWith f [0..]

groupN :: Int -> [a] -> [[a]]
groupN _ [] = []
groupN i l = let (grp, l') = splitAt i l in grp : (groupN i l')