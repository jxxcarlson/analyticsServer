{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

{-
https://codereview.stackexchange.com/questions/188555/haskell-api-for-accessing-a-sqlite-database

https://github.com/scotty-web/scotty-starter

-}

module Main where



import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import Database.PostgreSQL.Simple
import GHC.Generics
import Control.Monad.IO.Class (liftIO) -- liftIO :: IO a -> m a


import qualified Data.Text.Lazy as T
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Cors

import Event



server :: Connection -> ScottyM()
server conn = do
    -- middleware corsPolicy
    -- middleware logStdoutDev

    post "/analytics" $ do
        event <- jsonData :: ActionM Event
        newItem <- liftIO (insertEvent conn event)
        json newItem

    get "/analytics" $ do
      html .  T.pack $ "Yes, I'm still alive"


insertEvent :: Connection -> Event -> IO EventEntity
insertEvent conn event = do
    let insertQuery = "insert into events (userName, eventName, eventTime) values (?, ?, ?) returning id"
    [Only id] <- query conn insertQuery event
    return $ entityFromEvent id event       

port :: Int
port = 8080


main :: IO ()
main = do
    conn <- connectPostgreSQL ("host='127.0.0.1' user='jxx' dbname='forscotty' password='jxx'")
    scotty port $ server conn

      

      



-- main = do
--   putStrLn $ "\nScotty starting up ... \n"
--   scotty port $ do




-- corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
      policy = simpleCorsResourcePolicy
        { corsOrigins  = Nothing
        , corsRequestHeaders = ["Content-Type"]  }  