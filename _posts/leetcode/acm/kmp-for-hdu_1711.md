---
title: KMP / HDU 1711 找到匹配的位置并返回
date: 2013-01-17 15:22:21
categories: [leetcode]
tags: acm
---

kmp hdu 1711 number sequence

<!--more-->

### <font color=#2561c2>Description</font>

Given two sequences of numbers : a[1], a[2], …… , a[N], and b[1], b[2], …… , b[M] (1 <= M <= 10000, 1 <= N <= 1000000). Your task is to find a number K which make a[K] = b[1], a[K + 1] = b[2], …… , a[K + M – 1] = b[M]. If there are more than one K exist, output the smallest one.

### <font color=#2561c2>Input</font>

The first line of input is a number T which indicate the number of cases. Each case contains three lines. The first line is two numbers N and M (1 <= M <= 10000, 1 <= N <= 1000000). The second line contains N integers which indicate a[1], a[2], …… , a[N]. The third line contains M integers which indicate b[1], b[2], …… , b[M]. All integers are in the range of [-1000000, 1000000].

### <font color=#2561c2>Output</font>

For each test case, you should output one line which only contain K described above. If no such K exists, output -1 instead.

### <font color=#2561c2>Sample Input</font>

2
13 5
1 2 1 2 3 1 2 3 1 3 2 1 2
1 2 3 1 3
13 5
1 2 1 2 3 1 2 3 1 3 2 1 2
1 2 3 2 1

### <font color=#2561c2>Sample Output</font>

6
-1

### <font color=#2561c2>Code</font>

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
const int N = 1000005;  
const int M = 10005;  
  
int s[N];  
int t[M];  
int next[M];  
void getNext(int len) {  
    int i, j;  
    i = 0, j = -1;  
    next[0] = -1;  
    while(i < len-1) {  
        if(j == -1 || t[i] == t[j]) {  
            i++, j++, next[i] = j;  
        }  
        else {  
            j = next[j];  
        }  
    }  
}  
int kmp(int sl, int tl) {  
    int i = 0, j = 0;  
    while(i < sl && j < tl) {  
        if(j == -1 || s[i] == t[j]) {  
            i++, j++;  
        }  
        else j = next[j];  
    }  
    if(j == tl) return i-j+1;  
    else return -1;  
}  
// abcabcababcabcabdef  
// abcabcabd  
int main() {  
    int T, n, m, ans;  
    cin >> T;  
    while(T--) {  
        cin >> n >> m;  
        for(int i = 0; i < n; i++) {  
            scanf("%d", s+i);  
        }  
        for(int i = 0; i < m; i++) {  
            scanf("%d", t+i);  
        }  
        getNext(m);  
        ans = kmp(n, m);  
        cout << ans << endl;  
    }  
    return 0;  
}  
```