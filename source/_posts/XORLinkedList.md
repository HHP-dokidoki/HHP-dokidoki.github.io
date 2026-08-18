---
title: '[数据结构学习笔记]异或链表'
description: 异或链表(XOR Linked List)及其C语言实现
abbrlink: 34242
tags:
  - C Lanuage
  - Data Structure
categories: Study Notes
date: 2026-1-13 22:34:06
mathjax: true
---

# 异或链表

---

## 定义
&emsp;&emsp;异或链表（XOR Linked List）本质上是双向链表，但它利用按位异或的值，仅使用一个指针的内存大小便可以实现双向链表的功能。

---

## 实现原理
&emsp;&emsp;异或链表的核心原理是异或运算($\oplus$)的自反性，即 $ A \oplus A = 0 $，$ A \oplus 0 = A $。使用异或链表时，我们在结构```Node```中定义```xorp```为 $ pre \oplus next $ ，即前后两个节点地址的按位异或，正向遍历时只需要用前驱的地址与```xorp```进行异或运算即可得到后继的地址( $ xorp \oplus pre = pre \oplus next \oplus pre = next \oplus 0 = next $ )，反向遍历同理。

---

## 实现方法

### 结构体定义
```c
typedef struct node{
    int value;
    struct node* xorp; // xorp = pre XOR next;
}Node;

typedef struct list{
    Node* head;
    Node* tail;
}Linked_List;         // 存储列表的首尾节点地址
```
---

### 辅助函数
指针异或运算
```c
Node* xor(Node* a, Node* b)
{
    // 将指针转换为uintptr_t进行异或运算，再转回Node指针
    // uintptr_t 为 stdint.h 库中提供的能存储指针的数据类型
    return (Node*)((uintptr_t)a ^ (uintptr_t)b); 
}
```

创建新节点，分配内存并初始化value，xorp初始化为NULL
```c
Node* create_node(int value)
{
    Node* node = NULL;
    node = (Node*)malloc(sizeof(Node));
    if (node == NULL) {
        perror("malloc failed");
        exit(EXIT_FAILURE);
    }
    node->value = value;
    node->xorp  = NULL;
    return node;
}
```

---

从简单入手，先实现不需遍历链表的首尾插入与删除
### 首插/尾插

#### 首插
首插主要分为三步进行： 
1. 更新原表头```xorp```
2. 更新新表头```xorp```
3. 更新链表表头

具体实现如下：
时间复杂度 $ O(1) $
```c
void push_front(Linked_List* linked_list, int value) 
{
    Node* new_node = NULL;

    new_node = create_node(value);

    if (linked_list->head == NULL) {
        linked_list->tail       = new_node;
        linked_list->head       = new_node;
        linked_list->tail->xorp = NULL;
        linked_list->head->xorp = NULL;
        return ;
    }

    linked_list->head->xorp = xor(new_node, linked_list->head->xorp);
    new_node->xorp        = linked_list->head;
    linked_list->head       = new_node;
}
```
&emsp;&emsp;当首插时链表为空，则直接将链表的首尾节点设置为要插入的节点的地址。此时首尾节点的前驱后继皆为```NULL```，而 ``` NULL XOR NULL = NULL ``` ，所以再将首尾节点的```xorp```均设置为```NULL```。

&emsp;&emsp;当首插时链表不为空，则先更新链表原表头的```xorp```：

1. 设原表头的后继的地址为```next```，插入新节点前，表头的```xorp```为 ``` NULL next ``` ，插入新节点后，原表头的前驱变为```new_node```，后继不变，所以我们要将原表头的```xorp```更新为 ``` new_node next ```，只需将原本的```xorp```与```new_node```进行一次异或运算即可;

2. 设置新节点的```xorp```为 ``` NULL XOR linked_list->head ``` 即可;

3. 将链表表头更新为 ```new_node```。

#### 尾插
尾插同理，这里直接放代码：
时间复杂度 $ O(1) $
```c
void push_back(Linked_List* linked_list, int value)
{
    Node *new_node = NULL;

    new_node = create_node(value);
    /* 
       如果链表为空，新节点既是头节点也是尾节点 
       xorp 设为 NULL 
    */
    if (linked_list->tail == NULL) {
        linked_list->tail       = new_node;
        linked_list->head       = new_node;
        linked_list->tail->xorp = NULL;
        linked_list->head->xorp = NULL;
        return ;
    }
    /*
       如果链表不为空：
        1. 更新旧尾节点的xorp: xor(linked_list->tail->xorp, new_node) 相当于
          (原倒数第二个节点 XOR NULL) XOR new_node
        2. 新节点的xorp应为 (旧尾节点 XOR NULL = 旧尾节点) 
        3. 更新链表尾指针
    */
    linked_list->tail->xorp = xor(new_node, linked_list->tail->xorp);
    new_node->xorp        = linked_list->tail;
    linked_list->tail       = new_node;
}
```

