program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   a, a2, b, b2, g, h, r, s: Double;
begin
	readln(r, h);
   g := Sqrt(Sqr(r+h)-Sqr(r));
   a := ArcTan2(g, r);
   a2 := a/2;
   b2 := Sin(a2)*r;
   b := 2*b2;
   s := Pi*Sqr(b);
   WriteLn(s);
end;

begin
   Solve;
end.
