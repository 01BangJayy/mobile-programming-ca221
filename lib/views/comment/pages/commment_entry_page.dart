import 'package:flutter/material.dart';
import 'package:myapp/core/resources/dimentions.dart';
import '../../../models/comment.dart';
import '../../../core/resources/colors.dart';
import 'package:nanoid2/nanoid2.dart'; // Import nanoid2

class CommentEntryPage extends StatefulWidget {
  const CommentEntryPage({super.key, required this.onSaved, this.selectedComment});

  final Function(Comment newComment) onSaved;
  final Comment? selectedComment;

  @override
  State<CommentEntryPage> createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends State<CommentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _dataComment = {};

  // Jika ada komentar yang dipilih, pre-fill form
  @override
  void initState() {
    super.initState();
    if (widget.selectedComment != null) {
      _dataComment['creator'] = widget.selectedComment!.creator;
      _dataComment['content'] = widget.selectedComment!.content;
    }
  }

  // Membuat method untuk menyimpan data komentar
  void _saveComment() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataComment
      _formKey.currentState!.save();
      final newComment = Comment(
        id: widget.selectedComment?.id ?? nanoid(), // Pastikan nanoid sudah diimpor
        creator: _dataComment['creator'],
        content: _dataComment['content'],
        createdAt: DateTime.now(), // Menetapkan waktu pembuatan komentar saat ini
        momentId: '', // Sesuaikan dengan ID moment yang relevan
      );
      
      widget.onSaved(newComment); // Panggil fungsi onSaved untuk mengirim komentar ke halaman utama
      Navigator.of(context).pop(); // Menutup halaman setelah menyimpan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Creator'),
                TextFormField(
                  initialValue: _dataComment['creator'] ?? '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Comment creator',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter creator name';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['creator'] = newValue;
                    }
                  },
                ),
                const Text('Comment'),
                TextFormField(
                  initialValue: _dataComment['content'] ?? '',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Enter your comment',
                    prefixIcon: const Icon(Icons.note),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter comment content';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['content'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize),
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: _saveComment,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(height: mediumSize),
                SizedBox(
                  height: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Kembali tanpa menyimpan
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
