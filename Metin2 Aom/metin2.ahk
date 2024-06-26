#SingleInstance Force
#MaxThreads 1
#Include, ocr.ahk
#Include %A_LineFile%\..\JSON.ahk

DefaultDirs = a_scriptdir

CoordMode, Pixel, Window
CoordMode, Mouse, Window

global listaPeixes := "p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25"
global Conta
global Conta1,Conta2,Conta3
global p := 1
global AchouOutX, AchouOutY
global tickVerVara := A_TickCount - 600000

;global Conta1 := "XXXXXXX,XXXXXXXXX"
;global Conta2 := "rlino001,08567315L123"
;global Conta3 := "bufflino,08567315L123"

Gui +AlwaysOnTop
Gui Add, Text, x9 y13 w120 h23 +0x200, Contas:
Gui Add, Radio, hWndradConta vConta x10 y46 w50 h23 +Checked, Conta1
Gui Add, Radio, hWndradConta x64 y46 w50 h23, Conta2
Gui Add, Radio, hWndradConta x117 y47 w50 h23, Conta3

Gui Show, x1603 y72 w249 h418, Window
SetKeyDelay, 25, 25

; Função para ler o arquivo JSON
ReadJSON(MEUDEUS) 
{
    FileRead, merda, %MEUDEUS%
    return %merda%
}

; Lê o arquivo JSON
putaquepariu := ReadJSON("contas.json")
quelixodelinguagem := JSON.Load(putaquepariu)
parsed := JSON.Load(json_str)


; Analisa o JSON e cria as variáveis globais
for key, value in quelixodelinguagem 
    %key% := value.ID . "," . value.Senha

F8::Pause

F9::
loop,
{
	TaLogado()
	AbreInventario()
	Manual()
	JogaTintaFora()
	UpaVaraPesca()
	;UsaTodosOsPeixes()
	ProcuraIsca()
	EsperaFisgar()
	Sleep, 1000
}
return

