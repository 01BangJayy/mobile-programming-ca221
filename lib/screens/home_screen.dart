import 'package:flutter/material.dart';
import '../models/tumbuhan.dart';
import 'add_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tumbuhan> tumbuhanList = [
    Tumbuhan(
      namaTumbuhan: 'Aloe Vera',
      namaNegara: 'Afrika',
      deskripsi: 'Tanaman penyembuh yang banyak digunakan untuk kulit dan rambut.',
      gambarTumbuhan: 'https://www.socfindoconservation.co.id/asset/plant/329-1-aloe-vera-l-burm-f.jpg',  // URL gambar
    ),
    // Tambahkan tumbuhan lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tumbuhan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tumbuhanList.length,
          itemBuilder: (context, index) {
            final tumbuhan = tumbuhanList[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  tumbuhan.namaTumbuhan,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Negara: ${tumbuhan.namaNegara}'),
                    Text('Deskripsi: ${tumbuhan.deskripsi}'),
                  ],
                ),
                leading: tumbuhan.gambarTumbuhan.isNotEmpty
                    ? Image.network(
                        tumbuhan.gambarTumbuhan,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image, size: 50), // Placeholder icon if no image
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(tumbuhan: tumbuhan),
                    ),
                  ).then((updatedTumbuhan) {
                    if (updatedTumbuhan != null) {
                      setState(() {
                        tumbuhanList[index] = updatedTumbuhan;
                      });
                    }
                  });
                },
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditScreen(tumbuhan: tumbuhan),
                          ),
                        ).then((updatedTumbuhan) {
                          if (updatedTumbuhan != null) {
                            setState(() {
                              tumbuhanList[index] = updatedTumbuhan;
                            });
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Konfirmasi Hapus'),
                              content: Text('Apakah Anda yakin ingin menghapus tumbuhan ini?'),
                              actions: <Widget>[
                                OutlinedButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text('Hapus'),
                                  onPressed: () {
                                    setState(() {
                                      tumbuhanList.removeAt(index);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(), // Ensure AddScreen is correctly defined and imported
            ),
          ).then((newTumbuhan) {
            if (newTumbuhan != null) {
              setState(() {
                tumbuhanList.add(newTumbuhan);
              });
            }
          });
        },
      ),
    );
  }
}
