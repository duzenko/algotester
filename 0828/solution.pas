program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, fgl;

procedure Solve;
var
   a, i, n, t: Integer;
begin
   t := 0;
	ReadLn(n);
   for i := n downto 1 do begin
      Read(a);
      t += a*i;
   end;
   WriteLn(t);
end;

begin
   if ParamStr(1) = 'd' then begin
      AssignFile(Input, 'stdin.txt');
      Reset(Input);
   end;
   Solve;
end.
