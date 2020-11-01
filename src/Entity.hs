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


module Entity where

import           Control.Monad.IO.Class  (liftIO)
import           Database.Persist
import           Database.Persist.Postgresql
import           Database.Persist.TH
import           Control.Monad.Logger    (runStderrLoggingT)

import Event

connStr = "host=localhost dbname=forscotty port=5432 user=jxx password=jxx"

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
EventEntity
    userName String
    eventName String
    eventTime Double    
    deriving Show
|]

dbFunction :: IO ()
dbFunction = runStderrLoggingT $ withPostgresqlPool connStr 10 $ \pool ->
    liftIO $ do
        flip runSqlPersistMPool pool $ do
            runMigration migrateAll

    -- insert $ EventEntity "jxxcarlson"  "signin" 1234.22
    -- insert $ EventEntity "mary88"  "signin" 1260.19

    -- liftIO  $ putStrLn "Done"

