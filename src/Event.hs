{-# LANGUAGE OverloadedStrings #-}

module Event where
import Data.Text.Lazy ( unpack, Text )
import Data.Text.Lazy.Encoding

import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToField

import Data.Aeson
import Control.Applicative


data Event = Event Int Text Text Double -- id userName eventName eventTime
     deriving (Show)

id_ :: Event -> Int
id_ (Event k _ _ _ ) = k

userName_ :: Event -> Text
userName_ (Event _ n _ _ ) = n

eventName_ :: Event -> Text
eventName_ (Event _ _ e _) = e

eventTime_ :: Event -> Double
eventTime_ (Event _ _ _ t) = t

setId :: Int -> Event -> Event
setId j (Event i userName eventName eventTime) = (Event j userName eventName eventTime)

-- Tell Aeson how to create an Event object from JSON string.
instance FromJSON Event where
     parseJSON (Object v) = Event <$>
                            v .: "id" <*>
                            v .: "userName" <*> 
                            v .:  "eventName" <*>
                            v .: "eventTime"

-- Tell Aeson how to convert a Event object to a JSON string.
instance ToJSON Event where
     toJSON (Event id userName eventName eventTime) =
         object [ 
                 "id" .= id,
                 "userName" .= userName,
                 "eventName" .= eventName,
                 "eventTime" .= eventTime]

instance FromRow Event where
    fromRow = Event <$> field <*> field <*> field <*> field

instance ToRow Event where
    toRow i = [toField $ userName_ i, toField $ eventName_ i, toField $ eventTime_ i]

