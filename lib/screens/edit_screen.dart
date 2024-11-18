import 'package:flutter/material.dart';
import '../models/tumbuhan.dart';

class EditScreen extends StatefulWidget {
  final Tumbuhan tumbuhan;

  EditScreen({required this.tumbuhan});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Tumbuhan _tumbuhan;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _negaraController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tumbuhan = widget.tumbuhan;
    _namaController.text = _tumbuhan.namaTumbuhan;
    _negaraController.text = _tumbuhan.namaNegara;
    _deskripsiController.text = _tumbuhan.deskripsi;
    _imageController.text = _tumbuhan.gambarTumbuhan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tumbuhan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
                onSaved: (value) {
                  _tumbuhan.namaTumbuhan = value!;
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
                onSaved: (value) {
                  _tumbuhan.namaNegara = value!;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi Tumbuhan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tumbuhan.deskripsi = value!;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Gambar Tumbuhan (URL atau Path)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gambar tumbuhan harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tumbuhan.gambarTumbuhan = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, _tumbuhan);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
