---
title: 总结 20 道 Array
date: 2020-08-24 10:54:16
tags: leetcode
categories: icpc
toc: true
---

<img src="/images/icpc/Array-In-C.png" width="550" />

<!-- more -->

1、七种常见的数组排序算法整理(C语言版本)


**1.1 easy**

> 1. ~~二维数组中的查找~~ ~~替换空格 if c == ' ': res.append("%20") or 从后向前，逐个赋值~~， ✔️
> 3. [剑指 Offer 53 - I. 在排序数组中查找数字 I](https://leetcode-cn.com/problems/zai-pai-xu-shu-zu-zhong-cha-zhao-shu-zi-lcof/),   bina(\*a, len, num, isLeft)， ✔️
> 4. 旋转数组的最小元素 while(low < high) { if(a[m] > a[high]) min[m+1,high], else [low,m]} ✔️ 
> 5. 调整数组位数使奇数位于前面 void odds(int[] arr) ， ✔️
> 6. 次数超过一半的次数 \* int core(int \*a, int len)， ✔️
> 7. **丑数**, 只包含质因子2、3和5的数称作丑数, 1, 2, 3, 5, 6, ... ， ✔️
> 8. 和为S的两个数字(双指针思想) ， ✔️
> 9. 扑克牌顺子 (排序后，统计大小王数量 + 间隔)， ✔️
> 10. 构建乘积数组 (A数组，从前向后，再从后向前j-2,构造 B)， ✔️

**1.2 medium**

> 1. **`八皇后`**， void dfs(int n) for(int i = 0; i < 8; i++) { pos[n] = i; ， ✔️
> 2. [和S连续正数序][S1] (3fun，mid = (1+sum)/2; while(start<mid), Sum(int start, int end), 双vector)， ✔️
> 3. 约瑟夫环 LinkedList; (index = (index + m) %link.size();link.remove(index-\-);) link.get(0); ， ✔️
> 4. [数组排成最小的数](https://www.weiweiblog.cn/printminnumber/) Arrays.sort(str, new Comparator<String>(){ public int compare(String s1, String s2)，✔️
> 5. 数组中只出现一次的数字 , 划分2数组，num & (-num);二者与后得到的数，将num最右边的1保留下来，✔️

**1.3 important**

> 1. 数组中的逆序对(归并排序).  void mergeSort(int a[], int l, int r) ， ✔️
> 2. 最小的K个数(堆排序)， [数据流中的中位数 （2 PriorityQueue）](https://www.weiweiblog.cn/getmedian/).   
> 3. **最小的K个数** （2fun）快排思想 part return l, 外else return left; void set_k(int\* input, n, k) ， ✔️
> 4. **quickSort**(a[],left,right), while(1) { (双while, if(l >= r) break; swap) } swap(a[left], a[l]);， ✔️
> 5. [最短路Floyd](https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html)， ✔️

> quickSort (1 while + [2while + break + swap] + swap + 2 quickSort)
> 
> mergeSort (2 mergeSort + new \*arr + 3 while + 1 for)

## 1. Easy Array

### 1.1 二维数组中的查找

<img src="/images/leetcode/array-1.png" width="500" alt="Array -> Tree" />

```python
class Solution:
    def findNumberIn2DArray(self, matrix: List[List[int]], target: int) -> bool:
        i, j = len(matrix) - 1, 0
        while i >= 0 and j < len(matrix[0]):
            if matrix[i][j] > target: i -= 1
            elif matrix[i][j] < target: j += 1
            else: return True
        return False
```

### 1.2 在排序数组中查找数字 I, //

```python
class Solution:
    def search(self, nums: [int], target: int) -> int:
        def helper(tar):
            i, j = 0, len(nums) - 1
            while i <= j:
                m = (i + j) // 2
                if nums[m] <= tar: i = m + 1
                else: j = m - 1
            return i
        return helper(target) - helper(target - 1)
```

> 本质上看， helper() 函数旨在查找数字 tartar 在数组 numsnums 中的 插入点 ，且若数组中存在值相同的元素，则插入到这些元素的右边。

### 1.3 旋转数组的最小元素

[题解](https://leetcode-cn.com/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof/solution/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-by-leetcode-s/)

输入：[3,4,5,1,2]
输出：1

```python
class Solution:
    def minArray(self, numbers: List[int]) -> int:
        low, high = 0, len(numbers) - 1
        while low < high:
            pivot = low + (high - low) // 2
            if numbers[pivot] < numbers[high]:
                high = pivot 
            elif numbers[pivot] > numbers[high]:
                low = pivot + 1
            else:
                high -= 1
        return numbers[low]
```

## 2. Medium


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

1.6 出现次数超过一半的次数

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


1.7 最小的K个数  part 快排思想

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

1.8 数组中的逆序对 & 归并排序

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

1.15 约瑟夫环

```java
import java.util.LinkedList;
public class Solution {
    public int LastRemaining_Solution(int n, int m) {
        if(n < 1 || m < 1)
            return -1;
        LinkedList<Integer> link = new LinkedList<Integer>();
        for(int i = 0; i < n; i++)
            link.add(i);
        int index = -1;   //起步是 -1 不是 0
        while(link.size() > 1){
            index = (index + m) % link.size();  //对 link的长度求余不是对 n
            link.remove(index);
            index --;
        }
        return link.get(0);
    }
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

- [leetcode CN](https://leetcode-cn.com/interview)
- [leetcode EN](https://leetcode.com/problemset/all/)

## Reference

- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)

