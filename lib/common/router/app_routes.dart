class AppRoutes {
  /// 包含BottomNavigationBar的主页面，即登录后跳转的主页
  static const String tabs = '/tabs';

  /// 首页，在tabs中，一般不会当作路由跳转
  static const String home = '/home';

  /// 我的，在tabs中，一般不会当作路由跳转
  static const String mine = '/mine';

  /// 登录页
  static const String login = '/login';

  /// 上拉刷新，下拉加载
  static const String pullRefresh = '/pullRefresh';
}
