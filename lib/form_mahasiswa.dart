import 'package:flutter/material.dart';

class FormMahasiswa extends StatefulWidget {
  const FormMahasiswa({super.key});

  @override
  State<FormMahasiswa> createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  String _nim = '';
  String _nama = '';
  String _panggilan = '';
  String _email = '';
  String _telepon = '';
  String? _jenisKelamin;
  String? _fakultas;

  final List<String> jenisKelaminList = ['Laki-laki', 'Perempuan'];

  final List<String> fakultasList = [
    'Fakultas Teknik',
    'Fakultas Ekonomi',
    'Fakultas Ilmu Komunikasi',
    'Fakultas Hukum',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Data Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // NIM
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NIM (12 digit)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 12,
                validator: (value) {
                  // TODO_1
                  if (value == null || value.isEmpty) {
                    return 'Nim wajib diisi';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Nim harus angka bro/sist';
                  }
                  if (value.length < 12) {
                    return 'Nim kurang dari 12 digit';
                  }
                  return null;
                  //END_TODO_1
                },
                onSaved: (value) => _nim = value!,
              ),
              const SizedBox(height: 12),

              // Nama Lengkap
              TextFormField(
                // TODO_2
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Lengkap Wajib diisi!';
                  }
                  return null;
                },
                // END_TODO_2
                onSaved: (value) => _nama = value!,
              ),
              const SizedBox(height: 12),

              // Nama Panggilan
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nama Panggilan',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _panggilan = value!,
              ),
              const SizedBox(height: 12),

              // Email
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
              const SizedBox(height: 12),

              // Nomor Telepon
              TextFormField(
                // TODO_3
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon Wajib diisi';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Nomor Telepon harus berupa angka';
                  } else if (value.length < 11 || value.length > 15) {
                    return 'Nomor Telepon harus terdiri dari 12-15 digit';
                  }
                  return null;
                },
                // END_TODO_3
                onSaved: (value) => _telepon = value!,
              ),
              const SizedBox(height: 12),

              // Jenis Kelamin
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
                value: _jenisKelamin,
                items:
                    jenisKelaminList
                        .map(
                          (jk) => DropdownMenuItem(value: jk, child: Text(jk)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _jenisKelamin = value),
                validator:
                    (value) => value == null ? 'Pilih jenis kelamin' : null,
                onSaved: (value) => _jenisKelamin = value,
              ),
              const SizedBox(height: 12),

              // Fakultas
              DropdownButtonFormField<String>(
                // TODO_4
                decoration: const InputDecoration(
                  labelText: 'Fakultas',
                  border: OutlineInputBorder(),
                ),
                value: _fakultas,
                items:
                    fakultasList
                        .map(
                          (fakultas) => DropdownMenuItem(
                            value: fakultas,
                            child: Text(fakultas),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _fakultas = value),
                validator: (value) => value == null ? 'Pilih fakultas' : null,
                // END_TODO_4
                onSaved: (value) => _fakultas = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            title: const Text('Data Mahasiswa'),
                            content: Text(
                              'NIM: $_nim\n'
                              'Nama: $_nama\n'
                              'Panggilan: $_panggilan\n'
                              'Email: $_email\n'
                              'Telepon: $_telepon\n'
                              'Jenis Kelamin: $_jenisKelamin\n'
                              'Fakultas: $_fakultas',
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
