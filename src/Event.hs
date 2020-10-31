{-# LANGUAGE OverloadedStrings #-}

module Event where
import Data.Text.Lazy ( unpack, Text )
import Data.Text.Lazy.Encoding
import Data.Aeson
import Control.Applicative
-- import System.Process
-- import Data.List.Split

-- Define the Article constructor
-- e.g. Article 12 "some title" "some body text"
data Event = Event Text Text Double -- userName eventName eventTime
     deriving (Show)


-- docId :: Document -> Text
-- docId (Document id _ _) = id

-- content :: Document -> Text
-- content (Document _ content _ ) = content

-- urlList :: Document -> [Text]
-- urlList (Document _  _ urlList ) = urlList

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


-- write :: Document -> IO()
-- write doc = 
--   let
--     fileName = "texFiles/" ++ (unpack $ docId doc) ++ ".tex"
--     contents = unpack $ content doc
--   in
--     writeFile fileName contents

-- cleanImages :: Text -> IO()
-- cleanImages docId =
--      do
--        let  manifestFileName = "texFiles/" ++ (unpack docId) ++ "_image_manifest.txt"
--        manifest <- readFile manifestFileName 
--        let commands = Document.removeImagesCommand manifest  
--        system commands >>= \exitCode -> print exitCode  


-- writeImageManifest :: Document -> IO()
-- writeImageManifest doc =
--   let
--     urlData =  joinStrings "\n" $ Prelude.map unpack  (urlList doc)
--     fileName = "texFiles/" ++ (unpack $ docId doc) ++ "_image_manifest.txt"
--     cmd = "wget -P image -i " ++ fileName

--   in 
--     do 
--       writeFile fileName urlData
--       system cmd >>= \exitCode -> print exitCode




-- removeImagesCommand :: String -> String
-- removeImagesCommand manifest =
--     joinStrings "; " $ map removeImageCommand $ lines manifest  


-- removeImageCommand :: String -> String
-- removeImageCommand imageName = 
--     "rm image/" ++ (getImageName imageName)

-- getImageName :: String -> String
-- getImageName str = last $ splitOn "/" str



-- joinStrings :: String -> [String] -> String
-- joinStrings separator [] = ""
-- joinStrings separator [x] = x
-- joinStrings separator (x:xs) = x ++ separator ++ (joinStrings separator xs) 
