import 'package:mangayomi/main.dart';
import 'package:mangayomi/models/settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cookie_providers.g.dart';

@riverpod
class CookieState extends _$CookieState {
  @override
  String build(String source) {
    final cookieList = isar.settings
        .getSync(227)!
        .cookiesList!
        .where((element) => element.source == source);
    String cookie = "";
    if (cookieList.isNotEmpty) {
      cookie = cookieList.first.cookie!;
    }
    return cookie;
  }

  void setCookie(String newCookie) {
    final settings = isar.settings.getSync(227);
    List<Cookie>? cookieList = [];
    for (var cookie in settings!.cookiesList!) {
      if (cookie.source != source) {
        cookieList.add(cookie);
      }
    }
    cookieList.add(Cookie()
      ..source = source
      ..cookie = newCookie);
    isar.writeTxnSync(
        () => isar.settings.putSync(settings..cookiesList = cookieList));
  }
}
