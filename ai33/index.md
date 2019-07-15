
## 6. Stack & Queue & heap

> 1. 用两个栈实现队列
> 2. 包含min函数的栈
> 3. 栈的压入、弹出序列

### 6.1 两个栈实现队列

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

### 6.2 包含min函数的栈

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

### 6.3 栈的 push pop 序列 

```cpp
// 栈的 push pop 序列 
// 1 2 3 4 5
// 4 3 5 1 2
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

