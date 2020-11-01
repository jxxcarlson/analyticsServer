{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}


module Main where

import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import Database.PostgreSQL.Simple
import GHC.Generics
import Control.Monad.IO.Class (liftIO) -- liftIO :: IO a -> m a


import qualified Data.Text.Lazy as T
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Cors
import Network.HTTP.Types.Method

import Event

port :: Int
port = 8080

main :: IO ()
main = do
    conn <- connectPostgreSQL ("host='127.0.0.1' user='jxx' dbname='forscotty' password='jxx'")
    scotty port $ do
       middleware corsPolicy
       middleware logStdoutDev
       server conn


server :: Connection -> ScottyM()
server conn = do

    post "/analytics" $ do
        event <- jsonData :: ActionM Event
        newItem <- liftIO (insertEvent conn event)
        json newItem

    get "/analytics/hello" $ do
      html .  T.pack $ "Yes, I'm still alive"


insertEvent :: Connection -> Event -> IO Event
insertEvent conn event = do
    let insertQuery = "insert into events (userName, eventName, eventTime) values (?, ?, ?) returning id"
    [Only id] <- query conn insertQuery event
    return $ setId id event


-- corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
      policy = simpleCorsResourcePolicy
        { corsOrigins  = Nothing
        , corsMethods = ["POST"]
        , corsRequestHeaders = ["Content-Type"]  }  