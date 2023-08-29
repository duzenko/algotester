program solution;
{$Mode delphi}

var
   n, k, i, avg, k1, k2: Integer;
   ok: Boolean;

begin
   ReadLn(n, k);
   avg := n div k;
   k2 := n - k*avg;
   k1 := k - k2;
   ok := True;
   if avg < 1 then
      ok := False;
   if avg > 3 then
      ok := False;
   if (avg = 3) and (k2 > 0) then
      ok := False;
   if ok then begin
      for i := 1 to k1 do
         Write(avg, ' ');
      for i := 1 to k2 do
         Write(avg+1, ' ');
   end else begin
      Write('Impossible');
      Exit;
   end;
end.

