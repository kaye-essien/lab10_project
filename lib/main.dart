import 'package:flutter/material.dart';
import 'logic/split.dart';

void main() => runApp(const SplitApp());

class SplitApp extends StatelessWidget {
  const SplitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chop Bar Split',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const SplitPage(),
    );
  }
}

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  final _total = TextEditingController();
  int _people = 2;
  double _tipPercent = 0; // Exercise 3: Tip percentage (0%, 5%, 10%)
  String _result = 'Enter the bill total';

  void _calculate() {
    final total = double.tryParse(_total.text.trim());
    setState(() {
      if (total == null || total <= 0) {
        _result = 'Please enter a valid amount';
      } else {
        final share =
            shareOf(total, _people, tipPercent: _tipPercent).toStringAsFixed(2);
        _result = 'Each person pays GHS $share';
      }
    });
  }

  @override
  void dispose() {
    _total.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chop Bar Split')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _total,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bill total (GHS)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Exercise 3: Tip option (0%, 5%, 10%) using SegmentedButton
            SegmentedButton<double>(
              segments: const [
                ButtonSegment<double>(value: 0, label: Text('0% tip')),
                ButtonSegment<double>(value: 5, label: Text('5% tip')),
                ButtonSegment<double>(value: 10, label: Text('10% tip')),
              ],
              selected: {_tipPercent},
              onSelectionChanged: (selection) {
                setState(() => _tipPercent = selection.first);
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      _people > 1 ? () => setState(() => _people--) : null,
                ),
                Text(
                  '$_people people',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _people++),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _calculate,
              child: const Text('Split'),
            ),
            const SizedBox(height: 24),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}