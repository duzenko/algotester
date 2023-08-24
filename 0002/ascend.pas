program ascend;
{$mode objfpc}{$h+}

uses SysUtils, Math;

function getMaxLenFrom(startIndex: integer; data: array of Integer): Integer;
var
   i, minNum, maxNum, innerLength: integer;
begin
   if startIndex < 0 then
      minNum := 0
   else
     	minNum := data[startIndex];
   maxNum := MaxInt;
   Result := 0;
   for i := startIndex+1 to High(data) do begin
   	if data[i] <= minNum then
         Continue;
   	if data[i] >= maxNum then
         Continue;
      maxNum := data[i];
      innerLength := getMaxLenFrom(i, data);
      if innerLength >= Result then
         Result := innerLength+1;
   end;
end;

var
   i, maxLength: Integer;
   N: Integer;
   data: array of Integer = nil;
begin
	readln(N);
   SetLength(data, N);
   for i := 0 to N-1 do
   	read(data[i]);
   maxLength := getMaxLenFrom(-1, data);
   Writeln(maxLength);
end.

