---
title: Graph Theory 近期小结
toc: true
date: 2011-12-29 10:26:48
categories: icpc
tags: graph_theory
---

关于图论的学习总结, 在本博可以详细的体现，做的大部分都是非常经典的图论算法入门题。

<!-- more -->

断断续续，也要接近一个月的时间啦！我今天终于把图论的大部分经典算法 复习+学习 小完毕。 因为中间学校总会有一些杂事在影响我的进度，所以是几经周折，断断续续，但是值得庆幸的是我一直没有间断过，这方面的学习。

本人图论所涉猎的算法如下 {

1. 拓扑排序  (Topology-h1285 )
2. 最小生成树 (Kruska-p1287 / Prim-p1287 )
3. 最短路 ( Dijkstra-p2387 / Bellman_Ford-z3033 / Bellman_Ford-p3259 / SPFA-template / SPFA-邻接矩阵-p3259 / SPFA-邻接表-p3259 / Floyd-template / Floyd-p1502 )
4. 二分图 (Hungary . poj 1274 / poj 2446 / zoj 1654   KM_CA_poj 2195O(n^4)/ KM_O(n^3)_p2195 )
5. 网络流 (EK_入门_p1273 / Dinic_入门_p1273 / 最小费用最大流(SPFA+EK)_p2195)
6. 强连通分量与缩点(有向图) Korasaju_p2186 / Korasaju and Tarjan_p1236 。 
7. 图的割点与桥(无向图)  ( Tarjan割点和桥的示例程序。 Sample : poj 144 求割点个数)
8. 双连通分量(无向图)  (Tarjan点双连通示例程序  / tarjan_边双连通-缩点p3352。  Sample : poj 3352 求加入最少的边使其变成边双连通分支)
9. 2-sat(这个我目前只能求判定性的问题) : poj 3207 / poj 3678 / poj 2723

**Sample:**

Sample : poj 2186 求有多少顶点是由任何顶点出发都可达。 
Sample : poj 1236 

1. 至少要选几个顶点，才能做到从这些顶点出发，可以到达全部顶点 
2. 至少要加多少条边，才能使得从任何一个顶点出发，都能到达全部顶点


     


