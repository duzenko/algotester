program solution;
{$mode objfpc}

uses SysUtils, Math, Classes;

procedure Solve;
var
   n, zeroes: Integer;
begin
	readln(n);
   zeroes := 0;
   while n >= 5 do begin
      n := n div 5;
      zeroes += n;
   end;
   WriteLn(zeroes);
end;

begin
   Solve;
end.
