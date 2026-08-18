---
title: 从根轨迹到 PID 控制
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Root Locus
  - PID
categories:
  - Study Notes
mathjax: true
abbrlink: 55465
date: 2026-08-10 09:00:00
---

# 从根轨迹到 PID 控制

> 动态系统建模与分析 · 学习笔记
> 2026年8月10日

## 引言

反馈系统的稳定性由其**闭环极点**唯一确定，即由特征方程的根决定。简单的判稳方法是计算特征方程的根，但对于高阶系统或系统参数变化的情况，计算将十分繁杂。

鉴于此，**伊凡思（Evans）** 提出了以图解特征方程根的方法，即**根轨迹法**。

## 一、闭环系统的传递函数与开环传递函数

![闭环控制系统框图](/images/control-theory/closed-loop-block.jpg)

闭环传递函数（$R(s)$ 到 $Y(s)$）：

$$
T(s) = \frac{Y(s)}{R(s)} = \frac{K\,G_1(s)}{1 + K\,G_1(s)H(s)}
$$

开环传递函数即闭环系统在比较点处断开后，从 $E(s)$ 到 $B(s)$ 的传递关系：

$$
L(s) = \frac{B(s)}{E(s)} = K\,G_1(s)H(s)
$$

可以发现：

$$
T(s) = \frac{K\,G_1(s)}{1 + L(s)}
$$

通过 $T(s)$ 可分析系统的响应特性与稳定性。而系统特征方程

$$
1 + L(s) = 0
$$

说明闭环极点即为 $L(s) = -1$ 的根。那么可通过 $L(s)$ 分析系统稳定性，后者显然更方便。

## 二、根轨迹

### 1. 何为根轨迹

特征方程：

$$
1 + L(s) = 0 \quad \Longleftrightarrow \quad L(s) = -1 \quad \Longleftrightarrow \quad KG(s)H(s) = -1
$$

**根轨迹定义**：特征方程中参数（比例增益 $K$）从 $0$ 到 $+\infty$ 变化时，所有根 $s$ 在复平面上扫出的轨迹集合。

### 2. 幅值条件与相角条件

由 $KG(s)H(s) = -1$：

**幅值条件**：

$$
|K\,G(s)H(s)| = 1
$$

**相角条件**：

$$
\angle G(s)H(s) = (2n+1)\pi, \quad n = 0, 1, 2, \dots
$$

设 $G(s)H(s) = \dfrac{(s - z_1)(s - z_2)\cdots(s - z_m)}{(s - p_1)(s - p_2)\cdots(s - p_n)}$，其中 $\theta_k$ 为从零点 $z_k$ 到点 $s$ 的向量夹角，$\varphi_k$ 为从极点 $p_k$ 到点 $s$ 的向量夹角，则相角条件可写为：

$$
\sum_{k=1}^{m}\theta_k - \sum_{k=1}^{n}\varphi_k = (2n+1)\pi
$$

> 判断一个点 $s$ 是否在根轨迹上，仅需检查其是否满足相角条件；若满足，可根据幅值条件求出对应的 $K$ 值。

### 3. 手绘根轨迹的规则

设 $L(s) = KG(s)H(s) = K\cdot\dfrac{\prod_{k=1}^{m}(s - z_k)}{\prod_{k=1}^{n}(s - p_k)}$，即 $n$ 个极点、$m$ 个零点。

**1) 起点与终点**：起点为开环极点，终点为开环零点。

由 $1 + L(s) = 0 \Rightarrow G(s)H(s) = -\frac{1}{K}$：

- $K \to 0$ 时，轨迹起于极点
- $K \to \infty$ 时，轨迹终止于零点
- 若 $n > m$：$n$ 条轨迹起于极点，$m$ 条终止于零点，剩余 $n - m$ 条终止于无穷远处
- 若 $n < m$：$m$ 条起于零点，$n$ 条终止于极点，剩余 $m - n$ 条起于无穷远处

