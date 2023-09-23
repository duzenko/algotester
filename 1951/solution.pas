program solution;
{$mode delphi}

uses SysUtils, Math, fgl, gvector;

procedure Solve;
var
   i, c: Integer;
   s, s1: String;
begin
	ReadLn(s);
   if not (StrToIntDef(Copy(s, 1, 2), 0) in [51..55]) then begin
      WriteLn('BAD');
      Exit;
   end;
   for i := 1 to Length(s) do begin
      if Odd(i) then
         s1 := s1 + IntToStr(2*StrToInt(s[i]))
      else
         s1 := s1 + IntToStr(StrToInt(s[i]));
   end;
   c := 0;
   for i := 1 to Length(s1) do
      c := c + StrToInt(s1[i]);
   if c mod 10 = 0 then
      WriteLn('VALID')
   else
      WriteLn('BAD');
end;

begin
   Solve;
end.
