program paint;
{$mode objfpc}

uses SysUtils, Math, Classes;

function greatestCommonDivisor(a, b: Int64): Int64;
var
  temp: Int64;
begin
  while b <> 0 do
  begin
    temp := b;
    b := a mod b;
    a := temp
  end;
  result := a
end;

function leastCommonMultiple(a, b: Int64): Int64;
begin
  result := b * (a div greatestCommonDivisor(a, b));
end;

procedure Solve;
var
   b, y: Integer;
   n, lcm, changes, changesY, changesB, changesLcm: Int64;
begin
	readln(n, b, y);
   lcm := leastCommonMultiple(b, y);
   changesY := (n-1) div y;
   changesB := (n-1) div b;
   changes := changesY + changesB;
   changesLcm := n div lcm;
   changes -= changesLcm;
   WriteLn(changes);
end;

begin
   Solve;
end.
