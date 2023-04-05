import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mangayomi/utils/media_query.dart';

class ImageViewVertical extends ConsumerStatefulWidget {
  final int length;

  final String url;
  final int index;
  final String titleManga;
  final String source;
  final String chapter;
  final Directory path;

  const ImageViewVertical(
      {super.key,
      required this.url,
      required this.chapter,
      required this.index,
      required this.path,
      required this.titleManga,
      required this.source,
      required this.length});

  @override
  ConsumerState createState() => _ImageViewVerticalState();
}

class _ImageViewVerticalState extends ConsumerState<ImageViewVertical>
    with AutomaticKeepAliveClientMixin<ImageViewVertical> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.index == 0)
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
          ExtendedImage.network(widget.url,
              headers: const {
                "Referer": "https://www.mangahere.cc/",
                "Cookie": "isAdult=1"
              },
              handleLoadingProgress: true,
              fit: BoxFit.contain,
              cacheMaxAge: const Duration(days: 7),
              clearMemoryCacheWhenDispose: true,
              enableMemoryCache: false,
              loadStateChanged: (ExtendedImageState state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              final ImageChunkEvent? loadingProgress = state.loadingProgress;
              final double? progress =
                  loadingProgress?.expectedTotalBytes != null
                      ? loadingProgress!.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null;
              return SizedBox(
                height: mediaHeight(context, 0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    value: progress,
                  ),
                ),
              );
            }
            if (state.extendedImageLoadState == LoadState.failed) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      state.reLoadImage();
                    },
                    child: const Icon(
                      Icons.replay_outlined,
                      size: 30,
                    )),
              );
            }
            return null;
          }),
          if (widget.index + 1 == widget.length)
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.chapter} finished',
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  FontAwesomeIcons.circleCheck,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}