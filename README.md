
<br>

<p align="center">
  <a href="https://www.tencentcloud.com/products/im">
    <img src="https://qcloudimg.tencent-cloud.cn/raw/fd589e1dc7dc3752f320a3b0251189f0.png" width="288px" alt="Tencent Chat Logo" />
  </a>
</p>

<h1 align="center">腾讯云IM 表情包插件</h1>

<p align="center">
  快速接入腾讯云IM表情消息能力，支持Emoji Unicode及图片形式动态表情。提供表情选择面板，一键发送。
</p>


![](https://qcloudimg.tencent-cloud.cn/raw/16b922d1c14799f497e01d38a34441e1.jpg)

# TUIKit Sticker Plugin  自定义表情包插件介绍

## 0. 安装

在项目的 pubspec.yaml 文件中的 dependencies 下添加 tim_ui_kit_sticker_plugin 的依赖。或者执行以下命令：



```shell
// Step 1
flutter pub add tim_ui_kit_sticker_plugin

// Step 2
flutter pub get
```

## 1. 介绍

TUIKit Sticker Plugin 是提供定义自定义表情包数据，生成表情包Panel UI的 TUIKit plugin. (TUIKit Sticker Plugin 不依赖 TUIKit)

业务代码、TUIKit、TUIKit Sticker Plugin 三方关系如下图：

![img1](https://imgcache.qq.com/operation/dianshi/other/t1.35083e5e261af262010aa72c6808b1b37134ad7f.png)



表情包分为两类：

1. 字符类表情包，通过unicode定义，通过sendTextMsg方法发送消息，可与字符同时存在在输入栏，当作Text消息。
2. 图片类表情包，通过图片地址定义，通过sendFaceMsg方法发送消息，不能与字符同时存在在输入栏，当作Face消息。（支持动态图片 gif,webp,apng等格式）



流程：

1. TUIKit 通过 TIMUIKitChat 组件里的 *customStickerPanel* 将 *sendTextMessage* (发送文字信息), *sendFaceMessage* (发送表情信息), *deleteText* (删除最后一个文字/表情), *addText* (添加文字/表情) 方法暴露出来。
2. 业务侧通过 TUIKit Sticker Plugin 的 *CustomStickerPackage* 生成表情包所需的数据。
3. 业务侧通过 TUIKit Sticker Plugin 的 *StickerPanel* 生成表情包panel 组件
4. 将组件回传至TUIKit 生成 表情包panel

![img2](https://imgcache.qq.com/operation/dianshi/other/t2.ae865d087b173a0e493dba3ffa7f6cdbe2ae6bfa.png)



注意事项：

1. TUIKit 若未接受到 *customStickerPanel* 则展示默认表情包panel。
2. 业务侧可不通过TUIKit Sticker Plugin 定义表情包数据，可自行定义。
3. 业务侧可不用TUIKit Sticker Plugin 的 *StickerPanel* 生成表情包panel 组件，可自定义。
4. 表情包图片支持开发者本地地址或线上地址（通过http或https请求能访问的地址）。



## 2. TUIKit Sticker Plugin 定义表情包数据



调用 **CustomSticker** 类来生成单个表情包。

```dart
class CustomSticker {
  final int? unicode; // unicode int值 选填
  final String name; // 表情包名称
  final int index; // 表情包序号
  final String? url; // 表情包地址 选填
}
```

调用 **CustomStickerPackage** 类来初始化表情包Package

```dart
class CustomStickerPackage { // 一个系列的表情包定义为一个package
  final String name; // 表情包package name
  final String? baseUrl; // 表情包package baseUrl 选填
  final List<CustomSticker> stickerList; // 表情包列表
  final CustomSticker menuItem; // 切换表情包的按钮的图标

  bool get isCustomSticker => menuItem.unicode == null; // *** 注意，如果menuItem的unicode传值int，则认为当前表情包package为字符类表情包
}
```



## 3. TUIKit Sticker Plugin 生成表情包Panel UI

```dart
class StickerPanel extends StatefulWidget {
  final void Function() sendTextMsg; // TUIKit回传的方法，发送文本消息
  final void Function(int index, String data) sendFaceMsg; // TUIKit回传的方法，发送表情消息
  final void Function(int unicode) addText; // TUIKit回传的方法，添加文本给输入框
  final void Function() deleteText; // TUIKit回传的方法，删除最后一个输入框文本
  final List<CustomStickerPackage> customStickerPackageList; // 自定义表情包package列表
  final Widget? emptyPlaceHolder; // 空数据列表的PlaceHolder，选填
  final void Function(
      BuildContext context, LayerLink layerLink, int selectedIdx)? onLongTap; // 长按表情栏里的表情回调，选填 （可用来做浮层等）
  final Color? backgroundColor; // 背景颜色，选填
  final Color? lightPrimaryColor; // 轻主色调，选填
}
```

## 联系我们[](id:contact)
如果您在接入使用过程中有任何疑问，请加入 QQ 群：788910197 咨询。

![](https://qcloudimg.tencent-cloud.cn/raw/eacb194c77a76b5361b2ae983ae63260.png)
