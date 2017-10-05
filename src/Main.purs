module Main where

import App.Events (AppEffects, Event(..), foldp)
import App.State (State, init)
import App.View.Layout (view)
import Control.Monad.Aff.Console (CONSOLE)
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML.Types (HISTORY)
import Network.HTTP.Affjax (AJAX)
import Prelude
import Pux (CoreEffects, App, start)
import Pux.DOM.Events (DOMEvent)
import Pux.Renderer.React (renderToDOM)
import Signal (constant)

type WebApp = App (DOMEvent -> Event) Event State

type ClientEffects =
  CoreEffects ( AppEffects ( history :: HISTORY
                           , dom :: DOM
                           , console :: CONSOLE
                           , ajax :: AJAX ))

initialState :: State
initialState = init "/"

main :: String -> State -> Eff ClientEffects WebApp
main url state = do
  app <- start
    { initialState: state
    , view
    , foldp
    , inputs: [constant ReceiveRepos] }
  renderToDOM "#app" app.markup app.input
  pure app
