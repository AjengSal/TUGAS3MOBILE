import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorBMIApp());
}

class KalkulatorBMIApp extends StatelessWidget {
  const KalkulatorBMIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kalkulator BMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const KalkulatorBMIScreen(),
    );
  }
}

class KalkulatorBMIScreen extends StatefulWidget {
  const KalkulatorBMIScreen({super.key});

  @override
  State<KalkulatorBMIScreen> createState() => _KalkulatorBMIScreenState();
}

class _KalkulatorBMIScreenState extends State<KalkulatorBMIScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedGender = "Laki-laki";
  double? _bmiResult;
  String _bmiInterpretation = "Silakan masukkan data Anda!";

  void _hitungBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    setState(() {
      if (weight > 0 && heightInCM > 0) {
        final double heightInM = heightInCM / 100;
        final double bmi = weight / (heightInM * heightInM);
        _bmiResult = bmi;

        if (_selectedGender == "Laki-laki") {
          // Rentang BMI untuk laki-laki
          if (bmi < 18.5) {
            _bmiInterpretation = "Kekurangan berat badan (Pria)";
          } else if (bmi < 24.9) {
            _bmiInterpretation = "Berat badan ideal (Pria)";
          } else if (bmi < 29.9) {
            _bmiInterpretation = "Kelebihan berat badan (Pria)";
          } else {
            _bmiInterpretation = "Obesitas (Pria)";
          }
        } else {
          // Rentang BMI untuk perempuan
          if (bmi < 18.0) {
            _bmiInterpretation = "Kekurangan berat badan (Wanita)";
          } else if (bmi < 24.0) {
            _bmiInterpretation = "Berat badan ideal (Wanita)";
          } else if (bmi < 29.0) {
            _bmiInterpretation = "Kelebihan berat badan (Wanita)";
          } else {
            _bmiInterpretation = "Obesitas (Wanita)";
          }
        }
      } else {
        _bmiResult = null;
        _bmiInterpretation = "Data tidak valid!";
      }
    });
  }

  void _resetForm() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmiResult = null;
      _bmiInterpretation = "Silakan masukkan data Anda!";
      _selectedGender = "Laki-laki";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator BMI"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 10),
            const Text(
              "Hitung BMI (Indeks Massa Tubuh)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Gender selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: "Laki-laki",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                const Text("Laki-laki"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Perempuan",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                const Text("Perempuan"),
              ],
            ),

            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Berat Badan (kg)",
                prefixIcon: Icon(Icons.monitor_weight_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tinggi Badan (cm)",
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _hitungBMI,
                  icon: const Icon(Icons.calculate),
                  label: const Text("Hitung BMI"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _resetForm,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "Hasil",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    _bmiResult?.toStringAsFixed(1) ?? '--',
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bmiInterpretation,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
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