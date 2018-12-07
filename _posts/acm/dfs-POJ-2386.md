---
title: 搜索的经典 POJ 2386 Lake Counting 
toc: true
date: 2010-09-27 18:04:21
categories: icpc
tags: acm
mathjax: true
---

经典的搜索，寻找水泡 poj 2386 [Lake Counting][1]

<!--more-->

## [Lake Counting][1]

```cpp
#include <iostream>

using namespace std;

const int MAX = 101;

int asd[202];
int n, m;
int ans = 0;
char c;
int map[MAX][MAX];

void digui(int a, int b, int k) {
    
    if (a >= 0 & & a < n & & b >= 0 & & b < m & & map[a][b] == -2) {
        map[a][b] = k; // 这是很重要的标记
        digui(a + 1, b, k);
        digui(a, b + 1, k);
        digui(a - 1, b, k);
        digui(a, b - 1, k);
        digui(a + 1, b + 1, k);
        digui(a + 1, b - 1, k);
        digui(a - 1, b + 1, k);
        digui(a - 1, b - 1, k);
    }
}

int main() {

    int i, j;

    cin >> n >> m;
    
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++){
            cin >> c;
            if (c == 'W') map[i][j] = -2; // 这的标记要慎重，最好用负数，不避免和K重复
            else map[i][j] = 0;
        }
    }
    
    for (i = 0; i < n; i++) {
        for (j = 0; j < m; j++) {
            if (map[i][j] == -2) {
                ans++;
                digui(i, j, ans);
            }
        }
    }
        
    cout << ans << endl;
            
    return 0;
}
```

[1]: http://poj.org/problem?id=2386