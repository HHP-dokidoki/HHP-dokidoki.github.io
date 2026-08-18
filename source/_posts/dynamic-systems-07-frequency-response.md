---
title: 系统的频率响应
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Frequency Response
categories:
  - Study Notes
mathjax: true
abbrlink: 59572
date: 2026-08-13 09:30:00
---

# 系统的频率响应

> 动态系统建模与分析 · 学习笔记
> 2026年8月13日

## 引言：指数信号是 LTI 系统的特征函数

对于某个频率的输入，应如何分析其响应？

回顾：Fourier 变换本质上是将函数正交分解到 $e^{j\omega}$ 上，Laplace 变换又在其基础上多乘了 $e^{\sigma}$ 作为缩放因子。再参考线性代数中特征值的分析方法：

> **指数信号 $e^{st}$ 是 LTI 系统的特征函数**。LTI 系统本身就是作用在函数这个向量上的线性算子，具体作用方式就是和 $h(t)$ 卷积。

## 1. 证明

设输入 $x(t) = e^{st}$，则响应：

$$
y(t) = \int_{-\infty}^{\infty} h(\tau)\,e^{s(t-\tau)}\,d\tau
= e^{st}\int_{-\infty}^{\infty} h(\tau)\,e^{-s\tau}\,d\tau
= e^{st} H(s)
$$

故对一个系统，当输入为 $e^{st}$ 时，输出为 $e^{st}H(s)$。

## 2. 幅值与相位响应

设传递函数 $H(s) = \dfrac{N(s)}{D(s)}$。

假定输入为正弦叠加形式 $u(t) = A\sin\omega t + B\cos\omega t$，可化为：

$$
u(t) = \sqrt{A^2 + B^2}\sin(\omega t + \varphi_0), \qquad \varphi_0 = \arctan\frac{B}{A}
$$

其拉普拉斯变换：

$$
U(s) = \frac{A\omega + Bs}{s^2 + \omega^2} = \frac{A\omega + Bs}{(s + j\omega)(s - j\omega)}
$$

输出（$D(s) = (s-p_1)(s-p_2)\cdots(s-p_n)$）：

$$
X(s) = U(s)H(s) = \frac{(A\omega + Bs)\,N(s)}{(s + j\omega)(s - j\omega)\,D(s)}
$$

部分分式展开：

$$
X(s) = \frac{k_1}{s + j\omega} + \frac{k_2}{s - j\omega} + \frac{c_1}{s - p_1} + \cdots + \frac{c_n}{s - p_n}
$$

## 3. 稳态响应

拉普拉斯逆变换：

$$
x(t) = \mathcal{L}^{-1}\{X(s)\} = k_1 e^{-j\omega t} + k_2 e^{j\omega t} + c_1 e^{p_1 t} + \cdots + c_n e^{p_n t}
$$

对于**稳定系统**，稳态响应只包含正弦项（其余项随时间衰减，系数对稳态无贡献）：

$$
x_{ss}(t) = k_1 e^{-j\omega t} + k_2 e^{j\omega t} \quad \text{(steady state)}
$$

### 求 $k_1$、$k_2$

令 $s = -j\omega$：

$$
k_1 = -\frac{A - Bj}{2j}\,H(-j\omega) = \frac{B + Aj}{2}\,H(-j\omega)
$$

令 $s = j\omega$：

$$
k_2 = \frac{A + Bj}{2j}\,H(j\omega) = \frac{B - Aj}{2}\,H(j\omega)
$$

### $H(j\omega)$ 与 $H(-j\omega)$ 的共轭关系

$$
H(-j\omega) = \int_{-\infty}^{\infty} h(t)\,e^{j\omega t}\,dt = \overline{\int_{-\infty}^{\infty} h(t)\,e^{-j\omega t}\,dt} = \overline{H(j\omega)}
$$

（利用 $h(t)$ 为实函数，积分后取共轭可交换次序）

### 极坐标表示



$$
H(j\omega) = |H(j\omega)|\,e^{j\varphi_H}, \qquad
H(-j\omega) = |H(j\omega)|\,e^{-j\varphi_H}, \qquad \varphi_H = \angle H(j\omega)
$$

代入稳态响应：

$$
x_{ss}(t) = \frac{B + Aj}{2}\,|H(j\omega)|\,e^{-j\varphi_H} e^{j\omega t} + \frac{B - Aj}{2}\,|H(j\omega)|\,e^{j\varphi_H} e^{-j\omega t}
$$

