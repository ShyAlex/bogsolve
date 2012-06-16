module ShyAlex.Boggle
(Die(..)
,Dice
,getPoints
,getWord
,solve
) where

import ShyAlex.List
import ShyAlex.Trie

type Dice = [Die]

data Die = Die { x :: Int 
               , y :: Int
               , face :: String
               } deriving (Eq, Show)

data Link = Link { fromDie :: Die
                 , toDie :: Die
                 } deriving (Eq, Show)

toDice :: [[String]] -> Dice
toDice = toDice' 0

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

getLinks :: Dice -> [Link]
getLinks dice =
	concat $ map getDieLinks dice
	where getDieLinks d = map (\ d' -> Link d d') $ filter (isNeighbour d) dice

getLinksFrom :: Die -> [Link] -> [Link]
getLinksFrom d = filter (\ (Link f _) -> f == d)

removeLinksTo :: Die -> [Link] -> [Link]
removeLinksTo d = filter (\ (Link _ t) -> t /= d)

getRoutes :: String -> Dice -> [Link] -> [Dice]
getRoutes [] _ _ = return []
getRoutes letters availableDice activeLinks = do
	die <- filter (\ (Die _ _ f) -> take (length f) letters == f) $ availableDice
	let activeLinks' = removeLinksTo die activeLinks
	    availableDice' = map toDie $ getLinksFrom die activeLinks'
	    letters' = drop (length $ face die) letters
	subDice <- getRoutes letters' availableDice' activeLinks'
	return $ die : subDice

getWord :: Dice -> String
getWord ds = concat $ map face ds

solve :: [String] -> [String] -> [Dice]
solve faces dictionary =
	let dice = toDice $ groupN 4 faces
	    links = getLinks dice
	    trie = fromWords dictionary
	in solve' dice links "" trie

solve' :: Dice -> [Link] -> String -> [Trie] -> [Dice]
solve' _ _ _ [] = []
solve' ds ls cw ((Trie isWord c subTries):otherTries) =
	let cw' = cw ++ [c]
	    sols = getRoutes cw' ds ls
	in if sols == [] 
	   then solve' ds ls cw otherTries
	   else (if isWord then sols else []) ++ solve' ds ls cw' subTries ++ solve' ds ls cw otherTries

getPoints :: String -> Int
getPoints word =
	let points = [ 0, 0, 0, 1, 1, 2, 3, 5 ] ++ repeat 11
	in points !! length word