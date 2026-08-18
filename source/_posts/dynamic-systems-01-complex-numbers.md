---
title: 复数的幅角表示
description: 动态系统建模与分析学习笔记。
tags:
  - Control Theory
  - Complex Numbers
categories:
  - Study Notes
mathjax: true
abbrlink: 34218
date: 2026-08-13 09:00:00
---

# 复数的幅角表示

> 动态系统建模与分析 · 学习笔记
> 2026年8月13日

## 1. 复数的几何表示

复数 $z$ 在复平面上可表示为一点或一个向量：

- 横轴为实轴（Re），纵轴为虚轴（Im）
- 复数点坐标 $(a, b)$，即 $z = a + bj$（工程中虚数单位用 $j$ 表示）
- 从原点到该点的向量长度为模 $|z|$，与实轴正方向的夹角为幅角 $\alpha$

![复平面示意图](/images/control-theory/complex-plane.jpg)

## 2. 幅角表示（极坐标 / 指数形式）

由几何关系：

$$
|z| = \sqrt{a^2 + b^2}, \qquad
\sin\alpha = \frac{\operatorname{Im}(z)}{|z|}, \qquad
\cos\alpha = \frac{\operatorname{Re}(z)}{|z|}
$$

于是：

$$
z = |z|\cos\alpha + |z|\sin\alpha \cdot j
= |z|(\cos\alpha + j\sin\alpha)
= |z|\,e^{j\alpha}
$$

其中幅角 $\alpha = \arctan\left(\dfrac{\operatorname{Im}(z)}{\operatorname{Re}(z)}\right)$。

## 3. 幅角表示下的运算性质

设 $z_1 = |z_1|e^{j\alpha_1}$，$z_2 = |z_2|e^{j\alpha_2}$，则：

- **乘法**：$z_1 z_2 = |z_1||z_2|\,e^{j(\alpha_1 + \alpha_2)}$
- **除法**：$\dfrac{z_1}{z_2} = \dfrac{|z_1|}{|z_2|}\,e^{j(\alpha_1 - \alpha_2)}$
- **共轭**：$z = |z|e^{j\alpha}$，$\bar{z} = |z|e^{-j\alpha}$

即：幅角表示下，复数乘法相当于**模相乘、幅角相加**；除法相当于**模相除、幅角相减**；共轭即**幅角取反**。
