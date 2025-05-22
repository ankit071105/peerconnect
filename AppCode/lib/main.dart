import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:convert';

import 'package:http/http.dart' as http;
void main() {
  runApp(const PeerConnectApp());
}

// App Theme
final _appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFD1FBF3),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE2FDFA),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF031D32),),
    titleTextStyle: TextStyle(
      color: Color(0xFF040923),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFB1DDEC),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(8),
  ),
);

// Demo Images
const List<String> demoImages = [
  'https://imgs.search.brave.com/Wdb_I6Atkc2zlH5CLwY3YqGLqNDNhr9nS1CAbH10BFg/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9p/bmRpYW4tYnVzaW5l/c3NtYW4td2l0aC1o/aXMtd2hpdGUtY2Fy/XzQ5NjE2OS0yODg5/LmpwZz9zZW10PWFp/c19oeWJyaWQ',
  'https://imgs.search.brave.com/-b5rrRzWCjCZHpD2i3XzBoDbATq8JOhzkZKlm7N5q3w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9i/dXNpbmVzc3dvbWFu/LXBvc2luZ18yMy0y/MTQ4MTQyODI5Lmpw/Zz9zZW10PWFpc19o/eWJyaWQmdz03NDA',
  'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
  'https://imgs.search.brave.com/QmxQW5BHnRInPL6lEoa19xgBZ8YFyAHov4Pj985nZWE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA2LzU4Lzk1LzE2/LzM2MF9GXzY1ODk1/MTY5OF9SSHdZaGhK/SkVvR1V4RTV2U2hw/ZEdWSGVsMnB4RGRp/SC5qcGc',
  'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=200',
  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
  'https://imgs.search.brave.com/e6KS4U5hsImuyxNWUhZsOQr792nrJ8XL7Aywc8bosYs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9wb3J0cmFpdC15/b3VuZy1tYW4tc3Rh/bmRpbmctb3V0ZG9v/cnNfMTA0ODk0NC0x/NTQ5NzExMS5qcGc_/c2VtdD1haXNfaHli/cmlkJnc9NzQw',

];

// Mock Data
final List<String> departments = [
  'Computer Science',
  'Electrical Engineering',
  'Mechanical Engineering',
  'Business Administration',
  'Biology',
  'Chemistry',
  'Physics',
  'Mathematics'
];

final List<String> interests = [
  'Mobile Development',
  'Web Development',
  'AI/ML',
  'Data Science',
  'Cybersecurity',
  'IoT',
  'Robotics',
  'Entrepreneurship',
  'Research',
  'Design'
];

final List<String> years = ['Freshman', 'Sophomore', 'Junior', 'Senior'];

