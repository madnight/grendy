module App.Events where

import App.Data.GrendyApi (query, NET)
import App.State (State(..), Projects)
import Control.Monad.Aff.Console (CONSOLE, log)
import DOM (DOM)
import DOM.HTML.Types (HISTORY)
import Data.Maybe
import Network.HTTP.Affjax (AJAX)
import Node.HTTP (HTTP)
import Prelude (bind, pure, ($), (*>))
import Pux (EffModel, noEffects)

data Event = ReceiveRepos | SetRepos Projects

type AppEffects fx =
  ( history :: HISTORY
  , dom :: DOM
  , console :: CONSOLE
  , net :: NET
  , http :: HTTP
  , ajax :: AJAX | fx
  )

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (SetRepos p) (State st) =
  noEffects $ State st { projects = p }
foldp ReceiveRepos state =
  fetchPrint $ state

consolePrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
consolePrint state =
  { state: state
  , effects: [ log "increment" *> pure Nothing ]
  }

fetchPrint :: ∀ fx. State -> EffModel State Event (AppEffects fx)
fetchPrint state =
  { state: state
  , effects: [ do
             test <- query "https://grendy.herokuapp.com"
             pure $ Just $ SetRepos test ]
  }
