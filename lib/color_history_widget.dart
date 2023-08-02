import 'package:color_generator/home_page.dart';
import 'package:flutter/material.dart';

/// This widget displays the history of colors generated.
class ColorHistoryWidget extends StatelessWidget {
  /// Creates the ColorHistoryWidget widget
  const ColorHistoryWidget({
    required this.colorHistories,
    super.key,
  });

  /// holds the history of colors
  final List<Color> colorHistories;

  @override
  Widget build(BuildContext context) {
    const double colorHistoryWidgetRadius = 20.0;
    const double colorHistoryItemHeight = 60;
    const double colorHistoryWidgetHeightFactor = 0.75;

    return Container(
      height:
          MediaQuery.of(context).size.height * colorHistoryWidgetHeightFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(colorHistoryWidgetRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Builder(
            builder: (_) {
              return colorHistories.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Text(
                          'No Color History',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    )
                  : Flexible(
                      child: ListView.builder(
                        itemCount: colorHistories.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop(colorHistories[index]);
                            },
                            child: Container(
                              color: colorHistories[index],
                              height: colorHistoryItemHeight,
                              alignment: Alignment.center,
                              child: Text(
                                _getRGBValue(colorHistories[index]),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: getTextColor(
                                        colorHistories[index],
                                      ),
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          )
        ],
      ),
    );
  }

  String _getRGBValue(Color color) {
    return 'RGB(${color.red}, ${color.green}, ${color.blue})';
  }
}
