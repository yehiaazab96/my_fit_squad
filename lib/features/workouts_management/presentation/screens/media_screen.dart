import 'package:flutter/material.dart';
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
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // if (widget.isVideo ?? false) {
    //   print(widget.url);
    //   _controller = VideoPlayerController.network(
    //       'https://my-fit-squad.onrender.com/api/image/${widget.url ?? ''}')
    //     ..initialize().then((_) {
    //       setState(() {});
    //     }, onError: (error) {
    //       print(error);
    //     });
    //   _controller.play();
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.url ?? '');
    print(widget.isVideo);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          // height: 50.h,
          child: Hero(
              tag: widget.url ?? '',
              child: widget.isVideo!
                  ? ChunkedVideoPlayer(videoUrl: widget.url ?? '')

                  // _controller.value.isInitialized
                  //     ? AspectRatio(
                  //         aspectRatio: _controller.value.aspectRatio,
                  //         child: VideoPlayer(_controller),
                  //       )
                  //     : SpinKitWaveSpinner(
                  //         color: Theme.of(context).colorScheme.inversePrimary,
                  //         waveColor:
                  //             Theme.of(context).colorScheme.inversePrimary,
                  //       )

                  : AppNetworkImage(
                      url: widget.url ?? '',
                    )),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}

class ChunkedVideoPlayer extends StatefulWidget {
  final String videoUrl;

  ChunkedVideoPlayer({required this.videoUrl});

  @override
  _ChunkedVideoPlayerState createState() => _ChunkedVideoPlayerState();
}

class _ChunkedVideoPlayerState extends State<ChunkedVideoPlayer> {
  late VideoPlayerController _controller;
  final int chunkDuration = 2; // Duration in seconds for each chunk
  double currentChunkEnd = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        final currentPosition = _controller.value.position.inSeconds.toDouble();
        final nextChunkEnd = (currentChunkEnd + chunkDuration).toDouble();

        if (currentPosition >= nextChunkEnd) {
          final nextChunkStart = nextChunkEnd;
          currentChunkEnd = nextChunkEnd;
          _controller.seekTo(Duration(seconds: nextChunkStart.toInt()));
        }
      })
      ..initialize().then((_) {
        print('yarab ne5las');
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        VideoControls(controller: _controller),
      ],
    );
  }
}

class VideoControls extends StatelessWidget {
  final VideoPlayerController controller;

  VideoControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            icon: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
              child: VideoProgressIndicator(controller, allowScrubbing: true)),
        ],
      ),
    );
  }
}
