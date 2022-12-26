#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Users\Zelp\Documents\git\ZelpTools\scripts\OSTimeChanger\forms\MainInterface.kxf
$Form2 = GUICreate("OS Time Manipulator", 338, 107, 966, 391, -1, BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$lblOSDateNTimeCaption = GUICtrlCreateLabel("Data/Hora do sistema:", 8, 8, 111, 17)
$lblOSDateNTime = GUICtrlCreateLabel("", 8, 24, 108, 20)
$btnPlusDay = GUICtrlCreateButton("+ Dia", 72, 48, 43, 25)
$btnMinusDay = GUICtrlCreateButton("- Dia", 8, 48, 43, 25)
$inptProgramPath = GUICtrlCreateInput("Caminho do programa com extensão", 144, 24, 185, 21)
$btnClosePlusOpen = GUICtrlCreateButton("Fecha, adiciona um dia e abre", 144, 76, 187, 25)
$btnOpenApp = GUICtrlCreateButton("Abre", 144, 48, 75, 25)
$btnCloseApp = GUICtrlCreateButton("Fecha", 256, 48, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func LoadLastProgramPath()
	$file = FileOpen(@ScriptDir & "\AppPath.txt", 0)
	$fileContent = FileRead($file)
	GUICtrlSetData($inptProgramPath, $fileContent)
EndFunc

Func UpdateDateAndTime()
	$tCur = _Date_Time_GetLocalTime()
	GUICtrlSetData($lblOSDateNTime, _Date_Time_SystemTimeToDateTimeStr($tCur))
EndFunc

LoadLastProgramPath()
UpdateDateAndTime()