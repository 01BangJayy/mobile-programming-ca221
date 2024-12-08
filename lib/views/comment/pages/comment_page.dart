import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/comment.dart';
import 'package:faker/faker.dart' as faker;
import 'package:nanoid2/nanoid2.dart';
import 'package:myapp/views/comment/pages/commment_entry_page.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.momentId});
  final String momentId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];
  final _faker = faker.Faker();
  final _dateFormat = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _comments = List.generate(
      5,
      (index) => Comment(
        id: nanoid(),
        creator: _faker.person.name(),
        content: _faker.lorem.sentence(),
        createdAt: _faker.date.dateTime(),
        momentId: widget.momentId,
      ),
    );
  }

  // Fungsi untuk menyimpan atau memperbarui komentar
  void _saveComment(Comment newComment) {
    final existingComment = _comments.firstWhere(
      (comment) => comment.id == newComment.id,
      orElse: () => Comment(id: newComment.id, creator: '', content: '', createdAt: DateTime.now(), momentId: ''),
    );
    
    if (_comments.contains(existingComment)) {
      setState(() {
        _comments[_comments.indexOf(existingComment)] = newComment;
      });
    } else {
      setState(() {
        _comments.add(newComment);
      });
    }
  }

  // Fungsi untuk menghapus komentar
  void _deleteComment(String commentId) {
    final selectedComment = _comments.firstWhere((comment) => comment.id == commentId);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                setState(() {
                  _comments.remove(selectedComment);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk navigasi ke halaman Edit
  void _editComment(String commentId) {
    final selectedComment = _comments.firstWhere((comment) => comment.id == commentId);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CommentEntryPage(
        onSaved: _saveComment,
        selectedComment: selectedComment,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _comments.map((comment) {
            return ListTile(
              title: Text(comment.creator),
              subtitle: Text(comment.content),
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
              ),
              trailing: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(_dateFormat.format(comment.createdAt)),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'Edit') {
                        _editComment(comment.id);
                      } else if (value == 'Delete') {
                        _deleteComment(comment.id);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CommentEntryPage(
              onSaved: _saveComment,
            );
          }));
        },
        child: const Icon(Icons.comment),
      ),
    );
  }
}
