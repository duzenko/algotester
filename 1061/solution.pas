program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   c, f, i, n, t: Integer;
begin
	ReadLn(n);
   f := 0;
   t := 0;
   for i := 1 to n do begin;
      ReadLn(c);
      case c of
      1: Inc(t);
      2:
         if t > 0 then
            Dec(t)
         else
            Inc(f);
      else
         raise Exception.Create('');
      end;
   end;
   WriteLn(f);
end;

begin
   Solve;
end.
