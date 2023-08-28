program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   i, j: Integer;
   n, prev, next: Int64;
   s, sPrev, sNext: String;
begin
	readln(n);
   s := IntToStr(n);
   sPrev := s;
   sNext := s;
   for i := 1 to Length(s) do begin;
      if Odd(StrToInt(s[i])) then Continue;
      sPrev := IntToStr(StrToInt64(Copy(s, 1, i)) - 1) + DupeString('9', Length(s)-i);
      for j := 1 to i-1 do
         if not Odd(StrToInt(sPrev[j])) then begin
            sPrev := '';
            Break;
         end;
      sNext[i] := Succ(s[i]);
      for j := i + 1 to Length(sNext) do
         sNext[j] := '1';
      Break;
   end;
   prev := StrToInt64Def(sPrev, 0);
   next := StrToInt64(sNext);
   n := Min(n-prev, next-n);
   WriteLn(n);
end;

begin
   Solve;
end.
