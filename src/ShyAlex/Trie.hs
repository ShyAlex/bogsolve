module ShyAlex.Trie
(Trie(..)
,newTrie
) where

import Data.List(groupBy)
import ShyAlex.List(startsWith)

data Trie = Trie Bool String [Trie] | NullTrie deriving(Show)

newTrie :: [String] -> [String] -> [Trie]
newTrie allowedNodes dicWords = do
	nodeTag <- allowedNodes
	let nodeWords = map (drop (length nodeTag)) $ filter (startsWith nodeTag) dicWords
	if nodeWords == [] then []
	else return $ Trie (any (== []) nodeWords) nodeTag (newTrie allowedNodes $ filter (/= []) nodeWords)