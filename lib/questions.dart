import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MovementPage extends StatefulWidget {
  MovementPage({super.key});


  @override
  State<MovementPage> createState() => _MovementPageState();
}



class _MovementPageState extends State<MovementPage>
    with SingleTickerProviderStateMixin {

  // -------- CONDITIONS ANSWERS --------
  String? thyroidAnswer;
  String? cholesterolAnswer;
  String? gastricAnswer;
  String? pcodAnswer;
  String? foodQuality;
  String? eatingSchedule;
  String? fastingHabit;
  String? alcoholHabit;
  String? smokingHabit;
  String? energyLevel;
  String? stressLevel;
  String? sleepQuality;
  String? moodLevel;
  String? hobbyLevel;
  String? tongueColor;
  String? tongueCoating;
  String? tongueMoisture;
  String? tongueCracks;
  String? tongueShape;


  late VideoPlayerController _video;
  // ---------------- STEP ----------------
  int step = 1;

  // ---------------- MOVEMENT ----------------
  double steps = 6200;
  double jogging = 20;
  double running = 15;

  // ---------------- WORKOUT ----------------
  double gym = 30;
  double yoga = 20;

  double stressSlider = 30;   // minutes / level
  double sleepSlider = 7;     // hours

  late TextEditingController stressController;
  late TextEditingController sleepController;

  // ---------------- SPORTS ----------------
  double sports = 30;
  bool sportsTouched = false;
  final Map<String, double> sportsMinutes = {
    'Cricket': 0,
    'Football': 0,
    'Badminton': 0,
    'Basketball': 0,
    'Swimming': 0,
    'Tennis': 0,
    'Throwball': 0,
    'Volleyball': 0,
  };

  double get totalSportsTime {
    return sportsMinutes.values.fold(0, (sum, v) => sum + v);
  }




  final Set<String> selectedSports = {};

  final Map<String, IconData> sportsIcons = {
    'Cricket': Icons.sports_cricket,
    'Football': Icons.sports_soccer,
    'Badminton': Icons.sports_tennis,
    'Basketball': Icons.sports_basketball,
    'Swimming': Icons.pool,
    'Tennis': Icons.sports_tennis,
    'Throwball': Icons.sports_volleyball,
    'Volleyball': Icons.sports_volleyball,
  };


  // ---------------- SUGAR ----------------
  late TextEditingController fastingController;
  late TextEditingController pp1Controller;
  late TextEditingController pp2Controller;
  late TextEditingController pp3Controller;

  // ---------------- CONTROLLERS ----------------
  late TextEditingController stepsController;
  late TextEditingController joggingController;
  late TextEditingController runningController;
  late TextEditingController gymController;
  late TextEditingController yogaController;
  late TextEditingController sportsController;
  late AnimationController _fadeController;
  late TextEditingController systolicController;
  late TextEditingController diastolicController;
  late TextEditingController heartRateController;
  late TextEditingController hemoglobinController;
  // ---------------- VIDEO SELECTOR ----------------
  String get videoAsset {
    switch (step) {
      case 1:
        return 'assets/videos/step2.mp4';

      case 2:
        return 'assets/videos/workout.mp4';
      case 3:
        return 'assets/videos/sports.mp4';
      case 4:
        return 'assets/videos/sugarlevel.mp4';
      case 5:
        return 'assets/videos/vitals.mp4';
      case 6:

        return 'assets/videos/gastric.mp4';
      case 7:
        return 'assets/videos/diet_bg.mp4';
      case 8:
        return 'assets/videos/wellbeing_bg.mp4';
      default:
        return 'assets/videos/tongue.mp4';
    }
  }

  @override
  void initState() {
    super.initState();

    stepsController = TextEditingController(text: steps.round().toString());
    joggingController = TextEditingController(text: jogging.round().toString());
    runningController = TextEditingController(text: running.round().toString());
    gymController = TextEditingController(text: gym.round().toString());
    yogaController = TextEditingController(text: yoga.round().toString());
    sportsController = TextEditingController(text: sports.round().toString());
    stressController = TextEditingController(text: stressSlider.round().toString());
    sleepController  = TextEditingController(text: sleepSlider.round().toString());


    _fadeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));




    fastingController = TextEditingController();
    pp1Controller = TextEditingController();
    pp2Controller = TextEditingController();
    pp3Controller = TextEditingController();
    systolicController = TextEditingController();
    diastolicController = TextEditingController();
    heartRateController = TextEditingController();
    hemoglobinController = TextEditingController();


    _video = VideoPlayerController.asset(videoAsset)
      ..initialize().then((_) {
        _video
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
  }

  void loadVideoForStep() {


    _video.dispose();
    _video = VideoPlayerController.asset(videoAsset)
      ..initialize().then((_) {
        _video
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    stepsController.dispose();
    joggingController.dispose();
    runningController.dispose();
    gymController.dispose();
    yogaController.dispose();
    sportsController.dispose();
    fastingController.dispose();
    pp1Controller.dispose();
    pp2Controller.dispose();
    pp3Controller.dispose();
    systolicController.dispose();
    diastolicController.dispose();
    heartRateController.dispose();
    hemoglobinController.dispose();
    stressController.dispose();
    sleepController.dispose();



    _fadeController.dispose();
    _video.dispose();

    super.dispose();
  }


  Color valueColor(double value, double max) {
    if (value < max * 0.33) return Colors.lightBlueAccent;
    if (value < max * 0.66) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_video.value.isInitialized)
            SizedBox.expand(child: VideoPlayer(_video)),

          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(color: Colors.black.withOpacity(0.45)),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 24),

                Text(
                  step == 1
                      ? 'Tell us about your daily movement'
                      : step == 2
                      ? 'Tell us about your workouts'
                      : step == 3
                      ? 'Tell us about your sports activity'
                      : step == 4
                      ? 'Tell us about your sugar levels'
                      : step == 5
                      ? 'Tell us about your vital readings'
                      : step == 6
                      ? 'Tell us about your health conditions'
                      : step == 7
                       ? 'tell us about your diet'
                       : step == 8
                       ? 'Tell us about your wellbeing'
                      : 'Tell us about your Tongue',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),


                Text(
                  step <= 3
                      ? 'Move each slider to match your routine'
                      : step <= 5
                      ? 'Enter the values if you know them'
                       : 'enter yes or No to know you',
                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 32),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    child: ListView(
                      key: ValueKey(step),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: step == 1
                          ? movementQuestions()
                          : step == 2
                          ? workoutQuestions()
                          : step == 3
                          ? sportsQuestions()
                          : step == 4
                          ? sugarQuestions()
                          :step == 5
                          ? vitalsQuestions()
                          :step == 6
                          ? conditionsQuestions()
                          :step == 7
                           ? dietQuestions()
                           :step == 8

                          ?wellbeingQuestions()
                          : tongueQuestions(),

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5FA8FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        if (step < 9) {
                          setState(() {
                            step++;
                            if (step == 3) {
                              sportsTouched = false;
                              selectedSports.clear();
                              _fadeController.reset(); // ✅ reset animation safely
                            }
                          });
                          loadVideoForStep();
                        }
                      },

                      child: Text(
                        step < 9 ? 'Continue →' : 'Finish →',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- QUESTIONS (UNCHANGED) ----------------

  List<Widget> movementQuestions() => [
    activityCard(
      title: 'walking',
      subtitle: 'How many steps do you usually walk?',
      value: steps,
      max: 30000,
      unit: 'steps',
      controller: stepsController,
      onChanged: (v) {
        setState(() {
          steps = v;
          stepsController.text = v.round().toString();
        });
      },
    ),
    activityCard(
      title: 'Jogging',
      subtitle: 'How long do you usually jog?',
      value: jogging,
      max: 180,
      unit: 'min',
      controller: joggingController,
      onChanged: (v) {
        setState(() {
          jogging = v;
          joggingController.text = v.round().toString();
        });
      },
    ),
    activityCard(
      title: 'Running',
      subtitle: 'How long do you usually run?',
      value: running,
      max: 180,
      unit: 'min',
      controller: runningController,
      onChanged: (v) {
        setState(() {
          running = v;
          runningController.text = v.round().toString();
        });
      },
    ),
  ];

  List<Widget> workoutQuestions() => [
    activityCard(
      title: 'Gym',
      subtitle: 'How long do you usually work out?',
      value: gym,
      max: 180,
      unit: 'min',
      controller: gymController,
      onChanged: (v) {
        setState(() {
          gym = v;
          gymController.text = v.round().toString();
        });
      },
    ),
    activityCard(
      title: 'Yoga',
      subtitle: 'How long do you usually practice yoga?',
      value: yoga,
      max: 180,
      unit: 'min',
      controller: yogaController,
      onChanged: (v) {
        setState(() {
          yoga = v;
          yogaController.text = v.round().toString();
        });
      },
    ),
  ];
  List<Widget> sportsQuestions() {
    final bool hasAnyInput =
    sportsMinutes.values.any((v) => v > 0);

    return [
      ...sportsMinutes.entries.map((entry) {
        return sportMinuteCard(
          title: entry.key,
          icon: sportsIcons[entry.key]!,
          value: entry.value,
          onChanged: (v) {
            setState(() {
              sportsMinutes[entry.key] = v;
            });
          },
        );
      }).toList(),

      if (hasAnyInput)
        sportTotalCard(value: totalSportsTime),
    ];
  }




  Widget sportTotalCard({required double value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.lightBlueAccent),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer, color: Colors.white),
          const SizedBox(width: 8),
          const Text(
            'Total Sports Time',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            '${value.round()} min',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> sugarQuestions() => [sugarLevelCard()];

  Widget sugarLevelCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Blood Sugar Levels (mg/dL)',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          sugarRow('Fasting (12 hour)', 'Before food', fastingController),
          sugarRow('After breakfast (2 hour)', 'PP1', pp1Controller),
          sugarRow('After lunch (2 hours)', 'PP2 • Recommended',
              pp2Controller, highlight: true),
          sugarRow('After dinner (1 hours)', 'PP3', pp3Controller),
        ],
      ),
    );
  }

  Widget sugarRow(
      String title,
      String subtitle,
      TextEditingController controller, {
        bool highlight = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        highlight ? FontWeight.w600 : FontWeight.w500)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                    const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Container(
            width: 110,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: highlight
                  ? Colors.greenAccent.withOpacity(0.25)
                  : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  color:
                  highlight ? Colors.greenAccent : Colors.white24),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                suffixText: ' mg/dL',
                suffixStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  List<Widget> vitalsQuestions() => [

    // -------- SCREEN LEVEL TEXT --------
    const SizedBox(height: 8),



    const SizedBox(height: 8),

    const Text(
      'If you’re unsure, it’s okay to leave any field blank.',
      style: TextStyle(
        color: Colors.white60,
        fontSize: 13,
      ),
      textAlign: TextAlign.center,
    ),

    const SizedBox(height: 24),

    // -------- BLOOD PRESSURE CARD --------
    vitalsCard(
      icon: Icons.monitor_heart,
      title: 'Blood Pressure',
      subtitle: 'When was the last time you checked your blood pressure?',
      child: Row(
        children: [
          vitalsField(systolicController, '120'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('/', style: TextStyle(color: Colors.white)),
          ),
          vitalsField(diastolicController, '80'),
          const SizedBox(width: 8),
          const Text('mmHg', style: TextStyle(color: Colors.white70)),
        ],
      ),
    ),

    // -------- HEART RATE CARD --------
    vitalsCard(
      icon: Icons.favorite,
      title: 'Heart Rate',
      subtitle: 'Do you know your usual resting heart rate?',
      child: vitalsBigField(heartRateController, '72', 'bpm'),
    ),

    // -------- HEMOGLOBIN CARD --------
    vitalsCard(
      icon: Icons.bloodtype,
      title: 'Hemoglobin',
      subtitle: 'Have you had a recent blood test?',
      child: vitalsBigField(hemoglobinController, '13.5', 'g/dL'),
    ),
  ];



  Widget vitalsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget vitalsField(TextEditingController c, String hint) {
    return SizedBox(
      width: 70,
      height: 44,
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget vitalsBigField(
      TextEditingController c, String hint, String unit) {
    return SizedBox(
      width: 130,
      height: 44,
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          suffixText: ' $unit',
          suffixStyle: const TextStyle(color: Colors.white70),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
  List<Widget> conditionsQuestions() => [

    // -------- SCREEN LEVEL TEXT --------


    const SizedBox(height: 8),

    const Text(
      'You can skip anything you’re unsure about.',
      style: TextStyle(color: Colors.white60, fontSize: 13),
      textAlign: TextAlign.center,
    ),

    const SizedBox(height: 24),

    // -------- THYROID --------
    conditionCard(
      title: 'Thyroid',
      question: 'Have you ever been told you have a thyroid condition?',
      value: thyroidAnswer,
      onChanged: (v) => setState(() => thyroidAnswer = v),
    ),

    // -------- CHOLESTEROL --------
    conditionCard(
      title: 'Cholesterol',
      question: 'Have you ever had high cholesterol levels?',
      value: cholesterolAnswer,
      onChanged: (v) => setState(() => cholesterolAnswer = v),
    ),

    // -------- GASTRIC --------
    conditionCard(
      title: 'Digestion / Gastric',
      question: 'Do you often experience acidity or stomach discomfort?',
      value: gastricAnswer,
      onChanged: (v) => setState(() => gastricAnswer = v),
    ),

    // -------- PCOD --------
    conditionCard(
      title: 'PCOD / PCOS',
      question: 'Have you been diagnosed with PCOD or PCOS?',
      value: pcodAnswer,
      onChanged: (v) => setState(() => pcodAnswer = v),
      helper: 'This applies only if relevant to you',
    ),
  ];
  Widget conditionCard({
    required String title,
    required String question,
    required String? value,
    required ValueChanged<String> onChanged,
    String? helper,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(question, style: const TextStyle(color: Colors.white70)),

          if (helper != null) ...[
            const SizedBox(height: 4),
            Text(
              helper,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],

          const SizedBox(height: 14),

          Row(
            children: [
              choiceChip('Yes', value, onChanged),
              const SizedBox(width: 8),
              choiceChip('No', value, onChanged),
              const SizedBox(width: 8),
              choiceChip('Not sure', value, onChanged),
            ],
          ),
        ],
      ),
    );
  }

  Widget choiceChip(
      String label,
      String? selected,
      ValueChanged<String> onTap,
      ) {
    final bool isSelected = selected == label;

    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.lightBlueAccent.withOpacity(0.35)
              : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? Colors.lightBlueAccent
                : Colors.white24,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
  List<Widget> dietQuestions() => [


    const Text(
      'This helps us understand your daily nutrition and lifestyle habits',
      style: TextStyle(color: Colors.white70),
      textAlign: TextAlign.center,
    ),

    const SizedBox(height: 24),

    // 🍽 Food Quality
    dietCard(
      icon: Icons.restaurant,
      title: 'Food Quality',
      question:
      'How would you describe the overall quality of your daily meals?',
      options: const ['Poor', 'Average', 'Good', 'Excellent'],
      value: foodQuality,
      onChanged: (v) => setState(() => foodQuality = v),
    ),

    // ⏰ Eating Schedule
    dietCard(
      icon: Icons.schedule,
      title: 'Eating Schedule',
      question: 'How regular is your daily meal timing?',
      options: const ['Regular', 'Somewhat regular', 'Irregular'],
      value: eatingSchedule,
      onChanged: (v) => setState(() => eatingSchedule = v),
    ),

    // ⏳ Fasting Habits
    dietCard(
      icon: Icons.timelapse,
      title: 'Fasting Habits',
      question: 'Do you practice fasting as part of your routine?',
      options: const ['No', 'Occasionally', 'Yes'],
      value: fastingHabit,
      onChanged: (v) => setState(() => fastingHabit = v),
    ),

    // 🍺 Alcohol
    dietCard(
      icon: Icons.local_bar,
      title: 'Alcohol Consumption',
      question: 'Do you consume alcohol?',
      options: const ['No', 'Occasionally', 'Yes'],
      value: alcoholHabit,
      onChanged: (v) => setState(() => alcoholHabit = v),
    ),

    // 🚬 Smoking
    dietCard(
      icon: Icons.smoking_rooms,
      title: 'Smoking',
      question: 'Do you smoke or use tobacco products?',
      options: const ['No', 'Occasionally', 'Yes'],
      value: smokingHabit,
      onChanged: (v) => setState(() => smokingHabit = v),
    ),
  ];
  Widget dietCard({
    required IconData icon,
    required String title,
    required String question,
    required List<String> options,
    required String? value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(question, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options
                .map((o) => dietChip(o, value, onChanged))
                .toList(),
          ),
        ],
      ),
    );
  }
  Widget dietChip(
      String label,
      String? selected,
      ValueChanged<String> onTap,
      ) {
    final bool isSelected = selected == label;

    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.lightBlueAccent.withOpacity(0.35)
              : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.lightBlueAccent : Colors.white24,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
  List<Widget> wellbeingQuestions() => [

    const SizedBox(height: 8),

    const Text(
      'This helps us understand how you feel day to day',
      style: TextStyle(color: Colors.white70),
      textAlign: TextAlign.center,
    ),

    const SizedBox(height: 24),

    // ✅ ENERGY (options – SAME AS BEFORE)
    wellbeingCard(
      icon: Icons.battery_charging_full,
      title: 'Energy Levels',
      question: 'How would you describe your energy most days?',
      options: const ['Very low', 'Low', 'Moderate', 'High'],
      emojiMap: const {
        'Very low': '😔',
        'Low': '😐',
        'Moderate': '🙂',
        'High': '😄',
      },
      value: energyLevel,
      onChanged: (v) => setState(() => energyLevel = v),
    ),

    // ✅ STRESS (SLIDER STYLE)
    activityCard(
      title: 'Stress Level',
      subtitle: 'How stressed do you feel most days?',
      value: stressSlider,
      max: 100,
      unit: '%',
      controller: stressController,
      onChanged: (v) {
        setState(() {
          stressSlider = v;
          stressController.text = v.round().toString();
        });
      },
    ),

    // ✅ SLEEP (SLIDER STYLE)
    activityCard(
      title: 'Sleep Quality',
      subtitle: 'How many hours do you sleep on average?',
      value: sleepSlider,
      max: 12,
      unit: 'hrs',
      controller: sleepController,
      onChanged: (v) {
        setState(() {
          sleepSlider = v;
          sleepController.text = v.round().toString();
        });
      },
    ),

    // ✅ MOOD (options – SAME)
    wellbeingCard(
      icon: Icons.mood,
      title: 'Overall Mood',
      question: 'How has your mood been lately?',
      options: const ['Low', 'Neutral', 'Good', 'Very positive'],
      emojiMap: const {
        'Low': '😞',
        'Neutral': '😐',
        'Good': '🙂',
        'Very positive': '😄',
      },
      value: moodLevel,
      onChanged: (v) => setState(() => moodLevel = v),
    ),

    // ✅ HOBBIES (options – SAME)
    wellbeingCard(
      icon: Icons.interests,
      title: 'Hobbies & Skills',
      question: 'How often do you spend time on hobbies you enjoy?',
      options: const ['Rarely', 'Sometimes', 'Often', 'Very often'],
      emojiMap: const {
        'Rarely': '😕',
        'Sometimes': '🙂',
        'Often': '😄',
        'Very often': '🤩',
      },
      value: hobbyLevel,
      onChanged: (v) => setState(() => hobbyLevel = v),
    ),
  ];

  Widget wellbeingCard({
    required IconData icon,
    required String title,
    required String question,
    required List<String> options,
    required Map<String, String> emojiMap,
    required String? value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 ICON + TITLE
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // 🔹 QUESTION
          Text(question, style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 14),

          // 🔹 EMOJI (ONLY AFTER SELECTION)
          if (value != null)
            AnimatedSlide(
              offset: const Offset(0, -0.15),
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1,
                child: Text(
                  emojiMap[value] ?? '',
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),

          const SizedBox(height: 12),

          // 🔹 OPTIONS
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((o) {
              final bool selected = value == o;

              return GestureDetector(
                onTap: () => onChanged(o),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.lightBlueAccent.withOpacity(0.35)
                        : Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? Colors.lightBlueAccent
                          : Colors.white24,
                    ),
                  ),
                  child: Text(
                    o,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  List<Widget> tongueQuestions() => [

    const SizedBox(height: 8),



    const Text(
      'You can skip this if you’re unsure.',
      style: TextStyle(color: Colors.white60, fontSize: 13),
      textAlign: TextAlign.center,
    ),

    const SizedBox(height: 24),

    // 👅 Tongue Color
    selectionCard(
      icon: Icons.face,
      title: 'Tongue Color',
      question: 'How does your tongue usually look?',
      options: const ['Pink', 'Pale', 'Red', 'Yellowish', 'Whitish'],
      value: tongueColor,
      onChanged: (v) => setState(() => tongueColor = v),
    ),

    // 🧼 Tongue Coating
    selectionCard(
      icon: Icons.cleaning_services,
      title: 'Tongue Coating',
      question: 'Do you notice any coating on your tongue?',
      options: const ['None', 'Thin white', 'Thick white', 'Yellow'],
      value: tongueCoating,
      onChanged: (v) => setState(() => tongueCoating = v),
    ),

    // 💧 Tongue Moisture
    selectionCard(
      icon: Icons.water_drop,
      title: 'Moisture',
      question: 'Does your tongue feel dry?',
      options: const ['No', 'Sometimes', 'Often'],
      value: tongueMoisture,
      onChanged: (v) => setState(() => tongueMoisture = v),
    ),

    // 🧩 Tongue Cracks
    selectionCard(
      icon: Icons.broken_image_outlined,
      title: 'Cracks',
      question: 'Do you notice any cracks on your tongue?',
      options: const ['None', 'Mild', 'Deep'],
      value: tongueCracks,
      onChanged: (v) => setState(() => tongueCracks = v),
    ),

    // 👄 Tongue Shape
    selectionCard(
      icon: Icons.crop_free,
      title: 'Tongue Shape',
      question: 'How would you describe the shape of your tongue?',
      options: const ['Normal', 'Swollen', 'Thin', 'Scalloped'],
      value: tongueShape,
      onChanged: (v) => setState(() => tongueShape = v),
    ),
  ];
  Widget selectionCard({
    required IconData icon,
    required String title,
    required String question,
    required List<String> options,
    required String? value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(question, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((o) {
              final selected = value == o;
              return GestureDetector(
                onTap: () => onChanged(o),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.lightBlueAccent.withOpacity(0.35)
                        : Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? Colors.lightBlueAccent
                          : Colors.white24,
                    ),
                  ),
                  child: Text(
                    o,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  Widget sportMinuteCard({
    required String title,
    required IconData icon,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${value.round()} min',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Slider(
            min: 0,
            max: 60,
            divisions: 60,
            value: value,
            onChanged: onChanged,
            activeColor: Colors.lightBlueAccent,
            inactiveColor: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget activityCard({
    required String title,
    required String subtitle,
    required double value,
    required double max,
    required String unit,
    required TextEditingController controller,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Slider(
                  min: 0,
                  max: max,
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.lightBlueAccent,
                  inactiveColor: Colors.white24,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 130,
                height: 44,
                padding:
                const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color:
                  valueColor(value, max).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: valueColor(value, max),
                    width: 1.2,
                  ),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10),
                    suffixText: ' $unit',
                    suffixStyle:
                    const TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  onSubmitted: (text) {
                    final double typed =
                        double.tryParse(text) ?? value;
                    final double safe =
                    typed.clamp(0, max).toDouble();
                    controller.text =
                        safe.round().toString();
                    onChanged(safe);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}


