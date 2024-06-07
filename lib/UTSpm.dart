import 'package:flutter/material.dart';
import "package:counting_sort/profile.dart";


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counting Sort',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountingSortScreen(),
    );
  }
}

class CountingSortScreen extends StatefulWidget {
  @override
  _CountingSortScreenState createState() => _CountingSortScreenState();
}

class _CountingSortScreenState extends State<CountingSortScreen> {
  TextEditingController _inputController = TextEditingController();
  List<int> _arr = [];
  List<List<int>> _sortingSteps = [];
  List<int> _originalData = [];
  bool _isSorted = false;

  void _addData() {
    setState(() {
      if (_inputController.text.isNotEmpty) {
        int newData = int.parse(_inputController.text);
        _arr.add(newData);
        _originalData.add(newData);
        _inputController.clear();
        _isSorted = false;
      }
    });
  }

  void _clearData() {
    setState(() {
      _inputController.clear();
      _arr.clear();
      _sortingSteps.clear();
      _originalData.clear();
      _isSorted = false;
    });
  }

  void _countingSort() {
    setState(() {
      int max = _arr.reduce((value, element) => value > element ? value : element);
      int min = _arr.reduce((value, element) => value < element ? value : element);

      int range = max - min + 1;

      List<int> count = List.filled(range, 0);

      _sortingSteps.add(List.from(_arr));

      for (int i = 0; i < _arr.length; i++) {
        count[_arr[i] - min]++;
      }

      int outputIndex = 0;

      for (int i = 0; i < range; i++) {
        while (count[i] > 0) {
          _arr[outputIndex++] = i + min;
          count[i]--;

          _sortingSteps.add(List.from(_arr));
        }
      }

      _isSorted = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counting Sort'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a number',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addData,
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    primary: Colors.orange,
                  ),
                ),
                ElevatedButton(
                  onPressed: _countingSort,
                  child: Text('Sort'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    primary: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearData,
                  child: Text('Clear Data'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(nama: "Habibi", nim: "223303030226", kelas: "3 TI PAGI A")),
                    );
                  },
                  child: Text('Go to Profile'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Data Awal:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    _originalData.isEmpty
                        ? Text('No data entered', style: TextStyle(fontSize: 14.0))
                        : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _originalData.map((data) {
                        return Container(
                          color: Colors.lightBlue,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            data.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Sorting Steps:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    _sortingSteps.isEmpty
                        ? Text('No sorting steps', style: TextStyle(fontSize: 14.0))
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _sortingSteps.map((step) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.black,width: 2.0)
                          ),
                          child: Text(
                            'Step: ${step.join(', ')}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Data setelah diurutkan:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    _isSorted
                        ? Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _arr.map((data) {
                        return Container(
                          color: Colors.blue,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            data.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                        );
                      }).toList(),
                    )
                        : Text('Data not sorted yet', style: TextStyle(fontSize: 14.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

