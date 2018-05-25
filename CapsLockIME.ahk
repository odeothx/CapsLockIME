; Original Code
; http://www.autohotkey.co.kr/cgi/board.php?bo_table=script&wr_id=357
;

IME_CHECK(WinTitle)
{
    WinGet,hWnd,ID,%WinTitle%
    Return Send_ImeControl(ImmGetDefaultIMEWnd(hWnd),0x005,"")
}

Send_ImeControl(DefaultIMEWnd, wParam, lParam)
{
    DetectSave := A_DetectHiddenWindows       
    DetectHiddenWindows,ON                          

     SendMessage 0x283, wParam,lParam,,ahk_id %DefaultIMEWnd%
    if (DetectSave <> A_DetectHiddenWindows)
        DetectHiddenWindows,%DetectSave%
    return ErrorLevel
}

ImmGetDefaultIMEWnd(hWnd)
{
    return DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
}

+CapsLock::
return

!CapsLock::
return

^CapsLock::
return

CapsLock::
	KeyWait, capslock
	if A_TimeSinceThisHotkey >= 250 ; Long Press
	{
		if  IME_CHECK("A") <> 0     ; Hangul(Korean) mode
		{
			SetCapsLockState, On
			Send, {vk15sc138}
		}
		else						
		SetCapsLockState, % (State:=!State) ? "On" : "Off"		
	}
	else							; Short Press
	{
		SetCapsLockState, Off
		Send, {vk15sc138}
	}
return
