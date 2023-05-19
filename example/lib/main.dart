import 'package:flutter/material.dart';
import 'package:tim_ui_kit_sticker_plugin/tim_ui_kit_sticker_plugin.dart';

import 'utils/emoji.dart';
import 'utils/sticker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUIKit Sticker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TUIKit Sticker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<CustomStickerPackage> _customStickerPackageList;

  @override
  initState() {
    super.initState();
    setCustomSticker();
  }

  setCustomSticker() async {
    // 添加自定义表情包
    List<CustomStickerPackage> customStickerPackageList = [];
    // 添加文字表情包 （emoji）
    final defEmojiList = emojiData.asMap().keys.map((emojiIndex) {
      final emo = Emoji.fromJson(emojiData[emojiIndex]);
      return CustomSticker(
          index: emojiIndex, name: emo.name, unicode: emo.unicode);
    }).toList();

    customStickerPackageList.add(CustomStickerPackage(
        name: "defaultEmoji",
        stickerList: defEmojiList,
        menuItem: defEmojiList[0]));

    // 添加图片表情包 （sticker）
    customStickerPackageList.addAll(emojiList.map((customEmojiPackage) {
      return CustomStickerPackage(
          name: customEmojiPackage.name,
          baseUrl: "https://imgcache.qq.com/operation/dianshi/other",
          stickerList: customEmojiPackage.list
              .asMap()
              .keys
              .map((idx) =>
                  CustomSticker(index: idx, name: customEmojiPackage.list[idx]))
              .toList(),
          menuItem: CustomSticker(
            index: 0,
            name: customEmojiPackage.icon,
          ));
    }).toList());
    _customStickerPackageList = customStickerPackageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StickerPanel(
                addText: (int unicode) {
                  // 添加文字表情
                },
                deleteText: () {
                  // 删除表情文字
                },
                sendFaceMsg: (int stickerIndex, String stickerName) {
                  // 发送表情信息
                },
                sendTextMsg: () {
                  // 发送文字信息
                },
                // 长按表情栏里的表情回调
                onLongTap: (BuildContext context, LayerLink layerLink,
                    int selectedPackageIdx, CustomSticker selectedSticker) {
                  // Do overlay here
                },
                // 空数据列表的PlaceHolder
                emptyPlaceHolder: Container(),
                // 表情包数据列表
                customStickerPackageList: _customStickerPackageList)
          ],
        ),
      ),
    );
  }
}
