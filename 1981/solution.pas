program solution;
{$mode delphi}

uses SysUtils, Math, fgl, gvector;

procedure Solve;
var
   k, n: Integer;
begin
	ReadLn(n, k);
   if n+k>26 then
      WriteLn('No')
   else
      WriteLn('Yes');
end;

begin
   Solve;
end.
