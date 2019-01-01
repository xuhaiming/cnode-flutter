class Author {
  final String loginname;
  final String avatarUrl;

  Author({
    this.loginname,
    this.avatarUrl,
  });

  factory Author.fromData(Map<String, dynamic> data) {
    if (data == null) { return Author(); }

    return Author(
      loginname: data['loginname'],
      avatarUrl: data['avatar_url'],
    );
  }
}

class Topic {
  final String id;
  final int replyCount;
  final String title;
  final String content;
  final String createAt;
  final Author author;

  Topic({
    this.id,
    this.replyCount,
    this.title,
    this.content,
    this.author,
    this.createAt,
  });

  factory Topic.fromData(Map<String, dynamic> data) {
    return Topic(
      id: data['id'],
      replyCount: data['reply_count'],
      title: data['title'],
      content: data['content'],
      createAt: data['create_at'],
      author: Author.fromData(data['author']),
    );
  }
}
