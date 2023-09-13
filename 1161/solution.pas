program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, Classes, fgl, gset;

type
   { TSector }

   TSector = record
      NeighborCount: Integer;
      Neighbors: array[0..7] of ^TSector;
      Visited: Boolean;
   end;
   PSector = ^TSector;

   TPoint = class;
   TPointDescrip = record
      s: String;
      p: TPoint;
   end;

   { TPoint }

   TPoint = class(TFPGList<PSector>)
      constructor Create;
      class function c(const L, R: TPointDescrip): Boolean; static;
   end;

const
   MaxN = 350000;
var
   Sectors: array[0..MaxN] of TSector;
   Verbose: Boolean;

procedure VisitSector(last, next: TFPGList<PSector>);
var
   l, n: Integer;
begin
   next.Count := 0;
   for l := 0 to last.Count-1 do
      for n  := 0 to last[l].NeighborCount-1 do
         if not last[l].Neighbors[n].Visited then begin
            last[l].Neighbors[n].Visited := True;
            next.Add(last[l].Neighbors[n]);
         end;
end;

procedure Solve;
var
   Index2: TSet<TPointDescrip, TPoint>;
   a, b, i, j, l, n: Integer;
   s, s1: PSector;
   p1, p2: TPoint;
   Points: array[0..2] of TPoint;
   dt: TDateTime;
   visit1, visit2: TFPGList<PSector>;
   pd: TPointDescrip;
   node: Index2.PNode;
begin
   dt := Now;
   Index2 := TSet<TPointDescrip, TPoint>.Create;
   if not Verbose then begin
      ReadLn(n);
      ReadLn(a, b);
   end else begin
      n := MaxN;
      a := 1;
      b := n;
   end;
   if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
   for i := 0 to n-1 do begin;
      s := @Sectors[i];
      for j := 0 to 2 do begin
         if Verbose then
            pd.s := Format('%d %d %d', [(i mod 32 + j) div 2, i div 32 + (i+j) mod 2, 0])
         else
            ReadLn(pd.s);
         node := Index2.NFind(pd);
         if node = nil then begin
            p1 := TPoint.Create;
            pd.p := p1;
            Index2.Insert(pd);
         end else begin
            p1 := node.Data.p;
         end;
         p1.Add(s);
         Points[j] := p1;
      end;
      for p1 in Points do begin
         for p2 in Points do begin
            if p1 <> p2 then
               for l := 0 to p1.Count-1 do begin
                  s1 := p1[l];
                  for j := 0 to p2.Count-1 do begin
                     if (s1 = p2[j]) and (s1 <> s) then begin
                        if s1.NeighborCount = High(s1.Neighbors) then
                           raise Exception.Create('');
                        if s.NeighborCount = High(s.Neighbors) then
                           raise Exception.Create('');
                        s1.Neighbors[s1.NeighborCount] := s;
                        s1.NeighborCount += 1;
                        s.Neighbors[s.NeighborCount] := s1;
                        s.NeighborCount += 1;
                     end;
                  end;
               end;
         end;
      end;
   end;
   if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
   l := 0;
   visit1 := TFPGList<PSector>.Create;
   visit2 := TFPGList<PSector>.Create;
   visit1.Add(@Sectors[a-1]);
   repeat
      for s in visit1 do
         if s = @Sectors[b-1] then begin
            if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
            WriteLn(l);
            Exit;
         end;
      VisitSector(visit1, visit2);
      Inc(l);
      visit2 := InterlockedExchange(Pointer(visit1), visit2);
   until visit2.Count = 0;
   WriteLn(-1);
end;

constructor TPoint.Create;
begin
   inherited Create;
   Capacity := 8;
end;

class function TPoint.c(const L, R: TPointDescrip): Boolean;
begin
   Result := CompareStr(L.s, R.s) < 0;
end;

{ TPoint }

begin
   Verbose := ParamCount > 0;
   Solve;
end.
