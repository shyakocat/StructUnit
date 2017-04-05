unit StructUnit;
interface

const
 Less=false;
 Greater=true;
type
 pint=^longint;

 Vector=object                                              //Vector(队列)
  size:longint;                                             //队列大小
  a:array of longint;                                       //队列本体，可用Vector.a[i](i=1..size)访问第i项
  procedure clear;                                          //清空
  procedure resize(n:longint);                              //重设队列大小
  procedure pushback(x:longint);                            //在队列后添加一个数
  procedure insert(p:longint;const b:array of longint);     //在p位置前插入序列b
  procedure insert(p:longint;const b:Vector);
  procedure delete(p,L:longint);                            //在p位置开始删除L个数
  procedure fill(l,r,x:longint);                            //将l..r的数赋值为x
  procedure discretization(l,r:longint);                    //将l..r的数离散化
  function clone(l,r:longint):Vector;                       //复制l..r为一个Vector
  function head:pint;                                       //首元素的指针
  function tail:pint;                                       //末元素的指针
  function isnil:boolean;                                   //返回队列是否为空
 end;

 BitSet=object                                              //BitSet(压位队列)
  size,len:longint;                                         //size为压位队列大小
  a:array of longint;                                       //压位队列本体
  function ct1(x:longint):longint;                          //*返回x的二进制位上1的个数
  procedure clear;                                          //清空
  procedure resize(n:longint);                              //设置压位队列长度为n且清空
  procedure pushback(const s:ansistring);                   //在压位队列后添加一个01序列
  procedure pushback(x:char);                               //在压位队列后添加一个01值
  procedure convert(const s:ansistring);                    //把01序列转换成压位队列
  procedure set0(l,r:longint);                              //把压位队列上l..r赋值为0
  procedure set1(l,r:longint);                              //把压位队列上l..r赋值为1
  procedure reverse(l,r:longint);                           //把压位队列上l..r按位取反
  function pos(x:longint):longint;                          //返回第x位的值
  function copy(l,r:longint):ansistring;                    //返回压位队列l..r组成的01串
  function count0(l,r:longint):longint;                     //返回压位队列l..r上1的个数
  function count1(l,r:longint):longint;                     //返回压位队列l..r上0的个数
  function isnil:boolean;                                   //返回压位队列是否为空
 end;

 HashTab=object                                             //HashTab(哈希表)
  size,hashsize:longint;                                    //size为Hash表大小
  head,next,node,numb:Vector;                               //边表，node是原值，numb是出现次数
  procedure clear;                                          //清空
  procedure insert(x:longint);                              //添加数x
  procedure delete(x:longint);                              //删除数x（一次）
  function find(x:longint):longint;                         //返回数x的位置，找不到就返回-1
  function count(x:longint):longint;                        //返回数x的出现次数
  procedure Union(const b:HashTab);                         //与另一个Hash表合并
  function isnil:boolean;                                   //返回Hash表是否为空
 end;

 Heap=object                                                //Heap(堆)
  size,bias:longint;                                        //size堆大小，bias偏移量
  comp:boolean;                                             //比较器，false则小根堆，true则大根堆
  h:Vector;                                                 //堆本体
  procedure setcmp(z:boolean);                              //设定比较器，setcmp(Less)则小根堆，setcmp(Greater)则大根堆
  procedure clear;                                          //清空
  procedure add(x:longint);                                 //整体加值x
  procedure push(x:longint);                                //添加数x
  procedure pop;                                            //弹出堆顶
  function top:longint;                                     //读取堆顶
  function isnil:boolean;                                   //返回堆是否为空
 end;

 DeleteHeap=object                                          //DeleteHeap(可删堆)
  A,B:Heap;                                                 //A表示加堆，B表示减堆
  procedure clear;                                          //清空
  procedure update;                                         //更新
  procedure add(x:longint);                                 //整体加值x
  procedure push(x:longint);                                //添加数x
  procedure pop;                                            //弹出堆顶
  procedure delete(x:longint);                              //删除数x（一次）
  function top:longint;                                     //返回堆顶
  function isnil:boolean;                                   //返回可删堆是否为空
 end;

 Stack=object                                               //Stack(栈)
  sta:Vector;                                               //栈本体
  procedure clear;                                          //清空
  procedure push(x:longint);                                //入栈数x
  procedure pop;                                            //弹出栈顶
  function size:longint;                                    //返回栈大小
  function top:longint;                                     //返回栈顶
  function isnil:boolean;                                   //返回栈是否为空
 end;

 Treap=object                                               //Treap(树堆——平衡树)
  root,size,tot:longint;                                    //root树根，size树大小
  va,sm,ct,db,ls,rs,rd:Vector;                              //va值，sm和，ct个数，db重复个数，ls左子树，rs右子树
  private
   procedure pu(k:longint);                                 //更新
   procedure rr(var k:longint);                             //zig-zag
   procedure lr(var k:longint);                             //zig-zag
  public
   procedure clear;                                         //清空
   procedure insert(x:longint);                             //插入数x
   procedure delete(x:longint);                             //删除数x（一次）
   function count(x:longint):longint;                       //统计数x个数
   function lower(x:longint):longint;                       //返回比x小的最大值
   function upper(x:longint):longint;                       //返回比x大的最小值
   function askrank(x:longint):longint;                     //返回x的排名
   function getrank(x:longint):longint;                     //返回排名x的数
   function getsum(l,r:longint):longint;                    //返回排名l..r的数的和
   function isnil:boolean;                                  //返回树堆是否为空
 end;

 Splay=object                                               //Splay(伸展树——平衡树)
  root,size,tot:longint;                                    //root树根，size树大小
  fa,va,sm,ct,ad,tm,cg,ad_tg,tm_tg,cg_tg,rv:Vector;         //fa父亲，va值，sm和，ct个数，ad_tg添加标记，ad添加值，tm_tg乘法标记，tm乘法值，cg_tg赋值标记，cg赋值值，rv反转标记
  sn:array[0..1]of Vector;                                  //sn[0]左儿子，sn[1]右儿子
