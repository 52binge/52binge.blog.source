---
title: Trie Tree POJ 2001
toc: true
date: 2013-01-17 18:06:21
categories: icpc
tags: acm
---

trie tree poj 2001 shortest prefixes

<!--more-->

## [POJ 2001 Shortest Prefixes][1]

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
const int N = 1010;  
const int kind = 26;  
char str[N][25];  
struct Node {  
    int num;  
    bool tail;  
    Node* next[kind];  
    Node() : num(1), tail(false) {  
        memset(next, 0, sizeof(next));  
    }  
};  
void insert(Node* root, char *s) {  
    Node* p = root;  
    int i = 0, index;  
    while(s[i]) {  
        index = s[i] - 'a';  
        if(p->next[index] == NULL) {  
            p->next[index] = new Node();  
        }  
        else p->next[index]->num++;  
        p = p->next[index];  
        i++;  
    }  
    p->tail = true;  
}  
void solve(Node* root, int count) {  
    for(int i = 0; i < count; i++) {  
        Node* p = root;  
        int len = strlen(str[i]);  
        char* s = str[i];  
        cout << s << ' ';  
        for(int j = 0; j < len; j++) {  
            cout << s[j];  
            int index = s[j] - 'a';  
            if(p->next[index]->num == 1) {  
                break;  
            }  
            p = p->next[index];  
        }  
        cout << endl;  
    }  
}  
int main() {  
    Node* root = new Node(); // 根节点不包含任何字符  
    int i = 0, count = 0;  
    while(scanf("%s", str[i]) == 1) {  
        insert(root, str[i]);  
        i++;  
    }  
    count = i;  
    solve(root, count);  
    return 0;  
}  
```

[1]: http://poj.org/problem?id=2001