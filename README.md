```

】】UE4.27

】】GayHub链接：https://github.com/shudal/UESoccerGameDemo
】】b站演示视频：https://www.bilibili.com/video/BV1kr4y1M79g/

】】在start云游戏里偶然玩到fifa，就想着复现一下。目前的demo也大概实现了自己想复现的东西，游戏主角的球都像fifa那样写实，不会突然改变球的位置，不会突然让人和球立即转向另外一个方向。

】】游戏角色也使用了卡通渲染。包含描边+色素块+头发高光三个方面。都是使用的hlsl实现的，是写在custome节点里的。描边和色素块是在后期处理中进行卷积实现的。头发高光不太正常，因为想完全正常的话需要把头发的uv展的横平竖直，就懒得展了。

```