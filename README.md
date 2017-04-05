# StructUnit    
    
◆Pascal的数据结构库    

*2017/03/29 添加*     
>>◀Vector▶    
>>◀HashTab▶    

*2017/03/30 添加*     
>>◀Heap▶  
>>◀DeleteHeap▶   
>>◀Treap▶   

*2017/4/4 添加*      
>>◀Stack▶  
>>◀BitSet▶  
>>◀Splay▶   
>>◀TreeArray▶   

*2017/4/5 添加*     
>>◀UnionFind▶   
     
# 队列    
```
uses StructUnit;
var
 a,b:Vector;
 i:longint;
begin
 a.pushback(5);          //在队列后添加元素5，队列变成[5]
 a.insert(1,[2,6,2,0]);  //在队列位置1处插入序列，队列变成[2,6,2,0,5]
 a.fill(5,6,10);         //将队列5..6位置赋值成10，由于6位置超过了队列长度故不计，队列变成[2,6,2,0,10]
 a.discretization(1,4);  //将队列1..4位置离散化，队列变成[2,3,2,1,10]
 sort(a.head,a.tail);    //将队列排序，head是头指针，tail是尾指针，这句话等价于sort(@a.a[1],@a.a[a.size]);，
                         //队列变成[1,2,2,3,10]
 b:=a.clone(1,a.size);   //复制队列a的所有到队列b，注意请勿使用b:=a;语句
 for i:=1 to b.size do write(b.a[i],' ')  //从头到尾遍历一遍b队列的元素，并依次输出
end.
```
要注意的是：Vector的插入、删除、填充都是O(n)的，离散化是O(nlogn)的。    
# 哈希表    
```
uses StructUnit;
var
 a,b:HashTab;
begin
 for i:=1 to 100000 do a.insert(i mod 233);  //往a插入100000个元素
 writeln(a.count(5));                        //输出5的个数，1~100000中mod 233=5的有430个
 for i:=1 to 100000 do b.insert(i mod 666);  //往b插入100000个元素
 writeln(b.count(5));                        //输出5的个数，1~100000中mod 666=5的有151个
 b.delete(5);                                //在b中删除1个"5"
 writeln(b.count(5));                        //输出结果是150
 a.union(b);                                 //把b合并到a上
 writeln(a.count(5));                        //输出结果是580
end.
```
要注意的是：HashTab的插入、查询都是期望O(1)的，合并是O(n)的，HashTab所占内存与插入元素成比例    
# 堆    
```
uses StructUnit;
var
 a:Heap;
begin
 a.push(5);
 a.push(10);
 a.push(12);
 a.push(2);                     //往堆中依次添加5,10,12,2
 while not a.isnil do           //当堆不为空
 begin
  write(a.top,' ');             //输出堆顶（最小值）
  a.pop                         //弹出堆顶
 end;
 writeln;                       //输出结果是2 5 10 12
 a.setcmp(Greater);             //设置为大根堆，a.setcmp(Less)是小根堆，默认为小根堆
 a.push(15);                    
 a.push(16);
 a.push(18);                    //往堆中依次添加15,16,18
 a.add(-4);                     //堆中元素整体-4，即堆中元素变成11,12,14
 a.push(5);
 a.push(13);                    //再往堆中添加5,13
 while not a.isnil do
 begin
  write(a.top,' ');
  a.pop
 end;                           //输出结果是14 13 12 11 5
end.
```
要注意的是：插入、弹堆顶是O(logn)的，整体加数是O(1)的    
# 树堆    
```
uses StructUnit;
var
 a:Treap;
begin
 a.insert(5);
 a.insert(10);
 a.insert(12);
 a.insert(7);
 a.insert(12);              //往Treap中添加5,10,12,7,12，Treap中排列成有序的[5,7,10,12,12]
 writeln(a.count(5));       //输出5的个数，输出结果为1
 writeln(a.count(12));      //输出12的个数，输出结果为2
 writeln(a.lower(6));       //输出比6小的最大值，输出结果为5
 writeln(a.upper(10));      //输出比10大的最小值，输出结果为12
 writeln(a.askrank(7));     //输出7的排名，输出结果为2
 a.insert(1);               //添加1，Treap中为[1,5,7,10,12,12]
 writeln(a.askrank(7));     //输出7的排名，输出结果为3
 writeln(a.getrank(4));     //输出排名第4的数，输出结果为10
 a.delete(5);               //删除5，Treap中为[1,7,10,12,12]
 writeln(a.getrank(4));     //输出排名第4的数，输出结果为12
end.
```
要注意的是：插入、删除、统计、查询是O(logn)的，插入数的和太大会爆longint    
# 伸展树     
```
uses StructUnit;
var
 a:Splay;
begin
 a.insert(1,[1,10,6,7,2]);   //往splay的位置1前插入序列，Splay中为[1,10,6,7,2]
 a.insert(3,10);             //往splay的位置3前插入10，Splay中为[1,10,10,6,7,2]
 a.reverse(2,4);             //位置2..3反转，Splay中为[1,6,10,10,7,2]
 a.add(1,4,20);              //位置1..4加20，Splay中为[21,26,30,30,7,2]
 a.multiply(2,3,2);          //位置2..3乘2，Splay中为[21,52,60,30,7,2]
 a.change(3,6,0);            //位置3..6赋为0，Splay中为[21,52,0,0,0,0]
 a.delete(2,3);              //从位置2起删除3个，Splay中为[21,0,0]
 writeln(a.sum(1,5))         //输出1..5的和，由于只有3个数，所以输出1..3的和21
end.
```
要注意的是：所有单次操作期望O(logn)，但Splay常数比较大会慢，操作结果的和太大会爆longint    
# 并查集    
```
uses StructUnit;
var
 a:UnionFind;
begin
 a.union(1000000000,2);            //把1e9和2合并成一个连通块
 writeln(a.find(2,1));             //询问1、2是否连通？输出FALSE
 writeln(a.find(2,1000000000))     //询问1e9、2是否连通？输出TRUE
end.
```
要注意的是：合并、查询期望O(log\*n)，操作值在longint内都是可以的    
# 其他    
```
uses StructUnit;
var
 a:Vector;
 b:array[1..10]of longint;
 n,i:longint;
begin
 a.insert(3,[10,6,-1]);                    //往队列位置3前插入序列，由于1..2没有定义都为0，a=[0,0,10,6,-1]
 sort(a.head,a.tail);                      //对a排序，结果为[-1,0,0,6,10]
 b[1]:=10;
 b[2]:=5;
 b[3]:=1;
 b[4]:=2;
 b[5]:=9;
 b[6]:=2;
 b[7]:=4;
 b[8]:=12;
 b[9]:=0;
 b[10]:=6;                                 //数组b为[10,5,1,2,9,2,4,12,0,6]
 sort(@b[1],@b[10]);                       //对数组b的1..10排序，结果为[0,1,2,2,4,5,6,9,10,12]
 n:=unique(@b[1],@b[10]);                  //对数组b的1..10去重，n=9，b=[0,1,2,4,5,6,9,10,12]
 writeln(lower(@b[1],@b[10],8));           //输出数组b的1..10中比8小的最大值，输出结果为6
 writeln(lower(@b[1],@b[10],6));           //输出数组b的1..10中比6小的最大值，输出结果为5
 writeln(lower_equal(@b[1],@b[10],6));     //输出数组b的1..10中不大于6的最大值，输出结果为6
end.
```

###  尽量使用外部提供的函数/过程，莫轻易修改内部数据
