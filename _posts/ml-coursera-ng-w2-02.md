---
title: Coursera Week 2 - Octave learning
toc: true
date: 2016-10-12 10:28:21
categories: machine-learning
tags: machine-learning
description: coursera week 2 - octave learning
mathjax: true
---

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX"],
    tex2jax: {
      inlineMath: [ ['$','$'], ['\\(','\\)'] ],
      displayMath: [ ['$$','$$']],
      processEscapes: true
    }
  });
</script>
<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML,http://myserver.com/MathJax/config/local/local.js">
</script>

Octave Tutorial, Octave Learning

## 1. var

> 不像matlab有图形界面，octave只提供了命令行接口。 要启动octave，只需要在命令行输入octave即可。

```matlab
>> 2 * (3 + 5)
ans =  16
>> 2 ^ (3 + 5)
ans =  256
>> x = 2 * 3
x =  6
>> who
Variables in the current scope:

ans  x

>> disp(x)
 6
>>
```

## 2. constant

```matlab
> pi
ans =  3.1416
>> e
ans =  2.7183
>> format long
>> pi
ans =  3.14159265358979
>> format short
>> pi
ans =  3.1416
>>
```

> octave系统定义了圆周率pi和自然指数e这两个常量, octave 可以定义显示结果

```matlab
>> 3/0
warning: division by zero
ans = Inf
>> 0/0
warning: division by zero
ans = NaN
>>
```

> 系统定义了Inf和NaN（注意要区分大小写）。Inf(Infinity)表示被零除的结果，NaN(Not a Number)表示零除零的结果。

## 3. workspace

使用save命令保存当前工作区到文件 work1

```matlab
>> save work1
>> load work1
>> pi
ans =  3.1416
```

## 4. semicolon

```matlab
octave:32> x = 2 * 3
x =  6
octave:33> x = 2 * 3;
octave:34> disp(x)
 6
```

## 5. matrix

矩阵使用方括号([])括起来，维度使用分号(;)分割。 同一维度之间的分隔符可以是空格或逗号(,)

```matlab
octave:35> x = [ 2 3 5 ]
x =

   2   3   5

octave:36> y = [ 2, 3, 5 ]
y =

   2   3   5

octave:37> z = [ 2; 3; 5 ]
z =

   2
   3
   5

octave:39> a = [ 1 2; 1, 3; 1   5 ]
a =

   1   2
   1   3
   1   5
```

使用冒号表达式快速构造连续的向量

```matlab
octave:43> v = 2:5
v =

   2   3   4   5
   
octave:44> v = 2:0.3:3
v =

    2.0000    2.3000    2.6000    2.9000
```

构造矩阵的函数

> `linspace(start, end, N)` 产生N个均匀分布于start和end之间的向量。 在绘图时用于产生x坐标特别有用。

> `logspace(start, end, N)` 产生N个指数分布于10^start和10^end之间的向量。 在绘图时用于产生x坐标特别有用。

> zeros(M, N)

> zeros(N) = zeros(N, N)。

> ones(M, N)

> ones(N) = ones(N, N)。

> rand(M, N) 值位于0~1的随机数的矩阵。

> rand(N) = rand(N, N)。

```matlab
octave:66> x = linspace (3, 4, 5)
x =

 Columns 1 through 4:

   3.00000000000000   3.25000000000000   3.50000000000000   3.75000000000000

 Column 5:

   4.00000000000000

octave:67> logspace (1, 2, 6)
ans =

 Columns 1 through 4:

    10.0000000000000    15.8489319246111    25.1188643150958    39.8107170553497

 Columns 5 and 6:

    63.0957344480193   100.0000000000000
```

## 6. matrix operation

```matlab
A + B
A - B
A * B
A \ B
```

说明：A\B为矩阵左除，用于求解线性方程Wx=b，其中W为一个nxn的矩阵，b为一个n维的列向量。 求解线性方式示例：

