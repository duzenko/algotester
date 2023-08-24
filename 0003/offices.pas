program offices;
{$mode objfpc}

uses SysUtils, Math, Classes;

function CompareCompany(Item1, Item2: Pointer): Integer;
begin
  	Result := NativeUInt(Item1) and $3fff - NativeUInt(Item2) and $3fff;
end;

var
   i, x: Integer;
   Companies: TList;
begin
	Companies := TList.Create;
	readln(x);
   Companies.Count := x;
   for i := 0 to Companies.Count-1 do begin
      read(x);
      Companies[i] := Pointer(i shl 14 + x);
   end;
   Companies.Sort(@CompareCompany);
   for i := 0 to Companies.Count-1 do begin
      x := NativeUInt(Companies[i]) shr 14 + 1;
   	Write(x, ' ');
   end;
end.

