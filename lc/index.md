---
title: Coding
---

<!--# [Sea](https://leetcode-cn.com/company/shopee/)-->

- [Leetcode 分类总结](https://lefttree.gitbooks.io/leetcode-categories/content/DP/1d_dp.html)
- [LCP 18. 早餐组合](https://leetcode-cn.com/problems/2vYnGI/), [LCP 19. 秋叶收藏集](https://leetcode-cn.com/problems/UlBDOe/), [sort与sorted的区别](https://www.cnblogs.com/clement-jiao/p/9095699.htm)

```python
# "abc".zfill(5)  00abc
# result.append(-heapq.heappop(heap))  return result[::-1]
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None
```

## Data Engineer

No. | Question | Flag
:---: | --- | :---:
&nbsp; | [840. Magic Squares In Grid](https://leetcode-cn.com/problems/magic-squares-in-grid/) <br> for i in range(len(grid)-2):<br>&nbsp;&nbsp;for j in range(len(grid[i])-2):<br>&nbsp;&nbsp;&nbsp;&nbsp;subset.append(grid[i][j:j+3])<br>&nbsp;&nbsp;&nbsp;&nbsp;subset.append(grid[i+1][j:j+3])<br>&nbsp;&nbsp;&nbsp;&nbsp;subset.append(grid[i+2][j:j+3])| <br><br>❎
&nbsp; | [25. K 个一组翻转链表](https://leetcode-cn.com/problems/reverse-nodes-in-k-group/) 1->2->3->4->5 当 k = 3 时，应当返回: 3->2->1->4->5 <br> &nbsp;  def reverse(self, head: ListNode, tail: ListNode): prev=tail.next p=head <br> &nbsp; def reverseKGroup(head, k): hair = ListNode(0) while head: <br> &nbsp; (1) 查看剩余部分长度是否大于等于 k (2). 把子链表重新接回原链表 | <br>hard
1. | [股票最大利润(买卖一次)](https://leetcode-cn.com/problems/gu-piao-de-zui-da-li-run-lcof/) <br> cost, profit = float("+inf"), 0 <br> cost = min(cost, price); profit = max(profit, price - cost)| ❎
2. | [Move Zeroes](https://leetcode-cn.com/problems/move-zeroes/) for i in range(len(nums)): <br>if nums[i]: swap(nums[i], nums[j]) | ❎
3. | [102. 二叉树的层序遍历](https://leetcode-cn.com/problems/binary-tree-level-order-traversal/)<br>from collections import deque<br>queue = collections.deque(); queue.append(root); while queue: size = len(queue)<br>cur = queue.popleft()<br>queue.append(cur.left)<br>queue.append(cur.right) | <br><br>❎
4. | [83. 删除排序链表中的重复元素](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/)<br> while cur and cur.next: if ... : cur.next = cur.next.next<br>[82. 删除排序链表中的重复元素 II - 删除所有含有重复数字的节点](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii/) <br> dHead = ListNode(0), dHead.next = head <br> pre,cur = dHead,head; <br>`while cur: pre.next = cur.next` 跳过重复部分 | <br><br>❎
5. | [如何实现LRU](http://localhost:5000/lc/#review-shop), 双向链表+Dict+Size+Cap <br> class DLinkedNode(4), removeTail, moveToHead, addToHead, removeNode | ✔️❎
6. | [125. 验证回文串](https://leetcode-cn.com/problems/valid-palindrome/), while left < right: while left < right and not s[left].isalnum(): <br><br> 扩展: [5. 最长回文子串 dp](https://leetcode-cn.com/problems/longest-palindromic-substring/), 枚举长度 <br> &nbsp; for l in range(n): for i in n: dp[i][j] = (dp[i + 1][j - 1] and s[i] == s[j]) | <br>❎
7. | [101. 对称二叉树](https://leetcode-cn.com/problems/symmetric-tree/) <br> &nbsp; class TreeNode: def \_\_init\_\_(self, x): <br> &nbsp; isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left) | <br>❎
8. | [98. 验证二叉搜索树](https://leetcode-cn.com/problems/validate-binary-search-tree/), <br>stack, inorder = [], float('-inf')<br>while stack or root: while root | <br>❎
9. | [找出数组里三个数相乘最大的那个（有正有负）](https://leetcode-cn.com/problems/maximum-product-of-three-numbers/solution/), nums.sort() <br> a = nums[-1] \* nums[-2] \* nums[-3]<br>b = nums[0] \* nums[1] \* nums[-1] | <br>❎
10. | 做题：两个十六进制数的加法 | ❎
11. | [93. 复原IP地址](https://leetcode-cn.com/problems/restore-ip-addresses/), `".".join(['1','2','3','4']) == '1.2.3.4'`,&nbsp; `ord("a") = 97` <br> &nbsp; dfs(seg\_id, seg\_start) for seg\_end in range(seg\_start, len(s)): <br> &nbsp;&nbsp; if 0 < addr <= 0xFF（11111111==255): | <br>✔️❎
12. | [202. 快乐数](https://leetcode-cn.com/problems/happy-number/), `divmod(79, 10) = (7,9);`  <br>while n > 0: <br>&nbsp;&nbsp;n, digit = divmod(n, 10)<br>&nbsp;&nbsp;total_sum += digit \*\* 2 | <br>❎
13. | 快排归并手撕 for i in range(l, r+1): nums[i] = arr[i - l] | ❎
14. | [1143. 最长公共子序列](https://leetcode-cn.com/problems/longest-common-subsequence/) dp = [[0] * (n + 1) for _ in range(m + 1)] <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if text1[i - 1] == text2[j - 1]: dp[i][j] = dp[i-1][j-1] + 1 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else: dp[i][j] = max(dp[i-1][j], dp[i][j-1]) | <br>❎
15. | [3. 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/), occ=set(); <br>&nbsp; for l in range(n): remove(i-1), while r+1 < n and s[r+1] not in occ: add(r+1) | ❎
16. | 405-数字转换为十六进制数, bin(dec), oct(dec), hex(dec), int('0b10000', 2) | ❎
17. | [67. 二进制求和](https://leetcode-cn.com/problems/add-binary/)， for i, j in zip(a[::-1], b[::-1]):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = int(i) + int(j) + carry, r = str(s % 2) + r, carry = s // 2 <br><br> list(zip([1,2,3], [4,5,6])) == [(1, 4), (2, 5), (3, 6)]| <br>❎
18. | [4. 寻找两个正序数组的中位数 - hard](https://leetcode-cn.com/problems/median-of-two-sorted-arrays/) , 二分查找 O(log (m+n)) , k/2-1=7/2−1=2 <br> def getKthElement(k): <br> A: 1 3 4 9 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑<br>B: `1 2 3` 4 5 6 7 8 9<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;↑<br>k=k-k/2=4, 下一个位置是 k/2-1 = 4/2-1 = 1 | <br>✔️<br>❎
19. | [剑指 Offer 55 - II. 平衡二叉树](https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof/) <br> &nbsp; (1). abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 <br> &nbsp; (2). self.isBalanced(root.left) and self.isBalanced(root.right) | <br>❎
20. | ~~[155. 最小栈](https://leetcode-cn.com/problems/min-stack/), self.stack = [], self.min_stack = [float('inf')]~~ | ❎
21. | 非递归单链表反转 现场手写 | ❎
22. | ~~[105. 从前序与中序遍历序列构造二叉树](https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/) <br> root = TreeNode(preorder[0]) <br> i = inorder.index(preorder[0])~~ | <br>❎ 
23. | 全排列, def dfs(x): if x == len(c) - 1: res.append(''.join(c)) <br> &nbsp;&nbsp;&nbsp;&nbsp; for i in range(first, n): | ❎
24. | [1262. 可被三整除的最大和](https://leetcode-cn.com/problems/greatest-sum-divisible-by-three/), [题解](https://leetcode-cn.com/problems/greatest-sum-divisible-by-three/solution/ti-jie-5265-ke-bei-san-zheng-chu-de-zui-da-he-by-z/)<br> &nbsp;&nbsp;贪心+逆向思维：<br> &nbsp;&nbsp; a = [x for x in nums if x % 3 == 0] <br> &nbsp;&nbsp; b = sorted([x for x in nums if x % 3 == 1], reverse=True)<br>&nbsp;&nbsp; c = sorted([x for x in nums if x % 3 == 2], reverse=True) | <br><br>❎
27. | 两千万个文件找最小的一千个（答错了，应该用大顶堆，答成了小顶堆）| ❎
28. | 10亿个数中找出最大的10000个数? <br><br> &nbsp;&nbsp;&nbsp;&nbsp; 将1亿个数据分成100份，每份100万个数据，找到每份数据中最大的10000个，最后在剩下的100*10000个数据里面找出最大的10000个 | <br> 分治法
29. | 1000个数据，查找出现次数最多的k个数字 <br><br> 我们首先一样是要把这十亿个数分成很多份。例如 1000份，每份 10万。然后使用 HashMap<int,int> 来统计。在每一次的统计中，我们可以找出最大的100个数？ 这样100\*10000 可以 快排序 解决 | 1. 分治法HashMap <br><br> 2. 位图法Bitmap |
30. | [239. 滑动窗口最大值](https://leetcode-cn.com/problems/sliding-window-maximum/), [题解](https://leetcode-cn.com/problems/sliding-window-maximum/solution/hua-dong-chuang-kou-zui-da-zhi-by-leetcode-3/) 双端队列 <br> &nbsp;(1). # init deque and output: &nbsp;&nbsp;while deq and nums[i] > nums[`deq[-1]`]: deq.pop() <br> &nbsp;(2). # build output: &nbsp;&nbsp;&nbsp;&nbsp;for i in range(k, n): | <br> ✔️❎

## HOT

No. | Question | Flag
:---: | --- | :---:
Meeting | Meeting Rooms 系列 |
~~easy~~ | ~~252 [Meeting Rooms I](https://leetcode-cn.com/problems/meeting-rooms)~~, Sort, `right = intervals[0][-1]` for : if x<right: return False | ❎
<br> **heapq** | 253 [Meeting Rooms II](https://leetcode-cn.com/problems/meeting-rooms-ii) , **heapq** 中的 free_rooms 代表房间个数 <br> &nbsp; intervals.sort(key= lambda x: x[0]) <br> &nbsp; heapq.heappush(free_rooms, intervals[0][1]), for i in intervals[1:] re len(free_rms) | <br>❎
Array | 指针, 冒泡 |
&nbsp; | ~~[75 Sort Colors](https://leetcode-cn.com/problems/sort-colors), 2遍 单指针固定增加~~, <br>if nums[i] == 0: nums[i], nums[p] = nums[p], nums[i] | ❎
Array | Sort idea, 模拟 |
&nbsp; | ~~[621	任务调度器](https://leetcode-cn.com/problems/task-scheduler)~~， `桶思想 + 模拟计算` 两个相同种类的任务间必须有长度为整数 n 的冷却时间<br>for i in set(tasks):tnum.append(tasks.count(i)) maxt=max(tnum) | ❎ 
Array | ~~搜索旋转排序数组 nums = [4,5,6,7,0,1,2], target = 0~~ , `双if 判断位置` |
Array | [剑指 Offer 11. 旋转数组的最小数字](https://leetcode-cn.com/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof/) |
&nbsp; | ~~[33. 搜索旋转排序数组](https://leetcode-cn.com/problems/search-in-rotated-sorted-array/)~~, nums[0] <= nums[mid] if nums[0] <= target < nums[mid]: <br> while l <= r: mid = (l + r) // 2 if nums[mid] == target: return mid | ❎
Array | 单调性有关 | ✔️
**插空法** | [406. 根据身高重建队列 Queue Reconstruction by Height](https://leetcode-cn.com/problems/queue-reconstruction-by-height) <br>&nbsp;&nbsp;people.sort(key=lambda x:(-x[0], x[1])), 插空法, ans[p[1],p[1]]=[p] ,&nbsp; tmp[:] | ❎
Stock | 股票买卖系列 |
&nbsp; | [121. 买卖股票的最佳时机](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/) , inf = int(1e9), int max = sys.maxsize <br> &nbsp; maxprofit = max(price - minprice, maxprofit) | ❎
&nbsp; | [122. 买卖股票的最佳时机 II](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/), 贪心简单 & DP 分状态讨论 <br> &nbsp; dp[i][0] = max(dp[i - 1][0], dp[i - 1][1] + prices[i]); <br> &nbsp; dp[i][1] = max(dp[i - 1][1], dp[i - 1][0] - prices[i]); | 
&nbsp; | [309. Best Time to Buy and Sell Stock with Coo](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown), [题解：最佳买卖股票时机含冷冻期](https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/solution/zui-jia-mai-mai-gu-piao-shi-ji-han-leng-dong-qi-4/) <br> 1. f[i][0]: 手上持有股票的最大收益 <br> 2. f[i][1]: 手上不持有股票, 并且处于冷冻期的最大收益 <br> 3. f[i][2]: 手上不持有股票, 并且不处于冷冻期的最大收益 | ❎
0-1 | 背包 |
&nbsp; | [416 分割等和子集](https://leetcode-cn.com/problems/partition-equal-subset-sum), 0-1背包 变体 | ✔️
DP | Tree DP, 偷不偷 | 
&nbsp; | [337. House Robber III](https://leetcode-cn.com/problems/house-robber-iii)， 偷不偷 | ✔️
二维DP | 二维格子 DP |
&nbsp; | [221. Maximal Square 最大的正方形](https://leetcode-cn.com/problems/maximal-square/) if i == 0 or j == 0: dp[i][j] = 1 边界<br> &nbsp;&nbsp; dp = [[0] * columns for _ in range(rows)] &nbsp; <br> &nbsp;&nbsp; dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1 |
一维DP | 子序列 |
&nbsp; | [300. 最长上升子序列](https://leetcode-cn.com/problems/longest-increasing-subsequence/), dp[0]=1; j in range(i): dp[i] = max(dp[i], dp[j] + 1) | ❎
&nbsp; | [152. Maximum Product Subarray - 乘积最大的连续子数组](https://leetcode-cn.com/problems/maximum-product-subarray), pre_max ,pre_min,num <br> &nbsp;&nbsp;dp[i] = max(nums[i] * pre_max, nums[i] * pre_min, nums[i]) | ❎
DFS | 二维格子 |
&nbsp; | [79. Word Search](https://leetcode-cn.com/problems/word-search), 单词搜索 <br> &nbsp;&nbsp; for for if DFS 回溯, visited = set() visited.add((i,j)), visited.remove((i,j)) | ❎
&nbsp; | ~~[200. Number of Islands](https://leetcode-cn.com/problems/number-of-islands/)~~,  if grid[r][c] == `"1"`: num_islands += 1 | ❎
DFS | 全排列 |
&nbsp; | [39. 组合总和](https://leetcode-cn.com/problems/combination-sum/), [2,3,6,7] = [7], [2,2,3]， [DFS 树状图](https://leetcode-cn.com/problems/combination-sum/solution/hui-su-suan-fa-jian-zhi-python-dai-ma-java-dai-m-2/) <br><br> &nbsp;dfs(candidates, index, path + [candidates[index]], target - candidates[index]) | ❎
&nbsp; | [78. Subsets 子集](https://leetcode-cn.com/problems/subsets/), 放不放 dfs(ix=0)， 搜索+回溯 | ❎
| |
Bool DP | [139. Word Break](https://leetcode-cn.com/problems/word-break) ， [好题目，3种解法](https://leetcode-cn.com/problems/word-break/solution/shou-hui-tu-jie-san-chong-fang-fa-dfs-bfs-dong-tai/), for i in n: for j in (i+1,n+1)  if(dp[i] and (s[i:j] in wordDict)): dp[j]=True | ❎
&nbsp; | Tree |
&nbsp; | [543. Diameter of Binary Tree](https://leetcode-cn.com/problems/diameter-of-binary-tree), height = return max(L, R) + 1 | ❎
stack | 单调stack - 后进先出 |
&nbsp; | [739. Daily Temperatures 每日温度](https://leetcode-cn.com/problems/daily-temperatures/)， while stack and temperature > T[stack[-1]]: | ✔️❎
heapq  | 堆 |
&nbsp; | [215. Kth Largest Element in an Array](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/) | ❎
贪心 | 维护最大距离 |
&nbsp; | [55	跳跃游戏](https://leetcode-cn.com/problems/jump-game)， 贪心 索引&位置 rightmost = max(rightmost, i + nums[i]) | ❎
Linked | LinkedList |
&nbsp; | [234. Palindrome Linked List](https://leetcode-cn.com/problems/palindrome-linked-list), 巧妙[递归+front_point](https://leetcode-cn.com/submissions/detail/124258873/) or vals == vals[::-1] | ✔️❎
&nbsp; | [114. Flatten Binary Tree to Linked List](https://leetcode-cn.com/problems/flatten-binary-tree-to-linked-list/) <br> &nbsp; pre_list = list(), for i in pre_list: prev.left=None, prev.right=curr | ❎
| |
Tree | [538 Convert BST to Greater Tree](https://leetcode-cn.com/problems/convert-bst-to-greater-tree), 反中序遍, def dfs(root: TreeNode): nonlocal total | ❎ 
&nbsp; | Sliding Window |
前缀和<br>哈希优化 | [560. 和为K的子数组](https://leetcode-cn.com/problems/subarray-sum-equals-k) <br> &nbsp;&nbsp; num_times = collections.defaultdict(int), num_times[0]=1 <br> &nbsp;&nbsp;&nbsp;cur_sum - k in nums_times, res += num_times[cur_sum - k]  | <br> ❎

## [HOT100](https://leetcode-cn.com/problemset/leetcode-hot-100/)

No. | Question | Flag
:---: | --- | :---:
(1). | **binary-search** |
good | [15. 3Sum](https://leetcode-cn.com/problems/3sum) == TwoSum， nums.sort(), for for while second < third, `sec_ix & thd_ix ` | ❎
Array | ~~[283. Move Zeroes](https://leetcode-cn.com/problems/move-zeroes)， 冒泡思想~~ | ❎  
&nbsp; | [48. Rotate Image](https://leetcode-cn.com/problems/rotate-image), n\*n matrix, 上三角【`转置+reverse()`】,  matrix[i].reverse() | ✔️❎
(2). | **Dynamic programming**, DP |
&nbsp; | ~~[53. Maximum Subarray](https://leetcode-cn.com/problems/maximum-subarray/)， 连续的最大子序和~~ | ❎
&nbsp; | ~~[64. Minimum Path Sum 二维格子的最小路径和](https://leetcode-cn.com/problems/minimum-path-sum)~~ ， 格子 DP（向左和向下走） | ❎
&nbsp; | ~~[198 打家劫舍](https://leetcode-cn.com/problems/house-robber)~~ , dp = [0] * size, dp[0], dp[1], dp[i]=max(dp[i - 2] + nums[i], dp[i - 1]) | ❎
(3). | 模拟 |
&nbsp; | [31. Next Permutation](https://leetcode-cn.com/problems/next-permutation) == [8.5 下一个更大元素 III](https://leetcode-cn.com/problems/next-greater-element-iii/) | ❎
(4). | DFS / BFS / Tree / Stack |
&nbsp; | ~~[56. Merge Intervals](https://leetcode-cn.com/problems/merge-intervals/) ， Sort+遍历, 替换结果~~<br>&nbsp; intervals.sort(`key=lambda x: x[0]`) <br>&nbsp; merged[-1][1] = max(merged[-1][1], interval[1]) | ❎
&nbsp; | ~~[21. Merge Two Sorted Lists](https://leetcode-cn.com/problems/merge-two-sorted-lists)~~ | ❎
卡特兰 | ~~[96. Unique Binary Search Trees](https://leetcode-cn.com/problems/unique-binary-search-trees/)~~ , 2(2n+1)/n+1 | ❎
(6). | LinkedList |
&nbsp; | ~~[142. Linked List Cycle II](https://leetcode-cn.com/problems/linked-list-cycle-ii/)~~， 转为环形链表II-龟兔判圈 | ❎
&nbsp; | ~~[287. Find the Duplicate Number](https://leetcode-cn.com/problems/find-the-duplicate-number/)~~， 转为环形链表II-龟兔判圈 | ❎
匪夷 | ~~[148. Sort List](https://leetcode-cn.com/problems/sort-list)~~ | ✔️❎
&nbsp; | ~~[240	搜索二维矩阵 II](https://leetcode-cn.com/problems/search-a-2d-matrix-ii)~~ , while col < width and row >= 0: | ❎ 
&nbsp; | ~~[226 翻转二叉树](https://leetcode-cn.com/problems/invert-binary-tree)~~ <br> &nbsp;&nbsp; root.left, root.right = root.right, root.left | ❎
&nbsp; | ~~[617 合并二叉树](https://leetcode-cn.com/problems/merge-two-binary-trees)~~, new_root = TreeNode(t1.val + t2.val) | ❎


### 337. House Robber III

偷,不偷 [题解](https://leetcode-cn.com/problems/house-robber-iii/solution/san-chong-fang-fa-jie-jue-shu-xing-dong-tai-gui-hu/)

我们使用一个大小为 2 的数组来表示 int[] res = new int[2] 0 代表不偷，1 代表偷
任何一个节点能偷到的最大钱的状态可以定义为

> - 当前节点选择不偷：当前节点能偷到的最大钱数 = 左孩子能偷到的钱 + 右孩子能偷到的钱
> - 当前节点选择偷：当前节点能偷到的最大钱数 = 左孩子选择自己不偷时能得到的钱 + 右孩子选择不偷时能得到的钱 + 当前节点的钱数

```python
class Solution:
    def rob(self, root: TreeNode) -> int:
        def _rob(root):
            if not root: return 0, 0  # 偷，不偷

            left = _rob(root.left)
            right = _rob(root.right)
            # 偷当前节点, 则左右子树都不能偷
            v1 = root.val + left[1] + right[1]
            # 不偷当前节点, 则取左右子树中最大的值
            v2 = max(left) + max(right)
            return v1, v2

        return max(_rob(root))
```

621 任务调度器， leastInterval 

```python
class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        tnum=[]
        for i in set(tasks):tnum.append(tasks.count(i))
        maxt=max(tnum)
        return max((n+1)*(maxt-1)+tnum.count(maxt),len(tasks))
```

179. 最大数

```python
class LargerNumKey(str):
    def __lt__(x, y):
        return x+y > y+x
        
class Solution:
    def largestNumber(self, nums):
        largest_num = ''.join(sorted(map(str, nums), key=LargerNumKey))
        return '0' if largest_num[0] == '0' else largest_num
```

## Review shop

No. | Question | Flag
:---: | --- | :---:
(1). | **binary-search** |
&nbsp; | [179. 最大数](https://leetcode-cn.com/problems/largest-number), sorted(iter, key=your\_sort\_class, \_\_lt\_\_) | ❎ 
&nbsp; | [1.1 二分查找](https://leetcode-cn.com/problems/binary-search/), while l <= r | ❎
✔️ | [1.2 在排序数组中查找元素的第一个和最后一个位置](https://leetcode-cn.com/problems/find-first-and-last-position-of-element-in-sorted-array/), def binSearch(nums, t, flag), mid=r-1 or l+1, return r+1 or l-1 | ❎
addition | [162. 寻找峰值](https://leetcode-cn.com/problems/find-peak-element/) nums[-1] = nums[n] = -∞ , l=mid+1, r=mid| ❎
&nbsp; | [278. First Bad Version](https://leetcode-cn.com/problems/first-bad-version/) , if isBadVersion(mid): right = mid - 1 | ❎
hard | [410. Split Array Largest Sum](https://leetcode-cn.com/problems/split-array-largest-sum/) Input: nums = [7,2,5,10,8], m = 2. Output: 18 <br> 「使……最大值尽可能小」是二分搜索题目常见的问法 | ❎
逆向双指针 | [88. Merge Sorted Array](https://leetcode-cn.com/problems/merge-sorted-array/) nums1 = [1,2,3,0,0,0], nums2 = [2,5,6] | ❎
双指针 | [15. 3Sum](https://leetcode-cn.com/problems/3sum/)， for for while , second\_ix & third\_ix 两边夹 | 
双指针 | [11. 盛最多水的容器](https://leetcode-cn.com/problems/container-with-most-water) , 移动 l 和 r 较小的一方才可能增加 area | ❎
hard, merge+index | [315. Count of Smaller Numbers After Self](https://leetcode-cn.com/problems/count-of-smaller-numbers-after-self/) | hard
(2). | DFS / Stack |
&nbsp; | [2.1 字符串解码 "3[a2[c]]" == "accacc"](https://leetcode-cn.com/problems/decode-string/), `stack == [(3, ""), (2,"a")]` <img src="/images/leetcode/stack-string-decoding.jpg" width="500" alt="" /> | ✔️❎
&nbsp; | [215. 数组中的第K个最大元素](https://leetcode-cn.com/problems/kth-largest-element-in-an-array/) from heapq import heapify, heappush, heappop <br> &nbsp; python中的heap是小根堆:  heapify(hp) , heappop(hp), heappush(hp, v) |
(3). | Digit, 模拟 |
 &nbsp; | [3.1 回文数](https://leetcode-cn.com/problems/palindrome-number/) [禁止整数转字符串]， &nbsp;&nbsp;&nbsp;&nbsp;模拟 123321 -> 2332 -> 33 | ❎
 &nbsp; | [470. 用 Rand7() 实现 Rand10()](https://leetcode-cn.com/problems/implement-rand10-using-rand7/) , [题解: 等概率多次调用](https://leetcode-cn.com/problems/implement-rand10-using-rand7/solution/xiang-xi-fen-xi-fei-chang-jing-dian-de-ti-mu-deng-/) | 
&nbsp; | [205. 同构字符串](https://leetcode-cn.com/problems/isomorphic-strings/), all(s.index(s[i]) == t.index(t[i])  for i in range(len(s))) | ❎
(4). | DP |
`good` | [4.1 栅栏涂色](https://leetcode-cn.com/problems/paint-fence/) &nbsp;&nbsp; `dp[i] = dp[i-2]*(k-1) + dp[i-1]*(k-1)` | ✔️❎
&nbsp; | ~~[4.2 区域和检索](https://leetcode-cn.com/problems/range-sum-query-immutable/) == 连续子数组最大和~~ | ❎
`good`<br><br><br>`float('inf')`<br><br><br>good | [4.3 Coin Change [零钱兑换]](https://leetcode-cn.com/problems/coin-change/) &nbsp;&nbsp;`dp[0] = 0`, `dp[x] = min(dp[x], dp[x - coin] + 1)` <br><br> $F(i)= min_{j=0…n−1} F(i−c_j)+1$ `dp = [float('inf')] * (amount + 1)` <br><br> 输入：coins = [1, 2, 5], amount = 11<br>输出：3 <br>解释：11 = 5 + 5 + 1 <br> Tips: float('inf') + 1 = inf | ✔️❎
&nbsp; | [279. 完全平方数](https://leetcode-cn.com/problems/perfect-squares/), numSquares(n)=min(numSquares(n-k) + 1)∀k∈square <br> 与 Coin Change 非常类似，但不完全 | ✔️❎
&nbsp; | [4.4 除自身以外数组的乘积](https://leetcode-cn.com/problems/product-of-array-except-self/) , [0]\*len,  range(len(nums)-2, -1, -1) | ❎
hard | [44. Wildcard Matching](https://leetcode-cn.com/problems/wildcard-matching/) Input: s = "aa", p = "*" Output: true , Input: s = "cb", p = "?a" Output: false |
(5). | hash |
&nbsp; | [5.1 两数之和](https://leetcode-cn.com/problems/two-sum/), enumerate hash[num] = i | ❎
(6). | linkedList |
- | [6.1 相交链表](https://leetcode-cn.com/problems/intersection-of-two-linked-lists/) `romantic` | ❎
- | [6.2 环形链表](https://leetcode-cn.com/problems/linked-list-cycle/) `hash` | ❎
- | [6.3 两数相加 I](https://leetcode-cn.com/problems/add-two-numbers/) `LinkNode 模拟` head = ListNode(0), cur = head, carry = 0 | ❎
- | [445. Add Two Numbers II](https://leetcode-cn.com/problems/add-two-numbers-ii/), 链表求和, stack+post_p <br> while s1 or s2 or carry != 0: | ❎
- | [6.4 复制带随机指针的链表](https://leetcode-cn.com/problems/copy-list-with-random-pointer/) <br> &nbsp;&nbsp; 1. while, 2. while (random pointers) 3. while (ptr_old_list） | ❎
✔️✔️✔️✔️ | [6.5 LRUCache](https://leetcode-cn.com/problems/lru-cache/) class DLinkedNode(4), `removeTail`, `moveToHead`, `addToHead `, `removeNode` | ✔️❎
- | [6.6 删除链表的倒数第N个节点](https://leetcode-cn.com/problems/remove-nth-node-from-end-of-list/) | ❎
匪夷所思 | [6.7 排序链表](https://leetcode-cn.com/problems/sort-list/), slow, fast = head, head.next, mid, slow.next=slow.next, None | ✔️❎
- | ~~[面试题 02.05. 链表求和 I](https://leetcode-cn.com/problems/sum-lists-lcci/)~~ | ❎
hard | [25. Reverse Nodes in k-Group](https://leetcode-cn.com/problems/reverse-nodes-in-k-group/) |
hard | [23. Merge k Sorted Lists](https://leetcode-cn.com/problems/merge-k-sorted-lists/) |
(7). | stack |
- | [7.1 有效的括号](https://leetcode-cn.com/problems/valid-parentheses/) `if i == ')' and len(stack)> 0 and stack[-1] == '(': stack.pop()` | ❎
- | [402. 移掉K位数字](https://leetcode-cn.com/problems/remove-k-digits/) <img src="/images/leetcode/remove-k-1224.png" width="500" alt="" /> | ❎
(8). | string |
<br>reversed | [8.1 字符串相加](https://leetcode-cn.com/problems/add-strings/) 给定两个字符串形式的非负整数 num1 和num2 ，计算它们的和 <br> `num1 = "".join(list(reversed(num1)))`,<br> `num1 = num1 + ("0" * diff1) num2 = num2 + ("0" * diff2)` | ✔️️❎ 
- | [8.2 比较版本号](https://leetcode-cn.com/problems/compare-version-numbers/) , split then compare ..| ❎
- | ~~[8.3 字符串解码](https://leetcode-cn.com/problems/decode-string/)~~ | ❎
- | [8.4 无重复字符的最长子串](https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/) sliding window, `[l, r]`, occ=set(), occ.remove(elem) | ✔️❎️
- | [8.5 下一个更大元素 III](https://leetcode-cn.com/problems/next-greater-element-iii/) ， 模拟复杂 [见题解](https://leetcode-cn.com/problems/next-greater-element-iii/solution/xia-yi-ge-geng-da-yuan-su-iii-by-leetcode/) <br> `1,5,8,4,7,6,5,3,1` <br> => decreasing elem found `1,5,8,4(i-1),7,6,5(j),3,1` (found j, just larger a[i-1])<br> => `1,5,8,5,7,6,4,3,1` => `1,5,8,5,1,3,4,6,7` (reverse these elements) | ✔️️❎
- | [8.6 全排列](https://leetcode-cn.com/problems/permutations/) def backtrack(first=0): for i in range(first, n): swap(nums[first], nums[i])  <img src="/images/leetcode/permute.png" width="600" alt="" /> | ❎
(9). | tree |
- | [9.1 从前序与中序遍历序列构造二叉树](https://leetcode-cn.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/) `i = inorder.index(preorder[0])` | ❎
- | [9.2 二叉树的中序遍历 (非递归)](https://leetcode-cn.com/problems/binary-tree-inorder-traversal/) `while while` | ❎
- | [9.3 二叉树的右视图](https://leetcode-cn.com/problems/binary-tree-right-side-view/) | ❎
hard | [124. Binary Tree Maximum Path Sum](https://leetcode-cn.com/problems/binary-tree-maximum-path-sum/) |


[sales-person 销售员](https://leetcode-cn.com/problems/sales-person/)

```sql
SELECT
    s.name
FROM
    salesperson s
WHERE
    s.sales_id NOT IN (SELECT
            o.sales_id
        FROM
            orders o
                LEFT JOIN
            company c ON o.com_id = c.com_id
        WHERE
            c.name = 'RED')
```

### 3sum

```python
class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        n = len(nums)
        nums.sort()
        ans = list()
        
        # 枚举 a
        for first in range(n):
            # 需要和上一次枚举的数不相同
            if first > 0 and nums[first] == nums[first - 1]:
                continue
            # c 对应的指针初始指向数组的最右端
            third = n - 1
            target = -nums[first]
            # 枚举 b
            for second in range(first + 1, n):
                # 需要和上一次枚举的数不相同
                if second > first + 1 and nums[second] == nums[second - 1]:
                    continue
                # 需要保证 b 的指针在 c 的指针的左侧
                while second < third and nums[second] + nums[third] > target:
                    third -= 1
                # 如果指针重合，随着 b 后续的增加
                # 就不会有满足 a+b+c=0 并且 b<c 的 c 了，可以退出循环
                if second == third:
                    break
                if nums[second] + nums[third] == target:
                    ans.append([nums[first], nums[second], nums[third]])
        
        return ans
```

### 402. 移掉K位数字

```python
class Solution:
    def removeKdigits(self, num: str, k: int) -> str:
        numStack = []
        
        # 构建单调递增的数字串
        for digit in num:
            while k and numStack and numStack[-1] > digit:
                numStack.pop()
                k -= 1
        
            numStack.append(digit)
        
        # 如果 K > 0，删除末尾的 K 个字符
        finalStack = numStack[:-k] if k else numStack
        
        # 抹去前导零
        return "".join(finalStack).lstrip('0') or "0"
```

### 241. 为运算表达式设计优先级

解题思路

对于一个形如 x op y（op 为运算符，x 和 y 为数） 的算式而言，**它的结果组合取决于 x 和 y 的结果组合数**，而 x 和 y 又可以写成形如 x op y 的算式。

因此，该问题的子问题就是 x op y 中的 x 和 y：以运算符分隔的左右两侧算式解。

然后我们来进行 **分治算法三步走**：

1. 分解：按运算符分成左右两部分，分别求解
2. 解决：实现一个递归函数，输入算式，返回算式解
3. 合并：根据运算符合并左右两部分的解，得出最终解


```python
class Solution:
    def diffWaysToCompute(self, input: str) -> List[int]:
        # 如果只有数字，直接返回
        if input.isdigit():
            return [int(input)]

        res = []
        for i, char in enumerate(input):
            if char in ['+', '-', '*']:
                # 1.分解：遇到运算符，计算左右两侧的结果集
                # 2.解决：diffWaysToCompute 递归函数求出子问题的解
                left = self.diffWaysToCompute(input[:i])
                right = self.diffWaysToCompute(input[i+1:])
                # 3.合并：根据运算符合并子问题的解
                for l in left:
                    for r in right:
                        if char == '+':
                            res.append(l + r)
                        elif char == '-':
                            res.append(l - r)
                        else:
                            res.append(l * r)

        return res
```


### 279. 完全平方数

Recursion

```python
class Solution(object):
    def numSquares(self, n):
        square_nums = [i**2 for i in range(1, int(math.sqrt(n))+1)]

        def minNumSquares(k):
            """ recursive solution """
            # bottom cases: find a square number
            if k in square_nums:
                return 1
            min_num = float('inf')

            # Find the minimal value among all possible solutions
            for square in square_nums:
                if k < square:
                    break
                new_num = minNumSquares(k-square) + 1
                min_num = min(min_num, new_num)
            return min_num

        return minNumSquares(n)
```

DP

```python
class Solution(object):
    def numSquares(self, n):
        """
        :type n: int
        :rtype: int
        """
        square_nums = [i**2 for i in range(0, int(math.sqrt(n))+1)]
        
        dp = [float('inf')] * (n+1)
        # bottom case
        dp[0] = 0
        
        for i in range(1, n+1):
            for square in square_nums:
                if i < square:
                    break
                dp[i] = min(dp[i], dp[i-square] + 1)
        
        return dp[-1]

```

### 96. 不同的二叉搜索树

```python
class Solution:
    def numTrees(self, n):
        G = [0]*(n+1)
        G[0], G[1] = 1, 1

        for i in range(2, n+1):
            for j in range(1, i+1):
                G[i] += G[j-1] * G[i-j]

        return G[n]
```

<img src="/images/leetcode/stack-string-decoding.jpg" width="600" alt="字符串解码 " />

```python
class Solution:
    def decodeString(self, s: str) -> str:
        stack, res, multi = [], "", 0
        for c in s:
            if c == '[':
                stack.append([multi, res])
                res, multi = "", 0
            elif c == ']':
                cur_multi, last_res = stack.pop()
                res = last_res + cur_multi * res
            elif '0' <= c <= '9':
                multi = multi * 10 + int(c)            
            else:
                res += c
        return res
```

**LRUCache**

<img src="/images/leetcode/lc-146-lru.jpg" width="800" alt="" />

```python
class DLinkedNode:
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None
        
class LRUCache:
    def __init__(self, capacity: int):
        self.head = DLinkedNode()
        self.tail = DLinkedNode()
        self.head.next = self.tail
        self.tail.prev = self.head
        self.capacity = capacity
        self.size = 0
        self.cache = {}

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        # 如果 key 存在，先通过哈希表定位，再移到头部
        node = self.cache[key]
        self.moveToHead(node)
        return node.value

    def put(self, key: int, value: int) -> None:
        if key not in self.cache:
            # 如果 key 不存在，创建一个新的节点
            node = DLinkedNode(key, value)
            # 添加进哈希表
            self.cache[key] = node
            # 添加至双向链表的头部
            self.addToHead(node)
            self.size += 1
            if self.size > self.capacity:
                # 如果超出容量，删除双向链表的尾部节点
                removed = self.removeTail()
                # 删除哈希表中对应的项
                self.cache.pop(removed.key)
                self.size -= 1
        else:
            # 如果 key 存在，先通过哈希表定位，再修改 value，并移到头部
            node = self.cache[key]
            node.value = value
            self.moveToHead(node)


    def addToHead(self, node):
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node

    def removeNode(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev

    def moveToHead(self, node):
        self.removeNode(node)
        self.addToHead(node)

    def removeTail(self):
        node = self.tail.prev
        self.removeNode(node)
        return node

# Your LRUCache object will be instantiated and called as such:
# obj = LRUCache(capacity)
# param_1 = obj.get(key)
# obj.put(key,value)
```

very good sortList:


```python
# -*- coding: utf-8 -*-

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
# 在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。
#
# 示例 1:
#
# 输入: 4->2->1->3
# 输出: 1->2->3->4
class Solution:
    def sortList(self, head: ListNode) -> ListNode:
        if not head or not head.next: return head # termination.
        # cut the LinkedList at the mid index.
        slow, fast = head, head.next
        while fast and fast.next:
            fast, slow = fast.next.next, slow.next
        mid, slow.next = slow.next, None # save and cut.
        # recursive for cutting.
        left, right = self.sortList(head), self.sortList(mid)
        # merge `left` and `right` linked list and return it.
        h = res = ListNode(0)
        while left and right:
            if left.val < right.val: h.next, left = left, left.next
            else: h.next, right = right, right.next
            h = h.next
        h.next = left if left else right
        return res.next

```

二叉树的中序遍历

```python
class Solution:

    def __init__(self):
        self.res = []

    def inorderTraversal(self, root: TreeNode) -> List[int]:
        if not root:
            return []

        stack = list()

        while stack or root:
            while root:
                stack.append(root)
                root = root.left

            root = stack.pop()

            self.res.append(root.val)

            root = root.right

        return self.res
```

# [剑指,Table](https://leetcode-cn.com/problemset/lcof/)

No. | Question | Flag
:---: | --- | ---
**easy** |  |  
(1). | **Tree** |
&nbsp; | [1.1 平衡二叉树](https://leetcode-cn.com/problems/ping-heng-er-cha-shu-lcof) <br> abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right) | ❎
&nbsp; | [1.2 对称的二叉树](https://leetcode-cn.com/problems/dui-cheng-de-er-cha-shu-lcof) | ❎
&nbsp; | [1.3 二叉树的镜像](https://leetcode-cn.com/problems/er-cha-shu-de-jing-xiang-lcof)： root.left = self.mirrorTree(root.right) `swap后+递归` | ❎
&nbsp; | [1.4 二叉搜索树的第k大节点](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof/) &nbsp;&nbsp; [中序遍历 倒序, 右-中-左]  | ✔️❎ 
good | [1.5 (两个节点)二叉树的最近公共祖先](https://leetcode-cn.com/problems/er-cha-shu-de-zui-jin-gong-gong-zu-xian-lcof/) &nbsp;&nbsp; [**Recursion**] 后序遍历+路径回溯 | ✔️❎ 
good | [1.6 (两个节点)二叉搜索树的最近公共祖先](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-zui-jin-gong-gong-zu-xian-lcof) &nbsp;&nbsp; **Recursion** + 剪枝 | ✔️❎ 
good | [1.7 二叉树中和为某一值的路径](https://leetcode-cn.com/problems/er-cha-shu-zhong-he-wei-mou-yi-zhi-de-lu-jing-lcof) `递归回溯` | ✔❎️
&nbsp; | [1.8 二叉搜索树的后序遍历序列](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-de-hou-xu-bian-li-xu-lie-lcof) | ❎
&nbsp; | [1.9 二叉搜索树与双向链表](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/) <img src="/images/leetcode/binary-tree-delinkedlist.png" width="400" alt="" /> |
additional | 求二叉树第K层的节点个数 [**Recursion**] ，root != None and k==1，返回1  <br>  f(root.left, k-1) + f(root.right, k-1) | ❎
additional | 求二叉树第K层的叶子节点个数 [**Recursion**]  <br> if(k==1 and root.left and root.right is null) return 1; | ✔️❎
(2). | Stack |
&nbsp; | [394. 字符串解码 [a]2[bc]](https://leetcode-cn.com/problems/decode-string/) | ❎
&nbsp; | [28. 包含min函数的栈](https://leetcode-cn.com/problems/bao-han-minhan-shu-de-zhan-lcof/) | ❎
&nbsp; | [29. 最小的k个数【堆排的逆向】](https://leetcode-cn.com/problems/zui-xiao-de-kge-shu-lcof/) `heapq.heappop(hp),heapq.heappush(hp, -arr[i])` | ✔️❎
&nbsp; | 36. 滑动窗口的最大值  (同理于包含 min 函数的栈) deque.popleft(),双端队列+单调 | ✔️❎
&nbsp; | [59 II. 队列的最大值](https://leetcode-cn.com/problems/dui-lie-de-zui-da-zhi-lcof/) , `维护个单调的deque` <br> &nbsp;&nbsp; import queue, queue.deque(), queue.Queue(), deq[0], deq[-1] | ✔️❎
(3). | linkedList |
&nbsp; | 7. 从尾到头打印链表： <br>`reversePrint(head.next) + [head.val]` | ❎
&nbsp; | 8. [反转链表](https://leetcode-cn.com/problems/fan-zhuan-lian-biao-lcof/) &nbsp;&nbsp; (循环版 双指针) <img src="/images/leetcode/linkedlist-reverseList.gif" width="600" alt="" /> | ❎
&nbsp; | 10. [合并两个排序的链表](https://leetcode-cn.com/problems/he-bing-liang-ge-pai-xu-de-lian-biao-lcof/) &nbsp;&nbsp; [**Recursion**] <br> p.next = self.mergeTwoLists(l1.next, l2) | ❎
addition | 旋转单链表 (F1. 环 F2. 走n-k%n 断开) <br> 举例： 给定 1->2->3->4->5->6->NULL, K=3 <br> 则4->5->6->1->2->3->NULL |  ❎
addition | [92. 翻转部分单链表](https://zhuanlan.zhihu.com/p/141775663) `reverse(head: ListNode, tail: ListNode)` <br> 举例：1->2->3->4->5->null, from = 2, to = 4 结果：1->4->3->2->5->null | ❎
addition | 链表划分, 描述： 给定一个单链表和数值x，划分链表使得小于x的节点排在大于等于x的节点之前 | ❎
addition | [82. 删除排序链表中的重复元素 II](https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list-ii/) 链表1->2->3->3->4->4->5 处理后为 1->2->5. | ❎
addition | 输入：(7 -> 1 -> 6) + (5 -> 9 -> 2)，即617 + 295 <br> 输出：2 -> 1 -> 9，即912 |
(4). | **DP** |
&nbsp; | [31. n个骰子的点数](https://leetcode-cn.com/problems/nge-tou-zi-de-dian-shu-lcof) dp[i][j] ，表示投掷完 i 枚骰子后，点数 j 的出现次数 | ✔️
&nbsp; | [Summary 20 dynamic programming](/2020/08/31/leetcode/summary_dp/) |
(4.1) | **DP表示状态** |
easy | 1. climbing-stairs ， 新建{}or[] ,滚动数组 <br> 2. 连续子数组的最大和 | ❎
addition | [63. 不同路径 II](https://leetcode-cn.com/problems/unique-paths-ii/), `store = [[0]*n for i in range(m)]` 二维初始化 | ❎
<br> addition | [Edit Distance/编辑距离](https://leetcode-cn.com/problems/edit-distance/)【word1 转换成 word2】<br>&nbsp;&nbsp; 1. dp = [ [0] * (m + 1) for _ in range(n + 1)] <br>&nbsp;&nbsp; 2. dp[i][j] = min(A,B,C) | <br> ✔️❎
addition | [5. Longest Palindromic Substring/最长回文子串](https://leetcode-cn.com/problems/longest-palindromic-substring/) <br>1. 枚举子串的长度 l+1,从小问题到大问题 <br> 2. 枚举子串的起始位置 i, j=i+l 子串结束位置,  dp[i][j] = (dp[i+1][j-1] and s[i]==s[j])  | ✔️❎
good | [把数字翻译成字符串](https://leetcode-cn.com/problems/ba-shu-zi-fan-yi-cheng-zi-fu-chuan-lcof/) | Fib ✔️❎
addition | Leetcode 64. Minimum Path Sum, 最小路径和 `grid[i][j] = min(grid[i - 1][j], grid[i][j - 1]) + grid[i][j]` | ❎
addition | 115. Distinct Subsequences I | Hard
addition | 940. 不同的子序列 II | Hard
addition | Interleaving String/交错字符串 | Hard
(5). | DFS / BFS |
&nbsp; | [66. 矩阵中的路径](https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/) , `经典好题: 深搜+回溯` def dfs(i, j, k): |  ✔️❎ 
&nbsp; | [61. 机器人的运动范围](https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof) `bfs` good <br> &nbsp;&nbsp; `from queue import Queue, q.get() q.pup()` | ✔️❎ 
(6). | sliding Window |
&nbsp; | 65. 最长不含重复字符的子字符串 `滑动窗口` | ✔️❎ 
&nbsp; | 14. 和为s的连续正数序列 &nbsp;&nbsp; [sliding window] <br><br> input：target = 9 <br> output：[[2,3,4],[4,5]] | ✔️❎ 
(7). | 模拟 |
&nbsp; | [21. 圆圈中最后剩下的数字](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/) <br><br> 1. 当数到最后一个结点不足m个时，需要跳到第一个结点继续数 <br> 2. 每轮都是上一轮被删结点的下一个结点开始数 m 个 <br>3. 寻找 f(n,m) 与 f(n-1,m) 关系 <br> 4. A： f(n,m)=(m+x)%n  <br> 5. Python 深度不够手动设置 sys.setrecursionlimit(100000) <br> [东大 Lucien 题解,讲得最清楚的那个。官方讲解有误](https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/solution/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-by-lee/)  | <br><br><br><br>✔️❎
&nbsp; | 35. 顺时针打印矩阵 `left, right, top, bottom = 0, columns - 1, 0, rows - 1` | ✔️❎
&nbsp; | 56. 把数组排成最小的数, sorted vs sort, `strs.sort(key=cmp_to_key(sort_rule))` | ✔️❎  
&nbsp; | 70. 把字符串转换成整数 <br>&nbsp;&nbsp;&nbsp;&nbsp; int_max, int_min, bndry = 2**31-1, -2**31, 2**31//10 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bndry=2147483647//10=214748364 ，则以下两种情况越界<br>&nbsp;&nbsp;&nbsp;&nbsp; res > bndry or res == bndry and c >'7' | ✔️❎
 | | 
**medium** |  | 
 | | 
37 | 0～n-1中缺失的数字 | ❎
42 | 求1+2+…+n | ❎
43 | 数组中数字出现的次数 | so hard
44 | 复杂链表的复制 | ❎ 
45 | 数组中数字出现的次数 | ❎ 
46 | 重建二叉树 | ❎ 
47 | 礼物的最大价值 `f = [len(grid[0]) * [0]] * len(grid)` | ❎ 
48 | 从上到下打印二叉树 III `queue.append([root, 0])` | ❎ 
49 | 丑数 n2, n3, n5 = dp[a] * 2, dp[b] * 3, dp[c] * 5 | ❎ 
50 | 二叉搜索树与双向链表 | ✔️❎  
51 | 股票的最大利润 （买卖一次）  <br>`cost, profit = float("+inf"), 0` <br> for price in prices:<br>&nbsp;&nbsp;&nbsp;&nbsp;`cost, profit = min(cost, price), max(profit, price - cost)` |  
54 | 构建乘积数组 | ❎ 
55 | **二叉树中和为某一值的路径** | <br> ✔️❎ 
57 | 剪绳子 (1) n < 4 (2) n == 4 (3) n > 4, 多个 == 3 段 | ❎ 
58 | 字符串的排列 `c = list(s) res = [] def dfs(x):` | ❎  
59 | 把数字翻译成字符串 `f[i] = f[i-1] + f[i-2]` 同 打家劫舍 | ❎  
60 | 二叉搜索树的后序遍历序列 `def recur(i, j):` | ❎ 
68 | 数值的整数次方  （1）当 n 为偶数 （2）当 n 为奇数 | ❎
71 | 表示数值的字符串： [确定有限状态自动机](https://leetcode-cn.com/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/solution/biao-shi-shu-zhi-de-zi-fu-chuan-by-leetcode-soluti/) <br> [面试题20. 表示数值的字符串（有限状态自动机，清晰图解）](https://leetcode-cn.com/problems/biao-shi-shu-zhi-de-zi-fu-chuan-lcof/solution/mian-shi-ti-20-biao-shi-shu-zhi-de-zi-fu-chuan-y-2/) | 
 | | 
**hard** |  | 
 | | 
72 | 数据流中的中位数 | 
73 | 序列化二叉树 | 
64 | 1～n整数中1出现的次数 |  
74 | 数组中的逆序对 | 
75 | 正则表达式匹配 | 

No. | Pass Question | Flag
:---: | --- | ---
**pass_easy** |  | 
1 | 左旋转字符串 | ❎
2 | 链表中倒数第k个节点 | ❎
3 | 二叉树的深度 | ❎
5 | 打印从1到最大的n位数： `sum = 10 ** n` | ❎
6 | 替换空格 | ❎
11 | 二进制中1的个数 [n = n & (n-1)] | ❎ 
12 | 用两个栈实现队列 | ❎
16 | 从上到下打印二叉树II &nbsp;&nbsp;  `queue.append([root, 0])` 或 `for _ in range(queue_size)` | ❎
17 | 数组中出现次数超过一半的数字 | ❎
18 | 数组中重复的数字 set() | ❎
19 | 和为s的两个数字  [sliding window] | ❎
20 | 调整数组顺序使奇数位于偶数前面 | ❎
22 | 两个链表的第一个公共节点 | ❎
23 | 第一个只出现一次的字符:&nbsp;&nbsp; Python 3.6 后，默认字典就是有序的，无需用 OrderedDict() | ❎
24 | 连续子数组的最大和 `dp[i] = dp[i-1] + nums[i]` | ❎
25 | 删除链表的节点 pre, p | ❎
30 | 不用加减乘除做加法  add(a ^ b, (a & b) << 1) | ❎
32 | 在排序数组中查找数字I | ❎
33 | 旋转数组的最小数字 `numbers[high]` | ❎
34 | 扑克牌中的顺子 ma - mi < 5 | ❎
38 | 翻转单词顺序 | ❎
39 | 青蛙跳台阶问题 | ❎
40 | 二维数组中的查找 | ❎
41 | 斐波那契数列 | ❎
**pass_medium** |  | 
52 | 栈的压入、弹出序列 (+stack 辅助) | ❎  
53 | 剑指 Offer 32 - III. 从上到下打印二叉树 III | ❎ 
63 | 树的子结构 | ❎  
67 | 数字序列中某一位的数字 `找规律, pass`  | **NG**
69 | 剪绳子II | **Not Good**, so pass.

## 1. Tree

No. | Question | Flag
:---: | --- | ---
1.1 | 平衡二叉树
1.2 | 对称的二叉树
1.3 | 二叉树的镜像
1.4 | 二叉树的最近公共祖先
1.6 | 从上到下打印二叉树 II / III
1.7 | 二叉树中和为某一值的路径
1.8 | 二叉搜索树的后序遍历序列
1.9 | 二叉搜索树与双向链表

```python
class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        def dfs(cur):
            if not cur: return
            dfs(cur.left) # 递归左子树
            if self.pre: # 修改节点引用
                self.pre.right, cur.left = cur, self.pre
            else: # 记录头节点
                self.head = cur
            self.pre = cur # 保存 cur
            dfs(cur.right) # 递归右子树
        
        if not root: return
        self.pre = None
        dfs(root)
        self.head.left, self.pre.right = self.pre, self.head
        return self.head
```

[题解链接](https://leetcode-cn.com/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/solution/mian-shi-ti-36-er-cha-sou-suo-shu-yu-shuang-xian-5/)

**1.0 构造二叉树**

```python
class Node:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None


def creatTree(vals):
    nodes = []
    for i in range(len(vals)):
        cur_val = vals[i]
        if cur_val is not None:
            cur_node = Node(cur_val)
        else:
            cur_node = None
        nodes.append(cur_node)
        if i > 0:
            # 0, 1-1/2, 2-1/2
            par_id = (i - 1) // 2
            if (i - 1) % 2 == 0:
                nodes[par_id].left = cur_node
            else:
                nodes[par_id].right = cur_node
    return nodes[0]

def pre_out(root):
    if not root:
        return None

    print(root.val)
    pre_out(root.left)
    pre_out(root.right)

if __name__ == '__main__':
    vals = [3,5,1,6,2,0,8,None,None,7,4]
    root = creatTree(vals)
    pre_out(root)
```

**1.1 平衡二叉树**

```python
class Solution:
    def isBalanced(self, root: TreeNode) -> bool:

        def maxHigh(root):
            if root == None:
                return 0
            return max(maxHigh(root.left), maxHigh(root.right)) + 1

        if root == None:
            return True

        return abs(maxHigh(root.left) - maxHigh(root.right)) <= 1 and self.isBalanced(root.left) and self.isBalanced(root.right)
```

**1.2 对称的二叉树**

```python
def isSymmetricHelper(left: TreeNode, right: TreeNode):
    if left == None and right == None:
        return True
    if left == None or right == None:
        return False
    if left.val != right.val:
        return False
    return isSymmetricHelper(left.left, right.right) and isSymmetricHelper(left.right, right.left)

class Solution:
    def isSymmetric(self, root: TreeNode) -> bool:
        return root == None or isSymmetricHelper(root.left, root.right)
```

**1.3 二叉树的镜像**

```python
class Solution:
    def mirrorTree(self, root: TreeNode) -> TreeNode:
        if root == None:
            return root

        node = root.left
        root.left = self.mirrorTree(root.right)
        root.right = self.mirrorTree(node)

        return root
```

**1.4 二叉树的最近公共祖先**

```python
# 1. 从根节点开始遍历树
# 2. 如果节点 p 和节点 q 都在右子树上，那么以右孩子为根节点继续 1 的操作
# 3. 如果节点 p 和节点 q 都在左子树上，那么以左孩子为根节点继续 1 的操作
# 4. 如果条件 2 和条件 3 都不成立，这就意味着我们已经找到节 p 和节点 q 的 LCA 了
class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        # 当越过叶节点，则直接返回 null
        # 当 rootroot 等于 p, q， 则直接返回 root
        if root == None or root == p or root == q:
            return root
        
        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        
        if not left and not right: return None
        
        if not left: return right
        if not right: return left
        
        return root
```

**二叉搜索树的最近公共祖先**

```python
class TreeNode:
    def __init__(self, x):
        self.val = x
        self.left = None
        self.right = None

# 算法:
# 1. 从根节点开始遍历树
# 2. 如果节点 p 和节点 q 都在右子树上，那么以右孩子为根节点继续 1 的操作
# 3. 如果节点 p 和节点 q 都在左子树上，那么以左孩子为根节点继续 1 的操作
# 4. 如果条件 2 和条件 3 都不成立，这就意味着我们已经找到节 p 和节点 q 的 LCA 了

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        # Value of current node or parent node.
        parent_val = root.val
        # Value of p
        p_val = p.val
        # Value of q
        q_val = q.val

        # If both p and q are greater than parent
        if p_val > parent_val and q_val > parent_val:
            return self.lowestCommonAncestor(root.right, p, q)
        # If both p and q are lesser than parent
        elif p_val < parent_val and q_val < parent_val:
            return self.lowestCommonAncestor(root.left, p, q)
        # We have found the split point, i.e. the LCA node.
        else:
            return root
```

**1.6 从上到下打印二叉树 II / III**

从上到下打印二叉树 II

```python
from collections import deque

class Solution:
    def levelOrder(self, root: TreeNode) -> List[int]:
        if not root:
            return []
        queue = collections.deque()
        queue.append(root)
        res = []
        while queue:
            size = len(queue)
            for _ in range(size):
                cur = queue.popleft()
                if not cur:
                    continue
                res.append(cur.val)
                queue.append(cur.left)
                queue.append(cur.right)
        return res
```

**从上到下打印二叉树 III**

```python
class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []

        queue = deque()
        queue.append([root, 0])
        res = []
        tmp_dict = dict()
        while queue:
            cur, level = queue.popleft()
            if tmp_dict.get(level) is not None:
                tmp_dict[level].append(cur.val)
            else:
                tmp_dict[level] = [cur.val]

            if cur.left:
                queue.append([cur.left, level + 1])
            if cur.right:
                queue.append([cur.right, level + 1])

        for ix in range(len(tmp_dict)):
            if ix % 2 == 1:
                res.append(tmp_dict[ix][::-1])
            else:
                res.append(tmp_dict[ix])

        return res
```

**1.7 二叉树中和为某一值的路径**

```python
def pathSum(self, root: TreeNode, sum: int) -> List[List[int]]:

    if not root:
        return []

    self.path.append(root.val)
    sum = sum - root.val
    
    if sum == 0 and root.left is None and root.right is None:
        self.res.append(list(self.path))
    
    if root.left:
        self.pathSum(root.left, sum)
    if root.right:
        self.pathSum(root.right, sum)
    
    self.path.pop()
    return self.res
```

**1.8 二叉搜索树的后序遍历序列**

```python
class Solution:
    def verifyPostorder(self, postorder: [int]) -> bool:
        def recur(i, j):
            if i >= j:
                return True

            p = i

            while postorder[p] < postorder[j]:
                p += 1

            m = p

            while postorder[p] > postorder[j]:
                p += 1

            return p == j and recur(i, m - 1) and recur(m, j - 1)

        return recur(0, len(postorder) - 1)
```

**1.9 二叉搜索树与双向链表**

```python
class Solution:
    def treeToDoublyList(self, root: 'Node') -> 'Node':
        def dfs(cur):
            if not cur: return
            dfs(cur.left) # 递归左子树
            
            if self.pre: # 修改节点引用
                self.pre.right = cur
                cur.left = self.pre
            else: # 记录头节点
                self.head = cur
            self.pre = cur # 保存 cur
            
            dfs(cur.right) # 递归右子树
        
        if not root: return
        self.pre = None
        dfs(root)
        self.head.left = self.pre
        self.pre.right = self.head
        return self.head
```

## 2. LinkedList

**2.1 复杂链表的复制**

```
"""
# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random
"""
class Solution:
    def copyRandomList(self, head: 'Node') -> 'Node':
```

## 3. String

字符串全排列 permutation

```python
# 输入：s = "abc"
# 输出：["abc","acb","bac","bca","cab","cba"]

from typing import List


class Solution:

    def permutation(self, s: str) -> List[str]:
        c = list(s)
        res = []

        def dfs(x):
            if x == len(c) - 1:
                res.append(''.join(c))  # 添加排列方案
                return
            dic = set()
            for i in range(x, len(c)):
                # if c[i] in dic: continue  # 重复，因此剪枝
                # dic.add(c[i])
                c[i], c[x] = c[x], c[i]  # 交换，将 c[i] 固定在第 x 位
                dfs(x + 1)               # 开启固定第 x + 1 位字符
                c[i], c[x] = c[x], c[i]  # 恢复交换

        dfs(0)
        return res
```


## 4. Array & Sort

**4.1 最小的k个数**

```python
import heapq
from typing import List

class Solution:
    def getLeastNumbers(self, arr: List[int], k: int) -> List[int]:

        if k == 0:
            return list()

        hp = [-x for x in arr[:k]]

        heapq.heapify(hp)

        for i in range(k, len(arr)):
            if -hp[0] > arr[i]:
                heapq.heappop(hp)
                heapq.heappush(hp, -arr[i])

        ans = [-x for x in hp]

        return ans
```

**4.2 n个骰子的点数**

```
# 把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s的所有可能的值出现的概率。
#
# 你需要用一个浮点数数组返回答案，其中第 i 个元素代表这 n 个骰子所能掷出的点数集合中第 i 小的那个的概率。
#
# 输入: 1
# 输出: [0.16667,0.16667,0.16667,0.16667,0.16667,0.16667]
#
# 输入: 2
# 输出: [0.02778,0.05556,0.08333,0.11111,0.13889,0.16667,0.13889,0.11111,0.08333,0.05556,0.02778]


# 通过题目我们知道一共投掷 n 枚骰子，那最后一个阶段很显然就是：当投掷完 n 枚骰子后，各个点数出现的次数。
#
# 注意，这里的点数指的是前 n 枚骰子的点数和，而不是第 n 枚骰子的点数，下文同理。
#
# 找出了最后一个阶段，那状态表示就简单了。
#
# 首先用数组的第一维来表示阶段，也就是投掷完了几枚骰子。
# 然后用第二维来表示投掷完这些骰子后，可能出现的点数。
# 数组的值就表示，该阶段各个点数出现的次数。
# 所以状态表示就是这样的：dp[i][j] ，表示投掷完 i 枚骰子后，点数 j 的出现次数。

# dp[i][j] += dp[i-1][j-cur];
```

```python
from typing import List


class Solution:

    def twoSum(self, n: int) -> List[float]:

        dp = [[0] * (6 * n + 1) for _ in range(11 + 1)]  # 索引0不取，后面取到最大索引6*n

        for i in range(1, 7):  # init
            dp[1][i] = 1

        for i in range(2, n + 1):  # 从第二轮抛掷开始算
            for j in range(2, 6 * i + 1):  # 第二轮抛掷最小和为2，从大到小更新对应的抛掷次数
                # dp[j] = 0  # 每次投掷要从0更新dp[j]大小，点数和出现的次数要重新计算
                for cur in range(1, 7):  # 每次抛掷的点数
                    if j - cur <= 0:
                        break

                    if j - cur > (i - 1) * 6:
                        continue

                    dp[i][j] += dp[i - 1][j - cur]  # 根据上一轮来更新当前轮数据
                    print(f'{i}, {j}, ==== {i-1} {j-cur}')

        sum_ = 6 ** n
        res = []

        for i in range(n, 6 * n + 1):
            res.append(dp[n][i] * 1.0 / sum_)

        return res
```

### 4.3 顺时针打印矩阵

```python
# 输入：matrix = [
#     [1,2,3,4],
#     [5,6,7,8],
#     [9,10,11,12]
# ]
# 输出：[
#     1,2,3,4,
#     8,12,11,10,
#     9,5,6,7
# ]
from typing import List


class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix or not matrix[0]:
            return list()

        rows, columns = len(matrix), len(matrix[0])
        order = list()
        left, right, top, bottom = 0, columns - 1, 0, rows - 1

        while left <= right and top <= bottom:
            for column in range(left, right + 1):
                order.append(matrix[top][column])

            for row in range(top + 1, bottom + 1):
                order.append(matrix[row][right])

            if left < right and top < bottom:
                for column in range(right - 1, left, -1):
                    order.append(matrix[bottom][column])
                for row in range(bottom, top, -1):
                    order.append(matrix[row][left])

            left, right, top, bottom = left + 1, right - 1, top + 1, bottom - 1

        return order
```
 
### 4.4 把数组排成最小的数

```python
from functools import cmp_to_key
from typing import List


class Solution:
    def minNumber(self, nums: List[int]) -> str:
        def sort_rule(x, y):
            a, b = x + y, y + x
            if a > b:
                return 1
            elif a < b:
                return -1
            else:
                return 0

        strs = [str(num) for num in nums]
        strs.sort(key=cmp_to_key(sort_rule))
        return ''.join(strs) 
 ```
 
### 4.5 把字符串转换成整数 

```python
class Solution:
    def strToInt(self, str: str) -> int:
        str = str.strip()                      # 删除首尾空格
        if not str: return 0                   # 字符串为空则直接返回
        res, i, sign = 0, 1, 1
        int_max, int_min, bndry = 2 ** 31 - 1, -2 ** 31, 2 ** 31 // 10
        if str[0] == '-': sign = -1            # 保存负号
        elif str[0] != '+': i = 0              # 若无符号位，则需从 i = 0 开始数字拼接
        for c in str[i:]:
            if not '0' <= c <= '9' : break     # 遇到非数字的字符则跳出
            if res > bndry or res == bndry and c > '7': return int_max if sign == 1 else int_min # 数字越界处理
            res = 10 * res + int(c) # 数字拼接
        return sign * res

```

### 4.7 数值的整数次方 (递归+2分)

```python
class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0: return 0
        res = 1
        if n < 0: x, n = 1 / x, -n
        while n:
            if n & 1: res *= x
            x *= x
            n >>= 1
        return res
```

## 5. sliding window

剑指 Offer 59 - I. 滑动窗口的最大值 - (同理于包含 min 函数的栈)

- [answ](https://leetcode-cn.com/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof/solution/mian-shi-ti-59-i-hua-dong-chuang-kou-de-zui-da-1-6/) 

```python
# -*- coding: utf-8 -*-
import collections
from typing import List

# 输入: nums = [1,3,-1,-3,5,3,6,7], 和 k = 3
# 输出: [3,3,5,5,6,7]
# 解释:
#
#   滑动窗口的位置                最大值
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
#  1 [3  -1  -3] 5  3  6  7       3
#  1  3 [-1  -3  5] 3  6  7       5
#  1  3  -1 [-3  5  3] 6  7       5
#  1  3  -1  -3 [5  3  6] 7       6
#  1  3  -1  -3  5 [3  6  7]      7

class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        if not nums or k == 0: return []
        deque = collections.deque()
        for i in range(k): # 未形成窗口
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
        res = [deque[0]]

        for i in range(k, len(nums)): # 形成窗口后
            #[0~k-1], [1~k], [2~k+1]
            if deque[0] == nums[i - k]:
                deque.popleft()
            while deque and deque[-1] < nums[i]:
                deque.pop()
            deque.append(nums[i])
            res.append(deque[0])
        return res

```
     
quickSort
 
```python
def quickSort(a, left, right):
    if left < right:
        l, r, x = left, right, a[l]
        while True
            while l < r and a[r] >= x:
                r--
            while l < r and a[l] <= x:
                l++

            if l >= r:
                break
                
            a[r], a[l] = a[l], a[r]

        a[left], a[l] = a[l], a[left]
        quickSort(a, left, l-1)
        quickSort(a, l+1, right)

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


## Reference

- [成长之路 0607offer](https://blog.csdn.net/qq_24243877)
- [知乎： [Leetcode][动态规划]相关题目汇总/分析/总结](https://zhuanlan.zhihu.com/p/35707293)
- [简书： 2019 算法面试相关(leetcode)--动态规划(Dynamic Programming)](https://www.jianshu.com/p/af880bbba792)
- [CSDN leetcode DP](https://blog.csdn.net/EbowTang/article/details/50791500)
- [刷完700多题后的首次总结：LeetCode应该怎么刷？](https://blog.csdn.net/fuxuemingzhu/article/details/105183554)
- [小白一路走来，连续刷题三年，谈谈我的算法学习经验](https://www.cnblogs.com/kubidemanong/p/10996134.html)
[codebunk.com](https://codebunk.com/b/3421100160572/)
[《程序员的算法趣题》-开坑记录](https://www.dattyrabbit.cn/articles/2020/08/16/1597576674555.html?utm_source=ld246.com)
