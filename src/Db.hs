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


module Db where

import           Control.Monad.IO.Class  (liftIO)
import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH



share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Event
    userName String
    eventName String
    eventTime Double
    deriving Show
|]

