import 'package:flutter/material.dart';

class SeatMappingScreen extends StatefulWidget {
  const SeatMappingScreen({super.key});

  @override
  State<SeatMappingScreen> createState() => _SeatMappingScreenState();
}

class _SeatMappingScreenState extends State<SeatMappingScreen> {
  final int rows = 8;
  final int seatsPerRow = 10;
  final Set<String> selectedSeats = {};
  final Set<String> bookedSeats = {
    'A3', 'A4', 'B7', 'C2', 'C3', 'D5', 'D6', 'E1', 'F8', 'G4', 'G5',
  };

  String _seatLabel(int row, int col) {
    return '${String.fromCharCode(65 + row)}${col + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Seats')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 200,
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[400]!, width: 3),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'SCREEN',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(rows, (row) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          child: Text(
                            String.fromCharCode(65 + row),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ...List.generate(seatsPerRow, (col) {
                          final label = _seatLabel(row, col);
                          final isBooked = bookedSeats.contains(label);
                          final isSelected = selectedSeats.contains(label);

                          return GestureDetector(
                            onTap: isBooked
                                ? null
                                : () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedSeats.remove(label);
                                      } else {
                                        selectedSeats.add(label);
                                      }
                                    });
                                  },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(
                                left: 4,
                                right: col == 4 ? 16 : 4,
                              ),
                              decoration: BoxDecoration(
                                color: isBooked
                                    ? Colors.grey[400]
                                    : isSelected
                                        ? Colors.green
                                        : Colors.blue[100],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                border: Border.all(
                                  color: isBooked
                                      ? Colors.grey
                                      : isSelected
                                          ? Colors.green[700]!
                                          : Colors.blue[300]!,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _legend(Colors.blue[100]!, 'Available'),
                    const SizedBox(width: 16),
                    _legend(Colors.green, 'Selected'),
                    const SizedBox(width: 16),
                    _legend(Colors.grey[400]!, 'Booked'),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  selectedSeats.isEmpty
                      ? 'No seats selected'
                      : 'Selected: ${(selectedSeats.toList()..sort()).join(', ')}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedSeats.isEmpty
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Booked: ${(selectedSeats.toList()..sort()).join(', ')}',
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      selectedSeats.isEmpty
                          ? 'Select Seats'
                          : 'Book ${selectedSeats.length} Seat(s)',
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

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