//tp:Stack;
  private
// function isroot(x:longint):boolean;
   procedure _ad(x,y:longint);                              //为x子树添加y
   procedure _tm(x,y:longint);                              //为x子树乘以y
   procedure _cg(x,y:longint);                              //为x子树赋值y
   procedure _rv(x:longint);                                //为x子树反转
   procedure pu(x:longint);                                 //更新
   procedure pd(x:longint);                                 //下放标记
   procedure rotate(x:longint;var k:longint);               //zig-zag
   procedure splay(x:longint;var k:longint);                //把x置为树根
   procedure split(l,r:longint);                            //提取[l,r]区间，置于root的右儿子的左儿子
   function newnode(x:longint):longint;                     //创建新结点
   function sk(k,x:longint):longint;                        //搜索序列第x的结点
   function build(const a:array of longint;s,t:longint):longint; //为序列a创建准完全二叉树的splay
  public
   procedure clear;                                         //清空
   procedure insert(p,x:longint);                           //在p位置前插入数x
   procedure insert(p:longint;const a:array of longint);    //在p位置前插入序列a
   procedure delete(p,x:longint);                           //删除p位置开始x个数
   procedure change(l,r,x:longint);                         //将l..r赋值为x
   procedure add(l,r,x:longint);                            //将l..r加x
   procedure multiply(l,r,x:longint);                       //将l..r乘x
   procedure reverse(l,r:longint);                          //将l..r反转
   function sum(l,r:longint):longint;                       //求l..r的和
   function isnil:boolean;                                  //返回伸展树是否为空
 end;

 TreeArray=object                                           //TreeArray(树状数组)
  size:longint;                                             //树状数组大小
  f:vector;                                                 //树状数组本体
  procedure setsize(n:longint);                             //设定树状数组大小
  procedure add(x,y:longint);                               //为x添加y
  function sum(x:longint):longint;                          //求前缀和1..x
  function isnil:boolean;                                   //返回树状数组是否为空
 end;

 UnionFind=object                                           //UnionFind(并查集)
  a:HashTab;                                                //离散化数值
  fa:Vector;                                                //父亲指向
  function father(x:longint):longint;                       //求x的祖先
  procedure clear;                                          //清空
  procedure union(u,v:longint);                             //合并u、v
  function find(u,v:longint):boolean;                       //询问u、v是否在一个连通块中
 end;



operator +(const a,b:Vector)c:Vector;