TaLogado()
{
	ImageSearch, OutX, OutY, 673, 223, 904, 395, *20 %a_scriptdir%\login.png
	if !ErrorLevel
	{
		GeraLog("Estava deslogado")
		SetKeyDelay, -1, -1
		Gui, Submit, NoHide
		GeraLog(Conta)
		ClicaRandom(876, 566, 5)
		Loop, parse, Conta%Conta%, `,
		{
			Loop, 60
				Send, {BackSpace}
			
			Sleep, 60
			Send, %A_LoopField%
			Sleep, 60
			Send, {Enter}
		}
		ProcuraAteAcharSemLogar(52, 263, 148, 325, 40, "flag", MinToMili(3))
		Send, {Enter}
		SetKeyDelay, 25, 25
	}
}


EsperaFisgar()
{
	Tecla("space")
	ProcuraAteAchar(776, 357, 830, 375, 20, "pescaria", 1000)
	ImageSearch, OutX, OutY, 776, 357, 830, 375, *20 %a_scriptdir%\pescaria.png
	while (!ErrorLevel)
	{
		ImageSearch, OutX, OutY, 775, 416, 838, 449, *20 %a_scriptdir%\vermelho.png
		if !ErrorLevel
		{
            Sleep, 30
			;ImageSearch, OutX, OutY, 744, 415, 879, 556, *20 %a_scriptdir%\peixe.png
			PixelSearch, OutX, OutY, 744, 422, 885, 553, 0x795C3B, 5, fast
            if !ErrorLevel
                ClicaRandom(OutX, OutY, 3)
		}
		ImageSearch, OutX, OutY, 776, 357, 830, 375, *20 %a_scriptdir%\pescaria.png
	}
}

ProcuraIsca()
{
	ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 %a_scriptdir%\isca.png
	if !ErrorLevel
	{
		ClicaRandomDIreito(OutX, OutY, 3)
		return
	}
	ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 %a_scriptdir%\minhoca.png
	if !ErrorLevel
	{
		ClicaRandomDIreito(OutX+10, OutY+5, 3)
		return
	}
	CompraIsca()
	; Futura troca de aba
}

F11::
TaLogado()
return



F5::
WinActivate AoM2
WinGetPos, X, Y, W, H, AoM2
loop
{
	if (ProcuraAteAchar(0, 0, W-300, H, 60, "boss", 60000))
	{
		MouseMove, AchouOutX, AchouOutY
		GeraLog("Achou")
	}
	else
	{
		GeraLog("Não achou")
	}
}
return


CompraManual()
{
	AbrePescador()
	Sleep, 60
	ClicaRandomDIreito(1303, 93, 3)
	Sleep, 60
	FechaJanelaCompra()
}

Manual()
{
	ImageSearch, OutX, OutY, 14, 40, 295, 61, *60 %a_scriptdir%\manual.png
	if ErrorLevel
	{
		ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 %a_scriptdir%\manualpesca.png
		if !ErrorLevel
		{
			ClicaRandomDIreito(OutX, OutY, 3)
			return
		}
		else
		{
			CompraManual()
		}
	}
}

CompraIsca()
{
	AbrePescador()
	Sleep, 60
	ClicaRandomDIreito(1301, 120, 3)
	Sleep, 60
	FechaJanelaCompra()
}

FechaJanelaCompra()
{
	if (ProcuraAteAchar(1268, 53, 1332, 68, 20, "loja", 1000))
	{
		ClicaRandom(1374, 62, 3)
		return
	}
	else
	{
		loop, 10
		{
			Send, {ESC}
		}
		return
	}
}

AbrePescador()
{
	ImageSearch, OutX, OutY, 0, 0, A_ScreenWidth, A_ScreenHeight, *60 *TransBlack %a_scriptdir%\pescador.png
	if !ErrorLevel
	{
		ClicaRandom(OutX+20, OutY+20, 3)
		ProcuraAteAchar(699, 350, 916, 478, 20, "abrir", 2000)
		ClicaRandom(AchouOutX, AchouOutY, 3)
		if (ProcuraAteAchar(1268, 53, 1332, 68, 20, "loja", 1000))
		{
			return
		}
		else
		{
			Send, {ESC}
			return
		}
	}
}

JogaTintaFora()
{
	ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 *TransBlack %a_scriptdir%\tinta.png
	if !ErrorLevel
	{
		MouseMove, OutX, OutY
		Sleep, 40
		Send {LButton down}
		MouseMove, 829, 357
		Send {LButton up}
		Sleep, 40
		ClicaRandom(765, 492, 3)
		Sleep, 40
	}
}

AbreSkill()
{
	ImageSearch, OutX, OutY, 40, 284, 279, 681, *40 %a_scriptdir%\skills.png
	if ErrorLevel
	{
		Send, v
	}
	if (!ProcuraAteAchar(40, 284, 279, 681, 40, "skills", 500))
		AbreSkill()
}

ClicaSkillPesca()
{
	ImageSearch, OutX, OutY, 40, 284, 279, 681, *40 %a_scriptdir%\skillpesca.png
	if !ErrorLevel
	{
		ClicaRandomDIreito(OutX+5, OutY+5, 3)
		MouseMove, 809, 484
	}
	while (!ProcuraAteAchar(776, 357, 830, 375, 20, "pescaria", 100))
	{
		ImageSearch, OutX, OutY, 40, 284, 279, 681, *40 %a_scriptdir%\skillpesca.png
		if !ErrorLevel
		{
			ClicaRandomDIreito(OutX+5, OutY+5, 3)
			MouseMove, 809, 484
		}
		if (A_index > 5)
			return
	}
}

AbreInventario()
{
	MouseMove, 809, 484
	ImageSearch, OutX, OutY, 713, 603, 907, 648, *40 %a_scriptdir%\cancelar.png
	if !ErrorLevel
	{
		ClicaRandom(OutX, OutY, 2)
	}
	ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 %a_scriptdir%\inventario.png
	if ErrorLevel
	{
		Send, i
	}
	if (!ProcuraAteAchar(1439, 521, 1602, 865, 40, "inventario", 500))
	{
		loop, 5
		{
			Send, {ESC}
		}
		AbreInventario()
	}
}

TiraItemNovo()
{
	MouseMove, 809, 484
	ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *40 %a_scriptdir%\itemnovo.png
	if !ErrorLevel
	{
		MouseMove, OutX, OutY+5
	}
}
return

UsaTodosOsPeixes()
{
    Loop, parse, listaPeixes, `,
    {
        ;GeraLog("Procura " A_LoopField)
        ImageSearch, OutX, OutY, 1439, 521, 1602, 865, *30 %a_scriptdir%\%A_LoopField%.png
        if !ErrorLevel
        {
            GeraLog("achou " A_LoopField)
            ClicaRandomDIreito(OutX, OutY, 3)
        }
    }
}


ProcuraAteAchar(X, Y, H, W, var, img, mili)
{   
    ;Inicio := A_TickCount
    ;Ativa()
	TaLogado()
    Comeco := A_TickCount
    while ((A_TickCount - Comeco) < mili)
    {
        ImageSearch, OutX, OutY, X, Y, H, W, *%var% *TransBlack %a_scriptdir%\%img%.png
        if (!ErrorLevel)
        {
            AchouOutX := OutX
            AchouOutY := OutY
            return true
        }
    }
    return false
}
ProcuraAteAcharSemLogar(X, Y, H, W, var, img, mili)
{   
    ;Inicio := A_TickCount
    ;Ativa()
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

ProcuraPixelAteNaoAchar(X, Y, color, mili)
{   
    Comeco := A_TickCount
    while ((A_TickCount - Comeco) < mili)
    {
        if (RetornaCorPixel(X, Y) != color)
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

randSleep()
{
    Random, rand, 3000, 5000
    return rand
}


RetornaText(X, Y, W, H)
{
    hBitmap := HBitmapFromScreen(X, Y, W, H)
    pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
    DllCall("DeleteObject", "Ptr", hBitmap)
    text := StrReplace(ocr(pIRandomAccessStream), "`n","")
    return text 
}

ClicaRandom(X, Y, var)
{
    Random, rand, -var, var
    Random, rand2, -var, var
    MouseClick, left, X+rand, Y+rand2
}

ClicaRandomDireito(X, Y, var)
{
    Random, rand, -var, var
    Random, rand2, -var, var
    MouseClick, right, X+rand, Y+rand2
}


MinToMili(min)
{
    return min * 60000
}

RetornaCorPixel(X, Y)
{
    PixelGetColor, OutputVar, X, Y
    return OutputVar
}

F6::
UpaVaraPesca()
return

F7::
TesteVM()
return


UpaVaraPesca()
{
	if ((A_TickCount - tickVerVara) > MinToMili(10))
	{
		GeraLog("Verificou se precisa upar minha vara... haha")
		tickVerVara := A_TickCount
		MouseMove, 1464, 322
		if (ProcuraAteAchar(1286, 329, 1594, 690, 60, "refinar", 1000))
		{
			GeraLog("Precisava, bora upar...")
			ClicaRandomDIreito(1464, 322, 3)
			if (ProcuraAteAchar(1439, 521, 1602, 865, 60, "vara", 10000)) 
			{
				MouseMove, AchouOutX, AchouOutY
				Send {LButton down}
				Sleep, 60
				ImageSearch, OutX, OutY, 0, 0, A_ScreenWidth, A_ScreenHeight, *60 *TransBlack %a_scriptdir%\pescador.png
				if !ErrorLevel
				{
					MouseMove, OutX, OutY0-
					Sleep, 60
					Send {LButton up}
					Sleep, 60
					if (ProcuraAteAchar(697, 496, 937, 565, 60, "sim", 1000))
					{
						ClicaRandom(AchouOutX, AchouOutY, 1)
						GeraLog("Achou")
						Sleep, 1000
					}
					Send, {ESC}
					ProcuraAteAchar(1439, 521, 1602, 865, 40, "inventario", 1000)
					AbreInventario()
				}
				ProcuraAteAchar(1439, 521, 1602, 865, 60, "vara", 10000)
				ClicaRandomDIreito(AchouOutX, AchouOutY, 3)
				return
			}
		}
	}
}
