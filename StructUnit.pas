function max(a,b:longint):longint;
begin if a>b then exit(a); exit(b) end;

function min(a,b:longint):longint;
begin if a>b then exit(b); exit(a) end;

type
 Vector=object
  size:longint;
  a:array of longint;
  procedure resize(n:longint);
  procedure pushback(x:longint);
  procedure insert(p:longint;const b:array of longint);
  procedure insert(p:longint;const b:Vector);
  procedure delete(p,L:longint);
  procedure fill(l,r,x:longint);
 end;
 HashTab=object
  hashsize:longint;
  head,next,node,numb:Vector;
  procedure insert(x:longint);
  procedure delete(x:longint);
  function find(x:longint):longint;
  function count(x:longint):longint;
  procedure Union(const b:HashTab);
 end;

 procedure Vector.resize(n:longint);
 var m:longint;
 begin
  m:=max(n,8); while m<>m and(-m) do inc(m,m and(-m));
  setlength(a,m);
  if n>size then fill(size,n-1,0);
  size:=n
 end;

 procedure Vector.pushback(x:longint);
 begin
  inc(size);
  if high(a)<size then setlength(a,size*2);
  a[size-1]:=x
 end;

 procedure Vector.insert(p:longint;const b:array of longint);
 var n,i:longint;
 begin
  n:=high(b)+1;
  inc(size,n+max(0,p+1-size));
  resize(size);
  Move(a[p],a[p+n],n<<2);
  Move(b[0],a[p],n<<2)
 end;

 procedure Vector.insert(p:longint;const b:Vector);
 var n,i:longint;
 begin
  n:=b.size;
  inc(size,n+max(0,p+1-size));
  resize(size);
  Move(a[p],a[p+n],n<<2);
  Move(b.a[0],a[p],n<<2)
 end;

 procedure Vector.delete(p,L:longint);
 var i,n:longint;
 begin
  if p>=size then exit;
  if p+L>size then L:=size-p;
  for i:=0 to size-(p+L)-1 do a[p+i]:=a[p+L+i];
  for i:=p+L to size-1 do a[i]:=0;
  dec(size,L)
 end;

 procedure Vector.fill(l,r,x:longint);
 var i:longint;
 begin
  if l<0     then l:=0;
  if r>=size then r:=size-1;
  if x=0 then fillchar(a[l],(r-l+1)<<2,0)
  else for i:=l to r do a[i]:=x
 end;

 procedure HashTab.insert(x:longint);
 var i,u:longint;
 begin
  i:=find(x);
  if i<>-1 then begin inc(numb.a[i-1]); exit end;
  node.pushback(x);
  if node.size>hashsize then
  begin
   if hashsize<11 then hashsize:=11
                  else hashsize:=node.size<<1+1;
   head.resize(hashsize);
   fillchar(head.a[0],head.size<<2,0);
   next.resize(0);
   for i:=0 to node.size-1 do
   begin
    u:=node.a[i]mod hashsize;
    next.pushback(head.a[u]);
    head.a[u]:=i+1
   end
  end;
  u:=x mod hashsize;
  next.pushback(head.a[u]);
  numb.pushback(1);
  head.a[u]:=node.size
 end;

 procedure HashTab.delete(x:longint);
 var i:^longint; u:longint;
 begin
  if hashsize=0 then exit;
  u:=x mod hashsize;
  i:=@head.a[u];
  while i^<>0 do
  begin
   if node.a[i^-1]=x then begin dec(numb.a[i^-1]); i^:=next.a[i^-1]; exit end;
   i:=@next.a[i^-1]
  end
 end;

 function HashTab.find(x:longint):longint;
 var i,u:longint;
 begin
  if hashsize=0 then exit(-1);
  u:=x mod hashsize;
  i:=head.a[u];
  while i<>0 do
  begin
   if node.a[i-1]=x then exit(i);
   i:=next.a[i-1]
  end;
  exit(-1)
 end;

 function HashTab.count(x:longint):longint;
 var y:longint;
 begin
  y:=find(x);
  if y=-1 then exit(0);
  exit(numb.a[y-1])
 end;

 procedure HashTab.union(const b:HashTab);
 var i,j:longint;
 begin
  for i:=0 to high(b.node.a) do
  for j:=1 to b.numb.a[i] do insert(b.node.a[i])
 end;


var
 a:HashTab;
 b:Vector;
 i:longint;
begin
 for i:=1 to 10000000 do a.insert(i);
 for i:=1 to 10000000 do a.find(i);
 b.insert(10,[2,6,7,i+8]);
 b.resize(20);
 b.fill(1,5,10);
 for i:=0 to b.size-1 do writeln(b.a[i])
end.