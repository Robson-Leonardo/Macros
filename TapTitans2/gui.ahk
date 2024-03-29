﻿; Generated by AutoGUI 2.5.8
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Gui -MinimizeBox -MaximizeBox +AlwaysOnTop
Gui Add, Text, hWndhTxtStage vTxtStage x40 y8 w78 h23 +0x200, Stage
Gui Add, Text, vtxtTFtemp x8 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtFSTempo x56 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtWCTempo x104 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtHMTempo x152 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtDSTempo x200 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtSCTempo x248 y120 w42 h23 +0x200, nao
Gui Add, Text, vtxtTempoStage x160 y8 w42 h23 +0x200, 0
Gui Add, Progress, vPrgStage x176 y40 w120 h20 -Smooth, 10
Gui Add, Edit, vEdtTarget x48 y40 w120 h21
Gui Add, Text, x8 y40 w36 h23 +0x200, Target
Gui Add, Progress, vPrgMana x8 y96 w120 h20 -Smooth, 100
Gui Add, CheckBox, vChkPrestige x8 y168 w63 h23 +Checked, Prestige
Gui Add, CheckBox, vChkFairy x8 y192 w63 h23 +Checked, Fairy
Gui Add, Button, vPrestige gPrestige x104 y277 w80 h23, Prestige
Gui Add, Button, vBtnIniciar gIniciar x8 y277 w80 h23, Iniciar
Gui Add, Button, vBtnCalibrar gCalibrar x200 y277 w80 h23, Calibrar
Gui Add, Radio, hWndhRadBos vRadBos x8 y216 w63 h23 +Checked, BoS
Gui Add, Radio, hWndhRadAll vRadAll x80 y216 w63 h23, All
Gui Add, Text, x8 y8 w30 h23 +0x200, Atual:
Gui Add, Text, x120 y8 w39 h23 +0x200, Tempo:
Gui Add, Radio, hWndhRadPush vRadPush x8 y64 w49 h23, Push
Gui Add, Radio, hWndhRadFarm vRadFarm x64 y64 w49 h23 +Checked, Farm
Gui Add, Text, vtxtMana x128 y96 w57 h19 +0x200, 0/0

Gui Show, x1148 y397 w303 h420, TapMacro
Return

Prestige:
Return

Iniciar:
Return

Calibrar:
Return

GuiSize:
    If (A_EventInfo == 1) {
        Return
    }

Return

GuiClose:
    ExitApp
