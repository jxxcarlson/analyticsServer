{-# LANGUAGE OverloadedStrings #-}

module Event where
import Data.Text.Lazy ( unpack, Text )
import Data.Text.Lazy.Encoding

import Data.Aeson
import Control.Applicative
-- import System.Process
-- import Data.List.Split


data Event = Event Text Text Double -- userName eventName eventTime
     deriving (Show)



userName :: Event -> Text
userName (Event n _ _) = n

eventName :: Event -> Text
eventName (Event _ e _) = e

eventTime :: Event -> Double
eventTime (Event _ _ t) = t

-- Tell Aeson how to create an Event object from JSON string.
instance FromJSON Event where
     parseJSON (Object v) = Event <$>
                            v .: "userName" <*> 
                            v .:  "eventName" <*>
                            v .: "eventTime"


-- Tell Aeson how to convert a Event object to a JSON string.
instance ToJSON Event where
     toJSON (Event userName eventName eventTime) =
         object ["userName" .= userName,
                 "eventName" .= eventName,
                 "eventTime" .= eventTime]

