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
import           Database.Persist.Sqlite
import           Database.Persist.TH

import Event



share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
EventEntity
    userName String
    eventName String
    eventTime Double    
    deriving Show
|]

dbStuff :: IO ()
dbStuff = runSqlite ":memory:" $ do
    runMigration migrateAll

    insert $ EventEntity "jxxcarlson"  "signin" 1234.22
    insert $ EventEntity "mary88"  "signin" 1260.19

    liftIO  $ putStrLn "Done"

