program solution;
{$mode delphi}

procedure Solve;
var
   i, j, c, n: LongWord;
   a, b: array[1..3] of Int64;
begin
	ReadLn(n);
   a[1] := 1;
   a[2] := 0;
   a[3] := 0;
   for i := 2 to n+1 do begin
      b[1] := a[1]+2*(a[2]+a[3]);
      b[2] := a[1]+a[2];
      b[3] := a[1];
      a := b;
      if a[1] > 1 shl 60 then
         for j := 1 to 3 do
            a[j] := a[j] mod 1000000007;
   end;
   c := a[1] mod 1000000007;
   WriteLn(c);
end;

begin
   Solve;
end.

