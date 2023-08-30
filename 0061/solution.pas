program solution;
{$mode Delphi}

uses SysUtils, Math, fgl, Classes;

var
   n, m: Integer;

procedure Solve;
var
   i, j: Integer;
   a: Integer;
   colMax: array of Integer;
begin
	ReadLn(n, m);
   SetLength(colMax, m);
   for i := 1 to n do begin;
      for j := 0 to m-1 do begin
         Read(a);
         colMax[j] := Max(colMax[j], a);
      end;
   end;
   j := MinValue(PInteger(colMax), m);
   WriteLn(j);
end;

begin
   Solve;
end.
