import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:image_picker/image_picker.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Battery _battery = Battery();
  int _batteryLevel = 100;
  bool _isOverheating = false;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
    _checkBatteryAndNotify();
  }

  Future<void> _getBatteryLevel() async {
    final int batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });

    if (batteryLevel <= 30) {
      _triggerBatterySaver();
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Logika untuk memproses gambar
      print('Image path: ${image.path}');
    }
  }

  void _triggerBatterySaver() {
    // Logika untuk mengaktifkan mode hemat daya
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Battery Saver Triggered'),
        content: Text(
            'Your battery level is low. Battery Saver has been activated.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _scanForBlurryImages() {
    // Simulasi logika pemindai foto buram
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Blurry Image Scanner'),
        content: Text('Blurry images found: 3. Would you like to delete them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Logika penghapusan foto buram
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Successful'),
                  content: Text('The blurry images have been deleted.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _checkBatteryAndNotify() {
    if (_batteryLevel <= 10) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Low Battery Warning'),
          content:
              Text('Your battery is below 10%. Please charge your device.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Battery Level: $_batteryLevel%',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: Text('Refresh Battery Level'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _triggerBatterySaver,
              child: Text('Trigger Battery Saver Manually'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logika untuk pembersihan cache
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Cache Cleaner'),
                    content: Text('Cache has been cleaned successfully.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Clean Cache and Junk'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logika untuk reset pabrik
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Factory Reset'),
                    content: Text(
                        'This will reset your device to factory settings. Proceed?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Panggil metode untuk reset pabrik
                          Navigator.of(context).pop();
                        },
                        child: Text('Proceed'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Force Reset Factory'),
            ),
            ElevatedButton(
              onPressed: _scanForBlurryImages,
              child: Text('Scan for Blurry Images'),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: _showThemeRecommendations,
              child: Text('Show Recommended Themes'),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> themeList = [
    'Theme 1 - Dark Mode',
    'Theme 2 - Nature',
    'Theme 3 - Minimalistic',
    'Theme 4 - Abstract'
  ];
  void _showThemeRecommendations() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Recommended Themes'),
          content: Container(
            height: 150, // Sesuaikan ukuran sesuai kebutuhan
            child: ListView.builder(
              itemCount: themeList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(themeList[index]),
                  onTap: () {
                    Navigator.of(context).pop();
                    _applyTheme(themeList[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _applyTheme(String theme) {
    // Logika penerapan tema (simulasi)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Applying Theme'),
        content: Text('$theme is being applied.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPreview(String theme) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Column(
        children: [
          Text(
            theme,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 100,
            color: theme == 'Theme 1 - Dark Mode'
                ? Colors.black
                : Colors.blueAccent, // Simulasi warna tema
          ),
          Column(
            children: themeList
                .map((theme) => _buildBackgroundPreview(theme))
                .toList(),
          ),
        ],
      ),
    );
  }
}
