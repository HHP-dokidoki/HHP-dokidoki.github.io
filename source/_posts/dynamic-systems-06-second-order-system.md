---
title: 标准二阶系统
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Second-order System
categories:
  - Study Notes
mathjax: true
abbrlink: 11219
date: 2026-02-12 09:00:00
---

# 标准二阶系统

> 动态系统建模与分析 · 学习笔记
> 2026年2月12日

## 1. 标准形式

$$
H(s) = \frac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}
$$

对应的微分方程：

$$
\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = \omega_n^2 u(t)
$$

其中 $\omega_n$ 为**无阻尼自然频率**，$\zeta$ 为**阻尼比**。

### ① 标准系统从何而来？—— 弹簧-质量-阻尼系统

![弹簧—质量—阻尼系统](/images/control-theory/mass-spring-damper.jpg)

由牛顿第二定律：

$$
F(t) - b\dot{x} - kx = m\ddot{x}
$$

$$
\Rightarrow \ddot{x} + \frac{b}{m}\dot{x} + \frac{k}{m}x = \frac{F(t)}{m}
$$

定义系统参数：

$$
\omega_n = \sqrt{\frac{k}{m}}, \qquad \zeta = \frac{b}{2\sqrt{mk}}
$$

代入得：

$$
\ddot{x} + 2\zeta\omega_n \dot{x} + \omega_n^2 x = \frac{F(t)}{m}
$$

作拉普拉斯变换（零初始条件）：

$$
s^2 X(s) + 2\zeta\omega_n s X(s) + \omega_n^2 X(s) = \frac{1}{m}F(s)
$$

$$
\frac{X(s)}{F(s)} = H(s) = \frac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}
$$

> 注：$\omega_n$ 与 $\zeta$ 固定的情况下，增益系数 $K$ 不影响极点、零点，只对输出增益有影响，故取标准形式 $H(s) = \dfrac{\omega_n^2}{s^2 + 2\zeta\omega_n s + \omega_n^2}$。

## 2. 特征方程与极点

特征方程：

$$
s^2 + 2\zeta\omega_n s + \omega_n^2 = 0
$$

特征根：

$$
s = -\zeta\omega_n \pm \omega_n\sqrt{\zeta^2 - 1}
$$

定义：

- 衰减度：$\delta = \zeta\omega_n$
- 阻尼振荡频率：$\omega_d = \omega_n\sqrt{1 - \zeta^2}$（$\zeta < 1$ 时）

按阻尼比 $\zeta$ 分类：

| 条件 | 特征根 | 响应特性 |
|------|--------|----------|
| $\zeta > 1$ | 两个负实根 $s_{1,2} < 0$ | 过阻尼，无振荡 |
| $\zeta = 1$ | 重根 $s = -\omega_n$ | 临界阻尼，最快无振荡 |
| $0 < \zeta < 1$ | 共轭复根 $s = -\zeta\omega_n \pm j\omega_n\sqrt{1-\zeta^2}$ | 欠阻尼，振荡衰减 |
| $\zeta = 0$ | 纯虚根 $s = \pm j\omega_n$ | 无阻尼，等幅振荡 |
| $\zeta < 0$ | 实部为正 | 不稳定，振荡发散 |

![s 平面极点与不同阻尼比的阶跃响应](/images/control-theory/s-plane-poles-and-response-2nd.png)

![不同阻尼比的阶跃响应](/images/control-theory/s-plane-poles-and-response-2nd.png)

## 3. 阶跃响应推导

输入 $R(s) = \frac{1}{s}$：

$$
X(s) = R(s)H(s) = \frac{\omega_n^2}{s(s^2 + 2\zeta\omega_n s + \omega_n^2)}
$$

部分分式展开：

$$
X(s) = \frac{A}{s} + \frac{Bs + C}{s^2 + 2\zeta\omega_n s + \omega_n^2}
$$

解得 $A = 1$，$B = -1$，$C = -2\zeta\omega_n$：

$$
X(s) = \frac{1}{s} + \frac{-s - 2\zeta\omega_n}{s^2 + 2\zeta\omega_n s + \omega_n^2}
$$

这是根据 $\zeta$ 的取值分类讨论。

### ① $\zeta > 1$（过阻尼）

$$
X(s) = \frac{1}{s} + \frac{\omega_n}{2\sqrt{\zeta^2 - 1}}\left(\frac{1}{s + \zeta\omega_n + \omega_n\sqrt{\zeta^2-1}} - \frac{1}{s + \zeta\omega_n - \omega_n\sqrt{\zeta^2-1}}\right)
$$

