import 'dart:convert';

class Comment {
  final String? id;
  final String? creatorId;
  final String? creatorUsername;
  final String? creatorFullname;
  final String momentId;
  final String content;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;

  Comment({
    this.id,
    this.creatorId,
    this.creatorUsername,
    this.creatorFullname,
    required this.momentId,
    required this.content,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  Comment copyWith({
    String? id,
    String? creatorId,
    String? creatorUsername,
    String? creatorFullname,
    String? momentId,
    String? content,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) {
    return Comment(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      creatorFullname: creatorFullname ?? this.creatorFullname,
      momentId: momentId ?? this.momentId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      creatorId: map['creatorId'],
      creatorUsername: map['creatorUsername'],
      creatorFullname: map['creatorFullname'],
      momentId: map['momentId'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      lastUpdatedAt: DateTime.parse(map['lastUpdatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorId': creatorId,
      'creatorUsername': creatorUsername,
      'creatorFullname': creatorFullname,
      'momentId': momentId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toDto() {
    return {
      'momentId': momentId,
      'content': content,
    };
  }
}
