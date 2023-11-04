program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, fgl, GQueue;

var
   k, n: Integer;
   m: array[1..1000000] of Char;

procedure Solve;
var
   i, j: Integer;
begin
   ReadLn(n);
   if n <= 4 then
   for i := 1 to n do begin
         k += 1;
         m[i] := '1';
   end
   else if n <= 8 then
   for i := 1 to n do
      if i<5 then begin
         k += 1;
         m[i] := '1';
      end else
         m[i] := '0'
   else
   if n mod 11 = 9 then
      for i := 1 to n do
         case i mod 11 of
         1, 4, 6, 7, 9:
         begin
            k += 1;
            m[i] := '1';
         end;
         else
           m[i] := '0';
         end
   else
      for i := 1 to n do
         case i mod 11 of
         1, 2, 4, 7, 10:
         begin
            k += 1;
            m[i] := '1';
         end;
         else
           m[i] := '0';
         end;
end;

var
   i: Integer;
begin
   if ParamStr(1) = 'd' then begin
      AssignFile(Input, 'stdin.txt');
      Reset(Input);
   end;
   Solve;
   WriteLn(k);
   for i := 1 to n do begin
      if m[i] = '1' then
         Write(i, ' ');
   end;
   WriteLn;
end.