final List<User> mockUsers = [
  User(
    id: '1',
    name: 'Sahil Sharma',
    email: 'sahil@university.edu',
    password: 'password123',
    collegeId: 'CS2021001',
    year: 'Junior',
    department: 'Computer Science',
    interests: ['Mobile Development', 'AI/ML'],
    connections: ['4', '6'],
    bio: 'Passionate about building mobile apps and exploring AI technologies.',
    imageUrl: demoImages[0],
  ),
  User(
    id: '2',
    name: 'Priya Kumari',
    email: 'priya@university.edu',
    password: 'password123',
    collegeId: 'EE2021002',
    year: 'Sophomore',
    department: 'Electrical Engineering',
    interests: ['IoT', 'Robotics'],
    connections: ['3', '7'],
    bio: 'Interested in smart devices and robotics. Always looking for project collaborators!',
    imageUrl: demoImages[1],
  ),
  User(
    id: '3',
    name: 'Ankita Kumar',
    email: 'ankita@university.edu',
    password: 'password123',
    collegeId: 'ME2021003',
    year: 'Senior',
    department: 'Mechanical Engineering',
    interests: ['Robotics', 'Entrepreneurship'],
    connections: ['2', '5'],
    bio: 'Building the next generation of robotic systems. Let\'s innovate together!',
    imageUrl: demoImages[2],
  ),
  User(
    id: '4',
    name: 'Sakshi Tiwary',
    email: 'sakshi@university.edu',
    password: 'password123',
    collegeId: 'CS2021004',
    year: 'Freshman',
    department: 'Computer Science',
    interests: ['Web Development', 'Design'],
    connections: ['1', '8'],
    bio: 'Web developer and UI/UX enthusiast. Love creating beautiful digital experiences.',
    imageUrl: demoImages[3],
  ),

  User(
    id: '5',
    name: 'Himanshu Singh',
    email: 'himanshu@university.edu',
    password: 'password123',
    collegeId: 'BA2021005',
    year: 'Junior',
    department: 'Business Administration',
    interests: ['Entrepreneurship', 'Research'],
    connections: ['3', '7'],
    bio: 'Aspiring entrepreneur with a passion for market research and startups.',
    imageUrl: demoImages[4],
  ),
  User(
    id: '6',
    name: 'Karshima Sinha',
    email: 'karshima@university.edu',
    password: 'password123',
    collegeId: 'CS2021006',
    year: 'Senior',
    department: 'Computer Science',
    interests: ['Cybersecurity', 'Data Science'],
    connections: ['1'],
    bio: 'Cybersecurity specialist and data science researcher. Always learning!',
    imageUrl: demoImages[5],
  ),
  User(
    id: '7',
    name: 'Swati Das',
    email: 'swati@university.edu',
    password: 'password123',
    collegeId: 'EE2021007',
    year: 'Sophomore',
    department: 'Electrical Engineering',
    interests: ['IoT', 'AI/ML'],
    connections: ['2', '5'],
    bio: 'Combining hardware and AI to create smart solutions for real-world problems.',
    imageUrl: demoImages[6],
  ),
  User(
    id: '8',
    name: 'Ayesha Hussain',
    email: 'ayesha@university.edu',
    password: 'password123',
    collegeId: 'DE2021008',
    year: 'Junior',
    department: 'Design',
    interests: ['Design', 'Web Development'],
    connections: ['4'],
    bio: 'Digital designer who codes. Passionate about creating intuitive user interfaces.',
    imageUrl: demoImages[7],
  ),
  User(
    id: '9',
    name: 'Akshat Kumar',
    email: 'akshat@university.edu',
    password: 'password123',
    collegeId: 'CS2021001',
    year: 'Junior',
    department: 'Computer Science',
    interests: ['Mobile Development', 'AI/ML'],
    connections: ['4', '6'],
    bio: 'Passionate about building mobile apps and exploring AI technologies.',
    imageUrl: demoImages[8],
  ),
];



// Models
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String collegeId;
  final String year;
  final String department;
  final List<String> interests;
  final List<String> connections;
  final String bio;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.collegeId,
    required this.year,
    required this.department,
    required this.interests,
    required this.connections,
    this.bio = '',
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'collegeId': collegeId,
    'year': year,
    'department': department,
    'interests': interests,
    'connections': connections,
    'bio': bio,
    'imageUrl': imageUrl,
  };
}

class Project {
  final String id;
  final String title;
  final String description;
  final List<String> skillsNeeded;
  final String creatorId;
  final List<String> collaborators;
  final String status;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.skillsNeeded,
    required this.creatorId,
    this.collaborators = const [],
    this.status = 'Planning',
  });
}

// Main App
class PeerConnectApp extends StatelessWidget {
  const PeerConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PeerConnect',
      debugShowCheckedModeBanner: false,
      theme: _appTheme,
      home: const GetStartedScreen(),
    );
  }
}

