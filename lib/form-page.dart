import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // GlobalKey untuk mengontrol state form
  final _formKey = GlobalKey<FormState>();

  // Variabel penampung input
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Input Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                //validator: (value) { inputan nama lengkap
                // TODO_20
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
                // TODO_20
                //},
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16),

              // Email  menambahkan inputan email
              // TextFormField(
              //   // TODO_30

              //   // TODO_30
              //   onSaved: (value) {
              //     _email = value!;
              //   },
              // ),
              // const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      print('Nama: $_name');
                      print('Email: $_email');

                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Data Tersimpan'),
                              content: Text('Nama: $_name\nEmail: $_email'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
