---
title: 从向量到拉普拉斯变换
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Fourier Transform
  - Laplace Transform
categories:
  - Study Notes
mathjax: true
abbrlink: 40211
date: 2026-08-08 09:00:00
---

# 从向量到拉普拉斯变换

> 动态系统建模与分析 · 学习笔记
> 2026年8月8日

## 一、向量的表示及其变换

线性代数中，设有正交基 $\{\alpha_1, \alpha_2, \dots, \alpha_n\}$，向量 $\mathbf{X} = [x_1, x_2, \dots, x_n]^T$：

$$
\mathbf{X} = \begin{bmatrix} \alpha_1 & \alpha_2 & \cdots & \alpha_n \end{bmatrix}
\begin{bmatrix} x_1 \\ x_2 \\ \vdots \\ x_n \end{bmatrix}
$$

对向量而言，**内积即投影**，原向量分别与新基向量内积可得新坐标：

$$
\mathbf{X}_\alpha^T = \mathbf{X}^T A \tag{1}
$$

称基 $\alpha$ 下的 $\mathbf{X}$ 为 $\mathbf{X}_\alpha$，$[\alpha_1, \dots, \alpha_n]$ 为 $A$，则：

$$
\mathbf{X}_\alpha = A^T \mathbf{X}
$$

基正交 ⇒ $A^T A = I_n$，即 $A^{-1} = A^T$，故：

$$
\mathbf{X} = A\,\mathbf{X}_\alpha \tag{2}
$$

12两式具有一种对称性（正变换与逆变换）。

## 二、函数与向量

### 1. 函数可看作无限维的向量

**函数内积**：

$$
\langle f(x), g(x) \rangle = \int_{-\infty}^{\infty} f(x)\,g(x)\,dx
$$

（把取点、组区间长度/步长取极限即得积分，也看作投影，得到一个数）

如果想以某个基来表示函数，则基也应为无穷维。可以这样写：

$$
F(\omega) = \int_{-\infty}^{\infty} f(x)\,g(x, \omega)\,dx \tag{1}
$$

> $F(\omega)$：$f(x)$ 在第 $\omega$ 个基向量上的坐标（**像函数**）

$$
f(x) = \int_{-\infty}^{\infty} F(\omega)\,g(x, \omega)\,d\omega \tag{2}
$$

> **原函数 ⟷ 像函数（函数组）**

注：1为投影，2为线性组合。

### 2. 复数域的内积

以上皆是实数域。对于复数域，内积应为 $A\bar{B}$（$A$ 与 $B$ 的共轭），因为向量与自身内积应得到实模长（定义），复数与自身共轭相乘才得其模。故复空间函数内积为：

$$
\langle f(x), g(x) \rangle = \int_{-\infty}^{\infty} f(x)\,g^*(x)\,dx
$$

## 三、差分与微分、求和与积分

向量用矩阵可实现差分：

$$
\begin{bmatrix}
-1 & 1 & 0 & \cdots & 0 \\
0 & -1 & 1 & \cdots & 0 \\
0 & 0 & -1 & \cdots & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
0 & 0 & 0 & \cdots & -1
\end{bmatrix}
$$

同样可用矩阵表示求和（上三角全 1 矩阵）。视函数为无穷维向量，求导、积分亦可作类似变换。

### 特征向量：$e^{st}$

线性代数中，若 $A\mathbf{X} = \lambda\mathbf{X}$，则 $\mathbf{X}$ 为变换 $A$ 对应特征值 $\lambda$ 的特征向量。若找到一组特征向量并以其为基，变换在该基下可简化为对角矩阵。

将求导、积分视作变换，同样寻找特征向量——不难找到 $e^{st}$：

$$
(e^{st})' = s\,e^{st}, \qquad \int e^{st}\,dt = \frac{1}{s}e^{st} + C
$$

接下来看其能否构成正交基。当 $s$ 为纯虚数时，在有限区间 $[-T/2, T/2]$ 内，令 $\omega_n = \dfrac{2\pi n}{T}$（$n \in \mathbb{Z}$），基函数 $\varphi_n = e^{j\omega_n t}$：

$$
\langle \varphi_m, \varphi_n \rangle = \int_{-T/2}^{T/2} e^{j(\omega_m - \omega_n)t}\,dt
= \begin{cases} T, & \omega_m = \omega_n \\ 0, & \omega_m \ne \omega_n \end{cases}
$$

> 注：一般复数 $s$ 且 $\operatorname{Re}(s) \ne 0$ 时，$e^{st}$ 在 $(-\infty, \infty)$ 上积分发散，**故正交基只取虚轴**。正交性要求：积分区间为 $e^{j\omega t}$ 周期的整数倍，且 $\omega_n = \frac{2\pi n}{T}$ 为 $2\pi$ 的整数倍。

