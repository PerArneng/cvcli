module Main where

import Skills

addNumbers :: Int -> Int -> Int
addNumbers x y = x + y

main :: IO ()
main = do
    Skills.loadSkills "skills.json" >>= print
    let sumoftwo = addNumbers 5 6
    putStrLn $ "Hello, Haskell! The sum of 5 and 6 is: " ++ show sumoftwo
