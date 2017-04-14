import Graphics.UI.GLUT
import Data.IORef
import qualified Types
import Gamestate
import Callback
import Physics


main :: IO ()
main = do
    (_progName, _args) <- getArgsAndInitialize
    initialDisplayMode $= [DoubleBuffered]
    _window <- createWindow "Artillery Game"
    windowSize $= Size 1280 720
    let gameX = initializeGamestate
    putStr "Tile Matrix Dimensions\n\tRows : "
    print $ length (Types.tileMatrix gameX)
    putStr "\tColumns : "
    print $ length ((Types.tileMatrix gameX) !! 0)
    gamestate <- newIORef gameX
    bulletRotationAngle  <- newIORef 0.0
    reshapeCallback $= Just reshape
    displayCallback $= display gamestate bulletRotationAngle
    keyboardMouseCallback $= Just (keyboardMouse gamestate bulletRotationAngle)
    idleCallback $= Just (idle gamestate bulletRotationAngle)
    mainLoop
