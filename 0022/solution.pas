program solution;
{$Mode delphi}

function greatestCommonDivisor(a, b: Int64): Int64;
var
  temp: Int64;
begin
  while b <> 0 do
  begin
    temp := b;
    b := a mod b;
    a := temp
  end;
  result := a
end;

var
   n, i, gcd, a: Integer;
   total: Int64;

begin
   ReadLn(n);
   Read(a);
   gcd := a;
   total := a;
   for i := 2 to n do begin
      Read(a);
      gcd := greatestCommonDivisor(gcd, a);
      total += a;
   end;
   WriteLn(total div gcd);
end.
