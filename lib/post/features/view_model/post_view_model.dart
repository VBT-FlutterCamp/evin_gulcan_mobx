import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import '../../core/constant/enum.dart';
import '../../core/network/app_constant.dart';
import '../model/post_model.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase with Store {
  @observable
  List<Post> posts = [];
  @observable
  PageState pageState = PageState.NORMAL;

  @observable
  bool isServiseReuquestLoading = false;

  @action
  Future<void> getAllPost() async {
    changeRequest();
    final response = await Dio().get(AppConstant.instance.baseUrl);

    if (response.statusCode == 200) {
      final responseData = response.data as List;
      posts = responseData.map((e) => Post.fromJson(e)).toList();
    }
    changeRequest();
  }

  @action
  Future<void> getAllPost2() async {
    pageState = PageState.LOADING;
    try {
      final response = await Dio().get(AppConstant.instance.baseUrl);
      if (response.statusCode == 200) {
        final responseData = response.data as List;
        posts = responseData.map((e) => Post.fromJson(e)).toList();
        pageState = PageState.SUCCESS;
      }
    } catch (e) {
      pageState = PageState.ERROR;
    }
  }

  @action
  void changeRequest() {
    isServiseReuquestLoading = !isServiseReuquestLoading;
  }
}
