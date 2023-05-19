class CustomStickerPackage {
  CustomStickerPackage({
    required this.name,
    this.baseUrl,
    this.isEmoji = false,
    this.isDefaultEmoji = false,
    required this.stickerList,
    required this.menuItem,
  });

  final String name;
  final String? baseUrl;
  final List<CustomSticker> stickerList;
  final CustomSticker menuItem;
  bool? isEmoji;
  bool isDefaultEmoji;

  bool get isCustomSticker => menuItem.unicode == null;
  bool get isCustomEmojiSticker => isEmoji == true;
  bool get isDefaultEmojiSticker => isDefaultEmoji == true;
}

class CustomSticker {
  const CustomSticker(
      {required this.name, required this.index, this.url, this.unicode});

  final int? unicode;
  final String name;
  final int index;
  final String? url;
}

class StickerListUtil {
  StickerListUtil(this.customStickerList);
  final List<Map<String, dynamic>> customStickerList;

  StickerListUtil._(this.customStickerList);

  static StickerListUtil? _instance;
  StickerListUtil get instance =>
      _instance ??= StickerListUtil._(customStickerList);
}
