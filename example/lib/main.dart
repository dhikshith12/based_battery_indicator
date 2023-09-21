import 'package:flutter/material.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark = true;

  void changeThemeMode() => setState(() => _isDark = !_isDark);

  int value = 0;
  double trackHeight = 10;
  double trackAspectRatio = 2;
  Curve curve = Curves.ease;
  Duration duration = const Duration(seconds: 1);
  BasedBatteryStatusType type = BasedBatteryStatusType.normal;

  String get message => '''
BasedBatteryIndicator(
    status: BasedBatteryStatus(
      value: $value,
      type: $type,
    ),
    trackHeight: $trackHeight,
    trackAspectRatio: $trackAspectRatio,
    curve: $curve,
    duration: $duration,
  ),
),''';

  void valueSlider(double v) => setState(() => value = v.toInt());
  void trackHeightSlider(double v) => setState(() => trackHeight = v);
  void trackAspectRatioSlider(double v) => setState(() => trackAspectRatio = v);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Based Battery Indicator Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Based Battery Indicator',
          ),
          actions: [
            IconButton(
              onPressed: changeThemeMode,
              icon: const Icon(
                Icons.color_lens_outlined,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: BasedBatteryIndicator(
                  status: BasedBatteryStatus(
                    value: value,
                    type: type,
                  ),
                  trackHeight: trackHeight,
                  trackAspectRatio: trackAspectRatio,
                  curve: curve,
                  duration: duration,
                ),
              ),
              const Divider(),
              const Text(
                'BasedBatteryIndicator',
                style: TextStyle(fontSize: 18),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('BasedBatteryStatus'),
                      ListTile(
                        leading: const Text('value: '),
                        title: Slider(
                          value: value.toDouble(),
                          min: -5,
                          max: 105,
                          divisions: 110,
                          label: '$value',
                          onChangeStart: valueSlider,
                          onChanged: valueSlider,
                          onChangeEnd: valueSlider,
                        ),
                      ),
                      ListTile(
                        leading: const Text('type: '),
                        title: SegmentedButton<BasedBatteryStatusType>(
                          segments: [
                            for (final value in BasedBatteryStatusType.values)
                              ButtonSegment(
                                value: value,
                                label: Text(value.name),
                              ),
                          ],
                          selected: {type},
                          onSelectionChanged: (p) =>
                              setState(() => type = p.first),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Text('trackHeight: '),
                title: Slider(
                  value: trackHeight,
                  min: 10,
                  max: 100,
                  divisions: 180,
                  label: '$trackHeight',
                  onChangeStart: trackHeightSlider,
                  onChanged: trackHeightSlider,
                  onChangeEnd: trackHeightSlider,
                ),
              ),
              ListTile(
                leading: const Text('trackAspectRatio: '),
                title: Slider(
                  value: trackAspectRatio,
                  min: 1,
                  max: 9,
                  divisions: 16,
                  label: '$trackAspectRatio',
                  onChangeStart: trackAspectRatioSlider,
                  onChanged: trackAspectRatioSlider,
                  onChangeEnd: trackAspectRatioSlider,
                ),
              ),
              const ListTile(
                leading: Text('type: '),
                title: Tooltip(
                  message: 'It\'s can\'t be config here conveniently',
                  child: OutlinedButton(
                    onPressed: null,
                    child: Text('Curves.ease'),
                  ),
                ),
              ),
              const ListTile(
                leading: Text('duration: '),
                title: Tooltip(
                  message: 'It\'s can\'t be config here conveniently',
                  child: OutlinedButton(
                    onPressed: null,
                    child: Text('Duration(seconds: 1)'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
