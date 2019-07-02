<img src="/images/icpc/BinaryTree-1.png" width="450" />

<!-- more -->

## 1. Binary Tree

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

- [20tree](https://www.weiweiblog.cn/20tree/)

### 1.1 前序中序重建二叉树

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

### 1.2 树2是否是树1的子结构

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

### 1.3 树的镜像 & BFS 二叉树

### 1.4 从上往下打印二叉树

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

### 1.5 二叉搜索树后序遍历的结果

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

### 1.6 中和为某一值的路径

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

### 1.7 二叉搜索树与双向链表

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

### 1.8 深度到是否为平衡二叉树

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

### 1.9 二叉搜索树后序遍历的结果

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

### 1.10 二叉树两节点的最低公共祖先

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

## Reference

- [【NLP/AI算法面试必备-2】NLP/AI面试全记录（持续更新）][1]
- [【NLP/AI算法面试必备-1】学习NLP/AI，必须深入理解“神经网络及其优化问题”][2]
- [JayLouNLP算法工程师][2]
- [140个GOOGLE的面试题](https://coolshell.cn/articles/3345.html)

[1]: https://zhuanlan.zhihu.com/p/57153934
[2]: https://www.zhihu.com/people/lou-jie-9/posts
[3]: https://zhuanlan.zhihu.com/p/56633392