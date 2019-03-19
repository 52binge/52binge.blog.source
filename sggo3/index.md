### 1. 字符串

> 1. 字符串的排列 void res(char \*str, char \*pStr), scanf("%s", str); \#include < utility\> 
> 2. 反转字串单词 string ReverseSentence(string str), reverse(str.begin(), str.end()); in lib algorithm
> 3. 左旋转字符串 string LeftRotateString(string str, int n),string Reverse(string str)
> 4. 字符串转整型 int StrToInt(char* str)       ok

### 2. 数组 & 排序

> 1. 二维数组中的查找 bool Find(int\* matrix, int rows, int cols, int value)用一维 \*(matrix+i\*cols+j)
> 2. 替换空格 char\* replace(char\* str, int len) ‘ ’->%20 在源数组总长度，从后向前，逐个赋值
> 3. 旋转数组的最小元素 int get_min(int \*a, int len)
> 4. 调整数组位数使奇数位于前面 void reorderOddEven(int[] arr) 
> 5. 数组中出现次数超过一半的次数 \* int core(int \*a, int len)
> 6. 最小的K个数  part 快排思想 + void set_k(int\* input, int n, int k) **nok**
> 7. 连续子数组的最大和   // dp: F[i] = max(a[i], F[i-1]+a[i]);
> 8. 把数组排成最小的数  #include < sstream \> ostringstream oss;oss <<t; oss.str() bool Compare(const string &left, const string &right)
> 9. [数组中的逆序对](https://blog.csdn.net/bf23456/article/details/51303632)
> 10. 数组中只出现一次的数字 , 划分2数组，num & (-num);二者与后得到的数，将num最右边的1保留下来
> 11. 丑数 ok
> 12. 整数中1出现的次数（从1到n整数中1出现的次数）. **nok**
> 13. 和为S的连续正数序列(滑动窗口思想) left=1, right = 2, total = (left + right) \* (right - left + 1) / 2; 
> 14. 和为S的两个数字(双指针思想) ok.
> 15. 孩子们的游戏-圆圈中最后剩下的数(约瑟夫环) ok.
> 16. [构建乘积数组](https://blog.csdn.net/u012327058/article/details/81007333)
> 17. 如何在排序数组中找出给定数字出现的次数 int bina(int \*a, int len, int num, bool isLeft)
> 18. [最短路Floyd](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html)
> 19. quick_sort 双 while + one swap

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

### 4. Tree

> 1. 重建二叉树 ok Node* f3(int* pre, int\* ino, int len)       
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

