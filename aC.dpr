library aC;

{
    author: yll kryeziu
    date: 05/02/2021
    name: aC
}

{$R *.res}

uses
  WinProcs,
  WinTypes,
  SysUtils,
  Controls,
  Forms,
  Math,
  Dialogs,
  aCDlg in 'aCDlg.pas' {aCForm};

type
  PUserData = ^TUserData;
  TUserData = record
    ComPort, Baudrate, Mode: integer;
  end;

  PParameterStruct=^TParameterStruct;
  TParameterStruct=packed record
    NuE : Byte;                           {Anzahl reeller Zahlenwerte}
    NuI : Byte;                           {Anzahl ganzer Zahlenwerte}
    NuB : Byte;                           {Anzahl Schalter}
    E:Array[0..31] of Extended;           {reelle Zahlenwerte}
    I:Array[0..31] of Integer;            {ganze Zahlenwerte}
    B:Array[0..31] of Byte;               {Schalter}
    D:Array[0..255] of AnsiChar;          {event. Dateiname f�r weitere Daten.}
    EMin:Array[0..31] of Extended;        {untere Eingabegrenze f�r jeden reellen Zahlenwert}
    EMax:Array[0..31] of Extended;        {obere Eingabegrenze f�r jeden rellen Zahlenwert}
    IMin:Array[0..31] of Integer;         {untere Eingabegrenze f�r jeden ganzzahligen Zahlenwert}
    IMax:Array[0..31] of Integer;         {obere Eingabegrenze f�r jeden ganzzahligen Zahlenwert}
    NaE : Array[0..31,0..40] of AnsiChar; {Namen der reellen Zahlenwerten}
    NaI : Array[0..31,0..40] of AnsiChar; {Namen der ganzen Zahlenwerten}
    NaB : Array[0..31,0..40] of AnsiChar; {Namen der Schalter}
    UserDataPtr: PUserData;               {Zeiger auf weitere Blockvariablen}
    ParentPtr: Pointer;                   {Zeiger auf User-DLL-Block}
    ParentHWnd: HWnd;                     {Handle des User-DLL-Blocks}
    ParentName: PAnsiChar;                {Name des User-DLL-Blocks}
    UserHWindow: HWnd;                    {Benutzerdef. Fensterhandle, z. B. f�r Ausgabefenster}
    DataFile: text;                       {Textdatei f�r universelle Zwecke}
  end;

  PDialogEnableStruct=^TDialogEnableStruct;
  TDialogEnablestruct=packed record
    AllowE: Longint;                      { Soll die Eingabe eines Wertes   }
    AllowI: Longint;                      { un-/zul�ssig sein so ist das Bit}
    AllowB: Longint;                      { des Allow?-Feldes 0 bzw. 1}
    AllowD: Byte;
  end;

  PNumberOfInputsOutputs=^TNumberOfInputsOutputs;
  TNumberOfInputsOutputs=packed record
    Inputs :Byte;                         {Anzahl Eing�nge}
    Outputs:Byte;                         {Anzahl Ausg�nge}
    NameI : Array[0..49,0..40] of AnsiChar;
    NameO : Array[0..49,0..40] of AnsiChar;
  end;

  PInputArray = ^TInputArray;
  TInputArray = packed array[1..30] of extended;
  POutputArray = ^TOutputArray;
  TOutputArray = packed array[1..30] of extended;


procedure GetParameterStruct(D:PParameterStruct);export stdcall;
begin
  //Anzahl der Parameter
  D^.NuE := 0;
  D^.NuI := 0;
  D^.NuB := 0;
end;

procedure GetDialogEnableStruct(D:PDialogEnableStruct;D2:PParameterStruct);export stdcall;
begin
end;

procedure GetNumberOfInputsOutputs(D:PNumberOfInputsOutputs);export stdcall;
begin
  D^.Inputs := 3;
  D^.Outputs := 0;
  D^.NameI[0] := 'Kanal 1';
  D^.NameI[1] := 'Kanal 2';
  D^.NameI[2] := 'Kanal 3';
end;

Procedure CallParameterDialogDLL(D1: PParameterStruct; D2: PNumberOfInputsOutputs); export stdcall;
var i: integer;
    DialogForm: TaCForm;
    Dummy: extended;
    s: array[0..1000] of AnsiChar;
