#include <Date.au3>
#include "interface.au3"
#include <Process.au3>
#RequireAdmin

HotKeySet("{ESC}", "Terminate")

Func Terminate()
	Exit 1
EndFunc

Func ChangeDay($nDays)
	$tNew = _Date_Time_EncodeSystemTime(@MON, @MDAY+$nDays, @YEAR, @HOUR, @MIN, @SEC)
	_Date_Time_SetLocalTime($tNew)
	UpdateDateAndTime()
EndFunc

Func SaveProgramPath($Path)
	$file = FileOpen(@ScriptDir & "\AppPath.txt", 2)
	FileWrite($file, $Path)
EndFunc

Func OpenApp($Path)
	;"C:\Users\Zelp\Desktop\Melvor Idle.url"
	ShellExecute($Path)
	SaveProgramPath($Path)
EndFunc

Func GetAppNameFromPath($Path)
	$FILEPATH=$Path
	$FILENAME=""
	$PATH=""
	$TITLE=""
	$EXT_START=0
	$FILE_START=0
	For $X = StringLen($FILEPATH) To 2 Step -1
		 If StringMid($FILEPATH,$X,1) = "." And $EXT_START = 0 Then $EXT_START = $X
		 If StringMid($FILEPATH,$X,1) = "\" And $FILE_START = 0 Then $FILE_START = $X
		 If $FILE_START > 0 Then
				$FILENAME = StringTrimLeft($FILEPATH,$FILE_START)
				$TITLE = StringLeft($FILENAME, $EXT_START - $FILE_START -1)
				$PATH = StringLeft($FILEPATH,$FILE_START)
				ExitLoop
		 EndIf
	Next
	Return $TITLE & ".exe"
EndFunc

Func CloseApp($Path)
	If not ProcessClose(GetAppNameFromPath($Path)) Then		
		ConsoleWrite("ERROR: Could not find process: " & GetAppNameFromPath($Path) & @CRLF)
	EndIf
EndFunc

;ConsoleWrite(@CRLF & "RUNNNNNNNN:::   " & Run("C:\Program Files (x86)\Steam\steamapps\common\Melvor Idle\Melvor Idle.exe", ""))
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnPlusDay
			ChangeDay(1)
		Case $btnMinusDay
			ChangeDay(-1)
		Case $btnCloseApp
			$appPath = GUICtrlRead($inptProgramPath)
			CloseApp($appPath)
		Case $btnOpenApp
			$appPath = GUICtrlRead($inptProgramPath)
			OpenApp($appPath)
		Case $btnClosePlusOpen
			$appPath = GUICtrlRead($inptProgramPath)
			SaveProgramPath($appPath)
			CloseApp($appPath)
			ChangeDay(1)
			OpenApp($appPath)
	EndSwitch
WEnd
