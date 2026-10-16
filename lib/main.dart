import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const DoroApp());
}

class DoroApp extends StatelessWidget {
  const DoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DORO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecurityLockScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stairs, size: 80, color: Colors.orangeAccent),
            SizedBox(height: 16),
            Text(
              "DORO",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            SizedBox(height: 8),
            Text("Vaqt va Intizom", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// 2. SECURITY LOCK SCREEN
class SecurityLockScreen extends StatefulWidget {
  const SecurityLockScreen({super.key});

  @override
  State<SecurityLockScreen> createState() => _SecurityLockScreenState();
}

class _SecurityLockScreenState extends State<SecurityLockScreen> {
  final TextEditingController _pinController = TextEditingController();

  void _unlock() {
    if (_pinController.text == "1234") { // Misol uchun PIN
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MotivationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Noto'g'ri PIN kod! (Test uchun: 1234)")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xavfsizlik Qulfi")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ilovaga kirish uchun PIN-kodni kiriting", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "PIN (1234)",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _unlock,
              child: const Text("Qulfni ochish"),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. MOTIVATIONAL SCREEN
class MotivationScreen extends StatelessWidget {
  const MotivationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "\"Vaqtni o'ldirma, chunki u seni asta-sekin o'ldiradi. Har bir lahza kelajaging poydevori!\"",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainDashboard()),
                );
              },
              child: const Text("BOSHLASH!", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. MAIN DASHBOARD
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String _timeString = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(milliseconds: 16), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dt) {
    String day = dt.day.toString().padLeft(2, '0');
    String month = dt.month.toString().padLeft(2, '0');
    String year = dt.year.toString();
    String hour = dt.hour.toString().padLeft(2, '0');
    String minute = dt.minute.toString().padLeft(2, '0');
    String second = dt.second.toString().padLeft(2, '0');
    String micro = dt.microsecond.toString().padLeft(6, '0');
    String nano = "000"; // Flutter mikrosekundan pastini simulyatsiya qiladi

    return "$day.$month.$year | $hour:$minute:$second:$micro:$nano";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DORO - Bosh Menyu"),
      ),
      body: Column(
        children: [
          // JONLI VAQT PANELI (Faqat bosh menyuda)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.black54,
            child: Column(
              children: [
                Text(
                  _timeString,
                  style: const TextStyle(fontSize: 14, fontFamily: 'Monospace', color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Vaqt toʻxtamaydi, sen ham toʻxtama!",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.flag, color: Colors.orange),
                    title: const Text("Maqsadlar Bo'limi"),
                    subtitle: const Text("1, 2, 3 yulduzli maqsadlar va boshqaruv"),
                    onTap: () {
                      // Maqsadlar sahifasiga o'tish
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.schedule, color: Colors.blueAccent),
                    title: const Text("Rejalar (Kun tartibi)"),
                    subtitle: const Text("24 soatlik jadvallar va arxiv"),
                    onTap: () {
                      // Rejalar sahifasiga o'tish
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
