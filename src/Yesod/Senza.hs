-- | Useful utilities for using Senza with Yesod.

module Yesod.Senza
  (module Yesod.Senza
  ,module Yesod)
  where

import Senza
import Yesod

-- | A senza generator.
type FromSenza a =
  Maybe (Route a) ->
  (Route a -> AttributeValue) ->
  Senza

-- | Output some senza, passes a URL renderer to the continuation.
senza :: MonadHandler m => FromSenza (HandlerSite m) -> m Html
senza cont =
  do render <- getUrlRender
     route <- getCurrentRoute
     return
       (cont route (toValue . render))
