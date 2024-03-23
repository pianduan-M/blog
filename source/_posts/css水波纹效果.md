---
title: css水波纹效果
date: 2024-03-23 12:19:12
tags:
  - css
  - 动态效果
---

[前往 codepen 查看](https://codepen.io/pan-chen/pen/KKYmQXR)

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

    .box {
      width: 100px;
      height: 100px;
      border: 5px solid #333;
      margin: 80px auto;
      overflow: hidden;
      border-radius: 5px;
    }

    .ripple {
      width: 100%;
      height: 100%;
      position: relative;
      transform: translateY(var(--number, 0));
    }

    .ripple::after {
      content: '';
      position: absolute;
      top: 100%;
      left: 50%;
      width: 200%;
      height: 200%;
      background-color: rgb(0, 255, 255);
      border-radius: 80px 80px 105px 95px;
      transform: translateX(-50%) rotate(0deg);
      animation: spin 5s linear infinite;
    }
    .ripple::before {
      content: '';
      position: absolute;
      top: 95%;
      left: 55%;
      width: 200%;
      height: 200%;
      background-color: rgb(174, 247, 247);
      border-radius: 90px 80px 105px 95px;
      transform: translateX(-50%) rotate(0deg);
      animation: spin 5s 1s linear infinite;
    }

    .range {
      display: block;
      margin: 0 auto;
    }


    @keyframes spin {
      100% {
        transform: translateX(-50%) rotate(360deg);
      }
    }
  </style>
</head>

<body>
  <div class="box">
    <div class="ripple"></div>
  </div>
  <input class="range" type="range" value="0">

  <script>
    const boxEl = document.querySelector(".box")
    const inputEl = document.querySelector(".range")

    inputEl.addEventListener('input', e => {
      const value = e.target.value
      boxEl.style.setProperty("--number", `-${value}%`)
    })
  </script>
</body>
</html>
```

