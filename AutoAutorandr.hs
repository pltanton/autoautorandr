import Data.Text.Encoding
import Data.Text

import Control.Monad

import System.Posix.IO.Select
import System.Posix.IO.Select.Types

import System.Process
import System.Directory

import Data.Maybe

import System.UDev.Monitor
import System.UDev.Device
import System.UDev.Context

isMonitorEvent dev =
    let 
        devNode = getDevnode dev
    in
        case devNode of
            Nothing  -> False
            Just val -> unpack (decodeUtf8 val) == "/dev/dri/card0"

startMonitorHotplug = do
    path <- findExecutable "autorandr"
    when (isNothing path) (error "Can't find 'autorandr' executable!")

    withUDev $ \ udev -> do
        monitor <- newFromNetlink udev KernelId
        enableReceiving monitor
        fd <- getFd monitor
        forever $ do
            res <- select' [fd] [] [] Never
            case res of
                Just ([_], [], []) -> do
                    dev <- receiveDevice monitor
                    when (isMonitorEvent dev) (callCommand autorandCommand)
                Nothing -> return ()
  where
    autorandCommand = "autorandr --change"

main = do
    startMonitorHotplug
