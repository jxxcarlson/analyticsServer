{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib

import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import qualified Data.Text.Lazy as T


main = scotty 3000 $ do
  middleware logStdoutDev
  
  get "/" $ do
    html .  T.pack $ "Hello World!"