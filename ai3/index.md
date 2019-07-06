
<img src="/images/icpc/Array-In-C.png" width="580" />

## 1. Array

**1.1 easy**

> 1. **二维数组中的查找** bool Find(int\* matrix, int rows, int cols, int value)用一维/二维 \*(matrix+i\*cols+j)
> 2. 替换空格 char\* replace(char\* str, int len) ‘ ’->%20 在源数组总长度，从后向前，逐个赋值
> 3. 如何在排序数组中找出给定数字出现的次数 int bina(int \*a, int len, int num, bool isLeft)
> 4. 旋转数组的最小元素 int get_min(int \*a, int len) , while(a[p1] >= a[p2]) {
> 5. 调整数组位数使奇数位于前面 void odds(int[] arr) 
> 6. 次数超过一半的次数 \* int core(int \*a, int len)
> 7. **丑数**, 只包含质因子2、3和5的数称作丑数, 1, 2, 3, 5, 6, ... ok
> 8. 和为S的两个数字(双指针思想) ok.

**1.2 medium**

> 1. **八皇后**， void dfs(int n)
> 2. 孩子们的游戏-圆圈中最后剩下的数(约瑟夫环) ok.
> 3. [把数组排成最小的数](https://www.cnblogs.com/youxin/p/3294154.html) #include < sstream > bool Compare(const string &left, const string &right)
> 4. 数组中只出现一次的数字 , 划分2数组，num & (-num);二者与后得到的数，将num最右边的1保留下来
> 5. **连续子数组的最大和**   // dp: F[i] = max(a[i], F[i-1]+a[i]);

**1.3 important**

> 1. quick_sort, while (双while + swap)
> 2. merge_sort
> 3. [数组中的逆序对](https://blog.csdn.net/bf23456/article/details/51303632)
> 4. **最小的K个数 ** part 快排思想 + void set_k(int\* input, int n, int k) **nok**
> 5. [最短路Floyd](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html)

**1.4 difficult**

> 1. 整数中1出现的次数（从1到n整数中1出现的次数）. **nok**
> 2. 和为S的连续正数序列(滑动窗口思想) left=1, right = 2, total = (left + right) \* (right - left + 1) / 2; 
> 3. [构建乘积数组](https://blog.csdn.net/u012327058/article/details/81007333)

1.1 八皇后

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
int main() {
    res = dfs(0);
    cout << res << endl;
    return 0;
}
```

1.2 二维数组中的查找

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

1.3 替换空格

```cpp
char* replace(char* str, int len) {
    
    while(str[len] != '\0'){
    
        if(str[len] == ' '){
            konglen++;
        }

        len++;
    }

    return '\0';
}
```

1.4 旋转数组的最小元素

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

1.5 调整数组位数使奇数位于前面

```cpp
void reorderOddEven(int[] arr, len) {
    if (arr == NULL || len <= 1 ) {
        return;
    }
    int l = 0, r = len - 1;
    while (l < r) {
        while (l < r && arr[r] % 2 == 0) {
            r--;
        }
        while (l < r && arr[l] % 2 == 1) {
            l++;
        }
        if (l < r) {
            swap(arr[l], arr[r]);
            l++, r--;
        }
    }
}   
```

1.5 出现次数超过一半的次数

```cpp
int core(int *a, int len) {
    if (arr == NULL || len <= 0 ) {
        return;
    }
    int target = a[0], cnt = 1;
    
    for (int i = 1; i < len; i++) {
        if (a[i] == target) {
            cnt++;
        }
        else {
            cnt--;
            if (cnt == 0) {
                target = a[i];
                cnt = 1;
            }
        }
    }
    return target;
}
```


1.6 最小的K个数  part 快排思想

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

void set_k(int *input, int n, int k) {
     
    if(input == NULL || k > n || k <= 0 || n <= 0) {
        return;
    }
    int start = 0, end = n - 1;
    
    int index = part(input, start, end);
    
    while(index != k-1) {
        
        if(index > k-1) {
            end = index - 1;
        }
        else if(index < k - 1) {
            start = index + 1;
        }
        else {
            break;
        }
        index = part(input, start, end);
    }
}
```

1.7 连续子数组的最大和

```cpp
dp: F[i] = max(a[i], F[i-1]+a[i]);
```

1.8 数组中的逆序对 & 归并排序

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

1.13 和为S的连续正序列(滑窗思想)

1.15 约瑟夫环

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

1.17 排序数组中某数字出现的次数

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

## 2. LinkedList

[linkedlist_summary](https://www.weiweiblog.cn/linkedlist_summary/)

**2.1 easy:**

> 1. 在 O(1) 时间删除链表节点
> 2. 删除单链表倒数第 n 个节点
> 3. 求单链表的中间节点
> 4. 判断单链表是否存在环
> 5. 从尾到头打印链表, 递归 ok.
> 6. 链表中倒数第k个结点 ok.
> 7. 判断两个无环单链表是否相交
> 8. 两个链表相交扩展：求两个无环单链表的第一个相交点
> 9. 两个链表的第一个公共结点  ok.   
> 10. 旋转单链表
> 
> 题目描述：给定一个单链表，设计一个算法实现链表向右旋转 K 个位置。
举例： 给定 1->2->3->4->5->6->NULL, K=3
则4->5->6->1->2->3->NULL

**2.2 medium:**

> 2. [反转链表][2.3] next=head->next, head->next=pre, pre=head, head=next; 4步 ok
> 3. 翻转部分单链表 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null
> 4. [复杂链表的复制][2.5] ok
> 7. 链表划分 （题目描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前）
> 9. 单链表排序
> 10. 合并两个或k个有序链表  ok， 递归 (三元运算符).   
> 12. 删除链表重复结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. first->next=head, last, p 三指针
> 10. 链表中环的入口结点     

单链表排序 or 合并两个或k个有序链表

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

**2.3 difficul:**

 1. 链表求和

[2.3]: https://www.jianshu.com/p/bd6a64d36916
[2.5]: https://zhuanlan.zhihu.com/p/38888164

**---**

**反转链表:**

```cpp
public ListNode reverseList(ListNode head) {
    ListNode next = null;
    ListNode pre = null

    while (head != null) {
        next = head.next; (保存当前头结点的下个节点)
        head.next = pre;  (将当前头结点的下一个节点指向“上一个节点”，这一步是实现了反转)
        pre = head;       (将当前头结点设置为“上一个节点”)
        head = next;      (将保存的下一个节点设置为头结点)
    }
    return pre;
}
```

**复杂链表的复制:**

![](https://pic2.zhimg.com/80/v2-995312b12e59f14c77f3572e9c94d4c5_hd.jpg)

```cpp
/*
public class RandomListNode {
    int label;
    RandomListNode next = null;
    RandomListNode random = null;

    RandomListNode(int label) {
        this.label = label;
    }
}
*/
```

```cpp
public class Solution {
    public RandomListNode Clone(RandomListNode pHead)
    {
        if(pHead == null)
            return null;
        //复制节点 A->B->C 变成 A->A'->B->B'->C->C'
        RandomListNode head = pHead;
        while(head != null){
            RandomListNode node = new RandomListNode(head.label);
            node.next = head.next;
            head.next = node;
            head = node.next;
        }
        //复制random
        head = pHead;
        while(head != null){
            head.next.random = head.random == null ? null : head.random.next;
            head = head.next.next;
        }
        //折分
        head = pHead;
        RandomListNode chead = head.next;
        while(head != null){
            RandomListNode node = head.next;
            head.next = node.next;
            node.next = node.next == null ? null : node.next.next;
            head = head.next;
        }
        return chead;
    }
}
```

**链表划分：**

给定一个单链表和数值x，划分链表使得所有小于x的节点排在大于等于x的节点之前。

你应该保留两部分内链表节点原有的相对顺序。

样例
给定链表 1->4->3->2->5->2->null，并且 x=3
返回** 1->2->2->4->3->5->null**

```java
    public ListNode partition(ListNode head, int x) {
        // write your code here
        if(head == null) return null;
        ListNode leftDummy = new ListNode(0);
        ListNode rightDummy = new ListNode(0);
        ListNode left = leftDummy, right = rightDummy;
        
        while (head != null) {
            if (head.val < x) {
                left.next = head;
                left = head;
            } else {
                right.next = head;
                right = head;
            }
            head = head.next;
        }
        
        right.next = null;
        left.next = rightDummy.next;
        return leftDummy.next;
    }
}
```

## 3. String

[13 道题搞定 BAT 面试——字符串](https://www.weiweiblog.cn/13string/)

**3.1 easy:**

> 1. 替换空格
> 2. 反转字符串 abcd -> dcba
> 3. 翻转单词顺序列， I am a student. -> student. a am I
> 4. 旋转字符串， abcde --2位--> cdeab, 若干次旋转操作之后，A 能变成B，那么返回True
> 5. 左旋转字符串 string LeftRotateString(string str, int n),string Reverse(string str)

> 反转字串单词 string ReverseSentence(string str), reverse(str.begin(), str.end()); in lib algorithm
 

```java
class Solution {
    public boolean rotateString(String A, String B) {
        return A.length() == B.length() && (A+A).contains(B);
    }
}
```

字符序列S=”abcXYZdef”,要求输出循环左移3位后的结果，即“XYZdefabc”。是不是很简单？OK，搞定它！

在第 n 个字符后面将切一刀，将字符串分为两部分，再重新并接起来即可。注意字符串长度为 0 的情况。

```java
public class Solution {
    public String LeftRotateString(String str,int n) {
        int len = str.length();
        if(len == 0)
            return "";
        n = n % len;
        String s1 = str.substring(n, len);
        String s2 = str.substring(0, n);
        return s1+s2;
    }
}
```

**3.2 medium:**

> 1. [字符流中第一个不重复的字符][3.2.1] (哈希来存每个字符及其出现的次数，另用一字符串 s 来保存字符流中字符顺序)
> 2. 字符串全排列 void res(char \*str, char \*pStr), scanf("%s", str); \#include < utility\> 
> 3. 字符串转整型 int StrToInt(char* str)       ok
> 4. 字符串的排列 (给定两个字符串 s1 和 s2，第一个字符串的排列之一是第二个字符串的子串)

[3.2.1]: https://www.weiweiblog.cn/firstappearingonce/

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

字符流中第一个不重复的字符 C++

```cpp
/class Solution
{
public:
  //Insert one char from stringstream
    
    // vector用来记录字符流
    vector<char> vec;
    // map用来统计字符的个数
    map<char, int> table;
    void Insert(char ch)
    {
        table[ch]++;
        vec.push_back(ch);
    }
  //return the first appearence once char in current stringstream
    char FirstAppearingOnce()
    {
        // 遍历字符流，找到第一个为1的字符
        for (char c : vec) {
            if (table[c] == 1)
                return c;
        }
        
        return '#';
    }

};
```

字符流中第一个不重复的字符 Java

```java
import java.util.HashMap;
public class Solution {
    HashMap<Character, Integer> map = new HashMap<Character, Integer>();
    StringBuffer s = new StringBuffer();
    //Insert one char from stringstream    
    public void Insert(char ch)    {
        s.append(ch);
        if(map.containsKey(ch)){
            map.put(ch, map.get(ch)+1);
        }else{
            map.put(ch, 1);
        }
    }
  //return the first appearence once char in current stringstream    
    public char FirstAppearingOnce()    {
        for(int i = 0; i < s.length(); i++){
            if(map.get(s.charAt(i)) == 1)
                return s.charAt(i);
        }
        return '#';
    }
}
```

**3.3 difficult:**

> 1. KMP 算法
> 2. 最长公共前缀
> 3. 最长回文串 (3.1) 验证回文串 (3.2) 最长回文子串 (3.3) 最长回文子序列
> 4. 表示数值的字符串

> 剑指offer: 表示数值的字符
> 
> 请实现一个函数用来判断字符串是否表示数值（包括整数和小数）。例如，字符串”+100″,”5e2″,”-123″,”3.1416″和”-1E-16″都表示数值。 但是”12e”,”1a3.14″,”1.2.3″,”+-5″和”12e+4.3″都不是。

## 4. Binary Tree

- [算法&数据结构 ， 20Tree](https://www.weiweiblog.cn/20tree/)

<img src="/images/icpc/BinaryTree-1.png" width="450" />

**4.1 easy**

> 1. 递归： [求二叉树中的节点个数][20tree] ， **✔️**
> 2. 递归： [求二叉树的最大层数(最大深度) & (最小深度)][20tree] 最小深度特殊情况：left/right==0 ， ✔️
> 3. 递归： [求二叉树第K层的节点个数][20tree] get_k(root.left, k-1) + get_k(root.right, k-1); ， ✔️
> 4. 递归： [求二叉树第K层的叶子节点个数][20tree] if(k==1 and root.left and root.right is null) return 1; ， ✔️
> 5. 递归： [二叉树先序遍历/前序遍历][20tree]  (非递归，也要练习，要会写)
> 6. 递归： [判断两棵二叉树是否结构相同][20tree] ， ✔️
> 7. 递归： [求二叉树的镜像（反转二叉树）][20tree]
> 8. 递归： [对称二叉树][20tree] （双函数，承接 上题二叉树的镜像）
> 9. 递归： [求二叉树中两个节点的最低公共祖先节点 good][20tree]
> 10. 递归： [求二叉搜索树的最近公共祖先 good][20tree]
> 11. 递归： [判断二叉树是不是完全二叉树][20tree] （利用层遍历。遍历到了NULL结点，如后续还有非NULL结点）

双函数，递归

> 1. 树的子结构,遍历+判断, bool f5(Node\* root1, Node\* root2), bool son(Node\* p1, Node\* p2) 
> 2. 判断二叉树是不是平衡二叉树 bool isBalance(Node\* root, int\* dep) 
> 3. 求二叉树的直径 （直径长度是任意两个结点路径长度中的最大值）

**4.2 medium**

> 1. 分层遍历 (自下而上分层遍历) bfs + vector< vector < int > >
> 2. 分层遍历 (按之字形顺序打印二叉树)
> 3. 重建二叉树 ok Node\* f3(int\* pre, int\* ino, int len) 

[20tree]: https://www.weiweiblog.cn/20tree/

**4.3 difficult:**
 
> 6. 二叉树中和为某一值的路径 void f4(Node\* root, int exSum, int curSum, vecotr\< int \>& path)    
> 10. [二叉树的下一个结点:3情况](https://blog.csdn.net/libin1105/article/details/48422299)  (1.有right.child 2.没有right.child,父left.child 3.没有right.child,父right.child)    
> 14. 序列化二叉树      
> 5. 二叉搜索树的后序遍历序列 bool f6(int\* sec, int len)  
> 7. 二叉搜索树与双向链表 void convert(Node\* root, Node\*& pLast)   
> 15. 二叉搜索树的第k个结点 ok.   
> 16. [二叉查找树节点的删除](https://blog.csdn.net/xiaoxiaoxuanao/article/details/61918125).  重要

平衡二叉树

```java
class Solution {
    public boolean isBalanced(TreeNode root) {
        if(root == null)
            return true;
        return Math.abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 
            && isBalanced(root.left) && isBalanced(root.right);
    }

    public int maxHigh(TreeNode root){
        if(root == null)
            return 0;
        return Math.max(maxHigh(root.left), maxHigh(root.right))+1;
    }
}
```

inorderTraversal

```cpp
class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> res = new ArrayList<Integer>();
        if(root == null)
            return res;

        Stack<TreeNode> stack = new Stack<TreeNode>();
        TreeNode cur = root;
        while(!stack.isEmpty() || cur != null){
            if(cur != null){
                stack.push(cur);
                cur = cur.left;
            }else{
                cur = stack.pop();
                res.add(cur.val);
                cur = cur.right;
            }
        }
        return res;
    }
}
```

aaa

```java
public static int getNodeNumRec(TreeNode root) {
        if (root == null) {
            return 0;
        }             
        return getNodeNumRec(root.left) + getNodeNumRec(root.right) + 1;
}
```

1.1 前序中序重建二叉树

```cpp
Node* f3(int* pre, int* ino, int len) { // pre : 1, 2, 4, 7, 3, 5, 6, 8  ino : 4, 7, 2, 1, 5, 3, 8, 6
    if(pre == NULL || ino == NULL || len <= 0) return NULL;
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

1.2 树2是否是树1的子结构

```cpp
bool son(Node* p1, Node* p2) {
	if (p2 == NULL) {
		return true;
	}
	if (p1 == NULL) {
		return false;
	}
	if (p1->value == p2->value) {
		return son(p1->lchild, p2-lchild);
	}
}

bool son_tree(Node* root1, Node* root2) {
	if (root2 == NULL) {
		return true;
	}
	if (root1 == NULL) {
		return false;
	}
	if (root1->value == root2->child) {
		return son(root1, root2);
	}
	bool flag = false
	flag = son_tree(root1->lchild, root2);
	if (!flag) {
		return son_tree(root1->rchild, root2);
	}
}
```

1.3 树的镜像 & BFS 二叉树

1.4 从上往下打印二叉树

```cpp
void LevelOrderBinaryTree(BinaryTreeNode *root)//层序遍历二叉树
{
    assert(root);
    queue<BinaryTreeNode*> q;

    q.push(root);
    while(!q.empty())
    {
        if(q.front()->_Lnode != NULL)
            q.push(q.front()->_Lnode);
        if(q.front()->_Rnode != NULL)
            q.push(q.front()->_Rnode);

        cout<<q.front()->_val<<" ";
        q.pop();
    }
    cout<<endl;
}
```

1.5 二叉搜索树后序遍历的结果

```cpp
bool f6(int* sec, int len) {
    if(sec == NULL) return false;
    if(len <= 1) return true;
    int i, rv = sec[len-1];
    for(i = 0; i < len-1; i++) {
        if(sec[i] > rv) break;
    }
    for(int j = i; j < len-1; j++) {
        if(sec[j] < rv) return false;
    }
    return f6(sec, i) && f6(sec+i, len-i-1);
}
```

1.6 中和为某一值的路径

```cpp
void f4(Node*, int, int, vector<int>&);
void f4(Node* root, int exSum) {
    if(root == NULL) return;
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
    if(root->lchild) f4(root->lchild, exSum, curSum, path);
    if(root->rchild) f4(root->rchild, exSum, curSum, path);
    curSum -= root->value;
    path.pop_back();
}
```

1.7 二叉搜索树与双向链表

```cpp
void convert(Node* root, Node*& pLast) {
    if(root == NULL) return;
    if(root->lchild) convert(root->lchild, pLast);
    Node* pCur = root;
    pCur->lchild = pLast;
    if(pLast) pLast->rchild = pCur;
    pLast = pCur;
    if(root->rchild) convert(root->rchild, pLast);
}
```

1.8 深度到是否为平衡二叉树

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

1.9 二叉搜索树后序遍历的结果

```cpp
bool f6(int* sec, int len) {
    if(sec == NULL) return false;
    if(len <= 1) return true;
    int i, rv = sec[len-1];
    for(i = 0; i < len-1; i++) {
        if(sec[i] > rv) break;
    }
    for(int j = i; j < len-1; j++) {
        if(sec[j] < rv) return false;
    }
    return f6(sec, i) && f6(sec+i, len-i-1);
}
```

1.10 二叉树两节点的最低公共祖先

```cpp
vector<Node*> V1;
vector<Node*> V2;
bool getNodePath(Node* root, Node* tar, vector<Node*>& V) { // 根左右，回溯
    if(root == NULL) return false;
    V.push_back(root);
    if(root == tar) return true;
    bool flag = false;
    if(root->lchild) flag = getNodePath(root->lchild, tar, V);
    if(!flag && root->rchild) flag = getNodePath(root->rchild, tar, V);
    if(!flag) V.pop_back();
    return flag;
}
Node* getCom(const vector<Node*>& V1, const vector<Node*>& V2) {
    vector<Node*>::const_iterator it1 = V1.begin();
    vector<Node*>::const_iterator it2 = V2.begin();
    Node* pLast = NULL;
    while(it != V1.end() && it2 != V2.end()) {
        if(*it != *it2) break;
        pLast = *it1;
        ++it1;
        ++it2;
    }
    return pLast;
}
```

## 5. 具体算法

### 5.1 斐波拉契

> 1. 斐波拉契数列 ok.   
> 2. 跳台阶  ok.   
> 3. 变态跳台阶  2 \* Fib(n-1).   
> 4. 矩形覆盖  ok

### 5.4 回溯

> 1. 矩阵中的路径(BFS).   
> 2. 机器人的运动范围(DFS)

### 5.5 排序

> 1. 数组中的逆序对(归并排序).  void mergeSort(int a[], int l, int r)
> 2. 最小的K个数(堆排序).   
> 3. 最小的K个数(快速排序) ok

### 5.6 位运算

> 1. 二进制中1的个数  n & n-1.   
> 2. 数值的整数次方 dp.   
> 3. 数组中只出现一次的数字 ok.  

## 6. Stack & Queue & heap


## 7. Offer

[算法学习](https://www.weiweiblog.cn/category/算法学习/page/3/)

2. [剑指offer] 求1+2+3+…+n
3. [剑指offer] 扑克牌顺子
4. [剑指offer] 和为S的连续正数序列
6. [剑指offer] 构建乘积数组
8. [剑指offer] 数组中重复的数字
10. [剑指offer] 数据流中的中位数
11. [剑指offer] 滑动窗口的最大值
11. [剑指offer] 矩阵中的路径
12. [剑指offer] 机器人的运动范围
13. [剑指offer] 把数组排成最小的数
14. [剑指offer] 整数中1出现的次数（从1到n整数中1出现的次数）

## 8. 10道海量数据

## Reference

- [【NLP/AI算法面试必备-2】NLP/AI面试全记录（持续更新）][1]
- [【NLP/AI算法面试必备-1】学习NLP/AI，必须深入理解“神经网络及其优化问题”][2]
- [JayLouNLP算法工程师][2]
- [140个GOOGLE的面试题](https://coolshell.cn/articles/3345.html)

[1]: https://zhuanlan.zhihu.com/p/57153934
[2]: https://www.zhihu.com/people/lou-jie-9/posts
[3]: https://zhuanlan.zhihu.com/p/56633392

