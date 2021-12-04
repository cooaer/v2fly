class User {
  final String name;
  final String avatar;
  final int index;
  final DateTime? addTime;
  final List<Social> socials;

  User(this.name, this.avatar, {this.index = 0, this.addTime, this.socials = const []});

  @override
  String toString() {
    return 'User{name: $name, avatar: $avatar, index: $index, addTime: $addTime, socials: $socials}';
  }
}

class Social {
  final String icon;
  final String url;

  Social(this.icon, this.url);

  @override
  String toString() {
    return 'Social{icon: $icon, url: $url}';
  }
}