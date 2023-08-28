program solution;
{$mode objfpc}

uses SysUtils, Math, StrUtils;

procedure Solve;
var
   days, today, weeks, firstMonday, lastSunday: LongWord;
   i: Integer;
   todayName: String;
   skipped: array of LongWord;
begin
   SetLength(skipped, 7);
	ReadLn(todayName);
	ReadLn(days);
   today := IndexStr(todayName, ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']);
   firstMonday := 0;
   lastSunday := (today + days-1) div 7 * 7 + 6;
   weeks := (lastSunday+1) div 7;
   for i := firstMonday to today-1 do
      Inc(skipped[i mod 7]);
   for i := today + days to lastSunday do
      Inc(skipped[i mod 7]);
   for i := 0 to 6 do
      Write(weeks-skipped[i], ' ');
end;

begin
   Solve;
end.
