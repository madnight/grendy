
module App.BigQuery
( NET
, query
) where

import App.State (State(..), Projects, Project)
import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Exception (Error)
import Control.Monad.Error.Class (throwError)
import Data.List as List
import Data.Either
import Data.Foldable
import Data.List ((:), List(..))
import Data.Maybe
import Data.NonEmpty ((:|), NonEmpty(..))
import Control.Monad.Eff (Eff, kind Effect)
import Data.String.CaseInsensitive
import Control.Promise (Promise, toAff)
import Control.Monad.Eff.Class (liftEff)
import Data.Traversable
import Data.JSDate (JSDate)
import Node.HTTP (HTTP)
import Prelude

foreign import data NET :: Effect

query :: ∀ eff. String -> Aff (net :: NET | eff) Projects
query language = liftEff (bigquery language) >>= toAff

foreign import bigquery
  :: forall eff. String
  -> Eff eff (Promise Projects)
