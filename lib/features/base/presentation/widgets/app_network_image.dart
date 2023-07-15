import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppNetworkImage extends StatefulWidget {
  final String? url;
  final String? extention;
  ImageProvider? image;

  AppNetworkImage({super.key, this.url, this.extention});

  @override
  State<AppNetworkImage> createState() => _AppNetworkImageState();
}

class _AppNetworkImageState extends State<AppNetworkImage> {
  Image? img;

  @override
  void initState() {
    img = Image.network(
      widget.url ?? '',
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SpinKitWaveSpinner(
          color: Theme.of(context).colorScheme.inversePrimary,
          waveColor: Theme.of(context).colorScheme.inversePrimary,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // print(error);
        if (widget.extention == '.mp4') {
          return Stack(
            children: [
              Positioned.fill(
                child: Assets.images.loginBg.image(
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.7)),
              ),
              Center(
                child: Container(
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Theme.of(context).colorScheme.inverseSurface,
                    size: 10.w,
                  ),
                ),
              ),
            ],
          );
        }
        return Assets.images.loginBg.image(fit: BoxFit.cover);
      },
      opacity: const AlwaysStoppedAnimation(0.85),
    );
    if (img != null) {
      widget.image = img!.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return img ?? Container();
  }
}
