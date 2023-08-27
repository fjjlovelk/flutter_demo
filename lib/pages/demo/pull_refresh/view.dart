import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/api/user_api.dart';
import 'package:flutter_demo/common/models/events_model.dart';
import 'package:flutter_demo/common/widgets/pull_refresh.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PullRefreshPage extends GetView<PullRefreshController> {
  const PullRefreshPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PullRefresh"),
      ),
      body: PullRefresh<EventsModel>(
        fetchFunction: UserApi.events,
        pageSizeName: 'per_page',
        itemBuilder: (BuildContext context, EventsModel item, int index) {
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
