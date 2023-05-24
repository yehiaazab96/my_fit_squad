import 'package:flutter/widgets.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final EdgeInsetsDirectional margin;

  const AppLogo(
      {Key? key,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.margin = EdgeInsetsDirectional.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child:
            Assets.images.logo.image(fit: fit, width: width, height: height));
  }
}
