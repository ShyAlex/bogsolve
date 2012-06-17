import Data.Char(toLower, toUpper)
import Data.List(group, intersperse, sort)
import ShyAlex.Boggle
import ShyAlex.List(groupN, padr)
import System.Environment(getArgs)

getGridStrings :: Dice -> Dice -> [String]
getGridStrings allDice wordDice =
    let faces = map (\ d -> map (if d `elem` wordDice then toUpper else toLower) $ face d) allDice
        maxFaceWidth = maximum $ map length faces
        paddedFaces = map (padr (maxFaceWidth + 1) ' ') faces
        groupedFaces = groupN 4 paddedFaces
    in map concat groupedFaces

getRouteString :: Dice -> String
getRouteString ds =
    let route = concat $ intersperse " -> " $ map dieToStr ds
        wordStr = getWord ds
        pointsStr = show $ getPoints wordStr
    in wordStr ++ " (" ++ pointsStr ++ " points) : " ++ route
    where dieToStr (Die x y f) = f ++ " (" ++ show x ++ ", " ++ show y ++ ")"

printGrid :: Dice -> Dice -> IO ()
printGrid allDice wordDice = do
    let (g:gs) = getGridStrings allDice wordDice
        routeString = getRouteString wordDice
        topLine = routeString ++ "    " ++ g
        otherLines = map (replicate (length routeString + 4) ' ' ++) gs
    putStrLn topLine
    mapM putStrLn otherLines
    putStrLn ""

main = do
    (dictionaryFile : faces) <- getArgs
    dictionary <- fmap (sort . map (map toLower) . lines) $ readFile dictionaryFile
    let dice = toDice (map (map toLower) faces)
        solution = solve dice dictionary
        pointsString = show $ foldl (+) 0 $ map (getPoints . head) $ group $ map getWord solution
    mapM (printGrid dice) solution
    putStrLn $ "Available points: " ++ pointsString