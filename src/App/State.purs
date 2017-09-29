module App.State where

import App.Routes (Route, match)

type Projects = Array Project

newtype Project = Project
  { name :: String
  , todayStars :: String
  , avatarUrl :: String
  , date :: String
  , language :: String
  , totalStars :: String
  , todayStars :: String
  , license :: String
  , desc :: String
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
