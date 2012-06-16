module ShyAlex.Trie
(Trie(..)
,newTrie
) where

import Data.List(groupBy)

data Trie a = Trie Bool a [Trie a] deriving(Show)

sameHead :: Eq a => [a] -> [a] -> Bool
sameHead [] _ = False
sameHead _ [] = False
sameHead (x:_) (y:_) = x == y 

newTrie :: Eq a => [[a]] -> [Trie a]
newTrie =
	let terminatesHere = any $ (== 1) . length
	    getTrieItem = head . head
	    getSubTries = newTrie . filter (/= []) . map tail
	    groupToTrie g = Trie (terminatesHere g) (getTrieItem g) (getSubTries g)
	in map groupToTrie . groupBy sameHead