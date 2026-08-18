---
title: 拉普拉斯变换与逆变换
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Laplace Transform
categories:
  - Study Notes
mathjax: true
abbrlink: 28579
date: 2026-08-05 09:00:00
---

# 拉普拉斯变换与逆变换

> 动态系统建模与分析 · 学习笔记
> 2026年8月5日

## 1. 拉普拉斯变换定义

$$
\mathcal{L}\{f(t)\} = F(s) = \int_0^{+\infty} f(t) e^{-st}\,dt
$$

其中 $s = \sigma + j\omega$ 为复变量，即从时域 $f(t)$ 变换到 $s$ 域 $F(s)$。

### 例：$f(t) = e^{-at}$

$$
F(s) = \int_0^{+\infty} e^{-at} e^{-st}\,dt = \int_0^{+\infty} e^{-(s+a)t}\,dt = \frac{1}{s+a}
$$

即 $\mathcal{L}\{e^{-at}\} = \dfrac{1}{s+a}$。

## 2. 基本性质

### ① 线性

$$
\mathcal{L}\{a f(t) + b g(t)\} = a\,\mathcal{L}\{f(t)\} + b\,\mathcal{L}\{g(t)\}
$$

### ② 例：求 $\sin\omega t$、$\cos\omega t$ 的拉普拉斯变换

由欧拉公式：

$$
e^{j\omega t} = \cos\omega t + j\sin\omega t, \qquad
e^{-j\omega t} = \cos\omega t - j\sin\omega t
$$

$$
\sin\omega t = \frac{e^{j\omega t} - e^{-j\omega t}}{2j}, \qquad
\cos\omega t = \frac{e^{j\omega t} + e^{-j\omega t}}{2}
$$

利用 $\mathcal{L}\{e^{-at}\} = \frac{1}{s+a}$（这里 $a = \pm j\omega$）：

$$
\mathcal{L}\{\sin\omega t\} = \frac{1}{2j}\left[\frac{1}{s - j\omega} - \frac{1}{s + j\omega}\right] = \frac{\omega}{s^2 + \omega^2}
$$

$$
\mathcal{L}\{\cos\omega t\} = \frac{1}{2}\left[\frac{1}{s - j\omega} + \frac{1}{s + j\omega}\right] = \frac{s}{s^2 + \omega^2}
$$

### ③ 导数的拉普拉斯变换

$$
\mathcal{L}\{f'(t)\} = \int_0^{+\infty} f'(t) e^{-st}\,dt
= \left. f(t) e^{-st} \right|_0^{+\infty} + s\int_0^{+\infty} f(t) e^{-st}\,dt
$$

（默认 $f(t)$ 有界，故 $\lim_{t\to\infty} f(t)e^{-st} = 0$）

$$
\mathcal{L}\{f'(t)\} = sF(s) - f(0)
$$

推广：

$$
\mathcal{L}\{f''(t)\} = s^2 F(s) - s f(0) - f'(0)
$$

### ④ 积分的拉普拉斯变换

$$
\mathcal{L}\left\{\int_0^t f(z)\,dz\right\} = \frac{1}{s} F(s)
$$

推导（交换积分次序，见【图1】）：

$$
\mathcal{L}\left\{\int_0^t f(z)\,dz\right\}
= \int_0^{+\infty}\int_0^t f(z)\,dz \cdot e^{-st}\,dt
= \int_0^{+\infty}\int_z^{+\infty} e^{-st}\,dt \cdot f(z)\,dz
= \int_0^{+\infty} \frac{1}{s} f(z) e^{-sz}\,dz
= \frac{1}{s}F(s)
$$

![积分区域交换示意](/images/control-theory/integral-region.jpg)

### ⑤ 卷积

$$
(f * g)(t) = \int_{-\infty}^{+\infty} f(\tau) g(t - \tau)\,d\tau
$$

$$
\mathcal{L}\{f * g\} = F(s) G(s)
$$

## 3. 收敛域（ROC）

例：$f(t) = e^{-at}$，当 $s = -a$（即 $\sigma = -a$）时积分不收敛。

设 $s = \sigma + j\omega$：

$$
\mathcal{L}\{f(t)\} = \int_0^\infty e^{-at} e^{-(\sigma + j\omega)t}\,dt
= \int_0^\infty e^{-(\sigma + a)t} e^{-j\omega t}\,dt
$$

$$
\mathcal{L}\{e^{-at}\} = \frac{1}{s + a} \quad \Longleftrightarrow \quad \operatorname{Re}(s) = \sigma > -a
$$


## 4. 拉普拉斯逆变换（部分分式法）

### 例 1：实数极点

$$
F(s) = \frac{-s + 5}{s^2 + 5s + 4} = \frac{-s + 5}{(s+1)(s+4)} = \frac{A}{s+1} + \frac{B}{s+4}
$$

解得 $A = -3$，$B = 2$：

$$
F(s) = -\frac{3}{s+1} + \frac{2}{s+4}
$$

利用 $\mathcal{L}^{-1}\left\{\frac{1}{s+a}\right\} = e^{-at}$：

$$
\mathcal{L}^{-1}\{F(s)\} = 2e^{-4t} - 3e^{-t}
$$

### 例 2：复数极点

$$
F(s) = \frac{4s + 8}{s^2 + 2s + 5} = \frac{4s + 8}{(s + 1 + 2j)(s + 1 - 2j)} = \frac{A}{s + 1 + 2j} + \frac{B}{s + 1 - 2j}
$$

解得 $A = 2 + 2j$，$B = 2 - 2j$，利用欧拉公式：

$$
f(t) = \mathcal{L}^{-1}\{F(s)\}
= (2 + 2j)e^{-(1+2j)t} + (2 - 2j)e^{-(1-2j)t}
$$

$$
f(t) = e^{-t}\left(2\sin 2t + 4\cos 2t\right)
$$

## 5. 拉普拉斯变换、传递函数与微分方程

### 例：一阶系统（液位/电路）建模


由系统的微分方程（一阶惯性系统，$x$ 为状态量、$u$ 为输入）：

$$
\dot{x}(t) + \frac{1}{\tau} x(t) = u(t)
$$

作拉普拉斯变换：

$$
sX(s) + \frac{1}{\tau} X(s) = U(s)
$$

$$
\frac{X(s)}{U(s)} = \frac{1}{s + \frac{1}{\tau}} = G(s)
$$

![传递函数框图](/images/control-theory/transfer-block.jpg)

### 若 $U(s) = c$（常数输入）

$$
\mathcal{L}\{c\} = \frac{c}{s}
$$

$$
X(s) = \frac{c}{s} \cdot \frac{1}{s + \frac{1}{\tau}} = c\left(\frac{A}{s} + \frac{B}{s + \frac{1}{\tau}}\right)
$$

令 $s = 0$：$A = c\tau$；令 $s = -\frac{1}{\tau}$：$B = -c\tau$。

### 核心思想

> **控制定理**：通过设计输入 $U$，利用 $U(s)G(s)$ 配置极点，达到控制输出的目的。

即通过设计控制器（输入 $U$）改变系统极点位置，从而控制系统动态响应。
