import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/models/property.dart';
import '../../widgets/property_card.dart';
import '../../widgets/primary_button.dart';

class BookingScreen extends StatefulWidget {
  final Property property;
  const BookingScreen({super.key, required this.property});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  int _selectedTimeIndex = 0;
  bool _submitted = false;

  final _times = const [
    '9:00 AM',
    '10:30 AM',
    '12:00 PM',
    '2:00 PM',
    '3:30 PM',
    '5:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final p = widget.property;

    if (_submitted) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle,
                      color: AppColors.primary, size: 56),
                ),
                const SizedBox(height: 24),
                const Text('Tour Booked!',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(
                  'Your tour for "${p.title}" is confirmed for '
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} '
                  'at ${_times[_selectedTimeIndex]}.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.textSecondary, height: 1.5),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Back to Home',
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text('Book a Tour',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    PropertyImage(url: p.image, height: 60, width: 70),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(p.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Select Date',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              SizedBox(
                height: 78,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 14,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final date = DateTime.now().add(Duration(days: i + 1));
                    final sel = date.day == _selectedDate.day &&
                        date.month == _selectedDate.month;
                    const days = [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun'
                    ];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        width: 56,
                        decoration: BoxDecoration(
                          color: sel ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color:
                                  sel ? AppColors.primary : AppColors.border),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(days[date.weekday - 1],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: sel
                                        ? Colors.white
                                        : AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            Text('${date.day}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: sel
                                        ? Colors.white
                                        : AppColors.textPrimary)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text('Select Time',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_times.length, (i) {
                  final sel = _selectedTimeIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTimeIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.primaryLight : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: sel ? AppColors.primary : AppColors.border),
                      ),
                      child: Text(_times[i],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: sel
                                  ? AppColors.primary
                                  : AppColors.textPrimary)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Confirm Booking',
                onPressed: () => setState(() => _submitted = true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
