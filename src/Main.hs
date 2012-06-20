import Data.Char(toLower, toUpper)
import Data.List(group, intersperse, sort)
import ShyAlex.Boggle
import ShyAlex.List(groupn, padr)
import System.Environment(getArgs)

getGridStrings :: Int -> Dice -> Dice -> [String]
getGridStrings width allDice wordDice =
    let faces = map (\ d -> map (if d `elem` wordDice then toUpper else toLower) $ face d) allDice
        maxFaceWidth = maximum $ map length faces
        paddedFaces = map (padr (maxFaceWidth + 1) ' ') faces
        groupedFaces = groupn width paddedFaces
    in map concat groupedFaces

getRouteStrings :: Dice -> [String]
getRouteStrings ds =
    let route = concat $ intersperse " -> " $ map dieToStr ds
        wordStr = getWord ds
        pointsStr = show $ getPoints wordStr
        unpaddedResult = [ wordStr, pointsStr ++ " point(s)", route ]
        maxLineWidth = maximum $ map length unpaddedResult
    in map (padr maxLineWidth ' ') unpaddedResult
    where dieToStr (Die x y f) = f ++ " (" ++ show x ++ ", " ++ show y ++ ")"

printGrid :: Int -> Dice -> Dice -> IO ()
printGrid width allDice wordDice = do
    let routeStrings = getRouteStrings wordDice 
        gridStrings = getGridStrings width allDice wordDice
        outputHeight = maximum $ map length [ routeStrings, gridStrings ]
        emptyRouteLine = map (\_ -> ' ') $ head routeStrings    
        emptyGridLine = map (\_ -> ' ') $ head gridStrings
        finalRouteStrings = padr outputHeight emptyRouteLine routeStrings
        finalGridStrings = padr outputHeight emptyGridLine gridStrings
        outputLines = zipWith (\ p1 p2 -> p1 ++ "    " ++ p2) finalGridStrings finalRouteStrings
    mapM putStrLn outputLines
    putStrLn ""

main = do
    (dictionaryFile : widthStr : faces) <- getArgs
    dictionary <- fmap (sort . map (map toLower) . lines) $ readFile dictionaryFile
    let width = read widthStr
        dice = toDice width $ map (map toLower) faces
        solution = solve dice dictionary
        pointsString = show $ foldl (+) 0 $ map (getPoints . head) $ group $ map getWord solution
    mapM (printGrid width dice) solution
    putStrLn $ "Available points: " ++ pointsString