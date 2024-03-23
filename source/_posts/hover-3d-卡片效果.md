---
title: hover 3d 卡片效果
date: 2024-03-23 13:43:40
tags:
  - css
  - 3d
  - 特效
---

[前往 codepen 查看](https://codepen.io/pan-chen/pen/WNWjMLy)

根据 3d 空间中 x 轴和 y 轴和平面的 x y 视觉上正好相反。

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <style>
    * {
      padding: 0;
      margin: 0;
    }

    .card {
      width: 200px;
      margin: 50px auto;
      border-radius: 10px;
      overflow: hidden;
      transform: perspective(500px) rotateX(var(--rx, 0deg)) rotateY(var(--ry, 0deg));
      transition: transform 0.3s ease-out;
    }

    .card:hover {
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .card img {
      width: 100%;
      vertical-align: middle;
      border-radius: inherit;
    }
  </style>
</head>

<body>
  <div class="card">
    <img src="https://gd-hbimg.huaban.com/f503f2e95b45cc5c49c0d2a21f31c3d9f6e03e516efec-g7nrii_fw1200" alt="">
  </div>

  <script>
    const boxEl = document.querySelector(".card")

    const cardWidth = boxEl.offsetWidth
    const cardHeight = boxEl.offsetHeight

    const yRange = [-10, 10]
    const xRange = [-10, 10]

    boxEl.addEventListener("mousemove", (e) => {
      clearMouseleave()
      const { offsetX, offsetY } = e
      const ry = getRotateDeg(yRange, offsetX, cardWidth)
      const rx = -getRotateDeg(xRange, offsetY, cardHeight)
      boxEl.style.setProperty("--rx", rx + 'deg')
      boxEl.style.setProperty("--ry", ry + 'deg')
    })


    boxEl.addEventListener("mouseleave", onmouseleave)

    let time
    function onmouseleave() {
      time = setTimeout(() => {
        boxEl.style.setProperty("--rx", 0 + 'deg')
        boxEl.style.setProperty("--ry", 0 + 'deg')
      }, 300)
    }

    function clearMouseleave() {
      time && clearTimeout(time)
    }


    function getRotateDeg(range, value, length) {
      return (value / length) * (range[1] - range[0]) + range[0]
    }


  </script>


</body>

</html>
```

