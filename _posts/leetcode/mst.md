---
title: Minimum Spanning Tree
toc: true
date: 2011-10-27 10:28:21
categories: icpc
tags: acm
---

data structure - minimal spanning tree

<!--more-->

## 1. prim

> http://acm.hdu.edu.cn/showproblem.php?pid=1233

```c++
#include <iostream>
#include <cstdio>
#include <cstring>

using namespace std;

const int INF = 0x7fffffff; // max int value
const int N = 101;

int map[N][N];
int dis[N];
bool vis[N];

int prim(int n) {
    memset(vis, false, sizeof(vis));
    memset(dis, 0, sizeof(dis));
    for(int i = 1; i <= n; i++) {
        if(map[1][i] != -1) {
            dis[i] = map[1][i];
        }
        else dis[i] = INF;
    }
    vis[1] = true;
    int sum = 0;
    for(int i = 1; i <= n-1; i++) {
        int minv = INF, c = 0;
        for(int j = 1; j <= n; j++) {
            if(!vis[j] && dis[j] < minv) {
                minv = dis[j];
                c = j;
            }
        }
        vis[c] = true;
        sum += minv;
        for(int j = 1; j <= n; j++) {
            if(!vis[j] && map[c][j] != -1 &&  map[c][j] < dis[j]) {
                dis[j] = map[c][j];
            }
        }
    }
    return sum;
}

int main() {

    int n, m;

    while(1 == scanf("%d", &n) && n != 0) {
        memset(map, 255, sizeof(map));
        int a, b, c;
        m = (n * (n-1)) / 2;
        for (int i = 0; i < m; i++) {
            scanf("%d%d%d", &a, &b, &c);
            map[a][b] = map[b][a] = c;
        }
        printf("%d\n", prim(n));
    }
    return 0;
}
```

## 2. kruskal

```c++
int pre[N];
int n, m;
struct Edge {
    int u, v;
    int w;
}e[N];
bool cmp(const Edge a, const Edge b) {
    return a.w < b.w;
}
void make_set(int n) {
    for(int i = 0; i <= n; i++)
        pre[i] = i;
}
int find_set(int a) {
    if(pre[a] == a) return a;
    return pre[a] = find_set(pre[a]);
}
void kruskal() {
    int sum = 0;
    sort(e, e + m, cmp);
    make_set(n);
    for (int i = 0, fu, fv, cnt_e; i < m; i++) {
        fu = find_set(e[i].u);
        fv = find_set(e[i].v);
        if (fu != fv) {
            sum += e[i].w;
            cnt_e++;
            if (cnt_e == n-1) break;
            pre[fv] = fu;
        }
    }
    cout << sum << endl;
}
```