import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_games/bloc/auth/bloc/auth_bloc.dart';
import 'package:mini_games/register.dart';
import 'package:mini_games/visibility_cubit.dart';
import 'loading.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const primaryColor = Colors.blueGrey;
  static const accentColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Make sure this is true to adjust when the keyboard appears
      body: Container(
        height: double.infinity, // Make sure the container fills the screen height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/download.jpeg'), // Background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),  // Add a dark overlay to the image
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Adjust padding when the keyboard shows
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Header text
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  alignment: Alignment.center,
                  child: const Text(
                    'TANGKAP BUAH',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 10.0, color: Colors.black, offset: Offset(5.0, 5.0)),
                      ],
                    ),
                  ),
                ),
                // Form
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      _emailField(),
                      const SizedBox(height: 25),
                      _passwordField(),
                      const SizedBox(height: 60),
                      _loginButton(context),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          child: const Text(
                            'Don\'t have an account? Register',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontSize: 16, color: Colors.white),
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
            filled: true,
            fillColor: Colors.blueGrey[50],
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
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 8),
        BlocConsumer<VisibilityCubit, bool>(
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
                fillColor: Colors.blueGrey[50],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AuthStateLoaded) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoadingScreen()),
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
          onPressed: state is AuthStateLoading
              ? null
              : () {
                  context.read<AuthBloc>().add(
                        AuthEventLogin(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                },
          child: state is AuthStateLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  'LOGIN',
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

