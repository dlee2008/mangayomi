import 'package:mangayomi/models/manga.dart';
import 'package:mangayomi/modules/more/settings/browse/providers/browse_state_provider.dart';
import 'package:mangayomi/services/fetch_sources_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'fetch_novel_sources.g.dart';

@Riverpod(keepAlive: true)
Future fetchNovelSourcesList(Ref ref, {int? id, required reFresh}) async {
  if (ref.watch(checkForExtensionsUpdateStateProvider) || reFresh) {
    await fetchSourcesList(
        sourcesIndexUrl:
            "https://kodjodevf.github.io/mangayomi-extensions/novel_index.json",
        refresh: reFresh,
        id: id,
        ref: ref,
        itemType: ItemType.novel);
  }
}
