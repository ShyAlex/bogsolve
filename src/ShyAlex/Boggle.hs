module ShyAlex.Boggle
(Die(..)
,Dice
,getPoints
,getWord
,solve
,toDice
) where

import Data.List(delete)
import ShyAlex.List
import ShyAlex.Trie

type Dice = [Die]

data Die = Die { x :: Int 
               , y :: Int
               , face :: String
               } deriving (Eq, Show)

getWord :: Dice -> String
getWord ds = concat $ map face ds

getPoints :: String -> Int
getPoints word =
	let points = [ 0, 0, 0, 1, 1, 2, 3, 5 ] ++ repeat 11
	in points !! length word

toDice :: [String] -> Dice
toDice = toDice' 0 . groupN 4

toDice' :: Int -> [[String]] -> Dice
toDice' _ [] = []
toDice' y (ss:sss) =
	let thisRow = mapi (\ x s -> Die x y s) ss
	    otherRows = toDice' (y + 1) sss
	in thisRow ++ otherRows

isNeighbour :: Die -> Die -> Bool
isNeighbour (Die x y _) (Die x' y' _) = 
	let dx = abs $ x - x'
	    dy = abs $ y - y'
	in (dx == 1 && dy <= 1) || (dy == 1 && dx <= 1)

getRoutes :: String -> Dice -> Dice -> [Dice]
getRoutes [] _ _ = return []
getRoutes letters availableDice activeDice = do
	die <- filter (\ (Die _ _ f) -> take (length f) letters == f) availableDice
	let activeDice' = delete die activeDice
	    availableDice' = filter (isNeighbour die) activeDice'
	    letters' = drop (length $ face die) letters
	subDice <- getRoutes letters' availableDice' activeDice'
	return $ die : subDice

solve :: Dice -> [String] -> [Dice]
solve dice dictionary =
	let trie = newTrie dictionary
	in solve' dice "" trie

solve' :: Dice -> String -> [Trie Char] -> [Dice]
solve' _ _ [] = []
solve' ds cw ((Trie isWord c subTries):otherTries) =
	let cw' = cw ++ [c]
	    sols = getRoutes cw' ds ds
	in (if isWord then sols else []) ++ 
           (if sols /= [] then solve' ds cw' subTries else []) ++ 
           (solve' ds cw otherTries)