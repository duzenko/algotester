program solution;
{$mode Delphi}

uses SysUtils, Math, fgl, Classes;

type
   TFun = class;
   TFunList = TFPGList<TFun>;

   { TFun }

   TFun = class
      Balance, BalanceWithFriendCache: Integer;
      Friends: array of TFun;
      Invited: Boolean;
      procedure AddFriend(a: TFun);
      function BalanceWithFriends(): Integer;
   end;

var
   n: Integer;
   funs: array of TFun;

procedure Solve;
var
   a, b, i, j, m: Integer;
   x, y: Byte;
   fun, friend: TFun;
begin
	ReadLn(n, m);
   SetLength(funs, n);
   for i := 0 to n-1 do
      funs[i] := TFun.Create;
   for fun in funs do begin;
   	ReadLn(a, b);
      fun.Balance := a - b;
      fun.BalanceWithFriendCache := MaxInt;
   end;
   for i := 1 to m do begin;
   	ReadLn(x, y);
      funs[x-1].AddFriend(funs[y-1]);
      funs[y-1].AddFriend(funs[x-1]);
   end;
   a := 0;
   for fun in funs do begin
      if fun.BalanceWithFriends() <= 0 then
         Continue;
      a += fun.Balance;
      fun.Invited := True;
   end;
   for fun in funs do begin
      if not fun.Invited then Continue;
      for friend in fun.Friends do
         if not friend.Invited then
            a += friend.Balance;
   end;
   WriteLn(a);
end;

procedure TFun.AddFriend(a: TFun);
begin
   SetLength(Friends, Length(Friends)+1);
   Friends[High(Friends)] := a;
end;

function TFun.BalanceWithFriends: Integer;
const
   Group: TFunList = nil;

   function recursion(next: TFun): Integer;
   var
      friend: TFun;
   begin
      Group.Add(next);
      Result := next.Balance;
      for friend in next.Friends do begin
         if Group.IndexOf(friend) >= 0 then Continue;
         Result += recursion(friend);
      end;
   end;

var
   fun: TFun;
begin
   if BalanceWithFriendCache <> MaxInt then
      Exit(BalanceWithFriendCache);
   if Group = Nil then
      Group := TFunList.Create;
   Group.Count := 0;
   Result := recursion(Self);
   for fun in Group do
      fun.BalanceWithFriendCache := Result;
end;

begin
   Solve;
end.
