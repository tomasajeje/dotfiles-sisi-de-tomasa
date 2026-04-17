import XMonad
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import System.Exit (exitSuccess)

-- 1. Procesos de inicio
myStartupHook :: X ()
myStartupHook = do
    spawnOnce "sh ~/.config/polybar/launch.sh"
    spawnOnce "setxkbmap latam"
    spawnOnce "picom --config ~/.config/picom/picom.conf &"
    spawnOnce "nm-applet &"
    spawnOnce "feh --bg-fill /home/tomas/Descargas/tomis.jpg"

-- 2. Layout con Gaps (Asegúrate de que 'spacingRaw' esté bien alineado)
myLayout = spacingRaw True (Border 3 3 3 3) True (Border 3 3 3 3) True 
           $ avoidStruts 
           $ layoutHook def

-- 3. Atajos de teclado
myKeys :: [(String, X ())]
myKeys = 
    [ ("M-p", spawn "rofi -show drun")  
    , ("M-S-q", kill)                   
    , ("M-S-e", io exitSuccess)         
    ]

-- 4. Configuración Principal
main :: IO ()
main = xmonad $ ewmh $ docks $ def
    { terminal           = "st"      -- Cambiado a kitty por tu preferencia actual
    , modMask            = mod4Mask     
    , borderWidth        = 3            
    , manageHook         = manageDocks <+> manageHook def
    , layoutHook         = myLayout
    , startupHook        = myStartupHook
    , normalBorderColor  = "#282a36"    
    , focusedBorderColor = "#959595"    
    } `additionalKeysP` myKeys
