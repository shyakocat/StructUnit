function max(a,b:longint):longint;
begin if a>b then exit(a); exit(b) end;

function min(a,b:longint):longint;
begin if a>b then exit(b); exit(a) end;

procedure sw(var a,b:longint);
var c:longint; begin c:=a; a:=b; b:=c end;

const
 Less=false;
 Greater=true;

function cmp(a,b:longint;z:boolean):boolean;
begin exit((a<b)xor z) end;

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
  function isnil:boolean;
 end;

 HashTab=object
  size,hashsize:longint;
  head,next,node,numb:Vector;
  procedure clear;
  procedure insert(x:longint);
  procedure delete(x:longint);
  function find(x:longint):longint;
  function count(x:longint):longint;
  procedure Union(const b:HashTab);
  function isnil:boolean;
 end;

 Heap=object
  size,bias:longint;
  comp:boolean;
  h:Vector;
  procedure setcmp(z:boolean);
  procedure clear;
  procedure add(x:longint);
  procedure push(x:longint);
  procedure pop;
  function top:longint;
  function isnil:boolean;
 end;

 DeleteHeap=object
  A,B:Heap;
  procedure clear;
  procedure update;
  procedure add(x:longint);
  procedure push(x:longint);
  procedure pop;
  procedure delete(x:longint);
  function top:longint;
  function isnil:boolean;
 end;

 Stack=object
  size:longint;
  sta:Vector;
  procedure clear;
  procedure push(x:longint);
  procedure pop;
  function top:longint;
  function isnil:boolean;
 end;

 Treap=object
  root,size,tot:longint;
  va,sm,ct,db,ls,rs,rd:Vector;
  private
   procedure pu(k:longint);
   procedure rr(var k:longint);
   procedure lr(var k:longint);
  public
   procedure clear;
   procedure insert(x:longint);
   procedure delete(x:longint);
   function count(x:longint):longint;
   function lower(x:longint):longint;
   function upper(x:longint):longint;
   function askrank(x:longint):longint;
   function getrank(x:longint):longint;
   function getsum(l,r:longint):longint;
   function isnil:boolean;
 end;

 procedure Vector.resize(n:longint);
 var m:longint;
 begin
  m:=max(n+1,8); while m<>m and(-m) do inc(m,m and(-m));
  setlength(a,m);
  if n>size then fill(size+1,n,0);
  size:=n
 end;

 procedure Vector.pushback(x:longint);
 begin
  inc(size);
  if high(a)<size then setlength(a,(size+1)*2);
  a[size]:=x
 end;

 procedure Vector.insert(p:longint;const b:array of longint);
 var n,i:longint;
 begin
  n:=high(b)+1;
  inc(size,n+max(0,p-1-size));
  resize(size);
  Move(a[p],a[p+n],n<<2);
  Move(b[0],a[p],n<<2)
 end;

 procedure Vector.insert(p:longint;const b:Vector);
 var n,i:longint;
 begin
  n:=b.size;
  inc(size,n+max(0,p-1-size));
  resize(size);
  Move(a[p],a[p+n],n<<2);
  Move(b.a[1],a[p],n<<2)
 end;

 procedure Vector.delete(p,L:longint);
 var i,n:longint;
 begin
  if p>size then exit;
  if p+L>size+1 then L:=size-p+1;
  for i:=0 to size-(p+L) do a[p+i]:=a[p+L+i];
  for i:=p+L to size do a[i]:=0;
  dec(size,L)
 end;

 procedure Vector.fill(l,r,x:longint);
 var i:longint;
 begin
  if l<1    then l:=1;
  if r>size then r:=size;
  if x=0 then fillchar(a[l],(r-l+1)<<2,0)
  else for i:=l to r do a[i]:=x
 end;

 function Vector.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure HashTab.clear;
 begin
  size:=0;
  hashsize:=0;
  head.resize(0);
  next.resize(0);
  node.resize(0);
  numb.resize(0)
 end;

 procedure HashTab.insert(x:longint);
 var i,u:longint;
 begin
  inc(size);
  i:=find(x);
  if i<>-1 then begin inc(numb.a[i]); exit end;
  node.pushback(x);
  if node.size>hashsize then
  begin
   if hashsize<11 then hashsize:=11
                  else hashsize:=node.size<<1+1;
   head.resize(hashsize);
   fillchar(head.a[0],(head.size+1)<<2,0);
   for i:=1 to node.size-1 do
   begin
    u:=node.a[i]mod hashsize;
    next.a[i]:=head.a[u];
    head.a[u]:=i
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
   if node.a[i^]=x then begin dec(size);
   if numb.a[i^]>1 then dec(numb.a[i^]) else i^:=next.a[i^]; exit end;
   i:=@next.a[i^]
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
   if node.a[i]=x then exit(i);
   i:=next.a[i]
  end;
  exit(-1)
 end;

 function HashTab.count(x:longint):longint;
 var y:longint;
 begin
  y:=find(x);
  if y=-1 then exit(0);
  exit(numb.a[y])
 end;

 procedure HashTab.union(const b:HashTab);
 var i,j:longint;
 begin
  for i:=1 to b.node.size do
  for j:=1 to b.numb.a[i] do insert(b.node.a[i])
 end;

 function HashTab.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure Heap.setcmp(z:boolean);
 begin
  comp:=z
 end;

 procedure Heap.clear;
 begin
  size:=0;
  h.resize(0)
 end;

 procedure Heap.add(x:longint);
 begin
  inc(bias,x)
 end;

 procedure Heap.push(x:longint);
 var i:longint;
 begin
  dec(x,bias);
  inc(size);
  h.pushback(x);
  i:=size;
  while (i>1)and(cmp(h.a[i],h.a[i>>1],comp)) do
  begin
   sw(h.a[i],h.a[i>>1]);
   i:=i>>1
  end
 end;

 procedure Heap.pop;
 var i,t:longint;
 begin
  sw(h.a[1],h.a[size]);
  dec(size);
  h.resize(size);
  i:=1;
  while i<<1<=size do
  begin
   t:=i<<1;
   if (t<size)and(cmp(h.a[t+1],h.a[t],comp)) then inc(t);
   if cmp(h.a[t],h.a[i],comp) then begin sw(h.a[t],h.a[i]); i:=t end else break
  end
 end;

 function Heap.top:longint;
 begin
  if size=0 then exit(-1);
  exit(h.a[1]+bias)
 end;

 function Heap.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure DeleteHeap.clear;
 begin
  A.clear;
  B.clear
 end;

 procedure DeleteHeap.update;
 begin
  while (A.size>0)and(B.size>0)and(A.top=B.top) do
  begin
   A.pop;
   B.pop
  end
 end;

 procedure DeleteHeap.add(x:longint);
 begin
  A.add(x);
  B.add(x)
 end;

 procedure DeleteHeap.push(x:longint);
 begin
  A.push(x)
 end;

 procedure DeleteHeap.delete(x:longint);
 begin
  B.push(x)
 end;

 procedure DeleteHeap.pop;
 begin
  delete(top)
 end;

 function DeleteHeap.top:longint;
 begin
  update;
  exit(A.top)
 end;

 function DeleteHeap.isnil:boolean;
 begin
  update;
  exit(A.isnil)
 end;

 procedure Treap.pu(k:longint);
 var l,r:longint;
 begin
  l:=ls.a[k]; r:=rs.a[k];
  ct.a[k]:=db.a[k];
  sm.a[k]:=va.a[k]*db.a[k];
  if l<>0 then begin inc(ct.a[k],ct.a[l]); inc(sm.a[k],sm.a[l]) end;
  if r<>0 then begin inc(ct.a[k],ct.a[r]); inc(sm.a[k],sm.a[r]) end
 end;

 procedure Treap.rr(var k:longint);
 var t:longint;
 begin
  t:=ls.a[k];
     ls.a[k]:=rs.a[t];
              rs.a[t]:=k;   pu(k); pu(t);
                       k:=t
 end;

 procedure Treap.lr(var k:longint);
 var t:longint;
 begin
  t:=rs.a[k];
     rs.a[k]:=ls.a[t];
              ls.a[t]:=k;   pu(k); pu(t);
                       k:=t
 end;

 procedure Treap.clear;
 begin
  size:=0;
  root:=0;
  tot:=0;
  va.resize(0);
  sm.resize(0);
  ct.resize(0);
  db.resize(0);
  ls.resize(0);
  rs.resize(0);
  rd.resize(0)
 end;

 procedure Treap.insert(x:longint);

  procedure ins(var k:longint;x:longint);
  begin
   if k=0 then
   begin
    inc(tot);
    k:=tot;
    va.pushback(x);
    sm.pushback(x);
    ct.pushback(1);
    db.pushback(1);
    ls.pushback(0);
    rs.pushback(0);
    rd.pushback(random(maxlongint));
    exit
   end;
   if x=va.a[k] then begin inc(db.a[k]); inc(sm.a[k],va.a[k]); exit end else
   if x<va.a[k] then begin ins(ls.a[k],x); if rd.a[ls.a[k]]<rd.a[k] then rr(k) end
                else begin ins(rs.a[k],x); if rd.a[rs.a[k]]<rd.a[k] then lr(k) end;
   pu(k)
  end;

 begin
  inc(size);
  ins(root,x)
 end;

 procedure Treap.delete(x:longint);
 var _del:boolean=false;

  procedure del(var k:longint;x:longint);
  begin
   if k=0 then exit;
   if x=va.a[k] then
   begin
    if db.a[k]>1 then dec(db.a[k]) else
    if (ls.a[k]=0)or(rs.a[k]=0) then begin k:=ls.a[k]+rs.a[k]; _del:=true end else
    if rd.a[ls.a[k]]<rd.a[rs.a[k]] then begin rr(k); del(rs.a[k],x) end
                                   else begin lr(k); del(ls.a[k],x) end
   end else
   if x<va.a[k] then del(ls.a[k],x)
                else del(rs.a[k],x);
   pu(k)
  end;

 begin
  del(root,x);
  if _del then dec(size)
 end;

 function Treap.count(x:longint):longint;

  function skcnt(k,x:longint):longint;
  begin
   if k=0 then exit(0);
   if x=va.a[k] then exit(db.a[k]);
   if x<va.a[k] then exit(skcnt(ls.a[k],x));
   exit(skcnt(rs.a[k],x))
  end;

 begin
  exit(skcnt(root,x))
 end;

 function Treap.lower(x:longint):longint;

  function sklow(k,x:longint):longint;
  begin
   if k=0 then exit(-1);
   if va.a[k]>=x then exit(sklow(ls.a[k],x));
   sklow:=sklow(rs.a[k],x); if sklow=-1 then exit(va.a[k])
  end;

 begin
  exit(sklow(root,x))
 end;

 function Treap.upper(x:longint):longint;

  function skhig(k,x:longint):longint;
  begin
   if k=0 then exit(-1);
   if va.a[k]<=x then exit(skhig(rs.a[k],x));
   skhig:=skhig(ls.a[k],x); if skhig=-1 then exit(va.a[k])
  end;

 begin
  exit(skhig(root,x))
 end;

 function Treap.askrank(x:longint):longint;

  function skrnk(k,x:longint):longint;
  begin
   if k=0 then exit(-1);
   if x=va.a[k] then exit(ct.a[ls.a[k]]+1);
   if x>va.a[k] then begin skrnk:=skrnk(rs.a[k],x);
   if skrnk=-1  then exit; exit(ct.a[ls.a[k]]+db.a[k]+skrnk) end;
   exit(skrnk(ls.a[k],x))
  end;

 begin
  exit(skrnk(root,x));
 end;

 function Treap.getrank(x:longint):longint;

  function sk(k,x:longint):longint;
  var t:longint;
  begin
   t:=ct.a[ls.a[k]];
   if (t+1<=x)and(x<=t+db.a[k]) then exit(va.a[k]);
   if x<=t then exit(sk(ls.a[k],x));
                exit(sk(rs.a[k],x-t-db.a[k]))
  end;

 begin
  if (x<1)or(x>size) then exit(-1);
  exit(sk(root,x))
 end;

 function Treap.getsum(l,r:longint):longint;

  function sksum(k,x:longint):longint;
  var t:longint;
  begin
   t:=ct.a[ls.a[k]];
   if (t+1<=x)and(x<=t+db.a[k]) then exit(sm.a[ls.a[k]]+(x-t)*va.a[k]);
   if x<=t then exit(sksum(ls.a[k],x));
   exit(sm.a[ls.a[k]]+va.a[k]*db.a[k]+sksum(rs.a[k],x-t-db.a[k]))
  end;

 begin
  if l>r then exit(0);
  if (l<1)or(l>size)or(r<1)or(r>size) then exit(-1);
  if l=1 then exit(sksum(root,r));
  exit(sksum(root,r)-sksum(root,l-1))
 end;

 function Treap.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure Stack.Clear;
 begin
  size:=0;
  sta.resize(0)
 end;

 procedure Stack.push(x:longint);
 begin
  inc(size);
  sta.pushback(x)
 end;

 procedure Stack.pop;
 begin
  sta.delete(size,1);
  dec(size)
 end;

 function Stack.top:longint;
 begin
  exit(sta.a[size])
 end;

 function Stack.isnil:boolean;
 begin
  exit(size=0)
 end;

begin

end.