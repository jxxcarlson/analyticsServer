{-# LANGUAGE OverloadedStrings #-}

{-
https://codereview.stackexchange.com/questions/188555/haskell-api-for-accessing-a-sqlite-database

https://github.com/scotty-web/scotty-starter

-}

module Main where


import Control.Monad.IO.Class (liftIO) -- liftIO :: IO a -> m a
import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import qualified Data.Text.Lazy as T
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Cors

import Event
import Entity


port :: Int
port = 8080

main = do
  putStrLn $ "\nScotty starting up ... \n"
  Entity.dbStart
  scotty port $ do
    middleware corsPolicy
    middleware logStdoutDev
    
    get "/analytics" $ do
      html .  T.pack $ "Yes, I'm still alive"

    -- get "/events" $ do
    --     json allUsers

    post "/analytics" $ do
      
      event <- jsonData :: ActionM Event 
      liftIO $ Entity.dbInsert event
      liftIO $ putStrLn $ show event



-- corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
      policy = simpleCorsResourcePolicy
        { corsOrigins  = Nothing
        , corsRequestHeaders = ["Content-Type"]  }  