{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib

import Web.Scotty
import qualified Data.Text.Lazy as T


main = scotty 3000 $ do
  get "/" $ do
    html .  T.pack $ "Hello World!"