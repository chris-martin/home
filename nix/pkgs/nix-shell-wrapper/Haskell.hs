{-# LANGUAGE TemplateHaskell #-}

module Main (main) where

import           Path                (Abs, Dir, Path, mkRelFile, parent,
                                      parseAbsDir, (</>))
import qualified Path
import           System.Directory    (doesFileExist, getCurrentDirectory)
import           System.Environment  (getArgs, getEnv)
import           System.Exit         (ExitCode (..), exitWith)
import           System.IO           (hPutStrLn, stderr)
import           System.Posix.Escape (escapeMany)
import           System.Process      (CreateProcess (..), createProcess, proc,
                                      waitForProcess)

main :: IO ()
main = main' =<< getPath
    where
    main' path = do
        shellNixExists <- testShell
        if shellNixExists
            then useShell
            else do
                stackYamlExists <- testStack
                if stackYamlExists
                    then noWrap
                    else maybe fail main' $ parentMaybe path
        where
        testShell = doesFileExist $ Path.toFilePath $ path </> $(mkRelFile "shell.nix")
        testStack = doesFileExist $ Path.toFilePath $ path </> $(mkRelFile "stack.yaml")
        useShell = do
            cmd <- getWrappedCommand
            let interactive = cmd == "ghd-modi"
            args <- getArgs
            let cp = (bashProc [ "nix-shell"
                               , if interactive then "--command" else "--run"
                               , escapeMany (cmd:args)])
                     { cwd = Just (Path.toFilePath path)
                     , delegate_ctlc = interactive }
            execAndExit cp
        noWrap = do
            cmd <- getWrappedCommand
            let interactive = cmd == "ghd-modi"
            args <- getArgs
            let cp = (bashProc (cmd:args))
                     { cwd = Just (Path.toFilePath path)
                     , delegate_ctlc = interactive }
            execAndExit cp
        fail = do
            hPutStrLn stderr "Haskell project root not found."
            exitWith (ExitFailure 1)

bashProc :: [String] -> CreateProcess
bashProc args = proc "bash" ["-c", ". ~/.bashrc; " ++ escapeMany args]

execAndExit :: CreateProcess -> IO ()
execAndExit p = do
    (_, _, _, h) <- createProcess p
    exitCode <- waitForProcess h
    exitWith exitCode

getWrappedCommand :: IO String
getWrappedCommand = getEnv "NIX_SHELL_WRAPPER_COMMAND"

getPath :: IO (Path Abs Dir)
getPath = parseAbsDir =<< getCurrentDirectory

parentMaybe :: Path Abs Dir -> Maybe (Path Abs Dir)
parentMaybe x = if parent x == x then Nothing else Just $ parent x
