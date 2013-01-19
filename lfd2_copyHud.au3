#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <Misc.au3>
#include <ScreenCapture.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <WinAPI.au3>
#include <GDIPlus.au3>


;~ $transBackground = "c:\transparent.gif"

$screenLength = 1920

$winLeft = $screenLength
$winTop = 950


$picWidth_ally = 935
$picHeight_ally = 140
$picWidth_HP = 360
$picHeight_HP = 100
$picWidth_gun = 135
$picHeight_gun = 360


$guiLeftGun = $screenLength*2-$picWidth_gun
$guiTopGun = 320


$captureLeft_ally = 00 
$captureTop_ally = 960
$captureLeft_HP = $screenLength*3 -$picWidth_HP
$captureTop_HP = 960
$captureLeft_gun = $screenLength*3-$picWidth_gun 
$captureTop_gun = 360

Global $windowName = "Left 4 Dead"
;~ Global $windowName = "GDI"
global $picName_ally = "c:\allyHP.jpg"
global $picName_HP = "c:\myHP.jpg"
global $picName_gun = "c:\myGun.jpg"
global $g_mainGUI,$g_ally
;~ Global $outFile
HotKeySet("~","exitCode")
;~ HotKeySet("`","flyTime")


_GDIPlus_StartUp()


 _ScreenCapture_CaptureWnd($picName_ally, WinGetHandle($windowName) , $captureLeft_ally,$captureTop_ally,$captureLeft_ally+$picWidth_ally,$captureTop_ally+$picHeight_ally)
 $g_mainGUI = GUICreate("hello",$picWidth_ally+$picWidth_HP,$picHeight_ally,$winLeft,$winTop, $WS_POPUP, $WS_EX_TOPMOST+$WS_EX_LAYERED) 
 GUISetBkColor(0xABCDEF, $g_mainGUI)
 
;~  WinSetTrans($g_mainGUI,"",120)
 
 
 
;~  GUICtrlCreatePic($picName_ally,0,0,$picWidth_ally+$picWidth_HP,$picHeight_ally)
 $g_ally = GUICtrlCreatePic($picName_ally,0,0,$picWidth_ally,$picHeight_ally)
 $g_myHP = GUICtrlCreatePic($picName_HP,$picWidth_ally,0,$picWidth_HP,$picHeight_HP)
;~ $transPic = GUICtrlCreatePic($transBackground,0,0,$picWidth_ally+$picWidth_HP,$picHeight_ally)
 
;~  GUICtrlSetBkColor($transPic, 0xABCDEF)
 
 _WinAPI_SetLayeredWindowAttributes($g_mainGUI, 0xABCDEF, 255)
 GUISetState(@SW_SHOW,$g_mainGUI)

 
 $g_GUIgun = GUICreate("gun",$picWidth_gun,$picHeight_gun,$guiLeftGun,$guiTopGun, $WS_POPUP, $WS_EX_TOPMOST)  
 if $g_GUIgun == 0 Then
   MsgBox(0,"ERROR while creating $g_GUIgun",@error)
EndIf
 $g_myGun = GUICtrlCreatePic($picName_gun,0,0,$picWidth_gun,$picHeight_gun)

GUISetState(@SW_SHOW,$g_GUIgun)
 
 
  
 
 
while 1
   _ScreenCapture_CaptureWnd($picName_ally, WinGetHandle($windowName) , $captureLeft_ally,$captureTop_ally,$captureLeft_ally+$picWidth_ally,$captureTop_ally+$picHeight_ally)
   _ScreenCapture_CaptureWnd($picName_HP, WinGetHandle($windowName) , $captureLeft_HP,$captureTop_HP,$captureLeft_HP+$picWidth_HP,$captureTop_HP+$picHeight_HP)
   _ScreenCapture_CaptureWnd($picName_gun, WinGetHandle($windowName) , $captureLeft_gun,$captureTop_gun,$captureLeft_gun+$picWidth_gun,$captureTop_gun+$picHeight_gun)
    GUICtrlSetImage($g_ally, $picName_ally)
    GUICtrlSetImage($g_myHP, $picName_HP)
    GUICtrlSetImage($g_myGun, $picName_gun)
   sleep(10)
   
WEnd
	
	
Func createImage(ByRef $hImage,ByRef $hGraphic,ByRef $image,$left,$top)
   
   $hImage   = _GDIPlus_ImageLoadFromFile($image)

; Draw PNG image
   $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
   _GDIPlus_GraphicsDrawImage($hGraphic, $hImage, $left, $top)
   
EndFunc

Func updateImage(ByRef $hImage,ByRef $hGraphic,ByRef $image,$left,$top)
   
   ;cleanup past
   _GDIPlus_GraphicsDispose($hGraphic)
   _GDIPlus_ImageDispose($hImage)
   
   createImage($hImage,$hGraphic,$image)
   
   
EndFunc

   
	
func exitCode()
   GUIDelete()

   Exit
   
EndFunc
