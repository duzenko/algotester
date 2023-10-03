program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, fgl;

var
   c: array[1..77] of Integer;

procedure Solve;
var
   a, i, j, m, n, t: Integer;
begin
	ReadLn(n, m);
   for i := 1 to n do begin
      for j := 1 to m do begin
         Read(a);
         c[j] := Max(c[j], a);
      end;
   end;
   t := 0;
   for j := 1 to m do begin
      t += c[j];
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
