import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FurGo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD180),
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                // Header section with enhanced logo
                Container(
                  child: Column(
                    children: [
                      // Clean FurGlo Logo - Larger Image Only
                      Container(
                        height: 120,
                        width: 200,
                        child: Image.asset(
                          'assets/images/furglo_logo.png',
                          fit: BoxFit.cover,
                          width: 280,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) {
                            // Debug: Print error to console
                            print('Logo loading error: $error');
                            // Clean fallback styling
                            return Container(
                              height: 120,
                              width: 200,
                              child: Center(
                                child: Text(
                                  'FurGlo',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF8A50),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFF8A50),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Login to continue managing your services',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFF8A50),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Enhanced Form section
                Column(
                  children: [
                    // Email field with enhanced styling
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFD180),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFFBBBBBB),
                            size: 22,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password field with enhanced styling
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFD180),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color(0xFFBBBBBB),
                            fontSize: 16,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFFBBBBBB),
                            size: 22,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFFBBBBBB),
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFFFF8A50),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Enhanced Login button
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your login logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: const Color(0xFFFF8A50).withOpacity(0.3),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFFFD180),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Color(0xFFFF8A50),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFFFD180),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Continue with Email button
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Add your email signup logic here
                        },
                        icon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFFFF8A50),
                          size: 22,
                        ),
                        label: const Text(
                          'Continue With Email',
                          style: TextStyle(
                            color: Color(0xFFFF8A50),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(
                            color: Color(0xFFFFD180),
                            width: 1,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Continue with Google button
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Add your Google auth logic here
                        },
                        icon: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://developers.google.com/identity/images/g-logo.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        label: const Text(
                          'Continue With Google',
                          style: TextStyle(
                            color: Color(0xFFFF8A50),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(
                            color: Color(0xFFFFD180),
                            width: 1,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sign up section
                    Column(
                      children: [
                        const Text(
                          "Don't Have an Account?",
                          style: TextStyle(
                            color: Color(0xFFFF8A50),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            // Add your navigation to sign up screen here
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color(0xFFFF8A50),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}