**2) 分支与对称性**：一定有 $\max(n, m)$ 条分支，且一定关于实轴对称（复数解一定共轭）。

**3) 实轴上的根轨迹**：实轴上零、极点将轴分段，若某段右侧的零、极点总数是奇数，则该段必为根轨迹的一部分（可用幅角条件证明）。

**4) 渐近线**：当极点数 $n$ 大于零点数 $m$ 时，$n - m$ 条轨迹沿与实轴夹角 $\varphi_k$、交于 $\sigma_a$ 的渐近线趋于无穷：

$$
\varphi_k = \frac{(2k+1)\pi}{n - m}, \qquad
\sigma_a = \frac{\sum P_i - \sum Z_j}{n - m}
$$

**5) 会合点与分离点**：根轨迹于此会合、分离，对应**重根**，其坐标 $d$ 满足：

$$
\sum_{i=1}^{n}\frac{1}{d - P_i} = \sum_{j=1}^{m}\frac{1}{d - Z_j}
$$

或令 $\left.\dfrac{dK}{ds}\right|_{s=d} = 0$ 求解。

### 4. 根轨迹性能分析

对主导极点 $s_{1,2} = -\zeta\omega_n \pm j\omega_n\sqrt{1 - \zeta^2}$：

- 超调量：$M_p = e^{-\pi\zeta/\sqrt{1-\zeta^2}}$
- 调节时间（2%）：$t_s = \dfrac{4}{\zeta\omega_n}$

## 三、从根轨迹到 PID 控制

对一个系统，如果我们对其各项指标有要求，便可**通过要求反解出目标极点，再通过设计增益调控根轨迹经过目标极点**。

![含控制器的闭环控制系统](/images/control-theory/control-system-block.jpg)

### 1. P 控制（比例）

$$
K(s) = K_p
$$

开环传递函数 $L(s) = K_p G(s)H(s)$。此时根轨迹的**形状不变**（由被控对象决定），调整 $K_p$ 只改变闭环传递函数的极点在轨迹上的位置。

**缺点**：

1. 若目标极点不在根轨迹上，则无法达到目标；
2. 稳态误差无法消除。

**稳态误差分析**：

$$
E(s) = \frac{R(s)}{1 + K_p G(s)H(s)}
$$

由终值定理（前提是极限存在）：

$$
\lim_{t\to\infty} f(t) = \lim_{s\to 0} sF(s)
$$

$$
e_{ss} = \lim_{s\to 0} sE(s) = \lim_{s\to 0} \frac{sR(s)}{1 + K_p G(s)H(s)}
$$

阶跃输入 $R(s) = \frac{1}{s}$ 时：

$$
e_{ss} = \frac{1}{1 + K_p G(0)H(0)}
$$

对于实际系统 $G(0)H(0) \ne \infty$，仅当 $K_p \to \infty$ 时 $e_{ss} \to 0$；而实际调控中 $K_p$ 过大导致输入过大，故**无法消除稳态误差**。

### 2. 超前补偿器（Lead）

要改变轨迹，则需改变极、零点。

$$
K(s) = K_p\,\frac{s + z}{s + p}, \qquad z, p \in \mathbb{R}, \quad 0 < z < p
$$

设计目标：让期望的闭环主导极点落在加了补偿器后的根轨迹上。

**设计步骤**：

1. 计算相角亏空：$\phi = 180° - \angle G(s_1)H(s_1)$
2. 令 $\phi = \angle(s_1 - z) - \angle(s_1 - p)$
3. 选取合适的 $z$ 与 $p$
4. 利用幅值条件求解 $K_p$：

$$
\left|K_p\,\frac{s_1 - z}{s_1 - p}\,G(s_1)H(s_1)\right| = 1
\Rightarrow K_p = \frac{1}{\left|G(s_1)H(s_1)\cdot\frac{s_1 - p}{s_1 - z}\right|}
$$