## 四、使用纯虚数 $s$ 构造正交基（傅里叶级数）

设 $f(t)$ 周期为 $T$：

$$
f(t) = \sum_{n} F(n)\,e^{j\omega_n t}, \qquad \omega_n = \frac{2\pi n}{T}
$$

由周期性 $f(t + T) = f(t)$，要求 $e^{j\omega_n T} = 1$，即 $\omega_n T$ 为 $2\pi$ 的整数倍。

傅里叶级数系数（投影）：

$$
F(n) = \langle f(t), e^{j\omega_n t} \rangle = \frac{1}{T}\int_{-T/2}^{T/2} f(t)\,e^{-j\omega_n t}\,dt
$$

（$n$ 与 $\omega_n$ 一一对应）

## 五、从傅里叶级数到傅里叶变换

当 $T \to \infty$：$\Delta\omega = \omega_0 = \frac{2\pi}{T} \to 0$，$\Delta f = \frac{1}{T} \to 0$，离散求和过渡为连续积分：

$$
f(t) = \int_{-\infty}^{\infty}\left(\int_{-\infty}^{\infty} f(t)\,e^{-j\omega t}\,dt\right) e^{j\omega t}\,d\omega
$$

得 **Fourier 变换**（频域/频谱）：

$$
F(j\omega) = \int_{-\infty}^{\infty} f(t)\,e^{-j\omega t}\,dt
$$

**逆 Fourier 变换**：

$$
f(t) = \frac{1}{2\pi}\int_{-\infty}^{\infty} F(\omega)\,e^{j\omega t}\,d\omega
$$

![频谱从离散到连续的演变](/images/control-theory/spectrum-evolution.png)

## 六、拉普拉斯变换

FT 并不能应对所有函数：若 $f(t)$ 无界，则积分无定义。解决方法是引入**衰减因子** $e^{-\sigma t}$（$s = \sigma + j\omega$）：

$$
F(s) = \int_{-\infty}^{\infty} f(t)\,e^{-st}\,dt, \qquad s = \sigma + j\omega
$$

即 Laplace 变换。

**逆 Laplace 变换**（沿 $\sigma$ 常数线积分，$ds = j\,d\omega$）：

$$
f(t) = \frac{1}{2\pi j}\int_{\sigma - j\infty}^{\sigma + j\infty} F(s)\,e^{st}\,ds
$$

### 常见函数的拉普拉斯变换

| $f(t)$ | $F(s)$ | $f(t)$ | $F(s)$ |
|--------|--------|--------|--------|
| $u(t)$ | $\dfrac{1}{s}$ | $u(t)\sin\omega t$ | $\dfrac{\omega}{s^2 + \omega^2}$ |
| $u(t)e^{-at}$ | $\dfrac{1}{s + a}$ | $u(t)\cos\omega t$ | $\dfrac{s}{s^2 + \omega^2}$ |
| $t\,u(t)$ | $\dfrac{1}{s^2}$ | $u(t)e^{-at}\sin\omega t$ | $\dfrac{\omega}{(s+a)^2 + \omega^2}$ |
| | | $u(t)e^{-at}\cos\omega t$ | $\dfrac{s + a}{(s+a)^2 + \omega^2}$ |

## 七、利用拉普拉斯变换分析系统

### 逆变换的一种方法：部分分式展开

$$
F(s) = \frac{N(s)}{D(s)} = \sum_k \frac{A_k}{s - p_k}
\;\Longrightarrow\;
f(t) = \sum_k A_k e^{p_k t}
$$

设 $H(s)$ 有 $k$ 个极点 $p_k = \sigma_k + j\omega_k$，冲激响应：

$$
h(t) = \sum_k A_k e^{p_k t} = \sum_k A_k e^{\sigma_k t}e^{j\omega_k t}
$$

### 系统稳定性判断

| 极点条件 | $\lim_{t\to\infty} h(t)$ | 结论 |
|----------|--------------------------|------|
| $\sigma_k > 0$ | $\infty$ | 发散，**不稳定** |
| $\sigma_k < 0$ | $0$ | 收敛，**稳定** |
| $\sigma_k = 0$ | 等幅振荡 $\sum_k A_k e^{j\omega_k t}$ | **临界稳定** |

极点虚部的影响：

- $\operatorname{Im}(p_k) = \omega \ne 0$：振荡衰减（欠阻尼）
- $\operatorname{Im}(p_k) = \omega = 0$：单调收敛

![s 平面极点与典型响应](/images/control-theory/poles-and-responses.png)
