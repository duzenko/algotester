program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   i, x, y: Integer;
   s: String;
begin
	ReadLn(s);
	ReadLn(x, y);
   for i := 1 to Length(s) do begin
     if s[i]='R' then
        x -= 1;
     if s[i]='U' then
        y -= 1;
     if (x<=0) and (y<=0) then begin
         WriteLn('YES');
         Halt;
     end;
   end;
   WriteLn('NO');
end;

begin
   Solve;
end.
