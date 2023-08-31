program solution;
{$mode delphi}

uses SysUtils, Math;

procedure Solve;
const
   pattern1: array[0..1] of Char = 'BY';
   patternSub: array[0..7] of Char = 'BBBBBBBB';
   patternAdd: array[0..7] of Byte = (1, 1, 1, 1, 1, 1, 1, 1);
   patternXor: array[0..7] of Byte = (0, 1, 0, 1, 0, 1, 0, 1);
type
   TAccum = UInt64;
   PAccum = ^TAccum;
var
   s: String;
   i, j: Integer;
   s8: PAccum;
   i8sub: TAccum Absolute patternSub;
   i8and: TAccum Absolute patternAdd;
   i8xor: TAccum Absolute patternXor;
   n: Integer;
   n8: TAccum;
const
   SIZE=SizeOf(TAccum);
begin
	readln(s);
   n := 0;
   n8 := 0;
   if 1=0 then begin
      for i := 1 to Length(s) do
         if s[i] = pattern1[i and 1] then
            Inc(n);
      WriteLn(Min(n, Length(s)-n));
      Exit;
   end;
   s8 := @s[1];
   for i := 0 to Length(s) div SIZE - 1 do begin
      Inc(n8, (s8^-i8sub) and i8and xor i8xor);
      Inc(s8);
      if i and $7f = 0 then
         for j := 1 to SIZE do begin
            n += n8 and $ff;
            n8 := n8 shr 8;
         end;
   end;
   for j := 1 to SIZE do begin
      n += n8 and $ff;
      n8 := n8 shr 8;
   end;
   for i := Length(s) div SIZE * SIZE + 1 to Length(s) do
      if s[i] = pattern1[i and 1] then
         Inc(n);
   WriteLn(Min(n, Length(s)-n));
end;

begin
   Solve;
end.

