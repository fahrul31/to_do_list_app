import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/provider/auth_provider.dart';
import 'package:to_do_list/ui/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register_page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var txtEditUsername = TextEditingController();
  var txtEditEmail = TextEditingController();
  var txtEditPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    txtEditUsername.dispose();
    txtEditEmail.dispose();
    txtEditPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Navigator.pushNamed(context, HomePage.routeName);
              }
            },
            // child: const Button(text: "Masuk"),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Masuk Akun",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
                const SizedBox(height: 8),
                const Text(
                  "Masukkan nomor handphone atau email & password kamu untuk masuk ke aplikasi",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text("Email"),
                TextFormField(
                  controller: txtEditEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan email",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Color(0xffEF6A37),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF6A37))),
                      contentPadding: EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 24),
                const Text("Password"),
                TextFormField(
                  obscureText: true,
                  controller: txtEditPass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan password",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xffEF6A37),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF6A37))),
                      contentPadding: EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 24),
                const Text("Username"),
                TextFormField(
                  controller: txtEditUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan username",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Color(0xffEF6A37),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF6A37))),
                      contentPadding: EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 24),
                context.watch<AuthProvider>().isLoadingRegister
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            final authRead = context.read<AuthProvider>();

                            await authRead.register(txtEditEmail.text,
                                txtEditUsername.text, txtEditPass.text);
                            final result = authRead.registerResponse;
                            if (result?.statusCode == 2000) {
                              if (context.mounted) {
                                final message = context
                                    .read<AuthProvider>()
                                    .registerResponse
                                    ?.message;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(message!),
                                  ),
                                );
                              }
                              Navigator.pushNamed(context, LoginPage.routeName);
                            } else {
                              if (context.mounted) {
                                final loginError = context
                                    .read<AuthProvider>()
                                    .errorMessageRegister;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(loginError!),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                          backgroundColor: const Color(0xffEF6A37),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
