module App.Events where

import App.BigQuery (query, NET(..))
import App.Routes (Route)
import App.State (State(..), Projects)
import Data.Function (($))
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects)
import Control.Applicative ((*>), pure)
import Control.Monad.Aff.Console (CONSOLE, log)
import Data.Maybe
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Aff (Aff)
import DOM.HTML.Types (HISTORY)
import DOM (DOM)
import Node.HTTP (HTTP)
import Control.Promise (Promise, toAff)
import Control.Bind (bind, (>>=))
import Control.Monad.Eff.Class (liftEff)
import Data.Foldable (foldMap)
import Data.Traversable (traverse_)
import Prelude

foreign import trends :: forall e. String -> Eff e (Promise Projects)

data Event = PageView Route | ReceiveTodos | SetTodos Projects

type AppEffects fx =
  ( history :: HISTORY
  , dom :: DOM
  , console :: CONSOLE
  , net :: NET
  , http :: HTTP
  , ajax :: AJAX | fx
  )

fetch :: ∀ eff. String -> Aff (net :: NET | eff) Projects
fetch language = liftEff (trends language) >>= toAff

languages :: Array String
languages =
  ["haskell"]
  {-- ["javascript", "c#", "haskell", "purescript", "php", "typescript", "c", "c", "c"] --}

queryStars :: String
queryStars = "haskell"

fetchAll :: ∀ eff. Aff (net :: NET | eff) Projects
fetchAll = foldMap fetch languages

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) =
  noEffects $ State st { route = route, loaded = true }
foldp (SetTodos p) (State st) =
  noEffects $ State st { projects = p }
foldp ReceiveTodos state =
  fetchPrint $ state

consolePrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
consolePrint state =
  { state: state
  , effects: [ log "increment" *> pure Nothing ]
  }

feeds = ["http://github-trends.ryotarai.info/rss/github_trends_all_daily.rss"]

fetchPrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
fetchPrint state =
  { state: state
  , effects: [ do
             test <- query queryStars
             {-- traverse_ (\e -> log e.repo) test --}
             {-- b <- foldMap rss feeds --}
             {-- traverse_ (\e -> log e.title) b --}
             {-- traverse_ (\e -> log e.url) b --}
             {-- traverse_ log a --}
             pure $ Just $ SetTodos test ]
  }