```matlab
octave:15> W = [1 1 1 1; 1 2 3 4; 3 4 6 2; 2 7 10 5];
octave:16> b = [3; 5; 5; 8];
octave:17> x = W\b
x =

   1.0000
   3.0000
  -2.0000
   1.0000
```

**6.1 matrix transpose**

```matlab
octave:9> x = rand(3)
x =

   0.0052581   0.4446771   0.3970036
   0.7844458   0.3317067   0.9633000
   0.0577080   0.9015905   0.0344771

octave:10> x'
ans =

   0.0052581   0.7844458   0.0577080
   0.4446771   0.3317067   0.9015905
   0.3970036   0.9633000   0.034477
```

## 7. plotting

```matlab
>> t=[0:0.01:0.98];
>> t
t =

 Columns 1 through 10:

   0.00000   0.01000   0.02000   0.03000   0.04000   0.05000   0.06000   0.07000   0.08000   0.09000

 Columns 11 through 20:

   0.10000   0.11000   0.12000   0.13000   0.14000   0.15000   0.16000   0.17000   0.18000   0.19000

 Columns 21 through 30:

   0.20000   0.21000   0.22000   0.23000   0.24000   0.25000   0.26000   0.27000   0.28000   0.29000

 Columns 31 through 40:

   0.30000   0.31000   0.32000   0.33000   0.34000   0.35000   0.36000   0.37000   0.38000   0.39000

 Columns 41 through 50:

   0.40000   0.41000   0.42000   0.43000   0.44000   0.45000   0.46000   0.47000   0.48000   0.49000

 Columns 51 through 60:

   0.50000   0.51000   0.52000   0.53000   0.54000   0.55000   0.56000   0.57000   0.58000   0.59000

 Columns 61 through 70:

   0.60000   0.61000   0.62000   0.63000   0.64000   0.65000   0.66000   0.67000   0.68000   0.69000

 Columns 71 through 80:

   0.70000   0.71000   0.72000   0.73000   0.74000   0.75000   0.76000   0.77000   0.78000   0.79000

 Columns 81 through 90:

   0.80000   0.81000   0.82000   0.83000   0.84000   0.85000   0.86000   0.87000   0.88000   0.89000

 Columns 91 through 99:

   0.90000   0.91000   0.92000   0.93000   0.94000   0.95000   0.96000   0.97000   0.98000

>> y1=sin(2*pi*4*t);
>> plot(t,y1)
>> y2=cos(2*pi*4*t);
>> plot(t,y2)
>> hold on
>> plot(t,y1)
>> plot(t,y2,'r')
>> xlabel('time')
>> ylabel('value')
>> legend('sin','cos')
>> title('my plot')
>> print -dpng 'myPlot.png'
warning: print.m: fig2dev binary is not available.
Some output formats are not available.
```

```matlab
>> figure(2); plot(t, y2)
>> subplot(1,2,1);
>> plot(t,y1)
>> subplot(1,2,2)
>> plot(t,y2)
>> axis([0.5 1 -1 1])
```

![matric][2]


```matlab
>> clf;
>> A = magic(5)
A =

   17   24    1    8   15
   23    5    7   14   16
    4    6   13   20   22
   10   12   19   21    3
   11   18   25    2    9

>> imagesc(A)
>> imagesc(A), colorbar, colormap gray;
```

![matric][3]

```matlab
>> imagesc(magic(15)), colorbar, colormap gray;
>> a=1,b=2,c=3
a =  1
b =  2
c =  3
```

![matric][4]

## 8. ng

