program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, Classes, fgl, gset;

const
   MaxN = 35000;

type
   { TSector }

   TSector = record
      NeighborCount: Integer;
      Neighbors: array[0..7] of ^TSector;
      Visited: Boolean;
   end;
   PSector = ^TSector;

   TPointDescrip = record
      s: String;
      SectorCount: Integer;
      Sectors: array[0..7] of ^TSector;
   end;
   PPointDescrip = ^TPointDescrip;

   TPointDescripHelper = class
      class function c(L, R: PPointDescrip): Boolean; static; inline;
   end;

   TSmartArray = record
      Count: Integer;
      Data: array[0..MaxN] of PSector;
   end;

var
   Sectors: array[0..MaxN] of TSector;
   PointData: array[0..MaxN*3] of TPointDescrip;
   visit1, visit2: TSmartArray;
   Verbose: Boolean;

procedure VisitSector(var last, next: TSmartArray);
var
   l, n: Integer;
begin
   next.Count := 0;
   for l := 0 to last.Count-1 do
      for n  := 0 to last.Data[l].NeighborCount-1 do
         if not last.Data[l].Neighbors[n].Visited then begin
            last.Data[l].Neighbors[n].Visited := True;
            next.Data[next.Count] := last.Data[l].Neighbors[n];
            next.Count += 1;
         end;
end;

procedure Solve;
var
   Index2: TSet<PPointDescrip, TPointDescripHelper>;
   a, b, i, j, k1, k2, k3, n: Integer;
   s, s1: PSector;
   Points: array[0..2] of PPointDescrip;
   dt: TDateTime;
   pd, p1, p2: PPointDescrip;
   node: Index2.PNode;
begin
   dt := Now;
   Index2 := TSet<PPointDescrip, TPointDescripHelper>.Create;
   ReadLn(n);
   ReadLn(a, b);
   if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
   pd := @PointData;
   for i := 0 to n-1 do begin;
      s := @Sectors[i];
      for j := 0 to 2 do begin
         ReadLn(pd.s);
         node := Index2.NFind(pd);
         if node = nil then begin
            p1 := pd;
            Index2.Insert(pd);
            Inc(pd);
         end else begin
            p1 := node.Data;
         end;
         //if p1.SectorCount = High(p1.SectorCount) then
         //   raise Exception.Create('');
         p1.Sectors[p1.SectorCount] := s;
         p1.SectorCount += 1;
         Points[j] := p1;
      end;
      for j := 0 to 2 do begin
         p1 := Points[j];
         for k1 := 0 to 2 do
            if j <> k1 then begin
               p2 := Points[k1];
               for k2 := 0 to p1.SectorCount-1 do begin
                  s1 := p1.Sectors[k2];
                  if s1 = s then Continue;
                  for k3 := 0 to p2.SectorCount-1 do
                     if s1 = p2.Sectors[k3] then begin
                        //if s1.NeighborCount = High(s1.Neighbors) then
                        //   raise Exception.Create('');
                        //if s.NeighborCount = High(s.Neighbors) then
                        //   raise Exception.Create('');
                        s1.Neighbors[s1.NeighborCount] := s;
                        s1.NeighborCount += 1;
                        s.Neighbors[s.NeighborCount] := s1;
                        s.NeighborCount += 1;
                     end;
               end;
            end;
      end;
   end;
   if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
   n := 0;
   visit1.Count := 1;
   visit1.Data[0] := @Sectors[a-1];
   repeat
      for i := 0 to visit1.Count-1 do begin
         s := visit1.Data[i];
         if s = @Sectors[b-1] then begin
            if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
            WriteLn(n);
            Exit;
         end;
      end;
      VisitSector(visit1, visit2);
      Inc(n);
      if visit2.Count = 0 then Break;
      for i := 0 to visit2.Count-1 do begin
         s := visit2.Data[i];
         if s = @Sectors[b-1] then begin
            if Verbose then WriteLn(FormatDateTime('ss.zzz', Now-dt));
            WriteLn(n);
            Exit;
         end;
      end;
      VisitSector(visit2, visit1);
      Inc(n);
   until visit1.Count = 0;
   WriteLn(-1);
end;

class function TPointDescripHelper.c(L, R: PPointDescrip): Boolean;
begin
   Result := CompareStr(L.s, R.s) < 0;
end;

var
   i, j: Integer;
begin
   if ParamStr(1) = 't' then begin
      WriteLn(MaxN);
      WriteLn(1, ' ', MaxN);
      for i := 0 to MaxN-1 do
         for j := 0 to 2 do
            WriteLn(Format('%d %d %d', [(i mod 32 + j) div 2, i div 32 + (i+j) mod 2, 0]));
      Exit;
   end;
   Verbose := ParamStr(1) = 'd';
   Solve;
end.
