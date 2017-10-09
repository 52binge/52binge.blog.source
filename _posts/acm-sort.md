---
title: Sort algorithms
toc: true
date: 2016-10-27 10:28:21
categories: icpc
tags: acm
description: data structure - six kinds of sorting algorithms
mathjax: true
---

> input ： 8, 5, 4, 9, 2, 3, 6

## 1. heapSort

```c++
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

## 2. quickSort

```c++
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

## 3. mergeSort

```c++
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

## 4. insertSort

```c++
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

## 5. bubbleSort

```c++
void bubbleSort(int a[], int len) {
    for(int i = 1; i < len; i++) {
        for(int j = 0; j < len-i; j++) {
            if(a[j] > a[j+1]) swap(a[j], a[j+1]);
        }
    }
}
```

## 6. selectSort

```c++
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

