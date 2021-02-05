unit COMUtils;

interface

function  ReadString(ComPort: integer): AnsiString;
function  ReadStringLength(ComPort, Len: integer): AnsiString;
function  ReadStringLength2(ComPort, Len: integer): AnsiString;
procedure SendString(ComPort: integer; Command: AnsiString);

implementation

uses
  WinProcs, WinTypes, Forms, SysUtils;

function ReadStringLength2(ComPort, Len: integer): AnsiString;
// Read Byte
var i, StartTime: integer;
    BytesRead: DWORD;
    InBytes: array[1..100] of byte;
begin
  StartTime := GetTickCount;
  repeat
    ReadFile(ComPort, InBytes, Len, BytesRead, nil);
    Application.ProcessMessages;
  until (BytesRead = Len) or ((GetTickCount - StartTime) > 1000);
end;

function ReadByte(ComPort: integer; var ByteRead: byte): boolean;
// Read Byte
var i, StartTime: integer;
    BytesRead: DWORD;
    InBytes: array[1..1] of byte;
begin
  StartTime := GetTickCount;
  repeat
    InBytes[1] := 0;
    ReadFile(ComPort, InBytes, 1, BytesRead, nil);
    if BytesRead > 0 then
      ByteRead := InBytes[1];
    Application.ProcessMessages;
  until (BytesRead > 0) or ((GetTickCount - StartTime) > 1000);
  Result := BytesRead > 0;
end;

function ReadString(ComPort: integer): AnsiString;
var InByte: byte;
begin
  Result := '';
  repeat
    if not ReadByte(ComPort, InByte) then begin
      Result := '';
      exit;
    end;
    if InByte <> 0 then
      Result := Result + AnsiChar(InByte);
  until (InByte = 10);
end;

function ReadStringLength(ComPort, Len: integer): AnsiString;
var InByte, n: byte;
begin
  Result := '';
  n := 0;
  repeat
    if not ReadByte(ComPort, InByte) then begin
      Result := '';
      exit;
    end;
    if InByte <> 0 then begin
      Result := Result + AnsiChar(InByte);
      inc(n);
    end;
  until (n = Len);
end;

procedure SendString(ComPort: integer; Command: AnsiString);
var BytesWritten: DWORD;
    i: integer;
    Buffer: array[1..1000] of byte;
    F: TextFile;
begin
  for i:=1 to Length(Command) do
    Buffer[i] := ord(Command[i]);
  WriteFile(ComPort, Buffer, Length(Command), BytesWritten, nil);
end;



end.
