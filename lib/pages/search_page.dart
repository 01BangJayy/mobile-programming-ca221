import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari...',
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.cancel, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context); 
                },
              ),
            ],
          ),
        ),
      ),
      body: const Center(child: Text('Search')),
    );
  }
}