令 $\delta = \zeta\omega_n$，$\omega_d = \omega_n\sqrt{\zeta^2 - 1}$：

$$
x(t) = 1 - \frac{\omega_n}{\sqrt{\zeta^2 - 1}}e^{-\delta t}\cdot\frac{e^{\omega_d t} - e^{-\omega_d t}}{2}
= 1 - \frac{\omega_n}{\sqrt{\zeta^2 - 1}}e^{-\delta t}\sinh(\omega_d t)
$$

### ② $0 < \zeta < 1$（欠阻尼）

令 $\delta = \zeta\omega_n$，$\omega_d = \omega_n\sqrt{1 - \zeta^2}$，分母分解为共轭复根：

$$
X(s) = \frac{1}{s} - \frac{s + \delta}{(s + \delta)^2 + \omega_d^2} - \frac{\delta}{\omega_d}\cdot\frac{\omega_d}{(s + \delta)^2 + \omega_d^2}
$$

$$
x(t) = 1 - e^{-\delta t}\cos\omega_d t - e^{-\delta t}\frac{\delta}{\omega_d}\sin\omega_d t
$$

$$
x(t) = 1 - e^{-\delta t}\left(\cos\omega_d t + \frac{\zeta}{\sqrt{1 - \zeta^2}}\sin\omega_d t\right)
$$

合并为正弦形式：

$$
x(t) = 1 - \frac{e^{-\delta t}}{\sqrt{1 - \zeta^2}}\sin(\omega_d t + \varphi), \qquad
\varphi = \arctan\frac{\sqrt{1 - \zeta^2}}{\zeta}
$$

### ③ $\zeta = 1$（临界阻尼）

$$
X(s) = \frac{1}{s} - \frac{1}{s + \omega_n} - \frac{\omega_n}{(s + \omega_n)^2}
$$

$$
x(t) = 1 - e^{-\omega_n t} - \omega_n t\,e^{-\omega_n t}
= 1 - e^{-\omega_n t}(1 + \omega_n t)
$$

### ④ $\zeta = 0$（无阻尼）

$$
X(s) = \frac{1}{s} - \frac{s}{s^2 + \omega_n^2}
$$

$$
x(t) = 1 - \cos\omega_n t
$$

### ⑤ $\zeta < 0$（不稳定）

形式与欠阻尼相同：

$$
x(t) = 1 - \frac{e^{-\delta t}}{\sqrt{1 - \zeta^2}}\sin(\omega_d t + \varphi)
$$

但此时 $\delta = \zeta\omega_n < 0$，指数项 $e^{-\delta t}$ 随时间增长，振荡发散，系统不稳定。

## 4. 三个指标（以 $0 < \zeta < 1$ 为例）

基础公式：

$$
x(t) = 1 - \frac{e^{-\zeta\omega_n t}}{\sqrt{1 - \zeta^2}}\sin(\omega_d t + \varphi), \qquad
\varphi = \arctan\frac{\sqrt{1 - \zeta^2}}{\zeta}
$$

### ① 峰值时间 $T_p$

令 $x'(t) = 0$：

$$
\sin(\omega_d t + \varphi) = 0 \Rightarrow \omega_d t = n\pi
$$

第一个峰值（$n = 1$）：

$$
T_p = \frac{\pi}{\omega_d} = \frac{\pi}{\omega_n\sqrt{1 - \zeta^2}}
$$

### ② 超调量 $\%OS$

将 $T_p$ 代入 $x(t)$：

$$
x(T_p) = 1 - \frac{e^{-\zeta\pi/\sqrt{1-\zeta^2}}}{\sqrt{1 - \zeta^2}}\sin(\varphi + \pi)
= 1 + e^{-\zeta\pi/\sqrt{1-\zeta^2}}
$$

$$
\%OS = e^{-\zeta\pi/\sqrt{1-\zeta^2}} \times 100\%
$$

### ③ 调节时间 $T_s$（2% 准则）

响应的振荡包络为 $\dfrac{1}{\sqrt{1-\zeta^2}}e^{-\zeta\omega_n t}$，令包络衰减至 2%：

$$
e^{-\zeta\omega_n T_s} \le 0.02
$$

$$
T_{s,2\%} \approx \frac{4}{\zeta\omega_n}
$$

若按 5% 准则：

$$
T_{s,5\%} \approx \frac{3}{\zeta\omega_n}
$$