展开为实函数（利用欧拉公式合并共轭项）：

$$
x_{ss}(t) = |H(j\omega)|\,\sqrt{A^2 + B^2}\,\sin(\omega t + \varphi_0 + \varphi_H)
$$

**结论**（红色强调）：

- **幅值响应**：$|H(j\omega)|$ —— 输入幅值被放大的倍数
- **相位响应**：$\varphi_H$ —— 输出相对输入的相移

这正是系统频率响应的核心：系统对不同频率正弦输入的增益和相移特性。

## 4. 二阶系统的频率响应

$$
H(s) = \frac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}
$$

代入 $s = j\omega$：

$$
H(j\omega) = \frac{\omega_n^2}{(\omega_n^2 - \omega^2) + j2\zeta\omega_n\omega}
$$

引入**归一化频率** $u = \dfrac{\omega}{\omega_n}$：

$$
H(ju\omega_n) = \frac{1}{(1 - u^2) + j2\zeta u}
$$

幅值：

$$
|H(ju\omega_n)| = \frac{1}{\sqrt{(1 - u^2)^2 + (2\zeta u)^2}}
$$

相位：

$$
\varphi_H = -\arctan\frac{2\zeta u}{1 - u^2}
$$

### 极限情况

| 情况 | 幅值 | 相位 |
|------|------|------|
| 低频 $u \to 0$ | $\|H\| = 1$（0 dB） | $\varphi_H = 0°$ |
| 自然频率 $u = 1$（$\omega = \omega_n$） | $\|H\| = \frac{1}{2\zeta}$ | $\varphi_H = -\frac{\pi}{2}$ |
| 高频 $u \to \infty$ | $\|H\| = 0$ | $\varphi_H = -\pi$ |

### 谐振峰

令 $f(u) = (1 - u^2)^2 + (2\zeta u)^2$，分母越小幅值越大：

$$
\frac{df}{du} = -4u(1 - u^2) + 8\zeta^2 u = 4u(u^2 + 2\zeta^2 - 1)
$$

令 $\dfrac{df}{du} = 0$：

$$
u^2 = 1 - 2\zeta^2
$$

**谐振频率**（仅当 $\zeta < 0.707$ 时存在）：

$$
\omega_r = \omega_n\sqrt{1 - 2\zeta^2}, \qquad \zeta < 0.707
$$

**谐振峰值**：

$$
M_r = \frac{1}{2\zeta\sqrt{1 - \zeta^2}}, \qquad \zeta < 0.707
$$

## 5. 一阶系统的频率响应

回顾超调量：$\%OS = e^{-\pi\zeta/\sqrt{1-\zeta^2}}$，故 $\zeta \downarrow \Rightarrow \%OS \uparrow$，$M_r \uparrow$。

**带宽**：幅值降至 -3 dB 的频率（此时功率降至一半）。

一阶系统传递函数：

$$
H(s) = \frac{K}{\tau s + 1}
$$

代入 $s = j\omega$：

$$
H(j\omega) = \frac{K}{1 + j\tau\omega}
= \frac{K}{\sqrt{1 + (\tau\omega)^2}} - j\frac{K\tau\omega}{\sqrt{1 + (\tau\omega)^2}}
$$

幅值与相位：

$$
|H(j\omega)| = \frac{K}{\sqrt{1 + (\tau\omega)^2}}, \qquad
\varphi_H = -\arctan(\tau\omega)
$$

相位范围：$-90° < \varphi_H < 0°$（纯滞后）。

### 极限情况

- **低频极限**：$|H| = K$，$\varphi_H = 0°$
- **高频极限**：$|H| = 0$，$\varphi_H = -90°$

### 转折频率（截止频率）

取 $K = 1$：

$$
|H| = \frac{1}{\sqrt{1 + (\tau\omega)^2}}
$$

令 $|H| = \frac{1}{\sqrt{2}}$（即 -3 dB，功率降至一半）：

$$
\omega = \frac{1}{\tau}, \qquad \varphi_H = -45°
$$

### 为什么一阶系统没有谐振峰？

$|H| = \dfrac{1}{\sqrt{1 + (\tau\omega)^2}}$ 是关于 $\omega$ 的**单调递减函数**，无峰值，故不存在谐振峰。

---


