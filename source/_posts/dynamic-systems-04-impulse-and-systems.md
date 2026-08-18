---
title: 冲激函数与系统
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - LTI Systems
  - Impulse Response
categories:
  - Study Notes
mathjax: true
abbrlink: 11672
date: 2026-08-13 09:10:00
---

# 冲激函数与系统

> 动态系统建模与分析 · 学习笔记
> 2026年8月13日

## 1. 冲激函数（狄拉克函数）

### ① 定义

$$
\delta(t) = \begin{cases} \infty, & t = 0 \\ 0, & t \ne 0 \end{cases}
$$

且满足归一化条件（单位冲激函数）：

$$
\int_{-\infty}^{+\infty} \delta(t)\,dt = 1
$$

是一种**广义函数**。严格定义为与测试函数 $\varphi(t)$ 的作用：

$$
\int_{-\infty}^{+\infty} \delta(t)\,\varphi(t)\,dt = \varphi(0)
$$

更一般地（平移）：

$$
\int_{-\infty}^{+\infty} \delta(t - t_0)\,\varphi(t)\,dt = \varphi(t_0)
$$

> $\delta(t)$ 的本质：一种**"采样算子"**——提取函数在冲激位置处的值。

### ② 性质

**筛选性**：

$$
\int_{-\infty}^{+\infty} \delta(t - t_0)\,\varphi(t)\,dt = \varphi(t_0), \qquad
x(t)\,\delta(t - t_0) = x(t_0)\,\delta(t - t_0)
$$

**对称性**：

$$
\delta(t) = \delta(-t)
$$

**尺度变换**：

$$
\delta(at) = \frac{1}{|a|}\delta(t), \qquad
\delta(at + b) = \frac{1}{|a|}\delta\left(t + \frac{b}{a}\right)
$$

**卷积性质**：

$$
(\varphi * \delta)(t) = \int_{-\infty}^{+\infty} \varphi(\tau)\,\delta(t - \tau)\,d\tau = \varphi(t)
$$

$$
\varphi(t) * \delta(t - t_0) = \int_{-\infty}^{+\infty} \varphi(\tau)\,\delta(t - t_0 - \tau)\,d\tau = \varphi(t - t_0)
$$

即：任意函数与冲激函数卷积 = 该函数本身；与 $\delta(t - t_0)$ 卷积 = 平移后的函数。

## 2. 与阶跃函数的关系

$$
\delta(t) = \frac{d}{dt}u(t), \qquad u(t) = \int_{-\infty}^{t} \delta(\zeta)\,d\zeta
$$

## 3. 冲激响应

**定义**：系统在单位冲激函数 $\delta(t)$ 激励下产生的输出信号（系统须初始松弛）。

## 4. 利用冲激函数表示任意信号

### ① 筛选性质的直观理解

任意信号 $x(t)$ 可看作一系列冲激函数的叠加：

$$
x(t) = \int_{-\infty}^{+\infty} x(\zeta)\,\delta(t - \zeta)\,d\zeta
$$

推导思路：把 $x(t)$ 按 $\Delta t_0$ 分段，每段用一个面积为 $x(k\Delta t_0)\Delta t_0$ 的冲激近似：

$$
x(t) = \sum_{k=-\infty}^{+\infty} x(k\Delta t_0)\,\delta(t - k\Delta t_0)\,\Delta t_0
$$

当 $\Delta t_0 \to 0$ 时取极限即得积分形式。

### ② LTI 系统的三个性质

**(1) 时不变性**：输入 $\delta(t) \to$ 输出 $h(t)$；输入 $\delta(t - \zeta) \to$ 输出 $h(t - \zeta)$

**(2) 齐次性**：输入 $\delta(t) \to$ 输出 $h(t)$；输入 $A\delta(t) \to$ 输出 $Ah(t)$

**(3) 叠加性**：输入 $u_1(t) \to$ 输出 $x_1(t)$；输入 $u_2(t) \to$ 输出 $x_2(t)$；输入 $u_1(t) + u_2(t) \to$ 输出 $x_1(t) + x_2(t)$

### ③ 核心推论：只需知道 $h(t)$ 即可求任意输入下的输出

根据①②，信号可分解为冲激信号的叠加，而 LTI 系统对叠加的响应 = 响应的叠加。

输入分解：

$$
x(t) = \int_{-\infty}^{+\infty} x(\tau)\,\delta(t - \tau)\,d\tau
$$

输出即为（卷积）：

$$
\int_{-\infty}^{+\infty} x(\tau)\,h(t - \tau)\,d\tau = x(t) * h(t)
$$

即系统输出 = 输入与冲激响应的卷积：

$$
x(t) = \int_{-\infty}^{+\infty} u(\tau)\,h(t - \tau)\,d\tau = u(t) * h(t)
$$

## 5. 从另一角度看：冲激函数的拉氏变换

$$
\mathcal{L}\{\delta(t)\} = \int_{-\infty}^{+\infty} \delta(t) e^{-st}\,dt = e^0 = 1
$$

对应拉氏变换域关系 $X(s) = U(s)H(s)$：

当输入为 $\delta(t)$ 时，$U(s) = \mathcal{L}\{\delta(t)\} = 1$，故

$$
X(s) = 1 \cdot H(s) = H(s)
$$

> **故冲激响应就是传递函数**：$H(s) = \mathcal{L}\{h(t)\}$，即传递函数是冲激响应的拉普拉斯变换。