```matlab
>> A = [1 2; 3 4; 5 6;]
A =

   1   2
   3   4
   5   6
>> 
save hello.mat v; (压缩比例很大)
save hello.txt v -ascii % save as text(ASCII)

>> who
Variables in the current scope:

A

>> whos
Variables in the current scope:

   Attr Name        Size                     Bytes  Class
   ==== ====        ====                     =====  =====
        A           3x2                         48  double

Total is 6 elements using 48 bytes

>> clear
>> A(3,2)
ans =  6
>> A(:,2)
ans =

   2
   4
   6

>> A(2,:)
ans =

   3   4

>> A
A =

   1   2
   3   4
   5   6

>> A([1 3], :)
ans =

   1   2
   5   6

>> A(:,2)
ans =

   2
   4
   6

>> A(:,2) = [10; 11; 12]
A =

    1   10
    3   11
    5   12

>> A = [A, [100; 101; 102]];
>> A
A =

     1    10   100
     3    11   101
     5    12   102

>> [100;101;102]
ans =

   100
   101
   102

>> size(A)
ans =

   3   3

>> A(:)
ans =

     1
     3
     5
    10
    11
    12
   100
   101
   102

>> A = [1 2; 3 4; 5 6;]
A =

   1   2
   3   4
   5   6

>> B = [11 12; 13 14; 15 16]
B =

   11   12
   13   14
   15   16

>> C = [A B]
C =

    1    2   11   12
    3    4   13   14
    5    6   15   16

>> D = [A;B]
D =

    1    2
    3    4
    5    6
   11   12
   13   14
   15   16

>> size(D)
ans =

   6   2

>> [A, B]
ans =

    1    2   11   12
    3    4   13   14
    5    6   15   16

>> [A B]
ans =

    1    2   11   12
    3    4   13   14
    5    6   15   16

>>
>>
>>>> A .* B
ans =

   11   24
   39   56
   75   96

>> A .^ 2
ans =

    1    4
    9   16
   25   36

>> v = [1; 2; 3]
v =

   1
   2
   3

>> 1 ./ v
ans =

   1.00000
   0.50000
   0.33333

>> 1 ./ A
ans =

   1.00000   0.50000
   0.33333   0.25000
   0.20000   0.16667

>> log(v)
ans =

   0.00000
   0.69315
   1.09861

>> exp(v)
ans =

    2.7183
    7.3891
   20.0855

>> abs(v)
ans =

   1
   2
   3

>> abs([-1; -2; -3])
ans =

   1
   2
   3

>> V = v
V =

   1
   2
   3

>> V
V =

   1
   2
   3

>> V
V =

   1
   2
   3

>> -V
ans =

  -1
  -2
  -3

>> V + ones(length(V))
warning: operator +: automatic broadcasting operation applied
ans =

   2   2   2
   3   3   3
   4   4   4

>> length(V)
ans =  3
>> ones(3,1)
ans =

   1
   1
   1

>> V + ones(3, 1)
ans =

   2
   3
   4

>> V + 2
ans =

   3
   4
   5

>> V
V =

   1
   2
   3

>> A
A =

   1   2
   3   4
   5   6

>> A'
ans =

   1   3   5
   2   4   6

>> a  = [1 15 2 0.5]
a =

    1.00000   15.00000    2.00000    0.50000

>> val = max(a)
val =  15
>> [val, ind] = max(a)
val =  15
ind =  2
>> max(A)
ans =

   5   6

>> A
A =

   1   2
   3   4
   5   6

>> a
a =

    1.00000   15.00000    2.00000    0.50000

>> a < 3
ans =

   1   0   1   1

>> find(a < 3)
ans =

   1   3   4

>> A = magix(3)
error: 'magix' undefined near line 1 column 5
>> A = magic(3)
A =

   8   1   6
   3   5   7
   4   9   2

>> [r, c] = find(A >= 7)
r =

   1
   3
   2

c =

   1
   2
   3

>> A(2,3)
ans =  7
>> sum(a)
ans =  18.500
>> prod(a)
ans =  15
>> floor(a)
ans =

    1   15    2    0

>> ceil(a)
ans =

    1   15    2    1

>> rand(3)
ans =

   0.708800   0.905101   0.837562
   0.264139   0.265985   0.671546
   0.411435   0.058028   0.454436

>> max(rand(3), rand(3))
ans =

   0.87641   0.74541   0.92027
   0.61292   0.57756   0.95694
   0.26555   0.76822   0.63566

>> A
A =

   8   1   6
   3   5   7
   4   9   2

>> max(A, [], 1)
ans =

   8   9   7

>> max(A, [], 2)
ans =

   8
   7
   9

>> max(A)
ans =

   8   9   7

>> max(max(A))
ans =  9
>> A(:)
ans =

   8
   3
   4
   1
   5
   9
   6
   7
   2

>> max(A(:))
ans =  9
>>
>>
>> A = magic(9)
A =

   47   58   69   80    1   12   23   34   45
   57   68   79    9   11   22   33   44   46
   67   78    8   10   21   32   43   54   56
   77    7   18   20   31   42   53   55   66
    6   17   19   30   41   52   63   65   76
   16   27   29   40   51   62   64   75    5
   26   28   39   50   61   72   74    4   15
   36   38   49   60   71   73    3   14   25
   37   48   59   70   81    2   13   24   35

>> sum(A,1)
ans =

   369   369   369   369   369   369   369   369   369

>> sum(A,2)
ans =

   369
   369
   369
   369
   369
   369
   369
   369
   369

>> eye(9)
ans =

Diagonal Matrix

   1   0   0   0   0   0   0   0   0
   0   1   0   0   0   0   0   0   0
   0   0   1   0   0   0   0   0   0
   0   0   0   1   0   0   0   0   0
   0   0   0   0   1   0   0   0   0
   0   0   0   0   0   1   0   0   0
   0   0   0   0   0   0   1   0   0
   0   0   0   0   0   0   0   1   0
   0   0   0   0   0   0   0   0   1

>> A
A =

   47   58   69   80    1   12   23   34   45
   57   68   79    9   11   22   33   44   46
   67   78    8   10   21   32   43   54   56
   77    7   18   20   31   42   53   55   66
    6   17   19   30   41   52   63   65   76
   16   27   29   40   51   62   64   75    5
   26   28   39   50   61   72   74    4   15
   36   38   49   60   71   73    3   14   25
   37   48   59   70   81    2   13   24   35

>> A .* eye(9)
ans =

   47    0    0    0    0    0    0    0    0
    0   68    0    0    0    0    0    0    0
    0    0    8    0    0    0    0    0    0
    0    0    0   20    0    0    0    0    0
    0    0    0    0   41    0    0    0    0
    0    0    0    0    0   62    0    0    0
    0    0    0    0    0    0   74    0    0
    0    0    0    0    0    0    0   14    0
    0    0    0    0    0    0    0    0   35

>> sum(sum(A .* eye(9)))
ans =  369
>> flipud(eye(9))
ans =

Permutation Matrix

   0   0   0   0   0   0   0   0   1
   0   0   0   0   0   0   0   1   0
   0   0   0   0   0   0   1   0   0
   0   0   0   0   0   1   0   0   0
   0   0   0   0   1   0   0   0   0
   0   0   0   1   0   0   0   0   0
   0   0   1   0   0   0   0   0   0
   0   1   0   0   0   0   0   0   0
   1   0   0   0   0   0   0   0   0

>> sum(sum(A.*flipud(eye(9))))
ans =  369
>> A
A =

   47   58   69   80    1   12   23   34   45
   57   68   79    9   11   22   33   44   46
   67   78    8   10   21   32   43   54   56
   77    7   18   20   31   42   53   55   66
    6   17   19   30   41   52   63   65   76
   16   27   29   40   51   62   64   75    5
   26   28   39   50   61   72   74    4   15
   36   38   49   60   71   73    3   14   25
   37   48   59   70   81    2   13   24   35

>> A = magic(3)
A =

   8   1   6
   3   5   7
   4   9   2

>> temp = pinv(A)
temp =

   0.147222  -0.144444   0.063889
  -0.061111   0.022222   0.105556
  -0.019444   0.188889  -0.102778
```

## Reference article

> 1. coursera week 2 learning notes
> 2. [学习一点][1]

[1]: http://blog.chenming.info/blog/2012/07/15/learn-octave/
[2]: /images/ml/ml-ng-w2-11.png
[3]: /images/ml/ml-ng-w2-12.png
[4]: /images/ml/ml-ng-w2-13.png