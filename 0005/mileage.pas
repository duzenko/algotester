program mileage;
{$mode objfpc}
{$MODESWITCH AdvancedRecords+}

uses SysUtils, Math, Classes, GPriorityQueue;

type
   TPathPoint = Int64;

   { TStation }

   TStation = record
     	ConnectionCount, DistanceTo0: Integer;
      Connections: ^LongWord;
   end;

   TPathListComparer = class
      class function c(const a, b: TPathPoint): Boolean; inline;
   end;

   TPathList = specialize TPriorityQueue<TPathPoint, TPathListComparer>;

var
   Stations: array of TStation;
   StationsRemaining: Integer;
   Connections: array[0..200000] of LongWord;

procedure Traverse;
var
   list: TPathList;
   newPathPoint: TPathPoint;
   pp: packed record
      TotalLength, CurrentStationId: LongWord;
   end absolute newPathPoint;
   i: Integer;
   Station: ^TStation;
   CurrentLength, Connection: LongWord;
begin
   list := TPathList.Create;
   Station := @Stations[1];
   CurrentLength := 0;
	repeat
      Station^.DistanceTo0 := CurrentLength;
      for i := 0 to Station^.ConnectionCount-1 do begin
         Connection := DWord(Station^.Connections[i]);
         pp.CurrentStationId := Connection shr 10;
         if Stations[pp.CurrentStationId].DistanceTo0 >= 0 then
            Continue;
         pp.TotalLength := CurrentLength + Connection and $3ff;
         list.Push(newPathPoint);
      end;
      Dec(StationsRemaining);
      if StationsRemaining = 0 then
         Break;
      repeat
         newPathPoint := list.Top;
   		list.Pop;
         Station := @Stations[pp.CurrentStationId];
      until Station^.DistanceTo0 < 0;
      CurrentLength := pp.TotalLength;
	until false;
   list.Free;
end;

procedure ReadConnections(m: Integer);
var
   i, ConnectionsUsed: Integer;
   perStation: array[0..100000] of LongWord;
   data: array[0..100000] of record
      a, b, c: Integer;
   end;
begin
   FillDWord(perStation, Length(perStation), 0);
   for i := 1 to m do
      with data[i] do begin
         read(a, b, c);
         Inc(perStation[a]);
         Inc(perStation[b]);
      end;
   ConnectionsUsed := 0;
   for i := 1 to High(Stations) do begin
      Stations[i].ConnectionCount := perStation[i];
      Stations[i].Connections := @Connections[ConnectionsUsed];
      ConnectionsUsed += perStation[i];
   end;
   for i := 1 to m do
      with data[i] do begin
         Dec(perStation[a]);
         Dec(perStation[b]);
         Stations[a].Connections[perStation[a]] := b shl 10 or c;
         Stations[b].Connections[perStation[b]] := a shl 10 or c;
      end;
end;

procedure Solve;
var
   i, n, m, a, b: Integer;
   c: Int64;
begin
	readln(n, m);
   SetLength(Stations, n + 1);
   for i := 1 to n do
      with Stations[i] do begin
         DistanceTo0 := -1;
      end;
   ReadConnections(m);
   StationsRemaining := n;
   Traverse;
   c := 0;
   for i := 1 to n do begin
      c := c + Stations[i].DistanceTo0;
   end;
   WriteLn(c);
end;

{ TStation }

class function TPathListComparer.c(const a, b: TPathPoint): Boolean;
begin
   Result := Integer(a) > Integer(b);
end;

begin
   Solve;
end.
