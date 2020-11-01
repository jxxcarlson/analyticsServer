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


main = do
  dbStuff
  scotty 8080 $ do
    middleware corsPolicy
    middleware logStdoutDev
    
    get "/analytics" $ do
      html .  T.pack $ "Yes, I'm still alive"

    post "/analytics" $ do
      
      event <- jsonData :: ActionM Event 
      liftIO $ putStrLn $ show event



-- corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
    where
      policy = simpleCorsResourcePolicy
        { corsOrigins  = Nothing
        , corsRequestHeaders = ["Content-Type"]  }  