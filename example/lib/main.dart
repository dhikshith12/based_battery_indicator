import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:based_battery_indicator/based_battery_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      title: 'Based Dock Scaffold Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Based Battery Indicator',
          ),
        ),
        body: Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'BasedBatteryIndicator',
                        style: TextStyle(fontSize: 18),
                      ),
                      Card(
                        elevation: 2,
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
                                    for (final value
                                        in BasedBatteryStatusType.values)
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
            ),
            const VerticalDivider(width: 0),
            Expanded(
              child: Tooltip(
                message: message,
                child: Center(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
