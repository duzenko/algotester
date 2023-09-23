program solution; {$mode delphi}{$C+}

uses SysUtils, Math, StrUtils, Classes, fgl, gset;

type
   TPoint = record
      x, y: Integer;
   end;
   PPoint = ^TPoint;

   { TGroup }

   TGroup = class(TFPGList<PPoint>)
     InternalGap: Double;
     function DistanceTo(p: PPoint): Double; overload; inline;
     function Distance2To(p: PPoint): Double; overload;
     function DistanceTo(Group: TGroup): Double; overload; inline;
     function Distance2To(Group: TGroup): Double; overload;
     function DistanceToLeft: Double;
     function DistanceToRight: Double;
   end;

var
   n, r, xl, xr: Integer;
   Groups: TFPGList<TGroup>;
   All: TGroup;
   Verbose: Boolean;

function Distance2(p1, p2: PPoint): Double; inline;
begin
   Result := Sqr(p1.x-p2.x)+Sqr(p1.y-p2.y);
end;

procedure Solve;
var
   i: Integer;
   Group, g1, g2, g: TGroup;
   p: PPoint;
   d, d1, d2: Double;
begin
	ReadLn(xl, xr);
	ReadLn(r);
	ReadLn(n);
   Assert(xr>xl);
   for i := 1 to n do begin
      New(p);
      with p^ do begin
         ReadLn(x, y);
         Assert(x > xl-r);
         Assert(x < xr+r);
      end;
      All.Add(p);
      Groups.Add(TGroup.Create);
      Groups.Last.Add(p);
   end;
   while Groups.Count > 1 do begin
      d := MaxDouble;
      for g1 in Groups do begin
         for g2 in Groups do begin
            if g1 = g2 then Continue;
            d2 := g1.Distance2To(g2);
            if d2 >= d then Continue;
            d := d2;
            Group := g1;
            g := g2;
            Break;
         end;
         //Break;
      end;
      d1 := Max(Group.InternalGap, Max(Group.DistanceToLeft, Group.DistanceToRight));
      d2 := Max(g.InternalGap, Max(g.DistanceToLeft, g.DistanceToRight));
      d := Group.DistanceTo(g) - r;
      Group.InternalGap := Min(Min(d1, d2), d);
      if Verbose then
         WriteLn(Format('p1=(%d %d) p2=(%d %d) %f', [Group.First.x, Group.First.y, g.First.x, g.First.y, Group.InternalGap]));
      for p in g do
         Group.Add(p);
      Groups.Remove(g);
   end;
   d := Groups.First.InternalGap;
   d1 := Max(Groups.First.DistanceToLeft, Groups.First.DistanceToRight);
   d := Max(d, d1);
   Assert(d > r);
   d -= r;
   WriteLn(d);
end;

var
   i: Integer;

function TGroup.DistanceTo(p: PPoint): Double;
begin
   Result := Sqrt(Distance2To(p));
end;

function TGroup.Distance2To(p: PPoint): Double;
var
   i: PPoint;
begin
   Result := MaxSingle;
   for i in Self do
      Result := Min(Result, Distance2(p, i));
end;

function TGroup.DistanceTo(Group: TGroup): Double;
begin
   Result := Sqrt(Distance2To(Group));
end;

function TGroup.Distance2To(Group: TGroup): Double;
var
   i: PPoint;
begin
   Result := MaxSingle;
   for i in Self do
      Result := Min(Result, Group.Distance2To(i));

end;

function TGroup.DistanceToLeft: Double;
var
   i: PPoint;
begin
   Result := MaxSingle;
   for i in Self do
      Result := Min(Result, i.x);
   Result := Result - xl;
end;

function TGroup.DistanceToRight: Double;
var
   i: PPoint;
begin
   Result := -MaxSingle;
   for i in Self do
      Result := Max(Result, i.x);
   Result := xr - Result;
end;

begin
   if ParamStr(1) = 't' then begin
      WriteLn(0, ' ', 33);
      WriteLn(1);
      WriteLn(10);
      for i := 0 to 200-1 do
         WriteLn(3*i+1, ' ', i+1);
      Exit;
   end;
   Verbose := ParamStr(1) = 'v';
   All := TGroup.Create;
   Groups := TFPGList<TGroup>.Create;
   Solve;
end.
