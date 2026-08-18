---
title: 标准一阶系统
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - First-order System
categories:
  - Study Notes
mathjax: true
abbrlink: 44056
date: 2026-08-13 09:20:00
---

# 标准一阶系统

> 动态系统建模与分析 · 学习笔记
> 2026年8月13日

## 1. 标准一阶系统形式

标准一阶系统的传递函数为：

$$
H(s) = \frac{K}{\tau s + 1}
$$

其中 $K$ 为**直流增益**（对应微分方程中输入的增益），$\tau$ 为时间常数。

对应的微分方程为：

$$
\tau \dot{x} + x = K u(t)
$$

### 实例：液位系统

![液位系统示意图](/images/control-theory/tank-system.jpg)

设定 $x(t) = h(t)$（液位），$u(t) = q_{in}$（流入流量），建立微分方程：

$$
\dot{x} + \frac{g}{AR}\,x = \frac{1}{A}\,u(t)
$$

作拉普拉斯变换（LT）：

$$
sX(s) + \frac{1}{AR}\,X(s) = \frac{1}{A}\,U(s)
$$

得到传递函数：

$$
H(s) = \frac{X(s)}{U(s)} = \frac{\frac{1}{A}}{s + \frac{1}{AR}}
$$


## 2. 一阶系统分析

### ① 极点

$$
s = -\frac{1}{\tau}
$$

只有一个实数极点，故**不会超调，不会振荡**。

### ② 时间常数

系统的阶跃响应（输入 $u(t) = A \cdot 1(t)$）：

$$
X(s) = \frac{A}{s} \cdot \frac{K}{\tau s + 1} = \frac{AK}{s(\tau s + 1)}
$$

部分分式展开：

$$
X(s) = AK\left(\frac{1}{s} - \frac{1}{s + \frac{1}{\tau}}\right)
$$

![一阶系统阶跃响应](/images/control-theory/step-response-1st.jpg)

反变换得时域响应：

$$
x(t) = AK\left(1 - e^{-t/\tau}\right)
$$

当 $t = \tau$ 时：

$$
x(\tau) = AK\left(1 - e^{-1}\right) \approx AK \times 63\%
$$

这也是时间常数 $\tau$ 的定义方式之一：**响应达到稳态值约 63% 所需的时间**。

### ③ 上升时间（10% → 90%）

分别令 $1 - e^{-t/\tau} = 0.1$ 和 $1 - e^{-t/\tau} = 0.9$：

$$
t_{0.1} = \tau \ln\frac{1}{0.9} \approx 0.105\tau, \qquad
t_{0.9} = \tau \ln\frac{1}{0.1} \approx 2.303\tau
$$

$$
T_r = t_{0.9} - t_{0.1} \approx 2.2\tau
$$

### ④ 调节时间（2% 误差带）

令 $1 - e^{-t/\tau} = 0.98$：

$$
T_s = \tau \ln 50 \approx 4\tau
$$

若允许 5% 误差（即 $1 - e^{-t/\tau} = 0.95$）：

$$
T_s = \tau \ln 20 \approx 3\tau
$$
