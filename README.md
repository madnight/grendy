# grendy
Github Trending Repositories

![](https://i.imgur.com/V7IjvFD.png)

This project is written in pure functional haskell like language [PureScript](http://try.purescript.org/) together with the [pux framework]( https://github.com/alexmingoia/purescript-pux). Pux is currently in a experimental state and might have some performance bottlenecks.

Main pux function for projects:

```purescript
showProject :: Project -> HTML Event
showProject (Project project) =
  div ! className "project" $ do
    div ! className "todayStars" $ text $ "+" <> project.todayStars
    div ! className "avatar" $ img ! width "100" ! src project.avatarUrl
    div ! className "name" $ a ! href ("https://www.github.com/" <> project.name) $ text project.name
    div ! className "desc" $ text (shorten project.desc)
    div ! className "misc" $  do
      span ! className "star" $ svgStar
      span ! className "totalStars" $ text project.totalStars
      span ! className "license" $ text project.license
      span ! className "language" $ text project.language
```
# Backend API
https://github.com/madnight/grendel

The backend API fetches the required information from Google BigQuery plus Github via GraphQL and is written in Haskell.

# Related Work 

There are two alternatives that i am aware of first the offical GitHub Trends

https://github.com/trending
* Pros: select trending repos per programming language e.g. top trending haskell
* Cons: limitation of top 25 repos

http://www.gitlogs.com/
* Pros: select trending repos per programming language e.g. top trending haskell
* Cons: closed source, secret selection mechanism, GitHub OAuth required because of API rate limit
