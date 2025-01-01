{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Skills 
    ( Skill(..)
    , loadSkills
    , saveSkills
    ) where

import GHC.Generics
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Control.Exception (catch)
import System.IO.Error (IOError)

data Skill = Skill
    { id :: String
    , name :: String
    , level :: Int
    , roles :: [String]
    } deriving (Show, Generic)

instance FromJSON Skill
instance ToJSON Skill

-- | Load skills from a JSON file
loadSkills :: FilePath -> IO (Either String [Skill])
loadSkills path = do
    result <- (Right <$> B.readFile path) `catch` handleError
    return $ case result of
        Left err -> Left err
        Right contents -> case eitherDecode contents of
            Left err -> Left err
            Right skills -> Right skills
  where
    handleError :: IOError -> IO (Either String B.ByteString)
    handleError e = return $ Left $ "Error reading file: " ++ show e

-- | Save skills to a JSON file
saveSkills :: FilePath -> [Skill] -> IO (Either String ())
saveSkills path skills = do
    result <- (Right <$> B.writeFile path (encode skills)) `catch` handleError
    return result
  where
    handleError :: IOError -> IO (Either String ())
    handleError e = return $ Left $ "Error writing file: " ++ show e