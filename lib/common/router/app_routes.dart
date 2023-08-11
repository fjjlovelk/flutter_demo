enum AppRoutes {
  home('/home', '首页', '首页'),
  login('/login', '登录页', '登录页'),
  gridPatrol('/grid-patrol', '巡视打卡', '巡视打卡');

  const AppRoutes(this.path, this.title, this.desc);

  final String path;
  final String title;
  final String desc;
}
