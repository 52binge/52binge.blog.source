---
title:  Union-Find Sets POJ 1703
date: 2013-01-17 18:04:21
categories: [leetcode]
tags: acm
---

union-find sets poj 1703 find them, catch them 帮派之争

<!--more-->

## [Find them, Catch them][1]

### Sample Input

```
1
5 5
A 1 2
D 1 2
A 1 2
D 2 4
A 1 4
```

### Sample Output


```
Not sure yet.
In different gangs.
In the same gang.
```

### Code


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
#define MID(x,y) ( ( x + y ) >> 1 )  
#define L(x) ( x << 1 )  
#define R(x) ( x << 1 | 1 )  
#define BUG puts("here!!!");  
#define STOP system("pause");  
  
using namespace std;  
const int N = 100005;  
int f[N+N];  
int n, m;  
int find(int x) {  
    if(f[x] < 0) return x;  
    return f[x] = find(f[x]);  
}  
int main() {  
    int loop;  
    cin >> loop;  
    while(loop--) {  
        scanf("%d%d", &n, &m);  
        memset(f, 255, sizeof(f));  
        while(m--) {  
            int a, b;  
            char s[3];  
            scanf("%s%d%d", s, &a, &b);  
            if(s[0] == 'A') {  
                if(find(a) != find(b) && find(a) != find(b+n)) {  
                    printf("Not sure yet.\n");  
                }  
                else if(find(a) == find(b)) {  
                    printf("In the same gang.\n");  
                }  
                else printf("In different gangs.\n");  
            }  
            else {  
                if(find(a) != find(b+n)) {  
                    f[find(a)] = find(b+n);  
                    f[find(b)] = find(a+n);  
                }  
            }  
        }  
    }  
    return 0;  
}  
```

[1]: http://poj.org/problem?id=1703