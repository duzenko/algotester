program apb;

var
   a, b, c: Int64;

begin
   ReadLn(a, b, c);
   if a + b > c then
      WriteLn('YES')
   else
      WriteLn('NO');
end.
