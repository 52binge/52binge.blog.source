
- [十道海量数据处理面试题与十个方法大总结](https://blog.csdn.net/v_JULY_v/article/details/6279498)

- [hadoop相关试题](https://blog.csdn.net/qq_16633405/article/details/78947969#hadoop_7)

- [Hive相关试题](https://blog.csdn.net/qq_16633405/article/details/78947969#Hive_103)

### 1. 字符串

> 1. 字符串的排列 void res(char \*str, char \*pStr), scanf("%s", str); \#include < utility\> 
> 2. 反转字串单词 string ReverseSentence(string str), reverse(str.begin(), str.end()); in lib algorithm
> 3. 左旋转字符串 string LeftRotateString(string str, int n),string Reverse(string str)
> 4. 字符串转整型 int StrToInt(char* str)       ok

### 2. 数组 & 排序

> 1. 二维数组中的查找 bool Find(int\* matrix, int rows, int cols, int value)用一维/二维 \*(matrix+i\*cols+j)
> 2. 替换空格 char\* replace(char\* str, int len) ‘ ’->%20 在源数组总长度，从后向前，逐个赋值
> 3. 旋转数组的最小元素 int get_min(int \*a, int len) , while(a[p1] >= a[p2]) {
> 4. 调整数组位数使奇数位于前面 void reorderOddEven(int[] arr) 
> 5. 数组中出现次数超过一半的次数 \* int core(int \*a, int len)
> 6. 最小的K个数  part 快排思想 + void set_k(int\* input, int n, int k) **nok**
> 7. 连续子数组的最大和   // dp: F[i] = max(a[i], F[i-1]+a[i]);
> 8. [把数组排成最小的数](https://www.cnblogs.com/youxin/p/3294154.html) #include < sstream > bool Compare(const string &left, const string &right)
> 9. [数组中的逆序对](https://blog.csdn.net/bf23456/article/details/51303632)
> 10. 数组中只出现一次的数字 , 划分2数组，num & (-num);二者与后得到的数，将num最右边的1保留下来
> 11. **丑数**, 只包含质因子2、3和5的数称作丑数, 1, 2, 3, 5, 6, ... ok
> 12. 整数中1出现的次数（从1到n整数中1出现的次数）. **nok**
> 13. 和为S的连续正数序列(滑动窗口思想) left=1, right = 2, total = (left + right) \* (right - left + 1) / 2; 
> 14. 和为S的两个数字(双指针思想) ok.
> 15. 孩子们的游戏-圆圈中最后剩下的数(约瑟夫环) ok.
> 16. [构建乘积数组](https://blog.csdn.net/u012327058/article/details/81007333)
> 17. 如何在排序数组中找出给定数字出现的次数 int bina(int \*a, int len, int num, bool isLeft)
> 18. [最短路Floyd](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html)
> 19. quick_sort, while (双while + swap)

```cpp
void quickSort(int a[], int left, int right) {
    if(left < right) { // exit. good idea!
        int l = left, r = right, x = a[l];
        while(1) {
            while(l < r && a[r] >= x) r--;
            while(l < r && a[l] <= x) l++;
            if(l >= r) break;
            swap(a[r], a[l]);
        }
        swap(a[left], a[l]);
        quickSort(a, left, l-1);
        quickSort(a, l+1, right);
    }
}
```

mergeSort

```cpp
void mergeSort(int a[], int l, int r) { //  8, 5, 4, 9, 2, 3, 6
    if(l >= r) return;   // exit.
    int mid = (l+r) / 2; // overflow  <->  l + (r-l)/2
    mergeSort(a, l, mid);
    mergeSort(a, mid+1, r);  
    int *arr = new int[r-l+1];  
    int k = 0;
    int i = l, j = mid + 1;
    while(i <= mid && j <= r) {  
        if(a[i] <= a[j]) {
            arr[k++] = a[i++]; 
        }
        else {
            arr[k++] = a[j++]; // ans += (mid-i+1);  
        }
    }
    while(i <= mid) arr[k++] = a[i++];
    while(j <= r) arr[k++] = a[j++];
    for(int i = l; i <= r; i++) {
        a[i] = arr[i-l];
    }
    delete []arr;
}
```

约瑟夫环:

```cpp
int cirnm(int n, int m) {
    if(n < 1 || m < 1) return -1;
    int i = 0, count = 0; 
    list<int> L;
    for(int i = 0; i < n; i++) L.push_back(i);
    list<int>::iterator lcur = L.begin(), next;
    while(!L.empty()) {
        for(int i = 1; i < m; ++i) {
            lcur++;
            if(lcur == L.end()) lcur = L.begin();
        }
        next = lcur + 1;
        if(next == L.end()) next = L.begin();
        L.erase(lcur);
        count++;
        if(count == n - 1) break;
        lcur = next;
    }
    return *lcur;
}
```

如何在排序数组中找出给定数字出现的次数:

```cpp
int bina(int *a, int len, int data) {
    if(a == NULL || len <= 0) return -1;
    int l = 0, r = len - 1;
    while(l <= r) {
        int mid = (l + r) / 2;
        if(a[mid] == data) return mid;
        else if(data < a[mid]) {
            r = mid - 1;
        }
        else l = mid+1;
    }
    return -1;
 }
```

### 3. LinkedList

> 5. 从尾到头打印链表, 递归 ok.    
> 6. 链表中倒数第k个结点 ok.   
> 3. [反转链表][3.3] next=head->next, head->next=pre, pre=head, head=next; 4步
> 4. 合并两个或k个有序链表  ok， 递归 (三元运算符).   
> 5. 复杂链表的复制    
> 6. 两个链表的第一个公共结点  ok.   
> 7. 链表中环的入口结点     
> 8. 删除链表中重复的结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. first->next=head, last, p 三指针, first 技巧

[3.3]: https://www.jianshu.com/p/bd6a64d36916


> 1. 重建二叉树 ok Node\* f3(int\* pre, int\* ino, int len)       
> 2. 树的子结构,遍历+判断, bool f5(Node\* root1, Node\* root2), bool son(Node\* p1, Node\* p2) 
> 3. 二叉树的镜像  ok 递归.   
> 4. 从上往下打印二叉树 ok bfs      
> 5. 二叉搜索树的后序遍历序列 bool f6(int\* sec, int len)  
> 6. 二叉树中和为某一值的路径 void f4(Node\* root, int exSum, int curSum, vecotr\< int \>& path)     
> 7. 二叉搜索树与双向链表 void convert(Node\* root, Node\*& pLast)   
> 8. 二叉树的深度 bool isBalance(Node\* root, int\* dep)
> 9. 平衡二叉树 bool isBalance(Node\* root, int\* dep)    
> 10. [二叉树的下一个结点](https://blog.csdn.net/libin1105/article/details/48422299)  ok       
> 11. 对称的二叉树 ok      
> 12. 按之字形顺序打印二叉树      
> 13. 把二叉树打印成多行  ok.   
> 14. 序列化二叉树      
> 15. 二叉搜索树的第k个结点 ok.   
> 16. [二叉查找树节点的删除](https://blog.csdn.net/xiaoxiaoxuanao/article/details/61918125).  重要
> 17. strcpy 手写 char\* my_strcpy(char \*dst, const char\* src)

### 5. 具体算法

#### 5.1 斐波拉契

> 1. 斐波拉契数列 ok.   
> 2. 跳台阶  ok.   
> 3. 变态跳台阶  2 \* Fib(n-1).   
> 4. 矩形覆盖  ok

#### 5.4 回溯

> 1. 矩阵中的路径(BFS).   
> 2. 机器人的运动范围(DFS)

#### 5.5 排序

> 1. 数组中的逆序对(归并排序).  void mergeSort(int a[], int l, int r)
> 2. 最小的K个数(堆排序).   
> 3. 最小的K个数(快速排序) ok

#### 5.6 位运算

> 1. 二进制中1的个数  n & n-1.   
> 2. 数值的整数次方 dp.   
> 3. 数组中只出现一次的数字 ok.  

### 6. Stack & Queue & heap

## 题目报告

### 2.1 二维数组中的查找

```cpp
int a[][4] = {
	{ 1, 2, 3, 4 },
	{ 5, 6, 7, 8 },
	{ 9, 10, 11, 12},
	{ 13, 14, 15, 16},
	{ 17, 18, 19, 20}
};

bool Find(int b[][4], int rows, int cols, int value) {
	
	int row = 0, col = cols - 1;
	
	while (b != NULL && row < rows && col >= 0) {
		
		if (b[row][col] == value) {
			cout << "row: " << row << " col: " << col << end;
			return true;
		}
		else if (b[row][col] > value) {
			col--;
		}
		else {
			row++;
		}
	}
	return false;
}
```

### 2.3 旋转数组的最小元素

```cpp
int a[N] = {3, 4, 5, 1, 2};
int get_min(int *a, int len) {
    if(a == NULL || len <= 0) {
        return -1;
    }
    int p1 = 0, p2 = len-1;
    int mid = p1;
    
    while(a[p1] >= a[p2]) {
        if(p2 - p1 == 1) {
            mid = p2; break;
        }
        mid = (p1 + p2) / 2;
        if(a[p1] <= a[mid]) {
            p1 = mid;
        }
        else if(a[p2] >= a[mid]) {
            p2 = mid;
        }
    }
    return mid;
}
```

### 2.4 调整数组位数使奇数位于前面

### 2.5 最小的K个数 part 快排思想 

```cpp
void set_k(int* input, int n, int k)
```

=============

```cpp

/* 05_从尾到头打印链表 */ void printLinkList(Node* p) 利用递归 或者 栈
/* 06_重建二叉树 根据前序与中序 */ Node* f3(int* pre, int* ino, int len)
/* 07_两个栈实现队列 */

/* 10_二进制中 1 的个数 */  n & (n-1)
/* 11_数值的整数次方 */   a = a^n/2 * a^n/2 (偶数， 奇数 * a)， 利用递归
/* 12_打印1到最大的n位数 */ void res(char *number, int len, int index) void solve(int n)


/* 17_合并两个排序的链表 */
/* 18_树的子结构 */
/* 19_二叉树的镜像 */
/* 20_顺时针打印矩阵 狗血*/ int left = 0, right = col - 1, top = 0, bottom = row - 1;  https://zhuanlan.zhihu.com/p/38716707
/* 21_包含min函数的栈 */
/* 22_栈的压入、弹出序列 */
/* 23_从上到下打印二叉树 */
/* 24_二叉搜索树的后序遍历序列 */
/* 25_二叉树中和为某一值的路径 */
/* 26_复杂链表的复制 */
/* 27_二叉搜索树与双向链表 */ void convert(Node* root, Node*& pLast)
/* 28_字符串的全排列 */.    void res(char *str, char *pStr)

/* 32_从1到n整数中1出现的次数 狗血题 */

/* 35_第一个只出现一次的字符

/* 37_两个链表的第一个公共节点 */ // 会(略)
/* 38_数字在排序数组中出现的次数 */ 二分查找
/* 39_二叉树的深度 */ 递归，easy
 * 从二叉树的深度扩展到判断是否为平衡二叉树 */

/* 42_翻转单词顺序  Is core ! */
/* 42_左旋转字符串 同上 */
/* 43_N个骰子的点数 DP 好题目 */
/* 44_扑克牌的顺子*/
1）确认5张牌中除了0，其余数字没有重复的（可以用表统计的方法）;
2) 满足这样的逻辑：（max，min分别代表5张牌中的除0以外的最大值最小值）
     如果没有0，   则 max-min = 4，则为顺子，否则不是
     如果有一个0， 则 max-min = 4或者3，则为顺子，否则不是
     如果有两个0， 则 max-min = 4或者3或者2，则为顺子，否则不是
/* 45_圆圈中最后剩下的数字 创新DP解法，秒杀offer */
/* 46_求1+2+……+n */
/* 47_不用加减乘除做加法 */
/* 48_不能被继承的类 */
/* 49_把字符串转换成整数 
     数字与字符串的相互转化  atoi 与 itoa
 */
/* 50_树中两个结点的最低公共祖先 */

********** 第 13 章 数据结构与算法 ******
 *** 数组 ***
m_0101 如何用递归实现数组求和。
m_0102 用 for 循环打印出一个二维数组。
m_0103 如何用递归判断一个数组是否是递增。
 bool f(int a[], int n) {
    if(n == 1) return true;
    return (a[n-1] > a[n-2]) && f(a, n-1);
 }
m_0105 如何分别使用递归与非递归实现二分查找算法。
int bina(int *a, int len, int data) {
    if(a == NULL || len <= 0) return -1;
    int l = 0, r = len - 1;
    while(l <= r) {
        int mid = (l + r) / 2;
        if(a[mid] == data) return mid;
        else if(data < a[mid]) {
            r = mid - 1;
        }
        else l = mid+1;
    }
    return -1;
 } 递归的自己想(略) l, r.







m_0106 如何在排序数组中找出给定数字出现的次数。
int bina(int *a, int len, int num, bool isLeft) {
    int l = 0, r = len - 1;
    int last = 0;
    while(l <= r) {
        int mid = (l+r) / 2;
        if(a[mid] < num) {
            l = mid + 1;
        }
        else if(a[mid] > num) {
            r = mid - 1;
        }
        else {
            last = mid;
            if(isLeft) {
                r = mid - 1;
            }
            else {
                l = mid + 1;
            }
        }
    }
    return last > 0 ? last : -1;
}
m_0107 如何计算两个有序整型数组的交集
    a = 0, 1, 2, 3, 4
    b = 1, 3, 5, 7, 9
answ1 : 二路归并 [仔细]
answ2 : 先遍历一数组，将遍历得到的元素存放到哈希表，然后遍历另外一个数组，同时对建立的哈希表进行查询，如果存在，则为两者的交集元素。
情况二 ：如果两个数组的长度，相差悬殊的话，那么先遍历小的数组，然后挨个在大的上二分。
m_0108 如何找出数组中重复次数最多的数？
 answ1 : 空间换时间。(一般不采用)
 answ2 : 使用 map 映射表。 map<int, int> m; for( ) { if(++m[a[i]] >= m[val]) val = a[i];}
m_0109 O(n) 找出数组中出现次数超过一半的数字。
answ1 : 每次取出两个不同的数字. 时间O(n) 空间O(1)
answ2 : Hash 法, hash_map 遍历数组，并用两个值存储目前出现次数最多的数和对应出现的次数时空借O(n)。
m_0110 如何找出数组中唯一的重复元素。 1 ~ N-1 存放在 a[N] 中。
 answ1 : 异或法。 answ2 : 位图法。
 变形题 ： 取值为 [1, n-1] 含 n 个元素的整数数组，至少存在一个重复数，找出任意一个重复数。
  answ1 : 位图法。时间 O(n), 空间 O(n)
  answ2 : 数组排序法。 也就是 hash 计数。
  answ3 : Hash法，数组如果是有符号数 int 型，则本方法可行。将数组元素的值作为索引，对于元素 a[i]
          如果 a[a[i]]>0, 则设置 a[a[i]] = -a[a[i]]; 如果 a[a[i]]<0,说明a[a[i]] 是一个重复数。
遍历两个数组长度相差悬殊的情况，如数组 a 的长度远远大于数组 b 的长度
m_0111 如何判断一个数组中的数值是否连续相邻?
 如果没有 0 的存在，要组成连续的数列，最大值和最小值的差距必须是4,存在0的情况下，只要最大小值差距下于4就哦！
m_0113 如何找出数列中符合条件的数对的个数。
 answ1 : 排序 +二分
 answ2 : 计数排序，将 1 ~ N 个数放在一块很大的空间里面，比如 1 放在 1号位，...
m_0114 如何寻找出数列中缺失的数。 problem : 数组 a 有 n 个元素，元素的取值范围是 1 ~ n
 answ1 : 排序相邻，时间 O(nlogn), 空间 O(1)
 answ2 : 使用 bitmap 方法。 时间 O(n), 空间 O(n)
 answ3 : 遍历数组，假设第 i 个位置的数字为 j, 则通过交换将 j 换到下标为 j 的位置上。时O(n),空间O(1)
m_0116 如何重新排列数组使得数组左边为奇数，右边为偶数。 类似快排前奏，头尾指针。
m_0117 如何把一个整型数组中重复的数字去掉。
 answ : 快速排序首先，然后变为 1 1 1 2 2 3, 遍历该数组，k = 0, i = 1; 
 if(a[k] != a[i]) { a[k+1] = a[i];k++; }
m_0118 如何找出数组中第二大的数？
 answ1 : 堆排序被，两边筛选，出第二大的数了。
 answ2 : 用两个变量，一个记录最大的数，一个记录第二大的数字。遍历数组，1)更新最大，更新第二大2)检查更新二大
m_0121 如何计算出序列的前 n 项数据
 for(k = 0; k < N; k++) { tmpA = a*i; tmpB = b*j; if(tmpA <= tmpB) {Q[k] = tmpA; i++;} else }
m_0123 如何判断一个整数 x 是否可以表示成 n (n>=2) 个连续正整数的和。
 x = m + (m+1) + (m+2) + ... + (m+n-1), 推出 ： m = (2*x/n - n + 1) / 2; m >= 1;
 也就是判断 (2*x/n - n + 1) 是不是偶数的问题。 tmp = m; if(tmp == (int)tmp) 就 OK！

****** 链表 ******
m_0210 如何实现单链表交换任意两个元素(不包括表头)
struct Node {
    int value;
    Node* next;
};
Node* findPre(Node* head, Node* p) {
    Node* q = head;
    while(q) {
        if(q->next == p)
            return q;
        else q = q->next;
    }
    return NULL;
}
Node* swap(Node* head, Node* p, Node* q) {
    if(head == NULL || p == NULL || q == NULL) { return NULL; }
    if(p == q) return head;
    if(p->next == q) {
        Node* pre_p = findPre(head, p);
        pre_p->next = q;
        p->next = q->next;
        q->next = p;
    }
    else if(q->next == p) {
        Node* pre_q = findPre(head, q);
        pre_q->next = p;
        q->next = p->next;
        p->next = q;
    }
    else if(p != q) {
        Node* pre_p = findPre(head, p);
        Node* pre_q = findPre(head, q);
        Node* after_p = p->next;
        q->next = after_p;
        pre_p->next = q;
        pre_q->next = p;
    }
    return head;
}
m_0211 如何检测一个较大的单链表是否存在环。
 answ1 : fast, slow;
 answ2 : STL 中的 map<Node*, int>
m_0213 如何删除单链表中的重复节点
 answ : hash_map

****** 字符串 ******
m_0302 如何将字符串逆序
m_0605 非递归求二叉树的深度
```

```cpp
struct Node {
    int value;
    Node* par;
    Node* lchild;
    Node* rchild;
};
int dep(Node* root) {
    if(root == NULL) return 0;
    return max(dep(root->lchild), dep(root->rchild)) + 1;
}
int fdep(Node* root) {
    deque<Node*> dq;
    int high = -1;
    while(1) {
        for(; root != NULL; root = root->lchild) {
            dq.push_back(root);
        }
        high = max(high, (int)dq.size());
        while(1) {
            if(dq.empty()) return high;
            Node* par = dq.back();
            Node* rchild = par->rchild;
            if(rchild && root != rchild) {
                root = rchild;
                break;
            }
            root = par;
            dq.pop_back();
        }
    }
    return high;
}
```

===

===

```cpp
#include <iostream>
#include <cstdio>
#include <cmath>
#include <cstring>
#include <string>
#include <vector>
#include <list>
#include <queue>
#include <deque>
#include <algorithm>
#include <utility>

using namespace std;
struct Node {
    Node* lchild;
    Node* rchild;
};
```

## 1. 字符串

### 1.1 反转字符串的单词

```cpp
string ReverseSentence(string& str) {
    if(str.length() <= 0)
        return str;
	reverse(str.begin(), str.end());
    int begin = 0, end = 0;
	
    while(str[begin] != '\0') {
        if(str[begin] == ' ') {
            begin++;
            end++;
        }
        else if(str[end] == ' ' || str[end] == '\0'){
            reverse(str.begin() + begin, str.begin() + end);
            begin = ++end;
        }
        else
            end++;
    }
    return str;
}
```

## 2. 八皇后的实现

```cpp
const int N = 105;
int pos[N];
int num = 8, cnt = 0;
bool ok(int n) {
    for(int i = 0; i < n; i++) {
        if(pos[i] == pos[n]) return false;
        if(abs(pos[n] - pos[i]) == n-i) return false;
    }
    return true;
}
void dfs(int n) {
    if(n == num) {
        cnt++;
        return;
    }
    for(int i = 0; i < num; i++) {
        pos[n] = i;
        if(ok(n)) {
            dfs(n+1);
        }
    }
}
```

## 3. 根据前序中序重新建立二叉树

```cpp
Node* f3(int* pre, int* ino, int len) { 
    // pre : 1, 2, 4, 7, 3, 5, 6, 8    
    // ino : 4, 7, 2, 1, 5, 3, 8, 6
    if(pre == NULL || ino == NULL || len <= 0) {
        return NULL;
    }
    int r_v = pre[0];
    Node* root = new Node();
    root->value = r_v;
    int i;
    for(i = 0; ; i++) {
        if(ino[i] == r_v) break;
    }
    root->lchild = f3(pre+1, ino, i);
    root->rchild = f3(pre+i+1, ino+i+1, len-1-i);
    return root;
}
```

## 4. 二叉树中和为某一值的所有路径

```cpp
void f4(Node*, int, int, vector<int>&);
void f4(Node* root, int exSum) {
    if(root == NULL) {
        return;
    }
    vector<int> V;
    int curSum = 0;
    f4(root, exSum, curSum, V);
}
void f4(Node* root, int exSum, int curSum, vecotr<int>& path) {
    curSum += root->value;
    path.push_back(root->value);
    if(curSum == exSum && root->lchild == NULL && root->rchild == NULL) {
        //; 打印vector中的路径
    }
    if(root->lchild) {
        f4(root->lchild, exSum, curSum, path);
    }
    if(root->rchild) {
        f4(root->rchild, exSum, curSum, path);
    }
    curSum -= root->value;
    path.pop_back();
}
```

## 5. 树2 是否是 树1 的子结构

```cpp
bool son(Node* p1, Node* p2) {
    if(p2 == NULL) {
        return true;
    }
    if(p1 == NULL) {
        return false;
    }
    if(p1->value == p2->value) {
        return son(p1->lchild, p2->lchild) && son(p1->rchild, p2->rchild);
    }
    return false;
}
bool f5(Node* root1, Node* root2) {
    if(root2 == NULL) {
        return true;
    }
    if(root1 == NULL) {
        return false;
    }
    if(root1->value == root2->value) {
        return son(root1, root2);
    }
    bool flag = false;
    flag = f5(root->lchild, root2);
    if(!flag) {
        flag = f5(root->rchild, root2);
    }
    return flag;
}
```

## 6. 二叉搜索树后序遍历的结果

```cpp
bool f6(int* sec, int len) {
    if(sec == NULL) {
        return false;
    }
    if(len <= 1) {
        return true;
    }
    int i, rv = sec[len-1];
    for(i = 0; i < len-1; i++) {
        if(sec[i] > rv) {
            break;
        }
    }
    for(int j = i; j < len-1; j++) {
        if(sec[j] < rv) {
            return false;
        }
    }
    return f6(sec, i) && f6(sec+i, len-i-1);
}
```

## 7. 二叉树两节点的最低公共祖先

```cpp
vector<Node*> V1;
vector<Node*> V2;

bool getNodePath(Node* root, Node* tar, vector<Node*>& V) { // 根左右，回溯
    if(root == NULL) {
        return false;
    }
    V.push_back(root);
    if(root == tar) {
        return true;
    }
    bool flag = false;
    if(root->lchild) {
        flag = getNodePath(root->lchild, tar, V);
    }
    if(!flag && root->rchild) {
        flag = getNodePath(root->rchild, tar, V);
    }
    if(!flag) {
        V.pop_back();
    }
    return flag;
}
Node* getCom(const vector<Node*>& V1, const vector<Node*>& V2) {
    vector<Node*>::const_iterator it1 = V1.begin();
    vector<Node*>::const_iterator it2 = V2.begin();
    Node* pLast = NULL;
    while(it != V1.end() && it2 != V2.end()) {
        if(*it != *it2) {
            break;
        }
        pLast = *it1;
        ++it1;
        ++it2;
    }
    return pLast;
}
```

## 8. 从二叉树的深度扩展判断平衡

从二叉树的深度 扩展到 判断 是否为平衡二叉树

```cpp
bool isBalance(Node* root, int* dep) {
    if(root == NULL) {
        *dep = 0;
        return true;
    }
    int left = 0, right = 0;
    if(isBalance(root->lchild, &left) && isBalance(root->rchild, &right)) {
        int diff = left - right;
        if(diff >= -1 && diff <= 1) {
            *dep = 1 + (left > right ? left : right);
            return true;
        }
    }
    return false;
}
```

## 9. 二叉搜索树与双向链表

```cpp
void convert(Node* root, Node*& pLast) {
    if(root == NULL) {
        return;
    }
    if(root->lchild) {
        convert(root->lchild, pLast);
    }
    Node* pCur = root;
    pCur->lchild = pLast;
    if(pLast) {
        pLast->rchild = pCur;
    }
    pLast = pCur;
    if(root->rchild) {
        convert(root->rchild, pLast);
    }
}
```

## 10. strcpy 的实现，要考虑地址重叠

```cpp
char* my_strcpy(char *dst, const char* src) {
    size_t size = strlen(src);
    if(dst == NULL || src == NULL) {
        return NULL;
    }
    const char *psrc;
    char *pdst;
    if(src < dst && src + size > dst) {
        psrc = src + size - 1;
        pdst = dst + size - 1;
        while(size--) {
            *pdst-- = *psrc--;
        }
    }
    else {
        psrc = src;
        pdst = dst;
        while(size--) {
            *pdst++ = *psrc++;
        }
    }
    return dst;
}
void my_memcpy(void* dst, const void* src, size_t n); // 区域不可以重叠
void my_memmove(void* dst, const void* src, size_t n); // 区域可以重叠
int my_strcmp(const char* src1, const char* src2) {
    int ret = 0;
    while(!(ret = *src1 - *src2) && *src2 && *str1) {
        ++src1; ++src2;
    }
    if(ret < 0) return -1;
    else if(ret > 0) return 1;
    return 0;
}
char* my_strstr(char* src1, const char* src2) {
    if(src2 == NULL || !*src2) return src1;
    if(src1 == NULL || !*src2) return NULL; //
    int pj = kmp(strlen(str1), strlen(src2));
    if(pj == -1) return NULL;
    return src1 + pj;
}
char* my_strstr2(char* src1, const char* src2) {
    if(src2 == NULL || !*src2) return src1;
    if(src1 == NULL || !*src1) return NULL; //
        while(*str1) {
        for(int i = 0; *(str1+i) == *(str2+i); ++i) {
            if(!*(str2+i+1)) return str1;
        }
        str1++;
    }
    return NULL;
}
```

## 12. 6种排序的手写 

堆排序

```cpp
input ： 8, 5, 4, 9, 2, 3, 6 
void heapify(int a[], int i, int size) { // 堆化的维持需要用递归  
    int ls = 2*i, rs = 2*i + 1;  
    int large = i;  
    if(ls <= size && a[ls] > a[i]) {  
        large = ls;  
    }  
    if(rs <= size && a[rs] > a[large]) {  
        large = rs;  
    }  
    if(large != i) {  
        swap(a[i], a[large]);  
        heapify(a, large, size);  
    }  
}  
void buildHeap(int a[], int size) {  
    for(int i = size/2; i >= 1; i--) {  
        heapify(a, i, size);  
    }  
}  
void heapSort(int a[], int size) {  
    buildHeap(a, size);  
    int len = size;  
    for(int i = len; i >= 2; i--) {  
        swap(a[i], a[1]);  
        len--;  
        heapify(a, 1, len);  
    }  
}  
```

快速排序

```cpp
void quickSort(int a[], int left, int right) {  
    if(left < right) {  
        int l = left, r = right, x = a[l];  
        while(1) {  
            while(l < r && a[r] >= x) r--;  
            while(l < r && a[l] <= x) l++;  
            if(l >= r) break;  
            swap(a[r], a[l]);  
        }  
        swap(a[left], a[l]);  
        quickSort(a, left, l-1);  
        quickSort(a, l+1, right);  
    }  
}
```

归并排序

```cpp
void mergeSort(int a[], int l, int r) {  
    if(l >= r) return;  
    int mid = (l+r) / 2;  
    mergeSort(a, l, mid);  
    mergeSort(a, mid+1, r);  
    int *arr = new int[r-l+1];  
    int k = 0;  
    int i = l, j = mid+1;  
    while(i <= mid && j <= r) {  
        if(a[i] <= a[j]) {  
            arr[k++] = a[i++];  
        }  
        else {  
            arr[k++] = a[j++]; // ans += (mid+1-i);  
        }  
    }  
    while(i <= mid) arr[k++] = a[i++];  
    while(j <= r) arr[k++] = a[j++];  
  
    for(int i = l; i <= r; i++) {  
        a[i] = arr[i-l];  
    }  
    delete []arr;  
}
```

插入排序

```cpp
void insertSort(int a[], int len) {  
    int j;  
    for(int i = 1; i < len; i++) {// 新抓的每张扑克牌  
        int temp = a[i];  
        for(j = i-1; a[j] > temp && j >= 0; j--) {  
            a[j+1] = a[j];  
        }  
        a[j+1] = temp;  
    }  
}
```

冒泡排序

```cpp
void bubbleSort(int a[], int len) {  
    for(int i = 1; i < len; i++) {  
        for(int j = 0; j < len-i; j++) {  
            if(a[j] > a[j+1]) swap(a[j], a[j+1]);  
        }  
    }  
}
```

选择排序

```cpp
void selectSort(int a[], int len) {  
    int i, j, k;  
    for(i = 0; i < len-1; i++) {  
        k = i;  
        for(j = i+1; j < len; j++) {  
            if(a[j] < a[k]) k = j;  
        }  
        swap(a[i], a[k]);  // 将第i位小的数放入i位置  
    }  
}
```

## 13. 字符串的全排列

```cpp
void res(char *str, char *pStr) {
    if(*pStr == '\0') cout << str << endl;
    for(char *p = pStr; *p != '\0'; ++p) {
        char tmp = *p;
        *p = *pStr;
        *pStr = tmp;
        res(str, pStr+1);
        tmp = *p;
        *p = *pStr;
        *pStr = tmp;
    }
}
```

## 15. 二叉树非递归先根遍历和中序遍历

```cpp
void fPre(Node* root) { // 先根遍历    根->左->右
    Node* p = root;
    stack<Node*>    S;
    while(1) {
        if(p != NULL) {
            cout << p->value << ' ';
            S.push(p);
            p = p->lchild;
        }
        else {
            if(S.empty()) return;
            p = S.top(); S.pop();
            p = p->rchild;
        }
    }
}
void fIno(Node* root) {
    Node* p = root;
    stack<Node*> S;
    while(1) {
        if(p != NULL) {
            S.push(p);
            p = p->lchild;
        }
        else {
            if(S.empty()) return;
            p = S.top(); S.pop();
            cout << p->value <<    ' ';
            p = p->rchild;
        }
    }
}
```
            
## 16. 链表的归并，翻转，找环， 查找

### 16.1 链表的归并

```cpp
struct Node { Node *next; int value; }; 
/* 你一定要相信递归是一个强大的思想 */
Node* mergeList(Node* head1, Node* head2) { // 有序链表的合并
    if(head1 == NULL) return head2;
    if(head2 == NULL) return head1;
    Node* tmp;
    if(head1->value < head2->value) {
        tmp = head1;
        head1 = head1->next;
    }
    else {
        tmp = head2;
        head2 = head2->next;
    }
    tmp->next = mergeList(head1, head2);
    return tmp;
}
Node* mergeSort(Node* head) {
    if(head == NULL) return NULL;
    Node* r_head = head;
    Node* head1 = head;
    Node* head2 = head;
    while(head2->next != NULL && head2->next->next != NULL) {
        head1 = head1->next;
        head2 = head2->next->next;
    }
    if(head1->next == NULL) return r_head; // 只有一个节点
    head2 = head1->next;
    head1 = head;
    r_head = mergeList(mergeSort(head1), mergeSort(head2));
    return r_head;
}
```

### 16.2 链表的翻转

```cpp
Node* head;   
Node* reverse(Node* head) {  
    if(head == NULL) return NULL;  
    Node* tmp = head;  
    Node*p;  
    while(tmp->next != NULL) {  
        p = tmp->next;  
        tmp->next = p->next;  
        p->next = head;  
        head = p;  
    }  
    return head;  
}  
```

* 16_3 查找链表的第 k 个节点 [过]
* 16_4 O(1) 时间删除链表节点
* 16_5 在单链表末尾添加一个节点 (陷阱 ： 链表为空)
* 16_6 删除链表中第一个指定值的节点。(健壮性)
* 16_7 复杂链表的复制。 空间-O(1) 时间O(n)
>    (1), 对原链表任意节点N，创建N', 将其放在 N 之后。
>    (2), N 的Sib指向 S，复制 N'的Sib, 指向 S 的下一个节点S’。
>    (3), 拆开链表，奇数位一个链表，偶数位一个。
* 16_8 linkStack

```cpp
struct Node { char value; Node* next; };
bool push(Node* top, char x) {
    Node* tmp = new Node();
    if(tmp == NULL) return false;
    tmp->value = x;
    tmp->next = top->next; // 插入一个节点so easy!
    top->next = tmp;
    return true;
}
bool pop(Node* top) {
    Node* tmp = top->next;
    if(tmp == NULL) return false;
    top->next = tmp->next;
    delete tmp;
    return true;
}
char get_top(Node* top) {
    if(top->next != NULL) {
        return top->next->value;
    }
    return '#';
}
```

## 17. 数组的一些题目

* 17_01 找最小的 k 个元素

```cpp
const int N = 105;
int a[N] = {4, 5, 1, 6, 2, 7, 3, 8};
int part (int *a, int left, int right) {
    if(left < right) {
        int x = a[0], l = left, r = right;
        while(l < r) {
            while(l < r && a[r] >= x) r--;
            while(l < r && a[l] <= x) l++;
            if(l >= r) break;
            swap(a[l], a[r]);
        }
        swap(x, a[l]);
        return l;
    }
    else return left;
}
```

```cpp
void set_k(int *input, int n, int k) { 
    if(input == NULL || k > n || k <= 0 || n <= 0) return;
    int start = 0, end = n    - 1;
    int index = part(input, start, end);
    while(index != k-1) {
        if(index > k-1) end = index - 1;
        else if(index < k - 1) start = index + 1;
        else break;
        index = part(input, start, end);
    }
}
```

* 17_02 数组中出现次数超过一半的数字 发帖水王

```cpp
int a[N] = { 1, 2, 3, 2, 2, 2, 5, 4, 2};
int core(int *a, int len) {
    if(a == NULL || len < 1) return -1;
    int result = a[0];
    int times = 1;
    for(int i = 1; i < len; ++i) {
        if(times == 0) {
            result = a[i];
            times = 1;
        }
        else {
            if(a[i] == result) times++;
            else --times;
        }
    }
    return result; // 在数据合法的情况下。
}
```

* 17_03 顺时针打印矩阵 （col > start*2 && row > start*2）
* 17_04 调整数组顺序使奇数位于偶数前面 (bool (*func)(int))
* 17_05 二维数组中的查找 （剑指）
* 17_06 旋转数组的最小元素。 [3, 4, 5, 1, 2], [1, 2, 3, 4, 5]

```cpp
int a[N] = {3, 4, 5, 1, 2};
int get_min(int *a, int len) {
    if(a == NULL || len <= 0) return -1;
    int p1 = 0, p2 = len-1;
    int mid = p1;
    while(a[p1] >= a[p2]) {
        if(p2 - p1 == 1) {mid = p2; break;}
        mid = (p1 + p2) / 2;
        if(a[p1] <= a[mid]) p1 = mid;
        else if(a[p2] >= a[mid]) p2 = mid;
    }
    return mid;
}
```

## 18. 涉及 栈，队列的的 3 道题

### 18.1 包含 min 函数的栈

```cpp
template <typename T>
class StackWithMin {
public :
    StackWithMin() {}
    virtual ~StackWithMin() {}
    const size_t size() const;
    void pop();
    void push(const T&);
    T top() const;
    T min();
private :
    deque<T> m_data;
    deque<T> m_min;
};
template <typename T>
const size_t StackWithMin<T>::size() const {
    return m_data.size();
}
template <typename T>
void StackWithMin<T>::pop() {
    assert(!m_data.empty() && !m_min.empty());
    m_data.pop_front();
    m_min.pop_front();
}
template <typename T>
void StackWithMin<T>::push(const T& value) { // core 就是这个函数
    m_data.push_front(value);
    if(m_min.empty() || value < m_min[0]) {
        m_min.push_front(m_min[0]);
    }
    else m_min.push_front(m_min[0]);
}
template <typename T>
T StackWithMin<T>::top() const {
    assert(!m_data.empty() && !m_min.empty());
    return m_data[0];
}
template <typename T>
T StackWithMin<T>::min() {
    assert(!m_data.empty() && !m_min.empty());
    return m_min[0];
}
```

### 18.2 两个栈实现队列

```cpp
template<typename T>
class Queue {
public :
    Queue() {}
    ~Queue() {}
    T front();
    void pop();
    void push(const T&);
private :
    stack<T> S1;
    stack<T> S2;
};
template<typename T>
T Queue<T>::front() { // core 就是这个函数
    if(!S2.empty()) {
        T tmp = S2.top();
        return tmp;
    }
    else {
        assert(!S1.empty());
        while(!S1.empty()) {
            S2.push(S1.top());
            S1.pop();
        }
        T tmp = S2.top(); S2.pop();
        return tmp;
    }
}
template<typename T>
void Queue<T>::pop() {
    if(!S2.empty()) {
        S2.pop();
    }
    else {
        assert(!S1.empty());
        while(!S1.empty()) {
            S2.push(S1.top());
            S1.pop();
        }
        S2.pop();
    }
}
template<typename T>
void Queue<T>::push(const T& value) {
    S1.push(value);
}
```

### 18.3 栈的 push pop 序列

// 1 2 3 4 5
// 4 3 5 1 2

```cpp
bool solve(int *pPush, int *pPop, int len) {
    bool flag = false;
    if(pPush != NULL && pPop != NULL && len > 0) {
        int *pNextPush = pPush;
        int *pNextPop = pPop;
        stack<int> S;
        while(pNextPop - pPop < len) {
            while(S.empty() || S.top() != *pNextPop) {
                if(pNextPush - pPush == len) break;
                S.push(*pNextPush);
                ++pNextPush;
            }
            if(S.top() != *pNextPop) break;
            S.pop();
            ++pNextPop;
        }
        if(pNextPop - pPop == len) flag = true;
    }
    return flag;
}    
```

## 19. 蓄水池原理 随即取样问题

要求从 N 个元素中随机的抽取 k 个元素，其中 N 无法确定。

```cpp
for i=k+1 to N
    M = random（1, i);
    if(M < k) swap(Mth value, ith value);
```

## 20. 最长上升子序列

- m_14 poj 3903 最长上升子序列 dp n^2 vs （二分 nlogn）
 
> F[t] 表示从 1 到t这一段中以 t 结尾的最长上升子序列的长度. 
> F[t] = max(1, F[j]+1); (j = 1, 2, ..., t-1. 且 A[j] < A[t]). 

此方程让我想到可以对比连续子数组的最大和。   

>  dp: F[i] = max(a[i], F[i-1]+a[i]);  

[子序列问题（递增、公共、摆动）](https://blog.csdn.net/sisteryaya/article/details/82937967)

## 21. 寻找丑数 

不在非丑数上浪费时间，只看在丑数上的方法！ 

```cpp
pun[0] = 1; ind = 1; p2 = p3 = p5 = pun; while;
```

## 22. 圆圈中最后剩下的数字。

```cpp
int cirnm(int n, int m) {
    if(n < 1 || m < 1) return -1;
    int i = 0, count = 0; 
    list<int> L;
    for(int i = 0; i < n; i++) L.push_back(i);
    list<int>::iterator lcur = L.begin(), next;
    while(!L.empty()) {
        for(int i = 1; i < m; ++i) {
            lcur++;
            if(lcur == L.end()) lcur = L.begin();
        }
        next = lcur + 1;
        if(next == L.end()) next = L.begin();
        L.erase(lcur);
        count++;
        if(count == n - 1) break;
        lcur = next;
    }
    return *lcur;
}
```

## 23. 从 1 到 n 的整数中 1 出现的次数

> f(10^n-1) = n * 10^(n-1)

## 24. 数值的整数次方

> a^n = a^n/2 * a^n/2;（偶数）    
> 奇数的话再乘以 a.（递归神技）

## 25. 一些面试小题

面试题10 : 打印 1 到最大的 n位数。
面试题11 : 替换空格。(从后向先，先计算出长度！) ' ' -> %20
面试题12 : 无符号整数二进制中 1 的个数。 (n-1)&n     O(1的个数)。
面试题13 : 求 1+2+3+...+n, 要求不能使用，乘除法，for,while,if,else,switch,case。(n>1)&&(i=res(n-1)+n);
面试题14 : 不能用 +, -, *, %, /,实现int add(int num1, int num2); （^, &<<1）
面试题15 : 子数组的最大乘积。计算任意(N-1)个数的组合乘积最大的一组。P(0, 正，负)

```cpp
void res(char *number, int len, int index) {
    if(index == len-1) {
        printNum(number, len); return;
    }
    for(int i = 0; i < 10; i++) {
        number[index+1] = '0'+i;
        res(number, len, index+1);
    }
}
void solve(int n) {
    if(n <= 0) return;
    char *str = new char[n+1];
    str[n] = '\0';
    for(int i = 0; i < 10; i++) {
        str[0] = '0' + i;
        res(str, n, 0);
    }
    delete []str;
}                
```
  
## 29. 矩阵相乘

```cpp
a[m][n] * b[n][m] = c[m][m];
a :    a b c
       d e f
b:     1 2
       3 4
       5 6
结果 c :  1a+3b+5c  2a+4b+6c
         1d+3e+5f  2d+4e+6f
         
int a[2][3] = {{100, 200, 300}, {400, 500, 600}};  
int b[3][2] = {{1, 2}, {3, 4}, {5, 6}};  
int c[2][2];  
void solve(int m, int n) {  
    for(int i = 0; i < m; ++i) {  
        for(int j = 0; j < m; j++) {  
            for(int k = 0; k < n; k++) {  
                c[i][j] += a[i][k]*b[k][j];  
            }  
        }  
    }  
    for(int i = 0; i < m; ++i) {  
        for(int j = 0; j < m; ++j) {  
            cout << c[i][j] << ' ';  
        }  
        cout << endl;  
    }  
}  
int main() {  
    solve(2, 3);  
    return 0;  
}
  
Output :
  1400 2600 
  3200 6200
```

## 30. 数组相关的一些经典题目

1.1   如何用递归实现数组求和 return n == 0 ? 0 : getSum(a, n-1) + a[n-1];
1.2   如何用一个for循环打印出一个二维数组 (过)
1.4   如何用递归算法判断一个数组是否是递增 return (a[n-1] > a[n-2]) && isIncrease(a, n-1);
1.5   如何分别使用递归与非递归实现二分查找算法(过)
1.6   如何在排序数组中，找出给定数字出现的次数(二分好的题目) 

```cpp
int solve(int *a, int len, int num, bool isLeft);
```

1.7   如何计算两个有序整型数组的交集

> 情况1 : 两数组长度相差不悬殊，解决方法：哈希其中一数组，在遍历另一个数组。 
> 情况2 : 相差悬殊。小的数组中的数字，分别在长数组上二分查找。

1.8   如何找出数组中重复次数最多的数, 好题 map，遍历，if(++m[a[i]] >= m[val]) val = a[i] )
1.9   如何在O(n)的时间复杂度内找出数组中出现次数超过了一半的数(过，但是非常好的题目！，有一个count)
1.11 如何判断一个数组中的数值是否连续相邻 (未描述完整，解决 ： 非0最大 非0最小 <= 4)
1.12 如何找出数组中出现奇数次的元素 (过)
1.13 如何找出数列中符合条件的数对的个数 (排序，两边夹-O(nlogn) / 计数排序-O(n))
1.14 如何寻找出数列中缺失的数 (异或 O(2\*n) / (n+1)\*n / 2 sum O(n))
1.15 如何判定数组是否存在重复元素 a[n],元素取值范围也是 1~n  

> (解析 ： bitmap, 费空间 /  茂旭神之法，死磕到底O(2n)

1.16 如何重新排列数组使得数组左边为奇数，右边为偶数 (类似于快排的思想)

1.17 如何把一个整型数组中重复的数字去掉

```cpp
// sort1 1 1 2 2 3, 遍历数组，k=0, i=1; 

if(a[k] != a[i])) {
    a[k+1]=a[i];
    k++
}
```

1.18 如何找出一个数组中第二大的数

> (解析 ：法1 : 堆筛。 法2 : 遍历，用两个变量记录 maxv=a[0] ,sec_max=MIN, 更新)

1.19 如何最少的比较次数寻找数组中的最小值和最大值

《编程之美》 168P，给的证明比较次数为 1.5N 次

```cpp
void getMaxMin(int *a, int low, int high, int& maxv, int& minv) {  
    int mid, max1, max2, min1, min2;  
    if(high - low == 1 || high - low == 0) {  
        a[low] > a[high] ? (maxv = a[low], minv = a[high]) : (maxv = a[high], minv = a[low]);  
    }  
    else {  
        mid = (high + low) / 2;  
        getMaxMin(a, low, mid, max1, min1);  
        getMaxMin(a, mid+1, high, max2, min2);  
        maxv = max2 > max1 ? max2 : max1;  
        minv = min2 > min1 ? min1 : min2;  
    }  
}
```
  
1.20 如何将数组的后面m个数移动为前面m个数。 解析 ： 不就是左旋转！ OK！
1.21 如何计算出序列的前n项数据

> 描述 ： 正整数序列Q中的每个元素都至少能被正整数 a 和 b 中的一个整除。 求 序列前 n 项数据？

```cpp    
解析 ： 类似于归并的思想

for(int k = 0; k < N; k++) {
    tmpA = a*i; tmpB = b*j; 
    if(tmpA <= tmpB) {
        Q[k] = tmpA; i++;
    } 
    else ..
}
```

1.23 如何判断一个整数x是否可以表示成n（n≥2）个连续正整数的和

> 解析 ：
>
> x = m + (m+1) + (m+2) + ... + (m+n-1), 推出 : m = (2\*x / n - n + 1) / 2; m >= 1;
> 
> 也就是判断 (2\*x / n - n + 1) 是不是偶数的问题。
>    
> tmp = m; if(tmp == (int)tmp) 就 OK！

## 32. 链表经典的一些题目

2.5 如何找出单链表中的倒数第k个元素(过)
2.6 如何实现单链表反转 (很好的题目，三指针法！)
2.7 如何从尾到头输出单链表(过)
2.9 如何进行单链表排序(很好 ： 归并排序法)
2.10 如何实现单链表交换任意两个元素（不包括表头）(非常好的题目)
2.11 如何检测一个较大的单链表是否有环
2.12 如何判断两个单链表（无环）是否交叉
2.13 如何删除单链表中的重复结点
2.15 什么是循环链表
2.16 如何实现双向链表的插入、删除操作
2.18 如何删除结点的前驱结点
2.19 如何实现双向循环链表的删除与插入操作 343
2.20 如何在不知道头指针的情况下将结点删除 344

