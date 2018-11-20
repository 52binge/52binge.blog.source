---
title: Shortest Path
toc: true
date: 2016-10-27 15:28:21
categories: icpc
tags: acm
mathjax: true
---

shortest path : `dijstra`

<!--more-->

## 1. dijstra

```c++
int data[M][M]; // init INF
int lowc[M];
int vis[M];
int n, m;
void djst(int p) {
    int i, j;
    for(i = 1; i <= n; i++) {
        vis[i] = 0;
        lowc[i] = data[p][i];
    }
    vis[p] = 1;
    for(i = 1; i <= n-1; i++) {
        int minc = INF, c = 0, lk;
        for(j = 1; j <= n; j++) {
            if(vis[j] == 0 && lowc[j] < minc) {
                minc = lowc[j];
                c = j;
            }
        }
        if(c == 1) break;
        vis[c] = 1;
        for(j = 1; j <= n; j++) {
            if(vis[j] == 0 && data[c][j] + minc > 0 && data[c][j] + minc < lowc[j]) {
                lowc[j] = data[c][j] + minc;
            }
        }
    }
    cout << lowc[1] << endl;
}
```

## 2. Bellman

```c++
#define INF ((long long)(1))<<62
#define N 301
using namespace std;
struct edge{
   int u;
   int v;
   long long w; // 注意
}e[N*N];
int m, n;
long long d[1005];
bool bellman_ford(int s, int di) {
    int i, j;
     for(i = 1; i < n; i++) {
        d[i] = INF;
     }
     d[s] = 0;
     for(i = 1; i <= n-1; i++) {
        for(j = 1; j <= m; j++) {
            if(d[e[j].u] != INF && d[e[j].u]+e[j].w < d[e[j].v])    // 对边进行操作 、松弛
                d[e[j].v] = d[e[j].u] + e[j].w;
        }
     }
     for(j = 1; j <= m; j++) {
        if(d[e[j].u] != INF && (d[e[j].v] > d[e[j].u]+e[j].w))    // 很理解
            d[e[j].v] = -INF;
     }
     if(d[di] == INF || d[di] == -INF) return false;
     return true;
}
```

## 3. Floyd

## 4. SPFA

```c++
const int INF = 0x7fffffff;
const int N = 5501;
struct edge {
    int to;
    int w;
};
vector<edge> p[N]; // vector 实现邻接表
int d[N];
bool inque[N];     // 记录顶点是否在队列中，SPFA算法可以入队列多次
int cnt[N];        // 记录顶点入队的次数
int n, m, q;
bool SPFA(int s) {
    queue<int> Q;
    while(!Q.empty()) Q.pop();
    int i;
    for(i = 0; i <= n; i++) {
        d[i] = INF;
    }
    d[s] = 0;      // 源点的距离为 0
    memset(inque, 0, sizeof(inque));
    memset(cnt, 0, sizeof(cnt));
    Q.push(s);
    inque[s] = true;
    cnt[s]++;      // 源点入队列的次数增加
    while(!Q.empty()) {
        int t = Q.front();
        Q.pop();
        inque[t] = false;
        for(i = 0; i < p[t].size(); i++) {
            int to = p[t][i].to;
            if(d[t] < INF && d[to] > d[t] + p[t][i].w) {
                d[to] = d[t] + p[t][i].w;
                cnt[to]++;
                if(cnt[to] >= n) {  //当一个点入队的次数>=n时就证明出现了负环
                    return false;
                }
                if(!inque[to]) {
                    Q.push(to);
                    inque[to] = true;
                }
            }
        }
    }
    return true;
}
```