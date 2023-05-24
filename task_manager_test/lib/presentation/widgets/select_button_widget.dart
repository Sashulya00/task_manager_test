import 'package:flutter/material.dart';

class SelectButtonWidget extends StatefulWidget {
  const SelectButtonWidget({
    super.key,
    required this.firstTabTitle,
    required this.secondTabTitle,
    required this.thirdTabTitle,
    // required this.aboutTabBar,
    // required this.onChanged,
    // required this.data,
  });

  // final Object data;
  // final String aboutTabBar;
  final String firstTabTitle;
  final String secondTabTitle;
  final String thirdTabTitle;
  // final void Function(dynamic) onChanged;

  @override
  State<SelectButtonWidget> createState() => _SelectButtonWidgetState();
}

class _SelectButtonWidgetState extends State<SelectButtonWidget> with SingleTickerProviderStateMixin {
  late final TabController controller = TabController(length: 3, vsync: this);
  final circularRadius = BorderRadius.circular(40.0);

  static const countTabs = 3;
  static const fontSize = 16.0;
  static const buttonWeight = 55.0;
  static const heightButton = 72.0;
  static const indicatorWeight = 2.0;
  static const space = SizedBox(height: 14);
  static const spaceInsideButton = EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    // final sexTextProperty = Text(
    //   widget.aboutTabBar,
    //   style: Theme.of(context).textTheme.headline4?.copyWith(
    //     color: Theme.of(context).primaryColor,
    //     fontWeight: FontWeight.w500,
    //     fontSize: fontSize,
    //   ),
    // );
    return Column(
      children: [
        // Align(alignment: Alignment.bottomLeft, child: sexTextProperty),
        space,
        Container(
          height: heightButton,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: circularRadius,
          ),
          child: Column(
            children: [
              Padding(
                padding: spaceInsideButton,
                child: SizedBox(
                  height: buttonWeight,
                  child: DefaultTabController(
                    length: countTabs,
                    child: TabBar(
                      controller: controller,
                      unselectedLabelColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColorLight,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: indicatorWeight,
                      indicator: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: circularRadius,
                      ),
                      tabs: [
                        Tab(
                          child: Text(
                            widget.firstTabTitle,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            widget.secondTabTitle,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            widget.thirdTabTitle,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