### 首删/尾删
首删与尾删操作上与首插、尾插相似(甚至更简单)，是后者的逆过程。
#### 首删
首删主要分为3步进行:
1. 更新链表首节点
2. 更新新首节点的```xorp```
3. 释放原首节点内存

但执行过程中需要对链表为空或者删除后链表为空的情况进行特殊处理。
具体方式如下:
***该函数实现的其实是弹出链表表头的节点，并非单纯的删除***
时间复杂度 $ O(1) $
```c
int pop_front(Linked_List* linked_list, int* val)
{
    Node* head_node = NULL;

    head_node = linked_list->head;

    if (head_node == NULL) {
        return -1;      
    }
    
    *val = head_node->value;

    linked_list->head = linked_list->head->xorp;
    
    if (linked_list->head != NULL) {
        linked_list->head->xorp = xor(linked_list->head->xorp, head_node);
    } else {
        linked_list->tail = NULL;
    }
    
    free(head_node);
    return 0;
}
```
&emsp;&emsp;先解释函数：接收linked_list参数用于指定要查找的链表，再接受一个val参数用于接受结果；返回 0 / -1 用于标记是否删除成功。

若链表为空链表，无法进行删除操作，直接返回-1

若链表不为空，则

1. 更新链表首节点为原首节点的后继节点 (```linked_list->head = linked_list->head->xorp;```)

2. 更新首节点的```xorp```:如果删除后链表变为空链表，无新首节点，则直接将```linked_list->tail```设置为```NULL```。否则，新首节点为原首节点的后继节点，我们这里将原首节点、新首节点和新首节点的后继节点分别设为```first```、```second```、和```third```，则```second->xorp = first XOR third```，现在要将其变为```NULL XOR third```，则仅需将```second->xorp```与```first```进行一次异或运算即可。

3. 释放内存：不必多说

#### 尾删
时间复杂度 $ O(1) $
同理，这里直接放代码:
```c
int pop_back(Linked_List* linked_list, int* val)
{
    // 尾部删除
    Node* tail_node = NULL;

    if (linked_list->tail == NULL) {
        return -1;      // Error code
    }

    tail_node = linked_list->tail;
    *val      = tail_node->value;

        /*
        tail_node->xorp 等于 (prev XOR NULL) = prev
        所以新的尾节点是 tail_node->xorp
        */
    linked_list->tail = linked_list->tail->xorp;
    
    if (linked_list->tail != NULL) {
        // 更新新尾节点的xorp: 
        // 原本是 (prev_prev XOR tail_node)，现在应该是 (prev_prev XOR NULL)
        // 所以需要将 tail_node 从 xorp 中移除 (再异或一次 tail_node)
        linked_list->tail->xorp = xor(linked_list->tail->xorp, tail_node);
    } else {
        // 链表变为空
        linked_list->head = NULL;
    }

    free(tail_node);
    return 0;
}
```
### 遍历
时间复杂度 $ O(n) $
&emsp;&emsp;设当前节点为``` cur ```，其前驱为 ``` pre ```，后继为``` nxt ```。由```Node```的定义，我们已知当前节点的 ``` xorp ``` 为 ``` pre XOR nxt ```，那么我们就可以通过 ``` xorp XOR pre ``` 得到 ``` nxt ```，通过 ``` xorp XOR nxt ``` 得到 ``` pre ```。只要不断重复计算就实现遍历链表。
具体实现如下：
```c
void out_linked_list(Linked_List* linked_list)
{
    // 输出链表
    int   cnt = 0;
    Node* pre = NULL;
    Node* cur = NULL;
    Node* nxt = NULL;

    if (linked_list->head == NULL) {
        return ;
    }

    cur = linked_list->head;
    nxt = linked_list->head->xorp;    // head->xorp = NULL ^ next = next
    
    while(cur != NULL) {
        ++cnt;
        printf("[%d]:%d\n",cnt, cur->value);
        if (nxt == NULL) break;
        
        // 移动指针到下一个位置
        pre = cur;
        cur = nxt;
        nxt = xor(cur->xorp, pre);
    }
}
```

### 随机插入/随机删除/随机访问
&emsp;&emsp;基于遍历和首插/删的原理，随机插入/访问就只需遍历到指定位置然后执行插入或者删除操作即可，需要处理空列表插入/删除以及插入/删除到末尾的特殊情况。

