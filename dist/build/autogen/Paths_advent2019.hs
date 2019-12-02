{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_advent2019 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/sam/.cabal/bin"
libdir     = "/home/sam/.cabal/lib/x86_64-linux-ghc-8.0.2/advent2019-0.1.0.0-CX88RaByPKH2jPY4llJxUL"
dynlibdir  = "/home/sam/.cabal/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/home/sam/.cabal/share/x86_64-linux-ghc-8.0.2/advent2019-0.1.0.0"
libexecdir = "/home/sam/.cabal/libexec"
sysconfdir = "/home/sam/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "advent2019_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "advent2019_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "advent2019_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "advent2019_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "advent2019_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "advent2019_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
