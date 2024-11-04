import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/api_service.dart';

class EditItemScreen extends StatefulWidget {
  final Item item;

  EditItemScreen({required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String description;
  late double price;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    description = widget.item.description;
    price = widget.item.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Barang',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
        ),
        backgroundColor: Color(0xFFFE724C), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Edit Detail Barang',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFE724C),
                      ),
                    ),
                    SizedBox(height: 20),

                    TextFormField(
                      initialValue: name,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        prefixIcon: Icon(Icons.label, color: Color(0xFFFE724C)),
                        labelStyle: TextStyle(color: Color(0xFFFE724C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFE724C)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan masukkan nama barang';
                        }
                        return null;
                      },
                      onSaved: (value) => name = value ?? '',
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: description,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        prefixIcon: Icon(Icons.description, color: Color(0xFFFE724C)),
                        labelStyle: TextStyle(color: Color(0xFFFE724C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFE724C)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan masukkan deskripsi barang';
                        }
                        return null;
                      },
                      onSaved: (value) => description = value ?? '',
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      initialValue: price.toString(),
                      decoration: InputDecoration(
                        labelText: 'Harga',
                        prefixIcon: Icon(Icons.attach_money, color: Color(0xFFFE724C)),
                        labelStyle: TextStyle(color: Color(0xFFFE724C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFE724C)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || double.tryParse(value) == null) {
                          return 'Silakan masukkan harga yang valid';
                        }
                        return null;
                      },
                      onSaved: (value) => price = double.tryParse(value ?? '0') ?? 0.0,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final updatedItem = Item(
                            id: widget.item.id,
                            name: name,
                            description: description,
                            price: price,
                          );
                          try {
                            await apiService.updateItem(updatedItem);
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal memperbarui barang')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE724C),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Perbarui Barang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
