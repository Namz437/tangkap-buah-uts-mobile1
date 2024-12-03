import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_games/bloc/register/bloc/register_bloc.dart';
import 'package:mini_games/visibility_cubit.dart';
import 'login.dart'; // Import halaman login

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const primaryColor = Colors.blueGrey;  // Use same primary color as Login
  static const accentColor = Colors.amber;  // Use same accent color as Login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Menonaktifkan penggeseran untuk menghindari sisa putih
      body: Container(
        height: double.infinity,  // Pastikan container mengisi seluruh layar
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),  // Menambahkan efek gelap di atas gambar
          image: DecorationImage(
            image: AssetImage("assets/images/download.jpeg"),  // Gunakan gambar latar belakang (sesuaikan dengan path)
            fit: BoxFit.cover,  // Gambar menutupi seluruh layar
          ),
        ),
        child: SafeArea( // Menggunakan SafeArea untuk mencegah konten terpotong di bagian atas
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                  child: const Text(
                    'Buat Akun Dahulu',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, 15),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameField(),
                        const SizedBox(height: 20),
                        _emailField(),
                        const SizedBox(height: 20),
                        _passwordField(),
                        const SizedBox(height: 30),
                        _registerButton(context),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: const Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: 'Masukkan Nama Anda',
            hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            filled: true,
            fillColor: Colors.blueGrey[50],  // Warna latar belakang input
          ),
        ),
      ],
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintText: 'Masukkan Email Anda',
            hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            filled: true,
            fillColor: Colors.blueGrey[50],  // Warna latar belakang input
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        const SizedBox(height: 8),
        BlocConsumer<VisibilityCubit, bool>(  // Pastikan BlocConsumer berfungsi dengan baik
          listener: (context, state) {},
          builder: (context, isObscured) {
            return TextField(
              controller: _passwordController,
              obscureText: isObscured,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Masukkan Password Anda',
                hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    context.read<VisibilityCubit>().change();
                  },
                ),
                filled: true,
                fillColor: Colors.blueGrey[50],  // Warna latar belakang input
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _registerButton(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(  // Menambahkan listener untuk menangani state
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is RegisterSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: state is! RegisterLoading
              ? () {
                  if (_nameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Harap isi semua field!"),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  } else {
                    context.read<RegisterBloc>().add(
                          RegisterSubmitted(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  }
                }
              : null,
          child: state is RegisterLoading
              ? const CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              : const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }
}
