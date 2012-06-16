module ShyAlex.Trie
(Trie(..)
,fromWords
) where

import Data.List

data Trie = Trie Bool Char [Trie] deriving(Show)

fromWords :: [String] -> [Trie]
fromWords ws =
	map groupToTrie $ groupBy sameInitial ws
	where sameInitial x y | x == [] = False
	                      | y == [] = False
	                      | otherwise = head x == head y
	      groupToTrie g = Trie (any (\ w -> length w == 1) g) (head $ head g) (fromWords $ filter (/= []) $ map tail g)	