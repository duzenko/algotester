program solution;
{$mode objfpc}

uses SysUtils, Math, fgl, gvector;

{TCompare is comparing class, which should have class method c(a,b:T):boolean, which returns true is a is less than b}

type
  generic TPriorityQueue<T, TCompare>=class
  private
  type
    TContainer=specialize TVector<T>;
  var
    FData:TContainer;

    procedure PushUp();
    function Left(a:SizeUInt):SizeUInt;inline;
    function Right(a:SizeUInt):SizeUInt;inline;
    procedure Heapify(position:SizeUInt);
    function Parent(a:SizeUInt):SizeUInt;inline;
  public
    constructor Create;
    destructor Destroy;override;
    function Top:T;inline;
    procedure Pop;inline;
    procedure Push(value:T);inline;
    function Size:SizeUInt;inline;
    function IsEmpty:boolean;inline;
  end;

type
   { TSheet }

   TSheet = object
      Size: Integer;
      Pieces: Integer;
      CompareValue: Single;
      procedure SetPieces(n: Integer); inline;
   end;

   { THelper }

   THelper = class
      class function c(a, b: LongWord): Boolean; static; inline;
   end;

   TSheetQueue = specialize TPriorityQueue<LongWord, THelper>;

var
   s: TSheetQueue;
   Data: array[1..100000] of TSheet;

procedure Solve;
var
   i, j, k, n, r: Integer;
   t: Int64;
   f, a: Double;
   p: LongWord;
begin
	ReadLn(n, k);
   t := 0;
   for i := 1 to n do begin
      Read(Data[i].Size);
      t += Data[i].Size;
   end;
   a := t / k;
   r := 0;
   for i := 1 to n do begin
      Data[i].SetPieces(Floor(Data[i].Size / a));
      r += Data[i].Pieces;
   end;
   s.FData.Reserve(n);
   for i := 1 to n do
      s.Push(i);
   for i := r+1 to k do begin
      p := s.Top;
      s.Pop;
      with Data[p] do
         SetPieces(Pieces+1);
      s.Push(p);
   end;
   f := MaxSingle;
   for j := 1 to n do
      if Data[j].Pieces > 0 then
         f := Min(f, Data[j].Size/Data[j].Pieces);
   WriteLn(f);
end;

{ TSheet }

procedure TSheet.SetPieces(n: Integer);
begin
   Pieces := n;
   CompareValue := Size/(Pieces+1);
end;

{ THelper }

class function THelper.c(a, b: LongWord): Boolean;
begin
   Result := Data[a].CompareValue < Data[b].CompareValue;
end;

constructor TPriorityQueue.Create;
begin
  FData:=TContainer.Create;
end;

destructor TPriorityQueue.Destroy;
begin;
  FData.Destroy;
end;

function TPriorityQueue.Size:SizeUInt;inline;
begin
  Size:=FData.Size;
end;

function TPriorityQueue.IsEmpty:boolean;inline;
begin
  IsEmpty:=FData.Size=0;
end;

function TPriorityQueue.Top:T;inline;
begin
  Top:=FData[0];
end;

procedure TPriorityQueue.Pop;inline;
begin
  if not IsEmpty then begin
    FData[0]:=FData.back;
    FData.PopBack;
    Heapify(0);
  end;
end;

procedure TPriorityQueue.PushUp();
var position,np:SizeUInt; temp:T;
begin
  position:=FData.Size-1;
  while(position>0) do
  begin
    np := Parent(position);
    if(TCompare.c(FData[np],FData[position])) then
    begin
      temp:=FData[np];
      FData[np]:=FData[position];
      FData[position]:=temp;
      position:=np;
    end else
      break;
  end;
end;

procedure TPriorityQueue.Push(value:T);inline;
begin
  FData.PushBack(value);
  PushUp();
end;

function TPriorityQueue.Left(a:SizeUInt):SizeUInt;inline;
begin
  Left:=((a+1)shl 1)-1;
end;

function TPriorityQueue.Right(a:SizeUInt):SizeUInt;inline;
begin
  Right:=(a+1) shl 1;
end;

function TPriorityQueue.Parent(a:SizeUInt):SizeUInt;inline;
begin
  Parent:=(a-1)shr 1;
end;

procedure TPriorityQueue.Heapify(position:SizeUInt);
var mpos,l,r:SizeUInt; temp:T;
begin
  while(true) do
  begin
    mpos:=position;
    l:=Left(position);
    r:=Right(position);
    if (l<FData.Size) AND (TCompare.c(FData[mpos],FData[l])) then
      mpos:=l;
    if (r<FData.Size) AND (TCompare.c(FData[mpos],FData[r])) then
      mpos:=r;
    if mpos = position then break;

    temp:=FData[position];
    FData[position]:=FData[mpos];
    FData[mpos]:=temp;
    position:=mpos;
  end;
end;

begin
   s := TSheetQueue.Create;
   Solve;
end.
