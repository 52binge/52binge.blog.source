---
title: Coursera Week 2 - Octave Tutorial By NG
toc: true
date: 2016-10-21 10:28:21
categories: machine-learning
tags: machine-learning
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

ML:Octave Tutorial

<!-- more -->

## 1. Basic Operations

```matlab
%% Change Octave prompt  
PS1('>> ');
%% Change working directory in windows example:
cd 'c:/path/to/desired/directory name'
%% Note that it uses normal slashes and does not use escape characters for the empty spaces.

%% elementary operations
5+6
3-2
5*8
1/2
2^6
1 == 2 % false
1 ~= 2 % true.  note, not "!="
1 && 0
1 || 0
xor(1,0)


%% variable assignment
a = 3; % semicolon suppresses output
b = 'hi';
c = 3>=1;

% Displaying them:
a = pi
disp(a)
disp(sprintf('2 decimals: %0.2f', a))
disp(sprintf('6 decimals: %0.6f', a))
format long
a
format short
a


%%  vectors and matrices
A = [1 2; 3 4; 5 6]

v = [1 2 3]
v = [1; 2; 3]
v = 1:0.1:2   % from 1 to 2, with stepsize of 0.1. Useful for plot axes
v = 1:6       % from 1 to 6, assumes stepsize of 1 (row vector)

C = 2*ones(2,3) % same as C = [2 2 2; 2 2 2]
w = ones(1,3)   % 1x3 vector of ones
w = zeros(1,3)
w = rand(1,3) % drawn from a uniform distribution 
w = randn(1,3)% drawn from a normal distribution (mean=0, var=1)
w = -6 + sqrt(10)*(randn(1,10000));  % (mean = -6, var = 10) - note: add the semicolon
hist(w)    % plot histogram using 10 bins (default)
hist(w,50) % plot histogram using 50 bins
% note: if hist() crashes, try "graphics_toolkit('gnu_plot')" 

I = eye(4)   % 4x4 identity matrix

% help function
help eye
help rand
help help
```

## 2. Moving Data Around

```matlab
%% dimensions
sz = size(A) % 1x2 matrix: [(number of rows) (number of columns)]
size(A,1) % number of rows
size(A,2) % number of cols
length(v) % size of longest dimension


%% loading data
pwd   % show current directory (current path)
cd 'C:\Users\ang\Octave files'  % change directory 
ls    % list files in current directory 
load q1y.dat   % alternatively, load('q1y.dat')
load q1x.dat
who   % list variables in workspace
whos  % list variables in workspace (detailed view) 
clear q1y      % clear command without any args clears all vars
v = q1x(1:10); % first 10 elements of q1x (counts down the columns)
save hello.mat v;  % save variable v into file hello.mat
save hello.txt v -ascii; % save as ascii
% fopen, fread, fprintf, fscanf also work  [[not needed in class]]

%% indexing
A(3,2)  % indexing is (row,col)
A(2,:)  % get the 2nd row. 
        % ":" means every element along that dimension
A(:,2)  % get the 2nd col
A([1 3],:) % print all  the elements of rows 1 and 3

A(:,2) = [10; 11; 12]     % change second column
A = [A, [100; 101; 102]]; % append column vec
A(:) % Select all elements as a column vector.

% Putting data together 
A = [1 2; 3 4; 5 6]
B = [11 12; 13 14; 15 16] % same dims as A
C = [A B]  % concatenating A and B matrices side by side
C = [A, B] % concatenating A and B matrices side by side
C = [A; B] % Concatenating A and B top and bottom
```

## 3. Computing on Data

