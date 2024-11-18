import 'package:flutter/material.dart';
import '../models/tumbuhan.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _negaraController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String _gambarTumbuhan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tumbuhan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Tumbuhan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tumbuhan harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _negaraController,
                decoration: InputDecoration(labelText: 'Nama Negara'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama negara harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gambar Tumbuhan (URL atau Path)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL gambar harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _gambarTumbuhan = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTumbuhan = Tumbuhan(
                      namaTumbuhan: _namaController.text,
                      namaNegara: _negaraController.text,
                      deskripsi: _deskripsiController.text,
                      gambarTumbuhan: _gambarTumbuhan,
                    );
                    Navigator.pop(context, newTumbuhan);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
