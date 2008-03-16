-----------------------------------------------------------------------------
-- |
-- Module      :  Xmobar.Config
-- Copyright   :  (c) Andrea Rossato
-- License     :  BSD-style (see LICENSE)
--
-- Maintainer  :  Andrea Rossato <andrea.rossato@unibz.it>
-- Stability   :  unstable
-- Portability :  unportable
--
-- The configuration module of Xmobar, a text based status bar
--
-----------------------------------------------------------------------------

module Config ( -- * Configuration
                -- $config
                Config (..)
              , XPosition (..), Align (..)
              , defaultConfig
              , runnableTypes
              ) where

import Commands
import {-# SOURCE #-} Runnable
import Plugins.Monitors
import Plugins.Date
import Plugins.PipeReader
import Plugins.StdinReader

-- $config
-- Configuration data type and default configuration

-- | The configuration data type
data Config =
    Config { font           :: String     -- ^ Font
           , bgColor        :: String     -- ^ Backgroud color
           , fgColor        :: String     -- ^ Default font color
           , position       :: XPosition  -- ^ Top Bottom or Static
           , commands       :: [Runnable] -- ^ For setting the command, the command argujments
                                          --   and refresh rate for the programs to run (optional)
           , sepChar        :: String     -- ^ The character to be used for indicating
                                          --   commands in the output template (default '%')
           , alignSep       :: String     -- ^ Separators for left, center and right text alignment
           , template       :: String     -- ^ The output template
           } deriving (Read)

data XPosition = Top | TopW Align Int | Bottom | BottomW Align Int | Static {xpos, ypos, width, height :: Int} deriving ( Read, Eq )

data Align = L | R | C deriving ( Read, Eq )

-- | The default configuration values
defaultConfig :: Config
defaultConfig =
    Config { font     = "-misc-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
           , bgColor  = "#000000"
           , fgColor  = "#BFBFBF"
           , position = Top
           , commands = [ Run $ Date "%a %b %_d %Y * %H:%M:%S" "theDate" 10
                        , Run StdinReader
                        ]
           , sepChar  = "%"
           , alignSep = "}{"
           , template = "%StdinReader% }{ <fc=#00FF00>%uname%</fc> * <fc=#FF0000>%theDate%</fc>"
           }

-- | This is the list of types that can be hidden inside
-- 'Runnable.Runnable', the existential type that stores all commands
-- to be executed by Xmobar. It is used by 'Runnable.readRunnable' in
-- the 'Runnable.Runnable' Read instance. To install a plugin just add
-- the plugin's type to the list of types appearing in this function's type
-- signature.
runnableTypes :: (Command,(Monitors,(Date,(PipeReader,(StdinReader,())))))
runnableTypes = undefined
