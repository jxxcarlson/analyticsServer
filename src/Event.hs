{-# LANGUAGE OverloadedStrings #-}

module Event where
import Data.Text.Lazy ( unpack, Text )
import Data.Text.Lazy.Encoding

import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToField

import Data.Aeson
import Control.Applicative
-- import System.Process
-- import Data.List.Split


data Event = Event Text Text Double -- userName eventName eventTime
     deriving (Show)

data EventEntity = EventEntity Int Text Text Double -- userName eventName eventTime
     deriving (Show)

id_ :: EventEntity -> Int
id_ (EventEntity k _ _ _ ) = k

userName_ :: EventEntity -> Text
userName_ (EventEntity _ n _ _ ) = n

eventName_ :: EventEntity -> Text
eventName_ (EventEntity _ _ e _) = e

eventTime_ :: EventEntity -> Double
eventTime_ (EventEntity _ _ _ t) = t




userName__ :: Event -> Text
userName__ (Event n _ _) = n

eventName__ :: Event -> Text
eventName__ (Event _ e _) = e

eventTime__ :: Event -> Double
eventTime__ (Event _ _ t) = t


entityFromEvent id event = EventEntity id (userName__ event)  (eventName__ event) (eventTime__ event)

-- Tell Aeson how to create an Event object from JSON string.
instance FromJSON Event where
     parseJSON (Object v) = Event <$>
                            v .: "userName" <*> 
                            v .:  "eventName" <*>
                            v .: "eventTime"


-- Tell Aeson how to convert a Event object to a JSON string.
instance ToJSON Event where
     toJSON (Event userName eventName eventTime) =
         object [ 
                 "userName" .= userName,
                 "eventName" .= eventName,
                 "eventTime" .= eventTime]

instance ToJSON EventEntity where
     toJSON (EventEntity id userName eventName eventTime) =
         object [ 
                 "id" .= id,
                 "userName" .= userName,
                 "eventName" .= eventName,
                 "eventTime" .= eventTime]



instance FromRow EventEntity where
    fromRow = EventEntity <$> field <*> field <*> field <*> field

instance ToRow EventEntity where
    toRow i = [toField $ id_ i, toField $ userName_ i, toField $ eventName_ i, toField $ eventTime_ i]

instance ToRow Event where
    toRow i = [toField $ userName__ i, toField $ eventName__ i, toField $ eventTime__ i]
