import Data.Char(toLower)
import Data.List(group, intersperse, sort)
import ShyAlex.Boggle
import System.Environment(getArgs)

getDiceRoutes :: [Dice] -> [String]
getDiceRoutes [] = []
getDiceRoutes (ds:dss) = do
    let route = concat $ intersperse " -> " $ map dieToStr ds
        output = getWord ds ++ " : " ++ route
    output : getDiceRoutes dss
    where dieToStr (Die x y f) = f ++ " (" ++ show x ++ ", " ++ show y ++ ")"

main = do
    (dictionaryFile : faces) <- getArgs
    dictionary <- fmap (sort . map (map toLower) . lines) $ readFile dictionaryFile
    let solution = solve faces dictionary
        pointsString = show $ foldl (+) 0 $ map (getPoints . head) $ group $ map getWord solution
    mapM putStrLn $ getDiceRoutes solution
    putStrLn $ "Available points: " ++ pointsString