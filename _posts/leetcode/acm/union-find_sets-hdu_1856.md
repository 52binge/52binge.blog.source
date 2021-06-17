---
title:  Union-Find Sets HDU 1856
date: 2013-01-17 15:28:21
categories: [leetcode]
tags: acm
---

union-find sets hdu 1856 more is better

<!--more-->

**[More is better](http://acm.hdu.edu.cn/showproblem.php?pid=1856)**

```
Mr Wang wants some boys to help him with a project. ...
```

**<font color=#2561c2>Sample Input</font>**

```
4
1 2
3 4
5 6
1 6
4
1 2
3 4
5 6
7 8
```

**<font color=#2561c2>Sample Output</font>**

```
4
2
```

**<font color=#2561c2>Code</font>**

```cpp
#include <iostream>  
#include <string>  
#include <cstring>  
#include <cstdlib>  
#include <cstdio>  
#include <cmath>  
#include <vector>  
#include <stack>  
#include <deque>  
#include <queue>  
#include <bitset>  
#include <list>  
#include <map>  
#include <set>  
#include <iterator>  
#include <algorithm>  
#include <functional>  
#include <utility>  
#include <sstream>  
#include <climits>  
#include <cassert>  
#define BUG puts("here!!!");  
  
using namespace std;  
const int N = 100005;  
struct Node {  
    int par;  
    int sum;  
};  
int SUM;  
  
Node p[2*N + 5];  
void makeSet(int n) {  
    for(int i = 0; i <= 2*n; i++) {  
        p[i].par = i;  
        p[i].sum = 1;  
    }  
    SUM = 1;  
}  
int find(int a) {  
    if(a == p[a].par) return a;  
    return p[a].par = find(p[a].par);  
}  
void union1(int a, int b) {  
    int fa = find(a);  
    int fb = find(b);  
    if(fa != fb) {  
        p[fa].par = fb;  
        p[fb].sum += p[fa].sum;  
    }  
    if(p[fb].sum > SUM) {  
        SUM = p[fb].sum;  
    }  
}  
int main() {  
    int n, a, b;  
    while(scanf("%d", &n) == 1) {  
        makeSet(n);  
        while(n--) {  
            scanf("%d%d", &a, &b);  
            union1(a, b);  
        }  
        printf("%d\n", SUM);  
    }  
    return 0;  
}  
```