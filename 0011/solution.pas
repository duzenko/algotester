program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   a, n, i: Integer;
   total: Int64;
begin
	readln(n);
   total := 0;
   for i := 1 to n do begin
      Read(a);
      total += a;
   end;
   WriteLn(total-n);
end;

begin
   Solve;
end.
