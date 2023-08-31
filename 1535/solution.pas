program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   k: Integer;
   x, r: Double;
begin
	readln(x, k, r);
   WriteLn(2*Pi*r*k*x);
end;

begin
   Solve;
end.
