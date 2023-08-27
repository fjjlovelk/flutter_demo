import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum PullRefreshStatus { retry, loading, refresh }

class PullRefreshInstanceModel {
  final Function fetchPage;
  final Function onLoading;
  final Function onRefresh;

  PullRefreshInstanceModel({
    required this.fetchPage,
    required this.onLoading,
    required this.onRefresh,
  });
}

class PullRefresh<M> extends StatefulWidget {
  final bool initialRefresh;
  final int initialPage;
  final int pageSize;
  final String pageName;
  final String pageSizeName;
  final Map<String, dynamic> Function()? otherFetchParams;
  final void Function(PullRefreshInstanceModel)? getPullRefreshInstanceModel;
  final Future<List<M>> Function(Map<String, dynamic>) fetchFunction;
  final Widget Function(BuildContext context, M item, int index) itemBuilder;

  const PullRefresh({
    Key? key,
    this.initialRefresh = true,
    this.initialPage = 1,
    this.pageSize = 20,
    this.pageName = 'page',
    this.pageSizeName = 'pageSize',
    this.otherFetchParams,
    this.getPullRefreshInstanceModel,
    required this.fetchFunction,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  State<PullRefresh> createState() => _PullRefreshState<M>();
}

class _PullRefreshState<M> extends State<PullRefresh<M>> {
  late int _page;

  List<M> _items = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    _page = widget.initialPage;
    if (widget.getPullRefreshInstanceModel != null) {
      widget.getPullRefreshInstanceModel!(
        PullRefreshInstanceModel(
          fetchPage: _fetchPage,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
        ),
      );
    }
    super.initState();
  }

  Future<void> _fetchPage(PullRefreshStatus pullRefreshStatus) async {
    try {
      final otherFetchParams =
          widget.otherFetchParams != null ? widget.otherFetchParams!() : {};
      final newItems = await widget.fetchFunction({
        widget.pageSizeName: widget.pageSize,
        widget.pageName: _page,
        ...otherFetchParams
      });
      if (newItems.length < widget.pageSize) {
        _refreshController.loadNoData();
      } else {
        if (pullRefreshStatus == PullRefreshStatus.refresh) {
          _items = newItems;
          _refreshController.refreshCompleted();
        } else {
          _refreshController.loadComplete();
          _items.addAll(newItems);
        }
        setState(() {});
      }
    } catch (error) {
      if (pullRefreshStatus == PullRefreshStatus.refresh) {
        _items = [];
        _refreshController.refreshFailed();
        setState(() {});
      } else {
        _refreshController.loadFailed();
      }
      print('error-------${error.toString()}');
      rethrow;
    }
  }

  void _onRefresh() {
    _page = widget.initialPage;
    _fetchPage(PullRefreshStatus.refresh);
  }

  void _onLoading() async {
    _page += 1;
    _fetchPage(PullRefreshStatus.loading);
  }

  Widget _buildFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        switch (mode) {
          case LoadStatus.idle:
            body = const Text("上拉加载");
            break;
          case LoadStatus.loading:
            body = const CupertinoActivityIndicator();
            break;
          case LoadStatus.failed:
            body = PageErrorIndicator(
              onTryAgain: () => _fetchPage(PullRefreshStatus.retry),
            );
            break;
          case LoadStatus.canLoading:
            body = const Text("松手，加载更多!");
            break;
          default:
            body = const Text("没有更多了~");
            break;
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const ClassicHeader(
        idleText: '下拉刷新',
        releaseText: '松开刷新',
        refreshingText: '刷新中',
        completeText: '刷新完成',
        failedText: '刷新失败',
        refreshingIcon: CupertinoActivityIndicator(),
      ),
      footer: _buildFooter(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: !_refreshController.isLoading &&
              !_refreshController.isRefresh &&
              _items.isEmpty
          ? const NoItemsFoundIndicator()
          : ListView.builder(
              itemBuilder: (c, i) => widget.itemBuilder(c, _items[i], i),
              itemCount: _items.length,
            ),
    );
  }
}

// 加载出错
class PageErrorIndicator extends StatelessWidget {
  final VoidCallback onTryAgain;
  const PageErrorIndicator({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("加载出错，"),
        TextButton(
          onPressed: onTryAgain,
          child: const Text("重新加载"),
        ),
      ],
    );
  }
}

// 空白
class NoItemsFoundIndicator extends StatelessWidget {
  const NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("没有更多了~"),
    );
  }
}
