class AppConstant {
  static AppConstant? _instace;
  static AppConstant get instance {
    if (_instace != null) return _instace!;
    _instace = AppConstant._init();
    return _instace!;
  }

  AppConstant._init();

  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
}