begin
  DialogForm := TaCForm.Create(Application);
  with  DialogForm do begin
    comUpDown.Position := D1^.UserDataPtr.ComPort;
    baudEdit.Text := inttostr(D1^.UserDataPtr.Baudrate);
    modeEdit.Text := inttostr(D1^.UserDataPtr.Mode);
    if ShowModal = mrOK then begin
      D1^.UserDataPtr.ComPort := comUpDown.Position;
      D1^.UserDataPtr.Baudrate := strtoint(baudEdit.Text);
      D1^.UserDataPtr.Mode := strtoint(modeEdit.Text);
    end;
    Free;
  end;
end;

function CanSimulateDLL(D:PParameterStruct):Integer; export stdcall;
begin
    Result := 1;
end;

procedure SimulateDLL(T:Extended;D1:PParameterStruct;Inputs:PInputArray;Outputs:POutputArray);export stdcall;
var i: integer;
    s: string;
begin
  // Analog Outputs
end;

procedure InitSimulationDLL(D:PParameterStruct;Inputs:PInputArray;Outputs:POutputArray);export stdcall;
var i: integer;
begin

  SimulateDLL(0, D, Inputs, Outputs);
end;

procedure EndSimulationDLL2(D: PParameterStruct);export stdcall;
begin

end;

procedure InitUserDLL(D: PParameterStruct); export stdcall;
begin
  Application.Handle := D^.ParentHWnd;
  D^.UserDataPtr := new(PUserData);
  D^.UserDataPtr.ComPort := 1;
  D^.UserDataPtr.Baudrate := 9600;
  D^.UserDataPtr.Mode := 1;
end;

procedure DisposeUserDLL(D: PParameterStruct); export stdcall;
begin
  Application.Handle := 0;
  dispose(D^.UserDataPtr);
end;

function GetDLLName: PAnsiChar; export stdcall;
begin
  GetDLLName := 'ESP32 IN/Out';
end;

Procedure WriteToFile(AFileHandle:Word; D: PParameterStruct); export stdcall;
var i: integer;
    s: array[0..1000] of AnsiChar;
begin
  with D^.UserDataPtr^ do begin
    StrPCopy(s, IntToStr(ComPort) + #13#10); _lWrite(AFileHandle, s, StrLen(s));
    StrPCopy(s, IntToStr(Baudrate) + #13#10); _lWrite(AFileHandle, s, StrLen(s));
  end;
end;

Procedure ReadFromFile(AFileHandle:Word; D: PParameterStruct); export stdcall;
var i, Code: integer;
    s: array[0..1000] of AnsiChar;
procedure ReadOneLine(FHandle:Word; Aps :PAnsiChar);
var i  : Integer;
begin
  i:=0;
  _lRead(FHandle,@Aps[i],1);
  repeat
    inc(i);
    _lRead(FHandle,@Aps[i],1);
  until (Aps[i-1]=#13) and (Aps[i]=#10);
  Aps[i-1]:=#0;
end;
begin
  ReadOneLine(AFileHandle, s); D^.UserDataPtr.ComPort := StrToInt(StrPas(s));
  ReadOneLine(AFileHandle, s); D^.UserDataPtr.Baudrate := StrToInt(StrPas(s));
end;

function NumberOfLinesInSystemFile: integer; export stdcall;
begin
end;

procedure IsUserDLL32; export stdcall;
begin
//
end;

procedure IsDemoDLL; export stdcall;
begin
//
end;

{Exportieren der notwendigen Funktionen und Prozeduren }
exports
  WriteToFile,
  ReadFromFile,
  NumberOfLinesInSystemFile,
  GetParameterStruct,
  GetDialogEnableStruct,
  GetNumberOfInputsOutputs,
  CanSimulateDLL,
  InitSimulationDLL,
  SimulateDLL,
  InitUserDLL,
  DisposeUserDLL,
  EndSimulationDLL2,
  GetDLLName,
  CallParameterDialogDLL,
  IsUserDLL32,
  IsDemoDLL;


begin
  {Weitere Initialisierung der DLL}
end.
