import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_example/post/core/constant/enum.dart';
import '../../core/app_text_constant.dart';

import '../view_model/post_view_model.dart';

class PostView extends StatelessWidget {
  PostView({Key? key}) : super(key: key);

  final _viewModel = PostViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _viewModel.getAllPost();
        },
      ),
      body: _buildListViewPosts(),
    );
  }

  Center buildCenterLikeCubic() {
    return Center(child: Observer(builder: (_) {
      switch (_viewModel.pageState) {
        case PageState.LOADING:
          return const CircularProgressIndicator();
        case PageState.SUCCESS:
          return _buildListViewPosts();
        case PageState.ERROR:
          return const Center(
            child: Text('Error'),
          );
        default:
          return const FlutterLogo();
      }
    }));
  }

  Widget _buildListViewPosts() {
    return Observer(builder: (_) {
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _viewModel.posts.length,
        itemBuilder: (context, index) => _buildListTileCard(index),
      );
    });
  }

  Card _buildListTileCard(int index) {
    double _elevationCard = 10;
    return Card(
      elevation: _elevationCard,
      child: ListTile(
        leading: Text(_viewModel.posts[index].userId.toString()),
        title: Text(_viewModel.posts[index].title.toString()),
        subtitle: Text(_viewModel.posts[index].body.toString()),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppString().titleAppBarText),
      leading: Observer(builder: (_) {
        return Visibility(
          visible: _viewModel.isServiseReuquestLoading,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        );
      }),
    );
  }
}
