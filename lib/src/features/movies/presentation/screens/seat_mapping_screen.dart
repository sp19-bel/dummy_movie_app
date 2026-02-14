import 'package:flutter/material.dart';

/// Screen 2 – Cinema Seat Selection & Checkout
class SeatMappingScreen extends StatefulWidget {
  final String? movieTitle;
  final String? releaseDate;

  const SeatMappingScreen({
    super.key,
    this.movieTitle,
    this.releaseDate,
  });

  @override
  State<SeatMappingScreen> createState() => _SeatMappingScreenState();
}

class _SeatMappingScreenState extends State<SeatMappingScreen> {
  // ── grid config ──────────────────────────────────────────────────────
  static const int _totalRows = 10;
  static const int _leftBlock = 4;
  static const int _centerBlock = 12;
  static const int _rightBlock = 4;

  final TransformationController _txCtrl = TransformationController();
  final Set<String> _selected = {};

  // Row 3 col 4 pre‑selected for the demo (golden seat in the design)
  @override
  void initState() {
    super.initState();
    _selected.add(_key(3, 4));
  }

  // Rows 9‑10 are VIP
  static final Set<int> _vipRows = {9, 10};

  // Some seats marked as "not available"
  static final Set<String> _unavailable = {
    _key(1, 1), _key(1, 2), _key(1, 3), _key(1, 4), // left block row 1
    _key(1, 17), _key(1, 18), _key(1, 19), _key(1, 20), // right block row 1
    _key(2, 1), _key(2, 2), _key(2, 17), _key(2, 18), _key(2, 19),
    _key(3, 1), _key(3, 2), _key(3, 17), _key(3, 18),
    _key(4, 1), _key(4, 2), _key(4, 3), _key(4, 17), _key(4, 18), _key(4, 19),
    _key(8, 1), _key(8, 2), _key(8, 3), _key(8, 17), _key(8, 18), _key(8, 19),
  };

  static String _key(int row, int col) => '$row-$col';

  @override
  void dispose() {
    _txCtrl.dispose();
    super.dispose();
  }

  // ── zoom helpers ─────────────────────────────────────────────────────
  void _zoom(double factor) {
    final m = _txCtrl.value.clone()..scale(factor, factor);
    _txCtrl.value = m;
  }

  // ── build ────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
              widget.releaseDate ?? 'March 5, 2021  |  12:30 Hall 1',
              style: const TextStyle(
                color: Color(0xFF61C3F2),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ── seat map area ────────────────────────────────────────
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 32),
                    // curved SCREEN label
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: CustomPaint(
                        painter: _ScreenCurvePainter(),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              'SCREEN',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // interactive seat grid
                    Expanded(
                      child: InteractiveViewer(
                        transformationController: _txCtrl,
                        minScale: 0.5,
                        maxScale: 3.0,
                        constrained: false,
                        boundaryMargin: const EdgeInsets.all(80),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _buildGrid(),
                        ),
                      ),
                    ),
                  ],
                ),
                // zoom FABs
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      _fab(Icons.add, () => _zoom(1.2)),
                      const SizedBox(height: 10),
                      _fab(Icons.remove, () => _zoom(0.8)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── bottom sheet / checkout ──────────────────────────────
          _buildBottomSheet(),
        ],
      ),
    );
  }

  // ── grid builder ─────────────────────────────────────────────────────
  Widget _buildGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_totalRows, (ri) {
        final row = ri + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // row number label
              SizedBox(
                width: 18,
                child: Text(
                  '$row',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 4),
              // left block
              ..._seatBlock(row, 1, _leftBlock),
              const SizedBox(width: 14),
              // center block
              ..._seatBlock(row, _leftBlock + 1, _centerBlock),
              const SizedBox(width: 14),
              // right block
              ..._seatBlock(row, _leftBlock + _centerBlock + 1, _rightBlock),
            ],
          ),
        );
      }),
    );
  }

  List<Widget> _seatBlock(int row, int startCol, int count) {
    return List.generate(count, (i) {
      final col = startCol + i;
      final key = _key(row, col);
      final unavail = _unavailable.contains(key);
      final selected = _selected.contains(key);
      final vip = _vipRows.contains(row);

      Color color;
      if (selected) {
        color = const Color(0xFFCD9D0F);
      } else if (unavail) {
        color = const Color(0xFFE8E8E8);
      } else if (vip) {
        color = const Color(0xFF564CA3);
      } else {
        color = const Color(0xFF61C3F2);
      }

      return GestureDetector(
        onTap: unavail
            ? null
            : () => setState(() {
                  selected ? _selected.remove(key) : _selected.add(key);
                }),
        child: Container(
          width: 18,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
      );
    });
  }

  // ── zoom FAB ─────────────────────────────────────────────────────────
  Widget _fab(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  // ── bottom sheet ─────────────────────────────────────────────────────
  Widget _buildBottomSheet() {
    final count = _selected.length;
    // derive a representative row from the first selection
    final selRow =
        _selected.isNotEmpty ? _selected.first.split('-')[0] : '';
    final total = count * 50;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── legend row ──────────────────────────────────────────
            Row(
              children: [
                _legend(const Color(0xFFCD9D0F), 'Selected'),
                const Spacer(),
                _legend(const Color(0xFFE8E8E8), 'Not available'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _legend(const Color(0xFF564CA3), 'VIP (150\$)'),
                const Spacer(),
                _legend(const Color(0xFF61C3F2), 'Regular (50 \$)'),
              ],
            ),

            const SizedBox(height: 18),

            // ── selection chip ──────────────────────────────────────
            if (count > 0)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$count / $selRow row',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() => _selected.clear()),
                        child: const Icon(Icons.close, size: 16),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 18),

            // ── checkout row ────────────────────────────────────────
            Row(
              children: [
                // price block with subtle bg
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$ $total',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: count > 0 ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF61C3F2),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFB0E0F6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Proceed to pay',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── legend item ──────────────────────────────────────────────────────
  Widget _legend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Curved "SCREEN" indicator painter
// ─────────────────────────────────────────────────────────────────────────────
class _ScreenCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBBDDF5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(size.width * 0.12, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * -0.1,
        size.width * 0.88,
        size.height * 0.85,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
