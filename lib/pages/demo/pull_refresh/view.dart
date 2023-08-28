import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/api/user_api.dart';
import 'package:flutter_demo/common/models/events_model.dart';
import 'package:flutter_demo/common/widgets/custom_paging.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PullRefreshPage extends GetView<PullRefreshController> {
  PullRefreshPage({Key? key}) : super(key: key);

  final GlobalKey<CustomPagingState> _globalKey = GlobalKey();
  final otherFetchParams = {
    "id": 1,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PullRefresh"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          otherFetchParams["id"] = (otherFetchParams["id"] ?? 0) + 1;
          _globalKey.currentState?.callRefresh();
        },
        child: const Icon(Icons.refresh),
      ),
      body: CustomPaging<List<EventsModel>, EventsModel>(
        key: _globalKey,
        fetchFunction: UserApi.events,
        pageSizeName: 'per_page',
        otherFetchParams: () => otherFetchParams,
        itemBuilder: (BuildContext context, int index, EventsModel item) {
          return ListTile(
            title: Text(item.username),
            subtitle: Text(item.id),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(item.avatarUrl),
            ),
          );
        },
      ),
    );
  }
}
