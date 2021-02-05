Library WFComPortManager;

{$R *.res}

uses
  Forms,
  Dialogs,
  Controls,
  WinProcs,
  WinTypes,
  SysUtils;

var  Opened: array[1..255] of integer;
     hCom: array[1..255] of THandle;
     i: integer;

function Connect(ComPort, Baudrate: integer): boolean; export; stdcall;
var DCB: TDCB;
    CommTimeOuts: TCommTimeOuts;
begin
  if Opened[ComPort] = 0 then begin
    if ComPort < 10 then
      hCom[ComPort] := CreateFile(PChar('COM' + IntToStr(ComPort)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0)
    else
      hCom[ComPort] := CreateFile(PChar('\\.\COM' + IntToStr(ComPort)),GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,0,0);
    if hCom[ComPort] <> INVALID_HANDLE_VALUE then begin
      DCB.DCBlength := SizeOf(DCB);
      GetCommState(hCom[ComPort], DCB);
      DCB.BaudRate := Baudrate;
      DCB.ByteSize := 8;
      DCB.Parity := 0;
      DCB.StopBits := ONESTOPBIT;
      DCB.Flags := 1;
      SetCommState(hCom[ComPort], DCB);
      GetCommTimeOuts(hCom[ComPort], CommTimeOuts);
      CommTimeOuts.ReadTotalTimeoutConstant := 10;
      SetCommTimeOuts(hCom[ComPort], CommTimeOuts);
      sleep(100);
      Result := true;
    end else begin
      hCom[ComPort] := 0;
      Result := false;
    end;
  end else
    Result := true;
  if Result then
    inc(Opened[ComPort]);
end;

procedure Disconnect(ComPort: integer); export; stdcall;
begin
  dec(Opened[ComPort]);
  if Opened[ComPort] = 0 then begin
    CloseHandle(hCom[ComPort]);
    hCom[ComPort] := 0;
  end;
end;

function GetComHandle(ComPort: integer): THandle; export; stdcall;
begin
  Result := hCom[ComPort];
end;

{Exportieren der notwendigen Funktionen und Prozeduren}
exports
  Connect, Disconnect, GetComHandle;

begin
  {Initialisierung der DLL}
  for i:=1 to 255 do begin
    Opened[i] := 0;
    hCom[i] := 0;
  end;
end.
