module App.State where

import App.Routes (Route, match)

type Projects = Array Project

newtype Project = Project
  { owner :: String
  , name :: String
  }

newtype State = State
  { title :: String
  , route :: Route
  , loaded :: Boolean
  , projects :: Projects
  }

init :: String -> State
init url = State
  { title: "Github Starter"
  , route: match url
  , projects: []
  , loaded: false
  }
