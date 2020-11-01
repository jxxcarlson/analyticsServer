{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}


module Entity (dbStart, dbInsert) where

import           Control.Monad.IO.Class  (liftIO)
import           Database.Persist
import           Database.Persist.Postgresql
import           Database.Persist.TH
import           Control.Monad.Logger    (runStderrLoggingT)
import qualified Data.Text.Lazy as T

import Event

connStr = "host=localhost dbname=forscotty port=5432 user=jxx password=jxx"

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
EventEntity
    userName String
    eventName String
    eventTime Double    
    deriving Show
|]

dbStart :: IO ()
dbStart = runStderrLoggingT $ withPostgresqlPool connStr 10 $ \pool ->
    liftIO $ do
        flip runSqlPersistMPool pool $ do

            runMigration migrateAll

            insert $ EventEntity "jxxcarlson"  "signin" 1234.22
            insert $ EventEntity "mary88"  "signin" 1260.19

            liftIO  $ putStrLn "\nDatabase up and running\n"

dbInsert :: Event -> IO ()
dbInsert event = runStderrLoggingT $ withPostgresqlPool connStr 10 $ \pool ->
    liftIO $ do
        flip runSqlPersistMPool pool $ do
            insert $ EventEntity (T.unpack $ userName event)  (T.unpack $ eventName event) (eventTime event)
            liftIO  $ putStrLn $ "Inserted " ++ (T.unpack $ eventName event)


-- inHandlerDb = liftIO . dbFunction

-- inAppDb = liftIO . dbFunction

-- dbFunction query = runStderrLoggingT $ 
--         withPostgresqlPool connStr 10 $ 
--         \pool -> liftIO $ runSqlPersistMPool query pool

-- doMigrations = runMigration migrateAll

-- dbInitialData = do
--     insert $ EventEntity "jxxcarlson"  "signin" 1234.22
--     insert $ EventEntity "mary88"  "signin" 1260.19

