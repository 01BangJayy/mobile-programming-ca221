import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';

import 'commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  static const routeName = '/comments';
  const CommentPage({Key? key, required this.momentId}) : super(key: key);
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late List<Comment> _comments;
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _comments = List.generate(
      5,
      (index) => Comment(
        id: nanoid(),
        creatorId: nanoid(),
        creatorUsername: _faker.person.name(),
        creatorFullname: _faker.person.name(),
        momentId: widget.momentId,
        content: _faker.lorem.sentence(),
        createdAt: DateTime.now(),
        lastUpdatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          final comment = _comments[index];
          return ListTile(
            title: Text(comment.creatorUsername ?? 'Anonymous'),
            subtitle: Text(comment.content),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
            ),
            trailing: Text(_dateFormat.format(comment.createdAt)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newComment = await Navigator.of(context).pushNamed(CommentEntryPage.routeName);
          if (newComment != null && newComment is Comment) {
            setState(() {
              _comments.add(newComment);
            });
          }
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
