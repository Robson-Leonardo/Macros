﻿; Generated by AutoGUI 2.5.8
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui +AlwaysOnTop
Gui Add, Text, x9 y13 w120 h23 +0x200, Contas:
Gui Add, Radio, hWndradConta vConta x10 y46 w50 h23 +Checked, Conta1
Gui Add, Radio, hWndradConta x64 y46 w50 h23, Conta2
Gui Add, Radio, hWndradConta x117 y47 w50 h23, Conta3

Gui Show, x1603 y72 w249 h418, Window
Return

GuiEscape:
GuiClose:
    ExitApp
