{-# LANGUAGE OverloadedStrings #-}

module Event where
import Data.Text.Lazy ( unpack, Text )
import Data.Text.Lazy.Encoding

import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToField

import Data.Aeson
import Control.Applicative


data Event = Event Int Text Text Text Double -- id userName session eventName eventTime
     deriving (Show)

id_ :: Event -> Int
id_ (Event k _ _ _ _) = k

username_ :: Event -> Text
username_ (Event _ n _ _ _) = n

session_ :: Event -> Text
session_ (Event _ _ s _ _ ) = s

eventname_ :: Event -> Text
eventname_ (Event _ _ _ e _) = e

eventtime_ :: Event -> Double
eventtime_ (Event _ _ _ _ t) = t

setId :: Int -> Event -> Event
setId j (Event i username session eventname eventtime) = (Event j username session eventname eventtime)

-- Tell Aeson how to create an Event object from JSON string.
instance FromJSON Event where
     parseJSON (Object v) = Event <$>
                            v .: "id" <*>
                            v .: "username" <*> 
                            v .: "session" <*>
                            v .:  "eventname" <*>
                            v .: "eventtime"

-- Tell Aeson how to convert a Event object to a JSON string.
instance ToJSON Event where
     toJSON (Event id username session eventname eventtime) =
         object [ 
                 "id" .= id,
                 "username" .= username,
                 "session" .= session,
                 "eventname" .= eventname,
                 "eventtime" .= eventtime]

instance FromRow Event where
    fromRow = Event <$> field <*> field <*> field <*> field <*> field

instance ToRow Event where
    toRow i = [toField $ username_ i, toField $ session_ i, toField $ eventname_ i, toField $ eventtime_ i]

