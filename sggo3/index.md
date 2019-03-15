
short part

[正态分布-通俗知乎](https://www.zhihu.com/question/56891433)

[机器学习中的损失函数](https://blog.csdn.net/u010976453/article/details/78488279)

[LR 和 SVM 的 不同](/2018/06/23/ml/model-lr-vs-svm/)

[ID3、C4.5、CART、随机森林、bagging、boosting、Adaboost、GBDT、xgboost算法总结](https://zhuanlan.zhihu.com/p/34534004)

[从零开始使用TensorFlow建立简单的逻辑回归模型](https://segmentfault.com/a/1190000009954640)

[CNN如何做Padding](https://zhuanlan.zhihu.com/p/36278093)

seq2seq模型，并主要介绍了一下attention机制，让写了下attention的公式，怎样计算得分和权重，说了下soft attention和hard attention的区别。然后聊了下tensorflow里面seq2seq的借口

SVM 算法 与 tensorflow 实现 LR

## LR

[Logistic Regression常见面试题整理](https://zhuanlan.zhihu.com/p/34670728)

1. 怎么防止过拟合？
2. 为什么正则化可以防止过拟合？ 
3. L1正则和L2正则有什么区别？
4. 如何用LR解决非线性问题？
5. 工程上，怎么实现LR的并行化？有哪些并行化的工具

> 为什么正则化可以防止过拟合？
>
> 过拟合表现在训练数据上的误差非常小，而在测试数据上误差反而增大。其原因一般是模型过于复杂，过分得去拟合数据的噪声。正则化则是对模型参数添加先验，使得模型复杂度较小，对于噪声扰动相对较小。


## 0. 字符串

027-字符串的排列  ok.   
028-[反转字符串单词](https://blog.csdn.net/koala_tree/article/details/79625599)  ok.   
029-左旋转字符串  ok
030-[字符串转整型](https://blog.csdn.net/u010429424/article/details/78054448)       


[必刷-刷题小结](https://zhuanlan.zhihu.com/p/56200260)

## 1. LinkedList

003-从尾到头打印链表, 递归 ok.    
014-链表中倒数第k个结点 ok.   
015-反转链表    
016-合并两个或k个有序链表  ok， 递归 (三元运算符).   
025-复杂链表的复制    
036-两个链表的第一个公共结点  ok.   
055-链表中环的入口结点     
056-删除链表中重复的结点  链表1->2->3->3->4->4->5 处理后为 1->2->5.   

## 2. Tree

004-重建二叉树 ok Node* f3(int* pre, int\* ino, int len)       
017-树的子结构  ok 递归 , 需要2个函数，牛题.   
018-二叉树的镜像  ok 递归.   
022-从上往下打印二叉树 ok bfs      
023-二叉搜索树的后序遍历序列 ok.   
024-二叉树中和为某一值的路径 ok     
026-二叉搜索树与双向链表  ok.   
038-二叉树的深度  ok.   
039-平衡二叉树  ok.    
057-[二叉树的下一个结点](https://blog.csdn.net/libin1105/article/details/48422299)  ok       
058-对称的二叉树 ok      
059-按之字形顺序打印二叉树      
060-把二叉树打印成多行  ok.   
061-序列化二叉树      
062-二叉搜索树的第k个结点 ok.   
063-[二叉查找树节点的删除](https://blog.csdn.net/xiaoxiaoxuanao/article/details/61918125).  重要

## 3. Stack & Queue

## 4. heap

## 5. 具体算法类题目

### 5.1 斐波那契数列

007-斐波拉契数列 ok.   
008-跳台阶  ok.   
009-变态跳台阶  2 \* Fib(n-1).   
010-矩形覆盖  ok

### 5.2 搜索算法

001-二维数组查找  ok ， bool find(int a[], rows, cols, value) 右上角.   
006-旋转数组的最小数字（二分查找）  ok.   
037-数字在排序数组中出现的次数（二分查找）  ok.   

### 5.3 全排列

027-字符串的排列  ok.   
028-[反转字符串单词](https://blog.csdn.net/koala_tree/article/details/79625599)  ok.   
029-左旋转字符串  ok

### 5.4 动态规划

030-连续子数组的最大和 ok     
052-正则表达式匹配(我用的暴力)  (过滤)

### 5.5 回溯

065-矩阵中的路径(BFS).   
066-机器人的运动范围(DFS)

### 5.6 排序

035-数组中的逆序对(归并排序).  
029-最小的K个数(堆排序).   
029-最小的K个数(快速排序) ok

### 5.7 位运算

011-二进制中1的个数  n & n-1.   
012-数值的整数次方 dp.   
040-数组中只出现一次的数字 ok.  

### 5.8 其他算法

002-替换空格 ok.   
013-调整数组顺序使奇数位于偶数前面 ok.   
028-数组中出现次数超过一半的数字 ok.   
031-整数中1出现的次数（从1到n整数中1出现的次数）.    
032-把数组排成最小的数.  
033-丑数 ok.   
041-和为S的连续正数序列(滑动窗口思想) ok.   
042-和为S的两个数字(双指针思想) ok.   
043-左旋转字符串(矩阵翻转).   
046-孩子们的游戏-圆圈中最后剩下的数(约瑟夫环) ok.   
051-构建乘积数组


```cpp
/* 03_二维数组中的查找 */ bool find(int a[], rows, cols, value) 右上角 
/* 04_替换空格 */       char* replace(char* str, int len) 在源数组上先计算总长度，从后向前，逐个赋值
/* 05_从尾到头打印链表 */ void printLinkList(Node* p) 利用递归 或者 栈
/* 06_重建二叉树 根据前序与中序 */ Node* f3(int* pre, int* ino, int len)
/* 07_两个栈实现队列 */
/* 08_旋转数组的最小元素 */  int get_min(int *a, int len)
/* 09_斐波那契数列及其变形 */
/* 10_二进制中 1 的个数 */  n & (n-1)
/* 11_数值的整数次方 */   a = a^n/2 * a^n/2 (偶数， 奇数 * a)， 利用递归
/* 12_打印1到最大的n位数 */ void res(char *number, int len, int index) void solve(int n)
/* 13_在O(1)时间删除链表结点 */ [表头，表中，表尾](https://blog.csdn.net/cxllyg/article/details/7614440)
/* 14_调整数组位数使奇数位于前面 */
/* 15_链表中倒数第k个结点 */
/* 16_反转链表 三指针法*/
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
/* 29_数组中出现次数超过一半的次数 */ int core(int *a, int len)
/* 30_最小的K个数 */ part 快排思想 + void set_k(int* input, int n, int k)
/* 31_连续子数组的最大和 */  // dp: F[i] = max(a[i], F[i-1]+a[i]);
/* 32_从1到n整数中1出现的次数 狗血题 */
/* 33_把数组排成最小的数 */ // 心得 ： 排序cmp写好
/* 34_丑数 */ 能整除 2 或者 3 或者 5 的数定义为丑数   ac
/* 35_第一个只出现一次的字符
/* 36_数组中的逆序对 */ https://blog.csdn.net/bf23456/article/details/51303632
/* 37_两个链表的第一个公共节点 */ // 会(略)
/* 38_数字在排序数组中出现的次数 */ 二分查找
/* 39_二叉树的深度 */ 递归，easy
 * 从二叉树的深度扩展到判断是否为平衡二叉树 */
/* 40_数组中只出现一次的数字 41_递增序列和为S的两个数字  */ // 略
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
m_0606 如何判断两颗二叉树是否相等。
 A, B 两棵树相等，当且仅当 rootA->c == rootB->c; 而且A,B左右子树相等。我觉得是这样！

******** 第 14 章 海量数据处理 ********     
14-1 基本方法
  针对海量数据 ： Hash法，Bit-map法， Bloom filter法， 数据库优化法，倒排索引法，外排序法，Trie法，堆，双层桶法以及MapReduce法。
m_0301 topK 问题
topK : 分治 + Trie, 树/hash + 小项堆， 即先将数据集按照Hash方法分解成多个小数据集，
 然后使用Trie树或者Hash统计每个小数据集中出现频率最高的前K个数 ，最后在所有 topK 中求出最终的 top K.
例如 ： 有 1 亿个浮点数，如何找出其中最大的 10000 个？ [一亿个float 400M， 内存小的计算机排不了！]
 answ1 : 局部淘汰法  用一个容器保存前 10000 个数，然后将剩余的所有数字一一与容器内的最小数字相比。
 answ2 : 分治法  1 亿 = 100 个 100万。  100W 查找 10000 用类似快排的分治法。
 answ3 : 先 hash 去重。然后通过 分治法 或 最小堆法 查找最大的 10000 个数。
 answ4 : 最小堆。首先读入 1W 个数来创建大小为 1W 的小项堆。建堆的时间复杂度为 O(logm)
下面针对不同的应用场景分析 ： 1) 单机器，单核，足够大内存 2) 单机，多核，足够大内存 3) 单机，单核，受限内存 4) 多机，受限内存
```