procedure sort(l,r:pint);                                   //对longint数组快速排序成递增
procedure sort(l,r:pint;comp:boolean);                      //对longint数组快速排序，comp=Less为递增，comp=Greater为递减
function unique(l,r:pint):longint;                          //对longint数组相邻的相同元素去重，返回去重后长度
function lower(s,t:pint;x:longint):longint;                 //对longint数组二分，返回小于x的最大值
function upper(s,t:pint;x:longint):longint;                 //对longint数组二分，返回大于x的最小值
function lower_equal(s,t:pint;x:longint):longint;           //对longint数组二分，返回小于等于x的最大值
function upper_equal(s,t:pint;x:longint):longint;           //对longint数组二分，返回大于等于x的最小值


implementation


function max(a,b:longint):longint;
begin if a>b then exit(a); exit(b) end;

function min(a,b:longint):longint;
begin if a>b then exit(b); exit(a) end;

procedure sw(var a,b:longint);
var c:longint; begin c:=a; a:=b; b:=c end;


function cmp(a,b:longint;z:boolean):boolean;
begin exit((a<b)xor z) end;



procedure sort(l,r:pint;comp:boolean);
var i,j:pint; m:longint;
begin
 if r-l<15 then
 begin
  i:=l;   while i<r do  begin
  j:=i+1; while j<=r do begin
   if cmp(j^,i^,comp) then sw(i^,j^);
  inc(j) end;
  inc(i) end;
  exit
 end;
 i:=l; j:=r; m:=(l+random(r-l+1))^;
 repeat
  while cmp(i^,m,comp) do inc(i);
  while cmp(m,j^,comp) do dec(j);
  if i<=j then begin sw(i^,j^); inc(i); dec(j) end
 until i>j;
 if i<r then sort(i,r,comp);
 if l<j then sort(l,j,comp)
end;

procedure sort(l,r:pint);
begin
 sort(l,r,Less)
end;

function unique(l,r:pint):longint;
var n:longint; i:pint;
begin
 if l>r then exit(0);
 n:=1;
 i:=l+1;
 while i<=r do
 begin
  if i^<>(i-1)^ then begin (l+n)^:=i^; inc(n) end;
  inc(i)
 end;
 exit(n)
end;

function lower(s,t:pint;x:Longint):longint;
var l,r,m:longint;
begin
 l:=0; r:=t-s;
 while l<r do
 begin
  m:=(l+r+1)>>1;
  if (s+m)^<x then l:=m
              else r:=m-1
 end;
 exit(l+1)
end;

function upper(s,t:pint;x:Longint):longint;
var l,r,m:longint;
begin
 l:=0; r:=t-s;
 while l<r do
 begin
  m:=(l+r)>>1;
  if (s+m)^>x then r:=m
              else l:=m+1
 end;
 exit(l+1)
end;

function lower_equal(s,t:pint;x:Longint):longint;
var l,r,m:longint;
begin
 l:=0; r:=t-s;
 while l<r do
 begin
  m:=(l+r+1)>>1;
  if (s+m)^<=x then l:=m
               else r:=m-1
 end;
 exit(l+1)
end;

function upper_equal(s,t:pint;x:Longint):longint;
var l,r,m:longint;
begin
 l:=0; r:=t-s;
 while l<r do
 begin
  m:=(l+r)>>1;
  if (s+m)^>=x then r:=m
               else l:=m+1
 end;
 exit(l+1)
