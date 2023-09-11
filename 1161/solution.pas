program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, Classes, fgl;

type
   TSector = class;

   { TPoint }

   TPoint = class
      x, y, z: Single;
      Sectors: TFPGList<TSector>;
      constructor Create;
   end;

   { TSector }

   TSector = class(TFPGList<TSector>)
      Visited: Boolean;
      constructor Create;
   end;

var
   Sectors: TFPGList<TSector>;

function VisitSector(const last: TArray<TSector>): TArray<TSector>;
var
   l, n: Integer;
   c: Integer;
begin
   c := 0;
   SetLength(Result, 3*Length(last));
   for l := 0 to High(last) do
      for n  := 0 to last[l].Count-1 do
         if not last[l][n].Visited then begin
            last[l][n].Visited := True;
            Result[c] := last[l][n];
            Inc(c);
         end;
   SetLength(Result, c);
end;

procedure Solve;
var
   a, b, i, j, l, n: Integer;
   s, s1, s2: TSector;
   p1, p2: TPoint;
   Visited: TArray<TSector>;
   Data: array of String;
   Index: TStringList;
   st: String;
   x, y, z: Extended;
   Points: array[0..2] of TPoint;
begin
	ReadLn(n);
	ReadLn(a, b);
   Index := TStringList.Create;
   Index.Capacity := 3*n;
   Index.CaseSensitive := true;
   SetLength(Data, 3*n);
   for i := 0 to n-1 do begin
      for j := 0 to 2 do begin
         ReadLn(st);
         Data[Index.Count] := st;
         Index.Add(st);
      end;
   end;
   Index.Sorted := True;
   for i := 0 to n-1 do begin;
      s := TSector.Create;
      Sectors.Add(s);
      for j := 0 to 2 do begin
         l := Index.IndexOf(Data[i*3+j]);
         if Index.Objects[l] = Nil then begin
            p1 := TPoint.Create;
            Index.Objects[l] := p1;
            st := Index[l];
            SScanf(st, '%f %f %f', [@x, @y, @z]);
            p1.x := x;
            p1.y := y;
            p1.z := z;
         end;
         p1 := TPoint(Index.Objects[l]);
         p1.Sectors.Add(s);
         Points[j] := p1;
      end;
      for p1 in Points do begin
         for p2 in Points do begin
            if p1 <> p2 then
               for s1 in p1.Sectors do
                  for s2 in p2.Sectors do
                     if (s1 = s2) and (s1 <> s) then begin
                        s1.Add(s);
                        s.Add(s1);
                     end;
         end;
      end;
   end;
   l := 0;
   SetLength(Visited, 1);
   Visited[0] := Sectors[a-1];
   repeat
      for s in Visited do
         if s = Sectors[b-1] then begin
            WriteLn(l);
            Exit;
         end;
      Visited := VisitSector(Visited);
      Inc(l);
   until Length(Visited) = 0;
   WriteLn(-1);
end;

constructor TSector.Create;
begin
   inherited Create;
   Capacity := 4;
end;

{ TPoint }

constructor TPoint.Create;
begin
   Sectors := TFPGList<TSector>.Create;
end;

begin
   Sectors := TFPGList<TSector>.Create;
   Solve;
end.
