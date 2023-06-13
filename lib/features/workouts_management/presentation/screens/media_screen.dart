import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:video_player/video_player.dart';

class MediaScreen extends StatefulWidget {
  final String? title;
  final String? url;
  final bool? isVideo;
  const MediaScreen({super.key, this.url, this.title, this.isVideo = false});

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo!) {
      print(widget.url);
      _controller = VideoPlayerController.network(widget.url ?? '')
        ..initialize().then((_) {
          setState(() {});
        }, onError: (error) {
          print(error);
        });
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Hero(
            tag: widget.url ?? '',
            child: widget.isVideo!
                ? _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : SpinKitWaveSpinner(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        waveColor: Theme.of(context).colorScheme.inversePrimary,
                      )
                : AppNetworkImage(
                    url: widget.url ?? '',
                  )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
