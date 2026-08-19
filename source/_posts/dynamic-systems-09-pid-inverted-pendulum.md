---
title: PID 实践——倒立摆
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - PID
  - Inverted Pendulum
categories:
  - Study Notes
mathjax: true
abbrlink: 21087
date: 2024-08-15 09:00:00
---

# PID 实践——倒立摆

> 动态系统建模与分析 · 学习笔记
> 2024年8月15日

## 1. 物理模型与运动方程

不考虑阻力。设水平方向上杆对车的力为 $ P $，竖直方向删杆对车的力为 $ N $。车受到水平方向上的外力 $ F $。

### 对车（水平方向受力）

$$
F - P = M\ddot{x}
$$

### 对杆（平动）

质心坐标（$L = l/2$ 为转轴到质心距离）：

$$
x_c = x + L\sin\theta, \qquad y_c = -L\cos\theta
$$

质心加速度：

$$
\ddot{x}_c = \ddot{x} + L\cos\theta\cdot\ddot{\theta} - L\sin\theta\cdot\dot{\theta}^2
$$

$$
\ddot{y}_c = L\sin\theta\cdot\ddot{\theta} + L\cos\theta\cdot\dot{\theta}^2
$$

杆的受力：

$$
m\ddot{x}_c = P \quad \text{（水平）}, \qquad
m\ddot{y}_c = N - mg \quad \text{（竖直）}
$$

### 转动

以质心为参考，惯性力矩为 0，转动惯量：

$$
J_c = \frac{1}{12}ml^2
$$

### 代入得运动方程组

$$
\begin{cases}
(M + m)\ddot{x} + \frac{l}{2}m\left(\ddot{\theta}\cos\theta - \dot{\theta}^2\sin\theta\right) = F \\[4pt]
J_c\ddot{\theta} + \frac{l}{2}mg\sin\theta + \frac{l}{2}m\ddot{x}\cos\theta + \frac{l^2}{4}m\dot{\theta}^2\sin\theta = 0
\end{cases}
$$

令 $L = l/2$（连接处到质心位置），简化为：

$$
\begin{cases}
(M + m)\ddot{x} + mL\,\ddot{\theta}\cos\theta - mL\,\dot{\theta}^2\sin\theta = F \\[4pt]
J_c\ddot{\theta} + mgL\sin\theta + mL\,\ddot{x}\cos\theta + mL^2\dot{\theta}^2\sin\theta = 0
\end{cases}
$$

![倒立摆物理模型](/images/control-theory/inverted-pendulum-model.jpg)

![倒立摆坐标系与角度定义](/images/control-theory/pendulum-coords.jpg)

## 2. 线性化

可见上述方程组不是线性方程，需线性化。令

$$
\varphi = \pi - \theta
$$

表示杆偏离竖直向上的小角度。小角度近似（$\varphi$ 很小时）：

$$
\sin\theta = \sin(\pi - \varphi) = \sin\varphi \approx \varphi
$$

$$
\cos\theta = \cos(\pi - \varphi) = -\cos\varphi \approx -1
$$

$$
\theta = \pi - \varphi \approx \pi \Rightarrow \dot{\theta} = -\dot{\varphi}, \quad \ddot{\theta} = -\ddot{\varphi}
$$

忽略二阶小量（如 $\dot{\theta}^2\sin\theta$ 等），得到线性化方程组：

$$
\begin{cases}
(M + m)\ddot{x} + mL\,\ddot{\varphi} = F \\[4pt]
J_c\ddot{\varphi} + mL\,\ddot{x} - mgL\,\varphi = 0
\end{cases}
$$


## 3. 拉普拉斯变换与传递函数

零初始条件下作拉氏变换：

$$
\begin{cases}
(M + m)s^2 X(s) + mL\,s^2\Phi(s) = F(s) \\[4pt]
(J_c + mL^2)s^2\Phi(s) + mL\,s^2 X(s) = 0
\end{cases}
$$

由第二式解出 $\dfrac{\Phi(s)}{X(s)}$：

