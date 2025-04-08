import 'package:flutter/material.dart';
import 'package:goarogya_app/utils/app_theme.dart';

class PeriodTrackerScreen extends StatefulWidget {
  const PeriodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<PeriodTrackerScreen> createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  final List<List<int>> _calendarDays = [
    [0, 0, 0, 0, 1, 2, 3],
    [4, 5, 6, 7, 8, 9, 10],
    [11, 12, 13, 14, 15, 16, 17],
    [18, 19, 20, 21, 22, 23, 24],
    [25, 26, 27, 28, 29, 30, 31],
  ];
  
  final Set<int> _selectedDays = {16, 17, 18, 19};
  final Set<int> _markedDays = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31};
  
  int _currentStep = 7;
  final int _totalSteps = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 6,
              decoration: BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$_currentStep/$_totalSteps',
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When did your last period start?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildMonthCalendar('August'),
              const SizedBox(height: 16),
              _buildMonthCalendar('September', isNextMonth: true),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to next screen or finish
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Finish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthCalendar(String month, {bool isNextMonth = false}) {
    return Column(
      children: [
        Text(
          month,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text('Sun', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Mon', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Tue', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Wed', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Thu', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Fri', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('Sat', style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 8),
        if (!isNextMonth)
          ...List.generate(
            _calendarDays.length,
            (weekIndex) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  7,
                  (dayIndex) {
                    final day = _calendarDays[weekIndex][dayIndex];
                    final bool isSelected = _selectedDays.contains(day);
                    final bool isMarked = _markedDays.contains(day);
                    
                    return _buildDayCell(day, isSelected, isMarked);
                  },
                ),
              ),
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => _buildDayCell(0, false, false, isEmpty: true),
            ),
          ),
      ],
    );
  }

  Widget _buildDayCell(int day, bool isSelected, bool isMarked, {bool isEmpty = false}) {
    if (day == 0 || isEmpty) {
      return const SizedBox(
        width: 36,
        height: 36,
        child: Center(
          child: Text('-'),
        ),
      );
    }
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedDays.contains(day)) {
            _selectedDays.remove(day);
          } else {
            _selectedDays.add(day);
          }
        });
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppTheme.secondaryColor : Colors.transparent,
        ),
        child: Center(
          child: isMarked && !isSelected
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      day.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  day.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : null,
                  ),
                ),
        ),
      ),
    );
  }
}