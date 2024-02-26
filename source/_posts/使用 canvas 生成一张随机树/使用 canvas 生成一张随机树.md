---
layout: pianduan
title: 使用 canvas 生成一张随机 '树'
date: 2022-02-25 17:15:07
tags:
  - canvas
---

先看效果

<img src="/images/使用canvas生成一张随机树/01.png" width="200px" style="margin:1em 0" />

[前往 codepen 查看](https://codepen.io/pan-chen/pen/QWoeLoy)

上代码

```html
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      * {
        margin: 0;
        padding: 0;
      }

      #canvas {
        display: block;
        background-color: lightskyblue;
      }
    </style>
  </head>

  <body>
    <canvas id="canvas"></canvas>
    <script>
      const canvas = document.getElementById('canvas')
      const width = window.innerWidth * devicePixelRatio
      const height = window.innerHeight * devicePixelRatio
      canvas.width = width
      canvas.height = height

      const ctx = canvas.getContext('2d')
      ctx.translate(canvas.width / 2, canvas.height)
      ctx.scale(1, -1)

      // drawCloud([0, height / 2], 100)
      drawBranch([0, 0], 200, 30, 90)
      function drawBranch(p0, length, thick, dir) {

        if (thick < 10 && Math.random() < 0.2) {
          return
        }

        if (thick < 2) {
          ctx.beginPath()
          ctx.arc(...p0, 10, 0, 2 * Math.PI)

          if (Math.random() < 0.15) {
            ctx.fillStyle = 'red'

          } else {
            ctx.fillStyle = '#fff'

          }

          ctx.fill()
          return
        }


        ctx.beginPath()
        ctx.moveTo(...p0)
        const p1 = [
          p0[0] + length * Math.cos((dir * Math.PI) / 180),
          p0[1] + length * Math.sin((dir * Math.PI) / 180)
        ]

        ctx.lineTo(...p1)
        ctx.lineWidth = thick
        ctx.filleStyle = '#333'
        ctx.lineCap = 'round'
        ctx.stroke()


        drawBranch(p1, length * 0.8, thick * 0.8, dir + Math.random() * 30)
        drawBranch(p1, length * 0.8, thick * 0.8, dir - Math.random() * 30)
      }


      function drawCloud(p, r) {
        const v1 = [p[0] - r, p[1]]
        const v2 = [p[0] + r / 2, p[1] + r * 1.5]
        const v3 = [p[0] + r * 2, p[1] - r / 1.5 / 1.2 / 2]

        ctx.beginPath()
        ctx.fillStyle = 'rgba(255, 255, 255,.3)'
        ctx.arc(...v1, r * 1.5, 0, Math.PI / 180 * 90)

        // ctx.arc(...v2, r * 1.5, 0, 2 * Math.PI)
        // ctx.arc(...v3, r * 1.2, 0, 2 * Math.PI)
        ctx.fill()


      }
    </script>
  </body>

  </html>
```

### 众所周知 canvas 的坐标系是从左往右从上往下，而现实中树是往上生长的所有需要先调整 canvas 坐标系

1. 先把原点位置设置为底部中间位置

   `ctx.translate(canvas.width / 2, canvas.height)`

2. 设置原点位置后并没有改变 canvas 绘画方向，这时可以使用 scale 方法把 y 轴的缩放改成 -1 这样方向就反过来了

   ` ctx.scale(1, -1)`

### 了解画一根树枝需要哪些参数

把一根树枝当做一段线段，在画布上画一条线段需要开始位置，结束位置，宽度等参数。

#### 计算树枝结束位置

而树枝生长方向是随机的所以结束位置我们要根据角度和长度计算出来，这时候就需要用到三角函数
<img src="/images/使用canvas生成一张随机树/02.png" width="200px" style="margin:1em 0" />

如图所示一直位置A ( 开始位置  ) 和 斜边 C （长度）物品，需要求的是 AC （开始位置到结束位置的距离长度）和 BC（ 开始位置到结束位置的高度）

根据公式 AC = cos a * AB ; BC = sin a * ab

`p.x + length * Math.cos((dir * Math.PI) / 180)`

` p.y + length * Math.sin((dir * Math.PI) / 180)`

解决了结束位置我们就可以画出一根树枝了

```javascript
// p0 开始位置 length 长度 thick 粗细 dir 树枝生长的角度
function drawBranch(p0, length, thick, dir) {
  ctx.beginPath()
  ctx.moveTo(...p0)
  const p1 = [
  p0[0] + length * Math.cos((dir * Math.PI) / 180),
  p0[1] + length * Math.sin((dir * Math.PI) / 180)
  ]

  ctx.lineTo(...p1)
  ctx.lineWidth = thick
  ctx.filleStyle = '#333'
  ctx.lineCap = 'round'
  ctx.stroke()
}
```

有了一根树枝后，我们可以递归调用这个方法，让它分别想左右延升并减少长度跟粗细

```javascript
// 左
drawBranch(p1, length * 0.8, thick * 0.8, dir + Math.random() * 30)
// 右
drawBranch(p1, length * 0.8, thick * 0.8, dir - Math.random() * 30)
```

还需要一个跳出的判断，不然会陷入死循环中，可以根据最小的长度或者树干粗细判断

```javascript
if (thick < 10 && Math.random() < 0.2) {
  return
}

if (thick < 2) {
  return
}
```

至此一个简单的随机树 方法就已完成

