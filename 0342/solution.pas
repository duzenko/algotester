program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, fgl;

procedure Solve;
var
   a, b, c, r: Integer;
   s: Double;
begin
	ReadLn(a, b, c, r);
   if r >= a*b*c/Sqrt((a+b+c)*(a+b-c)*(a-b+c)*(-a+b+c)) then
      Write('+')
   else
      Write('-');
   s := (a+b+c)/2;
   if r <= Sqrt((s-a)*(s-b)*(s-c)/s) then
      Write('+')
   else
      Write('-');
end;

begin
   if ParamStr(1) = 'd' then begin
      AssignFile(Input, 'stdin.txt');
      Reset(Input);
   end;
   Solve;
end.