```matlab
%% initialize variables
A = [1 2;3 4;5 6]
B = [11 12;13 14;15 16]
C = [1 1;2 2]
v = [1;2;3]

%% matrix operations
A * C  % matrix multiplication
A .* B % element-wise multiplication
% A .* C  or A * B gives error - wrong dimensions
A .^ 2 % element-wise square of each element in A
1./v   % element-wise reciprocal
log(v)  % functions like this operate element-wise on vecs or matrices 
exp(v)
abs(v)

-v  % -1*v

v + ones(length(v), 1)  
% v + 1  % same

A'  % matrix transpose

%% misc useful functions

% max  (or min)
a = [1 15 2 0.5]
val = max(a)
[val,ind] = max(a) % val -  maximum element of the vector a and index - index value where maximum occur
val = max(A) % if A is matrix, returns max from each column

% compare values in a matrix & find
a < 3 % checks which values in a are less than 3
find(a < 3) % gives location of elements less than 3
A = magic(3) % generates a magic matrix - not much used in ML algorithms
[r,c] = find(A>=7)  % row, column indices for values matching comparison

% sum, prod
sum(a)
prod(a)
floor(a) % or ceil(a)
max(rand(3),rand(3))
max(A,[],1) -  maximum along columns(defaults to columns - max(A,[]))
max(A,[],2) - maximum along rows
A = magic(9)
sum(A,1)
sum(A,2)
sum(sum( A .* eye(9) ))
sum(sum( A .* flipud(eye(9)) ))


% Matrix inverse (pseudo-inverse)
pinv(A)        % inv(A'*A)*A'
```


## 4. Plotting Data

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

## 5. Control statements:for,while,if

```matlab
v = zeros(10,1);
for i=1:10, 
    v(i) = 2^i;
end;
% Can also use "break" and "continue" inside for and while loops to control execution.

i = 1;
while i <= 5,
  v(i) = 100; 
  i = i+1;
end

i = 1;
while true, 
  v(i) = 999; 
  i = i+1;
  if i == 6,
    break;
  end;
end

if v(1)==1,
  disp('The value is one!');
elseif v(1)==2,
  disp('The value is two!');
else
  disp('The value is not one or two!');
end
```

run example :

```matlab
>> i = 1;
>> while i <= 5,
     v(i) = 100;
     i = i+1;
   end;
>> v
v =

    100
    100
    100
    100
    100
     64
    128
    256
    512
   1024

>> i = 1;
>> while true,
     v(i) = 999;
     i = i + 1;
     if i == 6,
       break;
     end;
   end;
>> v
v =

    999
    999
    999
    999
    999
     64
    128
    256
    512
   1024
>> v(1)
ans =  999
>> v(1) = 2;
>> if v(1) == 1,
     disp('The value is one');
   elseif v(1) == 2,
     disp('The value is two');
   else
     disp('The value is not 1 or 2');
   end;
The value is two
```

## 6. Functions

To call the function in Octave, do either:

1) Navigate to the directory of the functionName.m file and call the function:

```matlab
  % Navigate to directory:
    cd /path/to/function

    % Call the function:
    functionName(args)
```

> simple compute line regression

```matlab
>> x = [1 1; 1 2; 1 3;]
x =

   1   1
   1   2
   1   3

>> y = [1; 2; 3]
y =

   1
   2
   3

>> theta = [0;1];
>> j = costFunctionJ(x,y,theta)
j = 0
>> theta = [0:0];
>> j = costFunctionJ(x, y, theta)
warning: operator -: automatic broadcasting operation applied
j =

   2.3333   2.3333
   2.3333   2.3333
```

> 应该为一个 2.3333， 而不是矩阵 2.3333


```matlab
>> (1^2 + 2^2 + 3^2) / (2*3)
ans =  2.3333
>> [-1,-2,-3]*[-1;-2;-3]
ans =  14
>> 14 / 6
ans =  2.3333
>>
```

## 7. Vectorization

Vectorization is the process of taking code that relies on loops and converting it into matrix operations. It is more efficient, more elegant, and more concise.

As an example, let's compute our prediction from a hypothesis. Theta is the vector of fields for the hypothesis and x is a vector of variables.

With loops:

```matlab
prediction = 0.0;
for j = 1:n+1,
  prediction += theta(j) * x(j);
end;
```

With vectorization:

```octave
prediction = theta' * x;
```

## Reference article

> 1. coursera week 2 learning notes
> 2. [学习一点][1]

[1]: http://blog.chenming.info/blog/2012/07/15/learn-octave/
[2]: /images/ml/coursera/ml-ng-w2-11.png
[3]: /images/ml/coursera/ml-ng-w2-12.png
[4]: /images/ml/coursera/ml-ng-w2-13.png