end;

 procedure Vector.resize(n:longint);
 var m:longint;
 begin
  m:=max(n+1,8); while m<>m and(-m) do inc(m,m and(-m));
  setlength(a,m);
  if n>size then fill(size+1,n,0);
  size:=n
 end;

 procedure Vector.clear;
 begin
  resize(0)
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
  if size-p-n+1>0 then
  Move(a[p],a[p+n],(size-p-n+1)<<2);
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

 function Vector.clone(l,r:longint):Vector;
 var t:Vector;
 begin
  if l<1    then l:=1;
  if r>size then r:=size;
  if l>r then begin t.size:=0; exit(t) end;
  t.size:=r-l+1;
  setlength(t.a,t.size+5); t.a[0]:=0;
  Move(a[l],t.a[1],(size+1)<<2);
  exit(t)
 end;

 procedure Vector.discretization(l,r:longint);
 var b:Vector; i:longint;
 begin
  b:=clone(l,r);
  for i:=1 to b.size do write(b.a[i],' '); writeln;
  sort(b.head,b.tail);
  for i:=1 to b.size do write(b.a[i],' '); writeln;
  b.size:=unique(b.head,b.tail);
  for i:=1 to b.size do write(b.a[i],' '); writeln;
  for i:=l to r do write(a[i],' '); writeln;
  for i:=l to r do a[i]:=lower_equal(b.head,b.tail,a[i]);
 end;

 function Vector.head:pint;
 begin
  exit(@a[1])
 end;

 function Vector.tail:pint;
 begin
  exit(@a[size])
 end;

 function Vector.isnil:boolean;
 begin
  exit(size=0)
 end;

 operator +(const a,b:Vector)c:Vector;
 begin
  c.resize(0);
  c.insert(1,a);
  c.insert(a.size+1,b)
 end;

 function BitSet.ct1(x:longint):longint;
 begin
  x:=(x and $55555555)+((x>>1)and $55555555);
  x:=(x and $33333333)+((x>>2)and $33333333);
  x:=(x and $0f0f0f0f)+((x>>4)and $0f0f0f0f);
  x:=(x and $00ff00ff)+((x>>8)and $00ff00ff);
  x:=(x and $0000ffff)+((x>>16)and $0000ffff);
  exit(x)
 end;

 procedure BitSet.clear;
 begin
  size:=0;
  len:=0
 end;

 procedure BitSet.resize(n:longint);
 begin
  size:=n;
  len:=(size-1)>>5+1;
  if high(a)+1<len then setlength(a,len);
  fillchar(a[0],len<<2,0)
 end;

 procedure BitSet.pushback(const s:ansistring);
 var i:longint;
 begin
  for i:=1 to length(s) do pushback(s[i])
 end;

 procedure BitSet.pushback(x:char);
 begin
  inc(size);
  if size and 31=1 then
  begin
   inc(len);
   if high(a)<len then setlength(a,len<<1);
   a[len-1]:=ord(x)and 1
  end
  else
   a[len-1]:=a[len-1]or longint(ord(x)and 1)<<((size-1)and 31)
 end;

 procedure BitSet.convert(const s:ansistring);
 var i,j:longint;
 begin
  resize(length(s));
  for i:=0 to len-1 do
  for j:=i<<5+1 to min((i+1)<<5,length(s)) do
   a[i]:=a[i]or (ord(s[j])and 1)<<((j-1)and 31)
 end;

 procedure BitSet.set0(l,r:longint);
 var i,pl,pr:longint;
 begin
  if l>r then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  pl:=(l-1)>>5;
  pr:=(r-1)>>5;
  l:=(l-1)and 31+1;
  r:=(r-1)and 31+1;
  if pl=pr then
   a[pl]:=a[pl]and(((1<<(r-l+1)-1)<<(l-1))xor(-1))
  else
  begin
   for i:=pl+1 to pr-1 do a[i]:=0;
   a[pl]:=a[pl]and(1<<(l-1)-1);
   a[pr]:=a[pr]>>r<<r
  end
 end;

 procedure BitSet.set1(l,r:longint);
 var i,pl,pr:longint;
 begin
  if l>r then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  pl:=(l-1)>>5;
  pr:=(r-1)>>5;
  l:=(l-1)and 31+1;
  r:=(r-1)and 31+1;
  if pl=pr then
   a[pl]:=a[pl]or((1<<(r-l+1)-1)<<(l-1))
  else
  begin
   for i:=pl+1 to pr-1 do a[i]:=-1;
   a[pl]:=a[pl]or((1<<(33-l)-1)<<(l-1));
   a[pr]:=a[pr]or(1<<r-1)
  end
 end;

 procedure BitSet.reverse(l,r:longint);
 var i,pl,pr:longint;
 begin
  if l>r then exit;
  if l<1 then l:=1;
  if r>size then r:=size;
  pl:=(l-1)>>5;
  pr:=(r-1)>>5;
  l:=(l-1)and 31+1;
  r:=(r-1)and 31+1;
  if pl=pr then
   a[pl]:=a[pl]xor((1<<(r-l+1)-1)<<(l-1))
  else
  begin
   for i:=pl+1 to pr-1 do a[i]:=not a[i];
   a[pl]:=a[pl]xor((1<<(33-l)-1)<<(l-1));
   a[pr]:=a[pr]xor(1<<r-1)
  end
 end;

 function BitSet.pos(x:longint):longint;
 begin
  if (x<1)or(x>size) then exit(-1);
  exit((a[(x-1)>>5]>>((x-1)and 31))and 1)
 end;

 function BitSet.copy(l,r:longint):ansistring;
 var i:longint;
 begin
  if l>r then exit('');
  if l<1    then l:=1;
  if r>size then r:=size;
  copy:='';
  for i:=l to r do copy:=copy+chr(pos(i)+48)
 end;

 function BitSet.count1(l,r:longint):longint;
 var i,pl,pr:longint;
 begin
  if l>r then exit(0);
  if l<1    then l:=1;
  if r>size then r:=size;
  pl:=(l-1)>>5;
  pr:=(r-1)>>5;
  if pl=pr then exit(ct1((a[pl]and(1<<r-1))>>(l-1)));
  count1:=0;
  for i:=pl+1 to pr-1 do inc(count1,ct1(a[i]));
  inc(count1,a[pl]>>(l-1));
  inc(count1,a[pr]and(1<<r-1))
 end;

 function BitSet.count0(l,r:longint):longint;
 begin
  if l>r then exit(0);
  if l<1    then l:=1;
  if r>size then r:=size;
  exit(r-l+1-count1(l,r))
 end;

 function BitSet.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure HashTab.clear;
 begin
  size:=0;
  hashsize:=0;
  head.clear;
  next.clear;
  node.clear;
  numb.clear
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
  h.clear
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
  va.clear;
  sm.clear;
  ct.clear;
  db.clear;
  ls.clear;
  rs.clear;
  rd.clear
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
  sta.clear
 end;

 procedure Stack.push(x:longint);
 begin
  sta.pushback(x)
 end;

 procedure Stack.pop;
 begin
  sta.delete(sta.size,1);
 end;

 function Stack.size:longint;
 begin
  exit(sta.size)
 end;

 function Stack.top:longint;
 begin
  exit(sta.a[sta.size])
 end;

 function Stack.isnil:boolean;
 begin
  exit(sta.isnil)
 end;
{
 function Splay.isroot(x:longint):boolean;
 var y:longint;
 begin
  y:=fa.a[x]; if y=0 then exit(true);
  exit((sn[0].a[y]<>x)and(sn[1].a[y]<>x))
 end;
}
 procedure Splay._ad(x,y:longint);
 begin
  ad_tg.a[x]:=1;
  inc(ad.a[x],y);
  inc(va.a[x],y);
  inc(sm.a[x],ct.a[x]*y)
 end;

 procedure Splay._tm(x,y:longint);
 begin
  if ad_tg.a[x]=1 then ad.a[x]:=ad.a[x]*y;
  tm_tg.a[x]:=1;
  tm.a[x]:=tm.a[x]*y;
  va.a[x]:=va.a[x]*y;
  sm.a[x]:=sm.a[x]*y
 end;

 procedure Splay._cg(x,y:longint);
 begin
  if ad_tg.a[x]=1 then begin ad.a[x]:=0; ad_tg.a[x]:=0 end;
  if tm_tg.a[x]=1 then begin tm.a[x]:=1; tm_tg.a[x]:=0 end;
  cg_tg.a[x]:=1;
  cg.a[x]:=y;
  va.a[x]:=y;
  sm.a[x]:=ct.a[x]*y
 end;

 procedure Splay._rv(x:longint);
 begin
  rv.a[x]:=1-rv.a[x];
  sw(sn[0].a[x],sn[1].a[x])
 end;

 procedure Splay.pu(x:longint);
 var l,r:longint;
 begin
  l:=sn[0].a[x]; r:=sn[1].a[x];
  ct.a[x]:=1;
  sm.a[x]:=va.a[x];
  if l<>0 then begin inc(sm.a[x],sm.a[l]); inc(ct.a[x],ct.a[l]) end;
  if r<>0 then begin inc(sm.a[x],sm.a[r]); inc(ct.a[x],ct.a[r]) end
 end;

 procedure Splay.pd(x:longint);
 var l,r:longint;
 begin
  l:=sn[0].a[x]; r:=sn[1].a[x];
  if cg_tg.a[x]=1 then
  begin
   if l<>0 then _cg(l,cg.a[x]);
   if r<>0 then _cg(r,cg.a[x]);
   cg_tg.a[x]:=0
  end;
  if tm_tg.a[x]=1 then
  begin
   if l<>0 then _tm(l,tm.a[x]);
   if r<>0 then _tm(r,tm.a[x]);
   tm.a[x]:=1;
   tm_tg.a[x]:=0
  end;
  if ad_tg.a[x]=1 then
  begin
   if l<>0 then _ad(l,ad.a[x]);
   if r<>0 then _ad(r,ad.a[x]);
   ad.a[x]:=0;
   ad_tg.a[x]:=0
  end;
  if rv.a[x]=1 then
  begin
   if l<>0 then _rv(l);
   if r<>0 then _rv(r);
   rv.a[x]:=0
  end
 end;

 procedure Splay.rotate(x:longint;var k:longint);
 var y,z,p:longint;
 begin
  y:=fa.a[x]; z:=fa.a[y]; p:=ord(sn[1].a[y]=x);
  if y=k then k:=x else sn[ord(sn[1].a[z]=y)].a[z]:=x;
  fa.a[y]:=x; fa.a[x]:=z; fa.a[sn[1-p].a[x]]:=y;
  sn[p].a[y]:=sn[1-p].a[x]; sn[1-p].a[x]:=y;
  pu(y); //pu(x)
 end;

 procedure Splay.splay(x:longint;var k:longint);
 var y,z:longint;
 begin
  {
  tp.clear; tp.push(x); y:=x;
  while y<>k do begin y:=fa.a[y]; tp.push(y) end;
  while not tp.isnil do begin pd(tp.top); tp.pop end;
  }
  while x<>k do
  begin
   y:=fa.a[x]; z:=fa.a[y];
   if y<>k then
   if (sn[0].a[y]=x)xor(sn[0].a[z]=y) then rotate(x,k)
                                      else rotate(y,k);
   rotate(x,k)
  end;
  pu(x)
 end;

 function Splay.sk(k,x:longint):longint;
 var t:longint;
 begin
  pd(k);
  if sn[0].a[k]=0 then t:=1 else t:=ct.a[sn[0].a[k]]+1;
  if x=t then exit(k);
  if x<t then exit(sk(sn[0].a[k],x));
  exit(sk(sn[1].a[k],x-t))
 end;

 procedure Splay.split(l,r:longint);
 begin
  splay(sk(root,l),root);
  splay(sk(root,r+2),sn[1].a[root])
 end;

 function Splay.newnode(x:longint):longint;
 begin
  inc(tot);
  fa.pushback(0);
  va.pushback(x);
  sm.pushback(x);
  ct.pushback(1);
  ad.pushback(0); ad_tg.pushback(0);
  tm.pushback(1); tm_tg.pushback(0);
  cg.pushback(0); cg_tg.pushback(0);
  rv.pushback(0);
  sn[0].pushback(0);
  sn[1].pushback(0);
  exit(tot)
 end;

 procedure Splay.clear;
 begin
  root:=0;
  size:=0;
  tot:=0;
  fa.clear;
  va.clear;
  sm.clear;
  ct.clear;
  ad.clear; ad_tg.clear;
  tm.clear; tm_tg.clear;
  cg.clear; cg_tg.clear;
  rv.clear;
  sn[0].clear;
  sn[1].clear
 end;

 procedure Splay.insert(p,x:longint);
 var t:longint;
 begin
  if (p<1)or(p>size+1) then exit;
  if isnil then
  begin
   inc(size);
   root:=newnode(x);
   t:=newnode(0); sn[0].a[root]:=t; fa.a[t]:=root;
   t:=newnode(0); sn[1].a[root]:=t; fa.a[t]:=root
  end
  else
  begin
   inc(size);
   split(p,p-1);
   t:=newnode(x);
   sn[0].a[sn[1].a[root]]:=t;
   fa.a[t]:=sn[1].a[root];
   pu(sn[1].a[root]);
   pu(root);
   splay(sk(root,random(size)+1),root)
  end
 end;

 function Splay.build(const a:array of longint;s,t:longint):longint;

  function bd(l,r:longint):longint;
  var m,t:longint;
  begin
   if l>r then exit(0);
   if l=r then exit(newnode(a[l]));
   m:=(l+r)>>1;
   bd:=newnode(a[m]);
   t:=bd(l,m-1); if t<>0 then begin sn[0].a[bd]:=t; fa.a[t]:=bd end;
   t:=bd(1+m,r); if t<>0 then begin sn[1].a[bd]:=t; fa.a[t]:=bd end;
   pu(bd)
  end;

 begin
  exit(bd(s,t))
 end;

 procedure Splay.insert(p:longint;const a:array of longint);
 var t:longint;
 begin
  if (p<1)or(p>size+1) then exit;
  t:=build(a,0,high(a));
  if isnil then
  begin
   inc(size,high(a)+1);
   root:=newnode(0);
   sn[1].a[root]:=newnode(0);
   fa.a[sn[1].a[root]]:=root;
   sn[0].a[sn[1].a[root]]:=t;
   fa.a[t]:=sn[1].a[root];
   pu(sn[1].a[root]);
   pu(root)
  end
  else
  begin
   inc(size,high(a)+1);
   split(p,p-1);
   sn[0].a[sn[1].a[root]]:=t;
   fa.a[t]:=sn[1].a[root];
   pu(sn[1].a[root]);
   pu(root);
   splay(sk(root,random(size)+1),root)
  end
 end;

 procedure Splay.delete(p,x:longint);
 begin
  if (p>size)or(x=0) then exit;
  if p+x-1>size then x:=size-p+1;
  dec(size,x);
  split(p,p+x-1);
  sn[0].a[sn[1].a[root]]:=0;
  pu(sn[1].a[root]);
  pu(root)
 end;

 procedure Splay.change(l,r,x:longint);
 var t:longint;
 begin
  if (l>r)or(l>size) then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  split(l,r);
  t:=sn[0].a[sn[1].a[root]];
  pd(t);
  _cg(t,x);
  pu(sn[1].a[root]);
  pu(root)
 end;

 procedure Splay.add(l,r,x:longint);
 var t:longint;
 begin
  if (l>r)or(l>size) then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  split(l,r);
  t:=sn[0].a[sn[1].a[root]];
  pd(t);
  _ad(t,x);
  pu(sn[1].a[root]);
  pu(root)
 end;

 procedure Splay.multiply(l,r,x:longint);
 var t:longint;
 begin
  if (l>r)or(l>size) then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  split(l,r);
  t:=sn[0].a[sn[1].a[root]];
  pd(t);
  _tm(t,x);
  pu(sn[1].a[root]);
  pu(root)
 end;

 procedure Splay.reverse(l,r:longint);
 var t:longint;
 begin
  if (l>r)or(l>size) then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  split(l,r);
  t:=sn[0].a[sn[1].a[root]];
  pd(t);
  _rv(t);
  pu(sn[1].a[root]);
  pu(root)
 end;

 function Splay.sum(l,r:longint):longint;
 begin
  if (l>r)or(l>size) then exit;
  if l<1    then l:=1;
  if r>size then r:=size;
  split(l,r);
  exit(sm.a[sn[0].a[sn[1].a[root]]])
 end;

 function Splay.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure TreeArray.setsize(n:longint);
 begin
  size:=n;
  f.resize(n);
  f.fill(1,n,0)
 end;

 procedure TreeArray.add(x,y:longint);
 begin
  if x<1 then exit;
  while x<=size do
  begin
   inc(f.a[x],y);
   inc(x,x and(-x))
  end
 end;

 function TreeArray.sum(x:longint):longint;
 begin
  sum:=0;
  while x>0 do
  begin
   inc(sum,f.a[x]);
   dec(x,x and(-x))
  end
 end;

 function TreeArray.isnil:boolean;
 begin
  exit(size=0)
 end;

 procedure UnionFind.clear;
 begin
  a.clear;
  fa.clear
 end;

 function UnionFind.father(x:longint):longint;
 var y:longint;
 begin
  y:=a.find(x);
  if y=-1 then exit(x);
  if x<>fa.a[y] then fa.a[y]:=father(fa.a[y]);
  exit(fa.a[y])
 end;

 procedure UnionFind.union(u,v:longint);
 var y,z:longint;
 begin
  y:=a.find(u); if y=-1 then begin a.insert(u); fa.pushback(u); y:=fa.size end;
  z:=a.find(v); if z=-1 then begin a.insert(v); fa.pushback(v); z:=fa.size end;
  fa.a[a.find(father(u))]:=fa.a[a.find(father(v))]
 end;

 function UnionFind.find(u,v:longint):boolean;
 begin
  if (a.find(u)=-1)or(a.find(v)=-1) then exit(false);
  exit(father(u)=father(v))
 end;

begin
end.