为了达到同样的目标，还可以令 $K(s) = K_1 s + K_p$，即典型的 **PD 控制**，但其缺点是对高频信号放大明显，会使系统对高频噪声敏感。

### 3. 消除稳态误差

滞后补偿器：$K(s) = K_p\,\dfrac{s + z}{s + p}$，其中 $0 < p < z$ 且 $|p|, |z|$ 较小。

闭环误差：

$$
E(s) = \frac{R(s)}{1 + K(s)G(s)H(s)} = \frac{R(s)}{1 + K_p G(s)H(s)\cdot\frac{s + z}{s + p}}
$$

阶跃输入下的稳态误差：

$$
e_{ss} = \lim_{s\to 0} sE(s) = \frac{1}{1 + K_p G(0)H(0)\cdot\frac{z}{p}}
$$

因为 $p < z$，所以 $K_p G(0)H(0)\cdot\frac{z}{p} > K_p G(0)H(0)$，**达到了减小 $e_{ss}$ 的目的**。

极限 $p \to 0$ 时，$e_{ss} \to 0$，此时：

$$
K(s) = K_p\,\frac{s + z}{s} = K_p + K_p\frac{z}{s} = K_p + \frac{K_i}{s}
$$

为典型的 **PI 控制**。

### 4. P、超前、滞后分析

对于恒定增益 $K_p$，其在高低频处的增益一致，无法改变根轨迹形态，也无法消除稳态误差。

对于超前/滞后补偿器 $K(s) = K_p\dfrac{s + z}{s + p}$：

- 原点处增益：$K(0) = K_p\dfrac{z}{p}$
- 高频处增益：$K(s) \approx K_p\dfrac{1 + z/s}{1 + p/s}$

$K(s)$ 的取值会影响极、零点位置，从而影响系统闭环瞬态（影响幅值条件与相位条件，决定闭环极点移动）；而当 $|K(s)| \approx 1$ 且 $\angle K(s) \approx 0°$ 时影响很小。

阶跃输入下：$e_{ss} = \dfrac{1}{1 + K(0)G(0)H(0)}$，$K(0) \uparrow \Rightarrow e_{ss} \downarrow$，而 $K(0) = K_p\frac{z}{p}$，故需要增大 $\frac{z}{p}$。

> 如何做到既调控闭环极点（瞬态）又减小稳态误差（稳态）？—— 同时采用多个控制器：
>
> - $K(s) = K_p$（$z = p = 0$）
> - $K(s) = K_p\frac{s + z}{s + p}$，$0 < z < p$（**超前**，调瞬态）
> - $K(s) = K_p\frac{s + z}{s + p}$，$0 < p < z$（**滞后**，调稳态）
>
> 为了使滞后不影响已调好的闭环极点，其 $p$ 应足够小；当 $p \to 0$ 变为 PI 控制。

### 5. PID 控制

将超前、滞后复合，便得到 **PID 控制**：

$$
K(s) = K_p + \frac{K_i}{s} + K_d s
$$

$$
\Rightarrow K(s) = \frac{K_d s^2 + K_p s + K_i}{s} = \frac{K_d(s - z_1)(s - z_2)}{s}
$$

即 **两个零点 + 一个在原点的极点**：利用 $z_1, z_2$ 调极点（瞬态），原点的极点消除稳态误差（$p \to 0$ 的稳态）。

### 6. PID 设计流程

> **设计流程：先 PD 定瞬态，再 PI 调稳态**

① 设定目标极点：$s = -\zeta\omega_n \pm j\omega_n\sqrt{1 - \zeta^2}$

② PD：$K_{PD}(s) = k_p + k_d s = k_d(s + z)$——反解零点，使目标极点落在根轨迹上

③ PI：$K_{PI}(s) = 1 + \frac{k_i}{s} = \frac{s + k_i}{s}$——对应原点处的极零点

④ PID：

$$
K_{PID}(s) = K_{PD} \times K_{PI} = \frac{k_d(s + z)(s + k_i)}{s}
$$
