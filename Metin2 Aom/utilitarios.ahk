#SingleInstance Force
SetWorkingDir %A_ScriptDir%
#MaxThreads 1
SetKeyDelay, 25, 25

Gui +AlwaysOnTop
Gui Add, Text, x9 y13 w120 h23 +0x200, Contas:
Gui Add, Radio, hWndhRadRau vConta x10 y46 w50 h23, Rau
Gui Add, Radio, hWndhRadHati x64 y46 w50 h23, Hati

Gui Show, x159 y78 w249 h418, Window
Return

ProcuraAteAchar(X, Y, H, W, var, img, mili)
{   
    ;Inicio := A_TickCount
    ;Ativa()
    ;GeraLog("Ativa(): " A_TickCount - Inicio)
    Comeco := A_TickCount
    while ((A_TickCount - Comeco) < mili)
    {
        ImageSearch, OutX, OutY, X, Y, H, W, *%var% %a_scriptdir%\%img%.png
        if (!ErrorLevel)
        {
            AchouOutX := OutX
            AchouOutY := OutY
            return true
        }
    }
    return false
}

ProcuraAteNaoAchar(X, Y, H, W, var, img, mili)
{   
    Comeco := A_TickCount
    while ((A_TickCount - Comeco) < mili)
    {
        ImageSearch, OutX, OutY, X, Y, H, W, *%var% %a_scriptdir%\%img%.png
        if (ErrorLevel)
        {
            return true
        }
    }
    return false
}

GeraLog(msg)
{
    FormatTime, DataFormatada, D1 T0
	FileAppend, %DataFormatada% - %msg%`n, %a_scriptdir%\metin2.log
	if ErrorLevel
	{
		FileAppend, %DataFormatada% - %msg%`n, %a_scriptdir%\metin2.log
	}
}
return

randSleep()
{
    Random, rand, 3000, 5000
    return rand
}