$$
\frac{\Phi(s)}{X(s)} = \frac{-mL\,s^2}{(J_c + mL^2)s^2 - mgL}
$$

输入为 $ L[\ddot{x}(t)] = \ddot{X}(s)$，这时传递函数为 

$$
G_1(s) = \frac{\Phi(s)}{X(s)} = \frac{-mL}{(J_c + mL^2)s^2 - mgL}
$$

## 4. 闭环系统与 PID 控制器设计

![倒立摆 PID 闭环框图](/images/control-theory/pid-block.jpg)

闭环传递函数：

$$
T(s) = \frac{\Phi(s)}{R(s)} = \frac{K(s)G(s)}{1 + K(s)G(s)}
$$

PID 控制器：

$$
K(s) = K_p + \frac{K_i}{s} + K_d s = \frac{K_d(s + z_i)^2}{s}, \qquad z_i = \frac{K_i}{K_d}
$$

由上一节，被控对象可化为 $G(s) = \dfrac{b}{s^2 - a}$（此处取 $b = 2.5$，$a = 24.5$，负号在反馈处吸收），开环传递函数：

$$
L(s) = K(s)G(s) = \frac{b(K_d s^2 + K_p s + K_i)}{s(s^2 - a)}
$$

### 特征方程

$$
1 + L(s) = 0
$$

$$
s^3 + bK_d\,s^2 + (bK_p - a)\,s + bK_i = 0
$$

### Routh-Hurwitz 稳定性判据

劳斯表：

| $s^3$ | 1 | $bK_p - a$ | 0 |
|-------|---|---|---|
| $s^2$ | $bK_d$ | $bK_i$ | 0 |
| $s^1$ | $bK_p - a - K_i/K_d$ | 0 | |
| $s^0$ | $bK_i$ | | |

第一列全正 ⇒ 稳定条件：

$$
K_d > 0, \qquad K_i > 0, \qquad
K_p > \frac{a}{b} + \frac{K_i}{K_d} > \frac{a}{b}
$$

### 极点配置：三重实根

这里没有指标要求，先使极点为**三重实根** $s = -\omega_n$（无超调、响应速度快、易调）：

$$
(s + \omega_n)^3 = s^3 + 3\omega_n s^2 + 3\omega_n^2 s + \omega_n^3 = 0
$$

与特征方程对比系数：

$$
\begin{cases}
3\omega_n = bK_d \Rightarrow K_d = \dfrac{3\omega_n}{b} \\[4pt]
3\omega_n^2 = bK_p - a \Rightarrow K_p = \dfrac{3\omega_n^2 + a}{b} \\[4pt]
\omega_n^3 = bK_i \Rightarrow K_i = \dfrac{\omega_n^3}{b}
\end{cases}
$$

之后在 MATLAB 中调参（用方程 $\left[(J_c + mL^2)s^2 - mgL\right]\Phi(s) + mL^2 X(s) = 0$ 仿真验证）。

## 5. 非零初始条件的处理

系统方程（拉氏域，含初始条件）：

$$
\left[(J_c + mL^2)s^2 - mgL\right]\Phi(s) = -mL\,s^2 X(s) + (J_c + mL^2)\,s\,\Phi(0)
$$

非零初始条件可看作多个系统的叠加：

① $\Phi(0) = 0$（零初始条件，零状态响应）：

$$
\Phi_1(s) = \frac{-mL\,s^2}{(J_c + mL^2)s^2 - mgL}\,X(s)
$$

② $X(s) = 0$（零输入响应）：

$$
\Phi_2(s) = \frac{(J_c + mL^2)\,s}{(J_c + mL^2)s^2 - mgL}\,\Phi(0)
$$

总响应：

$$
\Phi(s) = \Phi_1(s) + \Phi_2(s)
= \frac{-mL\,s^2}{(J_c + mL^2)s^2 - mgL}\,X(s) + \frac{(J_c + mL^2)\,s}{(J_c + mL^2)s^2 - mgL}\,\Phi(0)
$$
