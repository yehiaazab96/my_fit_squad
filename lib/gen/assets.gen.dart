/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Athelete.jpeg
  AssetGenImage get athelete =>
      const AssetGenImage('assets/images/Athelete.jpeg');

  /// File path: assets/images/Fat Loss.jpeg
  AssetGenImage get fatLoss =>
      const AssetGenImage('assets/images/Fat Loss.jpeg');

  /// File path: assets/images/Muscle Gain.jpeg
  AssetGenImage get muscleGain =>
      const AssetGenImage('assets/images/Muscle Gain.jpeg');

  /// File path: assets/images/Rehabilitation.jpeg
  AssetGenImage get rehabilitation =>
      const AssetGenImage('assets/images/Rehabilitation.jpeg');

  /// File path: assets/images/avatar.png
  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.png');

  /// File path: assets/images/check.png
  AssetGenImage get check => const AssetGenImage('assets/images/check.png');

  /// File path: assets/images/chest.png
  AssetGenImage get chest => const AssetGenImage('assets/images/chest.png');

  /// File path: assets/images/gearloading.png
  AssetGenImage get gearloading =>
      const AssetGenImage('assets/images/gearloading.png');

  /// File path: assets/images/login_bg.jpg
  AssetGenImage get loginBg =>
      const AssetGenImage('assets/images/login_bg.jpg');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// File path: assets/images/side.png
  AssetGenImage get side => const AssetGenImage('assets/images/side.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        athelete,
        fatLoss,
        muscleGain,
        rehabilitation,
        avatar,
        check,
        chest,
        gearloading,
        loginBg,
        logo,
        placeholder,
        side
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