具体实现如下：
#### 随机插入
时间复杂度 $ O(n) $
```c
int insert(Linked_List* linked_list, int value, int pos)
{
    Node* pre       = NULL;
    Node* cur       = NULL;
    Node* nxt       = NULL;
    Node* new_node  = NULL;
    
    // 空链表插入
    if (linked_list->head == NULL) {
        if (pos == 1) {
            push_back(linked_list, value);
            return 0;
        }
        return -1;
    }

    new_node = create_node(value);
    cur      = linked_list->head;
    nxt      = linked_list->head->xorp;       // XOR(NULL, next_node) -> next_node
    
    pos--;
    for (; pos > 0 && nxt != NULL; --pos){  // pos == 0 (达到指定位置) 或
        pre = cur;                          // nxt == NULL (达到链表末尾) 时停止
        cur = nxt;
        nxt = xor(cur->xorp, pre);
    }

    if (pos != 0) { // 到达链表末尾且没有达到指定位置-->位置越界
        return -1; 
    }

    new_node->xorp = xor(cur, nxt);
    // cur->xorp = pre XOR nxt
    // 所以 (cur->xorp XOR nxt) XOR new_node = pre XOR new_node
    cur->xorp = xor(xor(cur->xorp, nxt), new_node);
    
    if (nxt != NULL) {
        // nxt->xorp 原本是 (cur XOR next_next)，现在应该是 (new_node XOR next_next)
        // XOR cur XOR new_code 即可
        nxt->xorp = xor(xor(nxt->xorp, cur), new_node);
    } else {
        // 如果 nxt 为 NULL，说明插入在尾部
        linked_list->tail = new_node;
    }
    return 0;
}
```

#### 随机删除
时间复杂度 $ O(n) $
```c
int delete(Linked_List* linked_list, int pos)
{
    Node* pre = NULL;
    Node* cur = NULL;
    Node* nxt = NULL;

    if (linked_list->head == NULL) {
        return -1;
    }

    cur = linked_list->head;
    nxt = linked_list->head->xorp;
    pos--;
    
    // 遍历找到要删除的节点 cur
    for (; pos > 0 && nxt != NULL; --pos){
        pre = cur;
        cur = nxt;
        nxt = xor(cur->xorp, pre);
    }
    if (pos != 0) { // 到达链表末尾且没有达到指定位置-->位置越界
        return -1;
    }
    
    // 如果删除的是头节点，更新head
    if (pre == NULL) {
        linked_list->head = nxt;
    }
    // 如果删除的是尾节点，更新tail
    if (nxt == NULL) {
        linked_list->tail = pre;
    }

    // 更新前后节点的异或指针
    // pre->xorp 原本是 (pre_pre XOR cur)，现在要是 (pre_pre XOR nxt)
    // XOR cur XOR nxt 即可
    if (pre != NULL) pre->xorp = xor(xor(pre->xorp, cur), nxt);
    
    // nxt->xorp 原本是 (cur XOR nxt_next)，现在要是 (pre XOR nxt_next)
    // XOR cur XOR pre 即可
    if (nxt != NULL) nxt->xorp = xor(xor(nxt->xorp, cur), pre);
    
    free(cur); // 内存很贵，不要忘记释放
    return 0;
}

```

#### 随机访问
时间复杂度 $ O(n) $
```c
int query(Linked_List* linked_list, int pos, int* val)
{
    Node* pre = NULL;
    Node* nxt = NULL;
    Node* cur = NULL;

    if (linked_list->head == NULL) {
        return -1;
    }

    cur = linked_list->head;
    nxt = cur->xorp;    // XOR(NULL, next) -> next
    pos--;
    
    // 遍历链表
    for (; pos > 0 && nxt != NULL; --pos){
        pre = cur;
        cur = nxt;
        nxt = xor(cur->xorp, pre);
    }
    if (pos != 0) {
        return -1;
    }
    // 确保传过来的不是空指针
    if (val != NULL) {
        *val = cur->value;
    }
    return 0; 
}
```
&emsp;&emsp;函数解释：接收```linked_list```参数用于指定要查找的链表，接收``` pos ```参数确定要查找的位置 再接受一个```val```参数用于接受结果；返回 0 / -1 用于标记是否删除成功。

### 其他

#### 逆序遍历
&emsp;&emsp;只需要把```linked_list```中的```head```和```tail```交换之后再传入函数即可，十分方便。


### 后记
&emsp;&emsp;第一篇博文就这样水完了()

&emsp;&emsp;个人感觉异或链表与其他链表最大的区别就是异或链表没有那么强的“链接感”。其他链表的节点或多或少都需要一个指针指向其前驱/后继，而异或链表是通过指针（甚至可以换成```unsigned long long```等类型）间接存储其前驱和后继的信息，直到需要时才通过计算得到前驱/后继。这使得异或链表更加抽象，遍历时也更加麻烦，需要前驱或者后继的信息才能开始遍历。不过相比其他链表，异或链表的优势也很明显：在实现双向遍历的同时又避免对内存的过多占用，适用于一些内存受限的场景（如嵌入式），同时，理论上，更小的内存占用还能提高缓存命中率以提高程序运行效率，这也略微提高了异或链表的效率。

&emsp;&emsp;读者可以尝试了解完原理后自己从零开始写异或链表的结构和功能，并在其基础上进行拓展，这样或许能更好地体会异或链表的精神。

&emsp;&emsp;这是笔者第一次写文章，若有不足请多多批评指教。
