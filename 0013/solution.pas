program solution;
{$mode delphi}

uses SysUtils, Math, fgl;

var
   Divisors: array of Integer;

procedure GetPrimeFactors(n: Integer);
var
   Factorization: TFPGMap<Integer, Integer>;
   di: Integer;

   procedure AddDivisor(No, Current: Integer);
   var
      i: Integer;
   begin
      if No = Factorization.Count then begin
         Divisors[di] := Current;
         Inc(di);
         Exit;
      end;
      for i := 0 to Factorization.Data[No] do begin
         AddDivisor(No+1, Current);
         Current *= Factorization.Keys[No];
      end;
   end;

var
   j, rt: Integer;
begin
   Factorization := TFPGMap<Integer, Integer>.Create;
   Factorization.Sorted := True;
   while n > 1 do begin
      rt := Floor(Sqrt(n));
      for j := 2 to rt+1 do begin
         if n mod j > 0 then Continue;
         Break;
      end;
      if j > rt then begin
         Factorization.Add(n);
         Factorization.KeyData[n] := Factorization.KeyData[n] + 1;
         Break;
      end else
      Factorization.Add(j);
      Factorization.KeyData[j] := Factorization.KeyData[j] + 1;
      n := n div j;
   end;
   SetLength(Divisors, 1);
   for j := 0 to Factorization.Count-1 do begin
      SetLength(Divisors, Length(Divisors)*(Factorization.Data[j]+1));
   end;
   di := 0;
   AddDivisor(0, 1);
   Factorization.Free;
end;

procedure Solve;
var
   a, b, ai, aidivj, aimodj, i, j, l, l2, n, c, d: Integer;
begin
	ReadLn(a, b, c, d);
	ReadLn(n);
   for i := 1 to n do begin;
     	ReadLn(ai);
      GetPrimeFactors(ai);
      l := 0;
      for j in Divisors do begin
         aidivj := ai div j;
         if (j >= a) and (j <= b) then
            if (aidivj >= c) and (aidivj <= d) then
               Inc(l);
      end;
      WriteLn(l,'/',(b-a+1)*(d-c+1));
   end;
end;

begin
   Solve;
end.
