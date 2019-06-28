
<img src="/images/icpc/Array-In-C.png" width="580" />

## 1. 数组 & 排序

> 1. **八皇后**， void dfs(int n)
> 2. **二维数组中的查找** bool Find(int\* matrix, int rows, int cols, int value)用一维/二维 \*(matrix+i\*cols+j)
> 3. 替换空格 char\* replace(char\* str, int len) ‘ ’->%20 在源数组总长度，从后向前，逐个赋值
> 4. 旋转数组的最小元素 int get_min(int \*a, int len) , while(a[p1] >= a[p2]) {
> 5. 调整数组位数使奇数位于前面 void odds(int[] arr) 
> 6. 次数超过一半的次数 \* int core(int \*a, int len)
> 7. **最小的K个数 ** part 快排思想 + void set_k(int\* input, int n, int k) **nok**
> 8. **连续子数组的最大和**   // dp: F[i] = max(a[i], F[i-1]+a[i]);
> 9. [把数组排成最小的数](https://www.cnblogs.com/youxin/p/3294154.html) #include < sstream > bool Compare(const string &left, const string &right)
> 10. [数组中的逆序对](https://blog.csdn.net/bf23456/article/details/51303632)
> 11. 数组中只出现一次的数字 , 划分2数组，num & (-num);二者与后得到的数，将num最右边的1保留下来
> 12. **丑数**, 只包含质因子2、3和5的数称作丑数, 1, 2, 3, 5, 6, ... ok
> 13. 整数中1出现的次数（从1到n整数中1出现的次数）. **nok**
> 14. 和为S的连续正数序列(滑动窗口思想) left=1, right = 2, total = (left + right) \* (right - left + 1) / 2; 
> 15. 和为S的两个数字(双指针思想) ok.
> 16. 孩子们的游戏-圆圈中最后剩下的数(约瑟夫环) ok.
> 17. [构建乘积数组](https://blog.csdn.net/u012327058/article/details/81007333)
> 18. 如何在排序数组中找出给定数字出现的次数 int bina(int \*a, int len, int num, bool isLeft)
> 19. [最短路Floyd](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html)
> 20. quick_sort, while (双while + swap)

### 1.1 八皇后

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

### 1.2 二维数组中的查找

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

### 1.3 替换空格

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

### 1.4 旋转数组的最小元素

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

### 1.5 调整数组位数使奇数位于前面

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

### 1.5 出现次数超过一半的次数

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


### 1.6 最小的K个数  part 快排思想

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

### 1.7 连续子数组的最大和

```cpp
dp: F[i] = max(a[i], F[i-1]+a[i]);
```

### 1.8 数组中的逆序对 & 归并排序

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

### 1.13 和为S的连续正序列(滑窗思想)

### 1.15 约瑟夫环

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

### 1.17 排序数组中某数字出现的次数

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

> 5. 从尾到头打印链表, 递归 ok.    
> 6. 链表中倒数第k个结点 ok.   
> 3. [反转链表][3.3] next=head->next, head->next=pre, pre=head, head=next; 4步
> 4. 合并两个或k个有序链表  ok， 递归 (三元运算符).   
> 5. 复杂链表的复制    
> 6. 两个链表的第一个公共结点  ok.   
> 7. 链表中环的入口结点     
> 8. 删除链表中重复的结点  链表1->2->3->3->4->4->5 处理后为 1->2->5. first->next=head, last, p 三指针, first 技巧

[3.3]: https://www.jianshu.com/p/bd6a64d36916

## 3. String

> 1. 字符串的排列 void res(char \*str, char \*pStr), scanf("%s", str); \#include < utility\> 
> 2. 反转字串单词 string ReverseSentence(string str), reverse(str.begin(), str.end()); in lib algorithm
> 3. 左旋转字符串 string LeftRotateString(string str, int n),string Reverse(string str)
> 4. 字符串转整型 int StrToInt(char* str)       ok

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
