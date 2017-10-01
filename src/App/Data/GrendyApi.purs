module App.Data.GrendyApi
( NET
, query
) where

import App.State (Projects)
import Control.Monad.Aff (Aff)
import Control.Monad.Eff (Eff, kind Effect)
import Control.Promise (Promise, toAff)
import Control.Monad.Eff.Class (liftEff)
import Prelude ((>>=))

foreign import data NET :: Effect
foreign import fetch :: ∀ eff. String -> Eff eff (Promise Projects)

query :: ∀ eff. String -> Aff (net :: NET | eff) Projects
query url = liftEff (fetch url) >>= toAff
