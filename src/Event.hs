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

username_ :: Event -> Text
username_ (Event _ n _ _ ) = n

eventname_ :: Event -> Text
eventname_ (Event _ _ e _) = e

eventtime_ :: Event -> Double
eventtime_ (Event _ _ _ t) = t

setId :: Int -> Event -> Event
setId j (Event i username eventname eventtime) = (Event j username eventname eventtime)

-- Tell Aeson how to create an Event object from JSON string.
instance FromJSON Event where
     parseJSON (Object v) = Event <$>
                            v .: "id" <*>
                            v .: "username" <*> 
                            v .:  "eventname" <*>
                            v .: "eventtime"

-- Tell Aeson how to convert a Event object to a JSON string.
instance ToJSON Event where
     toJSON (Event id username eventname eventtime) =
         object [ 
                 "id" .= id,
                 "username" .= username,
                 "eventname" .= eventname,
                 "eventtime" .= eventtime]

instance FromRow Event where
    fromRow = Event <$> field <*> field <*> field <*> field

instance ToRow Event where
    toRow i = [toField $ username_ i, toField $ eventname_ i, toField $ eventtime_ i]

