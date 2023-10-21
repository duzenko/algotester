program solution;
{$mode delphi}

uses SysUtils, Math, StrUtils, fgl;

type
   PBox = ^TBox;
   PGroup = ^TGroup;
   TBox = record
      w, h, tmp: Integer;
      Group: PGroup;
   end;
   TGroup = record
      no, count: Integer;
   end;

   { TGroupList }

   TIndex = class(TFPGList<PBox>)
   end;

var
   Boxes: array[1..2000] of TBox;

function CompareBox(a, b: PBox): Integer;
begin
   Result := a.tmp - b.tmp;
end;

procedure Solve;
var
   k, m, n: Integer;
   box: PBox;
   index: TIndex;
   next: PBox;
   i, j, bk: Integer;
begin
	ReadLn(n, k, m);
   k := Min(n, k);
   index := TIndex.Create;
   box := @Boxes;
   for i := 1 to n do begin
      ReadLn(box.w, box.h);
      New(box.Group);
      box.Group.no := i;
      index.Add(box);
      Inc(box);
   end;
   for i := 1 to m do begin
      ReadLn(box.w, box.h);
      for j := 1 to index.Count do
         Boxes[j].tmp := Max(Abs(Boxes[j].w-box.w), Abs(Boxes[j].h-box.h));
      index.Sort(@CompareBox);
      bk := index[k-1].tmp;
      box.Group := nil;
      for j := 0 to index.Count-1 do begin
         next := index[j];
         if next.tmp > bk then Break;
         next.Group.count := 0;
      end;
      for j := 0 to index.Count-1 do begin
         next := index[j];
         if next.tmp > bk then Break;
         next.Group.count += 1;
         if (box.Group = nil) or (next.Group.count > box.Group.count) then
            box.Group := next.Group
         else
            if (next.Group.count = box.Group.count) and (next.Group.no < box.Group.no) then
               box.Group := next.Group
      end;
      WriteLn(box.Group.no);
      index.Add(box);
      Inc(box);
   end;
end;

{ TGroupList }

begin
   if ParamStr(1) = 'd' then begin
      AssignFile(Input, 'stdin.txt');
      Reset(Input);
   end;
   Solve;
end.