// Get Started Screen
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    timeDilation = 1.5;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD2F1F6),
              Color(0xFFC6EEF4),
              Color(0xFFB8F5FF),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Hero(
                  tag: 'app-logo',
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:Color(0xFFAFF1FD),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.people_alt_rounded,
                      size: 60,
                      color: Color(0xFF082240),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'PeerConnect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF082240),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Connect with peers who share your interests',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF082240),
                  ),
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF082240),
                            foregroundColor: Color(0xFFB6FFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF082240),
                            side: const BorderSide(color: Color(0xFF082240),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Log In'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _collegeIdController = TextEditingController();
  final _bioController = TextEditingController();
  String? _selectedYear;
  String? _selectedDepartment;
  final List<String> _selectedInterests = [];
  String? _selectedImageUrl;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _collegeIdController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _showInterestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Your Interests'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: interests
                  .map((interest) => CheckboxListTile(
                title: Text(interest),
                value: _selectedInterests.contains(interest),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedInterests.add(interest);
                    } else {
                      _selectedInterests.remove(interest);
                    }
                  });
                },
              ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose a profile picture'),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: demoImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageUrl = demoImages[index];
                    });
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      demoImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedYear == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your year')),
        );
        return;
      }

      if (_selectedDepartment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your department')),
        );
        return;
      }

      if (_selectedInterests.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one interest')),
        );
        return;
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        collegeId: _collegeIdController.text,
        year: _selectedYear!,
        department: _selectedDepartment!,
        interests: _selectedInterests,
        connections: [],
        bio: _bioController.text,
        imageUrl: _selectedImageUrl ?? demoImages[0],
      );

      // Navigate to dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(user: newUser, allUsers: mockUsers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _showImagePicker,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImageUrl != null
                        ? NetworkImage(_selectedImageUrl!)
                        : const AssetImage('assets/default_profile.png')
                    as ImageProvider,
                    child: _selectedImageUrl == null
                        ? const Icon(Icons.add_a_photo, size: 30)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'University Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _collegeIdController,
                decoration: const InputDecoration(
                  labelText: 'College ID',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your college ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Short Bio (Optional)',
                  prefixIcon: Icon(Icons.info),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(Icons.school),
                ),
                value: _selectedYear,
                items: years
                    .map((year) => DropdownMenuItem(
                  value: year,
                  child: Text(year),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Department',
                  prefixIcon: Icon(Icons.apartment),
                ),
                value: _selectedDepartment,
                items: departments
                    .map((dept) => DropdownMenuItem(
                  value: dept,
                  child: Text(dept),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _showInterestDialog,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Interests',
                    prefixIcon: Icon(Icons.interests),
                  ),
                  child: _selectedInterests.isEmpty
                      ? const Text(
                    'Select your interests',
                    style: TextStyle(color: Colors.grey),
                  )
                      : Wrap(
                    spacing: 4,
                    children: _selectedInterests
                        .map((interest) => Chip(
                      label: Text(interest),
                      backgroundColor: Color(0xFFAFFFF9),
                    ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF100842), // Use this for button color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white), // Optional for contrast
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Find user in mock data
      final user = mockUsers.firstWhere(
            (u) => u.email == _emailController.text && u.password == _passwordController.text,
        orElse: () => User(
          id: '',
          name: '',
          email: '',
          password: '',
          collegeId: '',
          year: '',
          department: '',
          interests: [],
          connections: [],
          bio: '',
          imageUrl: '',
        ),
      );

      if (user.id.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(user: user, allUsers: mockUsers),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Hero(
                tag: 'app-logo',
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFB0FFFD),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.people_alt_rounded,
                      size: 60,
                      color: Color(0xFF082240),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Log In'),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ChatBotDialog extends StatefulWidget {
  final String apiKey;

  const ChatBotDialog({super.key, required this.apiKey});

  @override
  _ChatBotDialogState createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _messages.add({
      "bot": "Hi there! I'm your Study Assistant. How can I help you with your projects or studies today?",
      "timestamp": DateTime.now(),
    });
  }

  Future<void> sendMessage(String input) async {
    if (input.isEmpty) return;

    setState(() {
      _messages.add({
        "user": input,
        "timestamp": DateTime.now(),
      });
      _isLoading = true;
    });

    // Scroll to bottom when new message arrives
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    try {
      final uri = Uri.parse(
          'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=${widget.apiKey}');
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                  "You're a helpful study assistant for university students. Help with project ideas, study tips, academic questions, and campus resources. Keep responses concise and practical. Current date: ${DateTime.now().toString()}"
                },
                {"text": input}
              ]
            }
          ]
        }),
      );

      final data = jsonDecode(response.body);
      final reply = data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ??
          "I couldn't process that request. Please try again.";

      setState(() {
        _messages.add({
          "bot": reply,
          "timestamp": DateTime.now(),
        });
        _isLoading = false;
      });

      // Scroll to bottom after response
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "bot": "Sorry, I'm having trouble connecting. Please check your internet and try again.",
          "timestamp": DateTime.now(),
        });
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF100842),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF191953),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://imgs.search.brave.com/ic_9JH9utwVlwXM1BPbLJ3rKfThngqhzRTQi3Z2bx64/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWdz/LnNlYXJjaC5icmF2/ZS5jb20vNlVzbFNr/RnhCRHhkaHBDd2d6/aE9USEtCTk5FUkxL/ZnRsS1lNRGJQcDlZ/US9yczpmaXQ6NTAw/OjA6MDowL2c6Y2Uv/YUhSMGNITTZMeTkw/TkM1bS9kR05rYmk1/dVpYUXZhbkJuL0x6/QXlMelEyTHprMkx6/WTMvTHpNMk1GOUdY/ekkwTmprMi9OamMz/T1Y5c1pHSnZWMUp6/L1IySTBhRUpYVFVG/VlVGZ3kvWVdwUVRX/TnBhVTg0TnpCdy9h/aTVxY0dj'),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Study Assistant",
                    style: TextStyle(
                      color: Color(0xFFC6FBF4),
                    ),),
                    Text(
                      "Online",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12),
                    ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFFC6FBF4)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Chat messages
            Expanded(
              child: Container(
                color: const Color(0xFF33CAC5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _messages.isEmpty
                    ? const Center(
                  child: Text(
                    "Ask me anything about your studies or projects!",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(top: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message.containsKey("user");
                    final timestamp = message["timestamp"] as DateTime;
                    final timeString =
                        "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isUser)
                            const CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(
                                  'https://imgs.search.brave.com/ic_9JH9utwVlwXM1BPbLJ3rKfThngqhzRTQi3Z2bx64/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWdz/LnNlYXJjaC5icmF2/ZS5jb20vNlVzbFNr/RnhCRHhkaHBDd2d6/aE9USEtCTk5FUkxL/ZnRsS1lNRGJQcDlZ/US9yczpmaXQ6NTAw/OjA6MDowL2c6Y2Uv/YUhSMGNITTZMeTkw/TkM1bS9kR05rYmk1/dVpYUXZhbkJuL0x6/QXlMelEyTHprMkx6/WTMvTHpNMk1GOUdY/ekkwTmprMi9OamMz/T1Y5c1pHSnZWMUp6/L1IySTBhRUpYVFVG/VlVGZ3kvWVdwUVRX/TnBhVTg0TnpCdy9h/aTVxY0dj'),
                            ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? const Color(0xFF221B60)
                                    : const Color(0xFF191953),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: Radius.circular(
                                      isUser ? 12 : 0),
                                  bottomRight: Radius.circular(
                                      isUser ? 0 : 12),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isUser
                                        ? message["user"] as String
                                        : message["bot"] as String,
                                    style: TextStyle(
                                      color: isUser
                                          ? const Color(0xFFC6FBF4)
                                          : const Color(0xFFC6FBF4),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    timeString,
                                    style: TextStyle(
                                      color: isUser
                                          ? const Color(0xFFC6FBF4).withOpacity(0.7)
                                          : const Color(0xFFC6FBF4).withOpacity(0.7),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isUser)
                            const CircleAvatar(
                              radius: 14,
                              backgroundColor: Color(0xFF221B60),
                              child: Icon(
                                Icons.person,
                                size: 16,
                                color: Color(0xFFC6FBF4),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Loading indicator
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFFC6FBF4),
                  ),
                ),
              ),

            // Input area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF191953),
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Color(0xFFC6FBF4)),
                      decoration: InputDecoration(
                        hintText: "Type your question...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: const Color(0xFF100842),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (text) {
                        sendMessage(text);
                        _controller.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF221B60),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFFC6FBF4)),
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final User user;
  final List<User> allUsers;

  const DashboardScreen({
    super.key,
    required this.user,
    required this.allUsers,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  late List<User> _connections;
  late List<User> _filteredUsers;
  String _searchQuery = '';
  String? _selectedFilter;
  final List<Project> _projects = [
    Project(
      id: '1',
      title: 'Mobile Development Course',
      description:
      'Building an app to help students navigate campus buildings and events',
      skillsNeeded: ['Mobile Development', 'UI/UX Design'],
      creatorId: '1',
      collaborators: ['4', '6'],
    ),
    Project(
      id: '2',
      title: 'Smart Campus IoT',
      description: 'Developing IoT solutions for energy efficiency on campus',
      skillsNeeded: ['IoT', 'Electrical Engineering'],
      creatorId: '2',
      collaborators: ['3', '7'],
    ),
    Project(
      id: '3',
      title: 'AI Tutor Assistant',
      description: 'Creating an AI-powered study assistant for students',
      skillsNeeded: ['AI/ML', 'Web Development'],
      creatorId: '6',
      collaborators: ['1'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _connections = widget.allUsers
        .where((user) => widget.user.connections.contains(user.id))
        .toList();
    _filteredUsers = widget.allUsers
        .where((user) => user.id != widget.user.id)
        .where((user) => !widget.user.connections.contains(user.id))
        .toList();
  }

  void _connect(User peer) {
    setState(() {
      widget.user.connections.add(peer.id);
      _connections.add(peer);
      _filteredUsers.removeWhere((user) => user.id == peer.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connected with ${peer.name}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = widget.allUsers
          .where((user) => user.id != widget.user.id)
          .where((user) => !widget.user.connections.contains(user.id))
          .where((user) =>
      _searchQuery.isEmpty ||
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.department
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          user.interests.any((interest) =>
              interest.toLowerCase().contains(_searchQuery.toLowerCase())))
          .where((user) =>
      _selectedFilter == null ||
          user.department == _selectedFilter ||
          user.interests.contains(_selectedFilter))
          .toList();
    });
  }

  void _showConnectionDetails(User user) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '${user.year} - ${user.department}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bio',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(user.bio),
              const SizedBox(height: 16),
              const Text(
                'Interests',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: user.interests
                    .map((interest) => Chip(
                  label: Text(interest),
                  backgroundColor: const Color(0xFFC5FAF9),
                ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProjectDetails(Project project) {
    final creator =
    widget.allUsers.firstWhere((user) => user.id == project.creatorId);
    final collaborators = widget.allUsers
        .where((user) => project.collaborators.contains(user.id))
        .toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${project.status}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(project.description),
              const SizedBox(height: 16),
              const Text(
                'Skills Needed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.skillsNeeded
                    .map((skill) => Chip(
                  label: Text(skill),
                  backgroundColor: const Color(0xFF95FFFB),
                ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Created By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(creator.imageUrl),
                ),
                title: Text(creator.name),
                subtitle: Text('${creator.department} - ${creator.year}'),
              ),
              const SizedBox(height: 8),
              const Text(
                'Collaborators',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (collaborators.isEmpty)
                const Text('No collaborators yet')
              else
                ...collaborators.map((user) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                  title: Text(user.name),
                  subtitle: Text('${user.department} - ${user.year}'),
                )),
              const SizedBox(height: 16),
              if (!project.collaborators.contains(widget.user.id))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text('Request to join sent to project creator'),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Request to Join'),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF100842),

        automaticallyImplyLeading: false,
        title: Text(_currentIndex == 0
            ? 'My Profile'
            : _currentIndex == 1
            ? 'Browse Peers'
            : _currentIndex == 2
            ? 'My Connections'
            : 'Projects', style: const TextStyle(color:  Color(0xFFBDF4FB),),),
        actions: _currentIndex == 1
            ? [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            color: Color(0xFFC4FAFA),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Filter By'),
                    content: SizedBox(
                      // Set a max height to allow scrolling when content is long
                      height: 300,
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...departments.map((dept) => ListTile(
                              title: Text(dept),
                              trailing: _selectedFilter == dept
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedFilter = dept;
                                });
                                _filterUsers();
                                Navigator.pop(context);
                              },
                            )),
                            const Divider(),
                            ...interests.map((interest) => ListTile(
                              title: Text(interest),
                              trailing: _selectedFilter == interest
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedFilter = interest;
                                });
                                _filterUsers();
                                Navigator.pop(context);
                              },
                            )),
                            ListTile(
                              title: const Text('Clear Filter'),
                              onTap: () {
                                setState(() {
                                  _selectedFilter = null;
                                });
                                _filterUsers();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

        ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Profile Tab
          Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: const Color(0xFF100842),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(widget.user.imageUrl),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.user.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC6FBF4),
                              ),
                            ),
                            Text(
                              widget.user.collegeId,
                              style: TextStyle(
                                color: const Color(0xFFC6FBF4),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _connections.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFC6FBF4),
                                      ),
                                    ),
                                    const Text('Connections',
                                      style: const TextStyle(
                                        fontSize: 16,

                                        color: const Color(0xFFC6FBF4),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      widget.user.interests.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFC6FBF4),
                                      ),
                                    ),
                                    const Text('Interests',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xFFC6FBF4),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _projects
                                          .where((project) => project.collaborators
                                          .contains(widget.user.id))
                                          .length
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xFFC6FBF4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text('Projects',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xFFC6FBF4),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: const Color(0xFF100842),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                color:  Color(0xFFC6FBF4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Year: ${widget.user.year}',
                              style: TextStyle(
                                color:  Color(0xFFC6FBF4),
                              ),
                            ),
                            Text('Department: ${widget.user.department}',
                              style: TextStyle(
                                color:  Color(0xFFC6FBF4),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Bio',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:  Color(0xFFC6FBF4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.user.bio.isEmpty ? 'No bio yet' : widget.user.bio,
                              style: TextStyle(
                                color:  Color(0xFFC6FBF4),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Interests',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:  Color(0xFFC6FBF4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.user.interests
                                  .map((interest) => Chip(
                                label: Text(interest),
                                backgroundColor: const Color(0xFFC3FAFA),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color:  Color(0xFF100842),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My Projects',
                              style: TextStyle(
                                fontSize: 18,
                                color:  Color(0xFFC6FBF4),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_projects
                                .where((project) =>
                            project.creatorId == widget.user.id ||
                                project.collaborators
                                    .contains(widget.user.id))
                                .isEmpty)
                              const Text('You are not part of any projects yet',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:  Color(0xFFC6FBF4),

                                ),

                              )
                            else
                              ..._projects
                                  .where((project) =>
                              project.creatorId == widget.user.id ||
                                  project.collaborators
                                      .contains(widget.user.id))
                                  .map((project) => ListTile(
                                title: Text(project.title),
                                subtitle: Text(project.description.length >
                                    50
                                    ? '${project.description.substring(0, 50)}...'
                                    : project.description),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () => _showProjectDetails(project),
                              )),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Handle create new project
                                },
                                child: const Text('Create New Project',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:  Color(0xFFC6FBF4),
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              // Floating Chatbot Button
              Positioned(
                bottom: 5, // Adjust this value based on your bottom navigation bar height
                right: 3,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF4E4EED),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ChatBotDialog(apiKey: 'AIzaSyA0dr_zXm5Bl-Vr1gizLi4tFBpekPpO3wA'),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://imgs.search.brave.com/ic_9JH9utwVlwXM1BPbLJ3rKfThngqhzRTQi3Z2bx64/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWdz/LnNlYXJjaC5icmF2/ZS5jb20vNlVzbFNr/RnhCRHhkaHBDd2d6/aE9USEtCTk5FUkxL/ZnRsS1lNRGJQcDlZ/US9yczpmaXQ6NTAw/OjA6MDowL2c6Y2Uv/YUhSMGNITTZMeTkw/TkM1bS9kR05rYmk1/dVpYUXZhbkJuL0x6/QXlMelEyTHprMkx6/WTMvTHpNMk1GOUdY/ekkwTmprMi9OamMz/T1Y5c1pHSnZWMUp6/L1IySTBhRUpYVFVG/VlVGZ3kvWVdwUVRX/TnBhVTg0TnpCdy9h/aTVxY0dj'),

                    radius: 24,
                  ),
                ),
              ),
            ],
          ),

          // Browse Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name, department, or interest',
                    prefixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _filterUsers();
                    });
                  },
                ),
              ),
              if (_selectedFilter != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Chip(
                        label: Text(_selectedFilter!,
                          style: TextStyle(
                            fontSize: 13,
                            color:  Color(0xFF100842),

                          ),
                        ),
                        onDeleted: () {
                          setState(() {
                            _selectedFilter = null;
                            _filterUsers();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: _filteredUsers.isEmpty
                    ? const Center(
                  child: Text('No users found. Try changing your search.'),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return Card(
                      color:Color(0xFF100842),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        onTap: () => _showConnectionDetails(user),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        title: Text(user.name,
                          style: TextStyle(
                            fontSize: 16,
                            color:  Color(0xFFC6FBF4),
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                        subtitle: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${user.year} - ${user.department}',
                              style: TextStyle(
                                fontSize: 14,
                                color:  Color(0xFFC6FBF4),
                              ),

                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 4,
                              children: user.interests
                                  .take(2)
                                  .map((interest) => Chip(
                                label: Text(interest),
                                backgroundColor:Color(0xFFC5FFFF),
                                labelStyle:
                                const TextStyle(fontSize: 12),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _connect(user),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC6FBF4),
                            foregroundColor:Color(0xFF191953),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text('Connect'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Connections Tab
          _connections.isEmpty
              ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.people_outline,
                    size: 60,
                    color: Color(0xFF082240)),
                SizedBox(height: 16),
                Text('No connections yet'),
                SizedBox(height: 8),
                Text(
                  'Start Browse to connect with peers',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _connections.length,
            itemBuilder: (context, index) {
              final user = _connections[index];
              return Card(
                  color: Color(0xFF082240),

                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  onTap: () => _showConnectionDetails(user),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                  title: Text(user.name,   style: TextStyle(color: Color(0xFFC6FBF4)),),
                  subtitle: Text('${user.year} - ${user.department}',
                    style: TextStyle(color: Color(0xFFC6FBF4)),


                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                      color: Color(0xFFC6FBF4),
                        icon: const Icon(Icons.message),
                        onPressed: () {
                          // Handle message action
                        },
                      ),
                      IconButton(
                        color: Color(0xFFC6FBF4),
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                               return Container(
                                color: const Color(0xFF100842),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.person_remove,
                                        color: Color(0xFFC6FBF4),
                                      ),
                                      title: const Text(
                                        'Remove Connection',
                                        style: TextStyle(color: Color(0xFFC6FBF4)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          widget.user.connections.remove(user.id);
                                          _connections.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Removed ${user.name}'),
                                          ),
                                        );
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.cancel,
                                        color: Color(0xFFC6FBF4),
                                      ),
                                      title: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Color(0xFFC6FBF4)),
                                      ),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
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

          // Projects Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search projects',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    // Implement search logic for projects here if needed
                  },
                ),
              ),
              Expanded(
                child: _projects.isEmpty
                    ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.work_outline,
                          size: 60, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No projects yet'),
                      SizedBox(height: 8),
                      Text(
                        'Create a new project to get started',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    final project = _projects[index];
                    final creator = widget.allUsers
                        .firstWhere((user) => user.id == project.creatorId);
                    return Card(
                      color: Color(0xFF191953),

                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        onTap: () => _showProjectDetails(project),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(creator.imageUrl),
                        ),
                        title: Text(project.title,
                          style: TextStyle(color: Color(0xFFC6FBF4)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.description.length > 50
                                  ? '${project.description.substring(0, 50)}...'
                                  : project.description,
                              style: TextStyle(color: Color(0xFFC6FBF4)),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 4,
                              children: project.skillsNeeded
                                  .take(2)
                                  .map((skill) => Chip(
                                label: Text(skill),
                                backgroundColor:
                                const Color(0xFFC6FBF4),
                                labelStyle:
                                const TextStyle(fontSize: 12),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFC6FBF4),),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color(0xFF100842), // Dark background
        selectedItemColor: Colors.lightBlueAccent, // Light blue for selected icons
        unselectedItemColor:  Color(0xFFE3FAF9),  // Optional: for unselected icons
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Connections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Projects',
          ),
        ],
      ),
    );
  }
}