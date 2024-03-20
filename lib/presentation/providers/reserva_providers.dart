import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reserva_providers.g.dart';

@Riverpod(keepAlive: true)
class RevervasList extends _$RevervasList {
  // final _prefs = SharedPreferencesData();

  @override
  List<dynamic> build() => [];

  getList() {
    // GET THE FAVORITE LIST OF LOCAL STORAGE
    // final _prefs = SharedPreferencesData();
    // String favorites = _prefs.favoriteList;
    // if (_prefs.favoriteList != '') {
    //   final jsonList = jsonDecode(favorites);
    //   final list = jsonDecode(jsonList);
    //   List newsList = list.map((json) => NewsPost.fromMap(json)).toList();
    //   return (newsList);
    // } else {
    //   return [];
    // }
  }
}
