module ShyAlex.Boggle
(Die(..)
,Dice
,getPoints
,getWord
,solve
,toDice
) where

import Data.List(delete, group, sortBy)
import ShyAlex.List

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

solve :: Dice -> [String] -> [Dice]
solve dice dictionary = sortBy (\ ds1 ds2 -> compare (getWord ds1) (getWord ds2)) $ solve' [] dice dice dictionary

solve' :: Dice -> Dice -> Dice -> [String] -> [Dice]
solve' wordDice availableDice activeDice dictionary = do
	die <- availableDice
	let dieFace = face die
	    activeDice' = delete die activeDice
	    availableDice' = filter (isNeighbour die) activeDice'
	    wordDice' = wordDice ++ [die]
	    dictionary' = map (drop $ length dieFace) $ filter (startsWith dieFace) dictionary
	    isWord = any (== []) dictionary'
	    dictionary'' = filter (/= []) dictionary'
	    subDices = if dictionary'' /= [] && availableDice' /= [] then solve' wordDice' availableDice' activeDice' dictionary'' else []
	if isWord then wordDice' : subDices else subDices