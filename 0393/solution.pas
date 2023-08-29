program solution;

var
   n, i: Integer;
   r: Int64;

begin
   ReadLn(n);
   r := 1;
   for i := 2 to n do
      r += i*i;
   WriteLn(r);
end.
