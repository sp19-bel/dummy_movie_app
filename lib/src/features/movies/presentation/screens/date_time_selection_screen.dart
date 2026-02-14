import 'package:flutter/material.dart';
import 'seat_mapping_screen.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final String? movieTitle;
  final String? releaseInfo;

  const DateTimeSelectionScreen({super.key, this.movieTitle, this.releaseInfo});

  @override
  State<DateTimeSelectionScreen> createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  int _selectedDateIndex = 0;
  int _selectedSlotIndex = 0;

  final List<String> _dates = const [
    '5 Mar',
    '6 Mar',
    '7 Mar',
    '8 Mar',
    '9 Mar',
    '10 Mar',
    '11 Mar',
  ];

  final List<Map<String, String>> _timeSlots = const [
    {
      'time': '12:30',
      'hall': 'Cinetech + Hall 1',
      'price': '50\$',
      'bonus': '2500 bonus',
    },
    {
      'time': '13:30',
      'hall': 'Cinetech + Hall 2',
      'price': '75\$',
      'bonus': '3000 bonus',
    },
    {
      'time': '15:00',
      'hall': 'Cinetech + Hall 1',
      'price': '50\$',
      'bonus': '2500 bonus',
    },
    {
      'time': '17:30',
      'hall': 'Cinetech + Hall 3',
      'price': '60\$',
      'bonus': '2800 bonus',
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.movieTitle ?? "The King's Man",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.releaseInfo ?? 'In Theaters December 22, 2021',
              style: const TextStyle(
                color: Color(0xFF61C3F2),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            const Text(
              'Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 14),

            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, i) {
                  final selected = i == _selectedDateIndex;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDateIndex = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF61C3F2)
                              : const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _dates[i],
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _timeSlots.length,
                itemBuilder: (context, i) {
                  final selected = i == _selectedSlotIndex;
                  final slot = _timeSlots[i];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedSlotIndex = i);
                      _navigateToSeatMap(slot);
                    },
                    child: Container(
                      width: 249,
                      height: 145,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF61C3F2),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                            child: Row(
                              children: [
                                Text(
                                  slot['time']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    slot['hall']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: CustomPaint(
                                size: const Size(
                                  double.infinity,
                                  double.infinity,
                                ),
                                painter: _MiniSeatMapPainter(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: 'From '),
                                  TextSpan(
                                    text: slot['price']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: ' or '),
                                  TextSpan(
                                    text: slot['bonus']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  _navigateToSeatMap(_timeSlots[_selectedSlotIndex]),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF61C3F2),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Select Seats',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSeatMap(Map<String, String> slot) {
    final title = widget.movieTitle ?? "The King's Man";
    final date = _dates[_selectedDateIndex];
    final time = slot['time']!;
    final hall = slot['hall']!;

    final hallShort = hall.contains('+') ? hall.split('+').last.trim() : hall;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SeatMappingScreen(
          movieTitle: title,
          releaseDate: '$date, 2021  |  $time $hallShort',
        ),
      ),
    );
  }
}

class _MiniSeatMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // optional screen arc (kept subtle)
    final path = Path();
    path.moveTo(size.width * 0.12, 18);
    path.quadraticBezierTo(size.width * 0.5, -8, size.width * 0.88, 18);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF61C3F2).withOpacity(0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

      
      final double seatSize = 7.0;
      final double gapX = 5.0;
      final double gapY = 7.0;
      final double startY = 28.0;

      
      const int leftCols = 3;
      const int centerCols = 14;
      const int rightCols = 3;
      final double aisleGap = 12.0;

      final int rows = 10; // as requested

      final double blockColsTotal = (leftCols + centerCols + rightCols) * (seatSize + gapX);
      final double totalWidth = blockColsTotal + 2 * aisleGap;
      final double startX = (size.width - totalWidth) / 2;

      // compute block starting x positions
      final double leftStartX = startX;
      final double centerStartX = leftStartX + leftCols * (seatSize + gapX) + aisleGap;
      final double rightStartX = centerStartX + centerCols * (seatSize + gapX) + aisleGap;

     
      for (int row = 0; row < rows; row++) {
       
        for (int col = 0; col < leftCols; col++) {
          final double x = leftStartX + col * (seatSize + gapX);
          final double y = startY + row * (seatSize + gapY);

          final int globalCol = col;
          paint.color = _seatColorFor(row, globalCol);

          canvas.drawRRect(
            RRect.fromRectAndRadius(Rect.fromLTWH(x, y, seatSize, seatSize), const Radius.circular(1.5)),
            paint,
          );
        }

       
        for (int col = 0; col < centerCols; col++) {
          final double x = centerStartX + col * (seatSize + gapX);
          final double y = startY + row * (seatSize + gapY);

          final int globalCol = leftCols + col;
          paint.color = _seatColorFor(row, globalCol);

          canvas.drawRRect(
            RRect.fromRectAndRadius(Rect.fromLTWH(x, y, seatSize, seatSize), const Radius.circular(1.5)),
            paint,
          );
        }

     
        for (int col = 0; col < rightCols; col++) {
          final double x = rightStartX + col * (seatSize + gapX);
          final double y = startY + row * (seatSize + gapY);

          final int globalCol = leftCols + centerCols + col;
          paint.color = _seatColorFor(row, globalCol);

          canvas.drawRRect(
            RRect.fromRectAndRadius(Rect.fromLTWH(x, y, seatSize, seatSize), const Radius.circular(1.5)),
            paint,
          );
        }
      }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Color _seatColorFor(int row, int globalCol) {
  // user palette:
  const accent = Color(0xFF61C3F2); // #61C3F2
  const greyAlpha = Color(0x80A6A6A6); // #A6A6A680 -> 0x80A6A6A6
  const pink = Color(0xFFE26CA5); // #E26CA5
  const teal = Color(0xFF15D2BC); // #15D2BC
  const purple = Color(0xFF564CA3); // #564CA3

  if (row >= 8) return purple; // VIP rows
  if ((row + globalCol) % 7 == 0) return accent;
  if ((row * (globalCol + 1)) % 11 == 0) return teal;
  if (row == 2 && (globalCol == 7 || globalCol == 8)) return pink;
  if ((globalCol - 7).abs() <= 1 && row <= 1) return accent;
  return greyAlpha;
}
