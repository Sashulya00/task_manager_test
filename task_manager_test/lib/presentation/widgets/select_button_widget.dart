import 'package:flutter/material.dart';
import 'package:task_manager_test/presentation/widgets/select_button_tab_widget.dart';

class SelectButtonWidget extends StatefulWidget {
  const SelectButtonWidget({
    super.key,
    required this.firstTabTitle,
    required this.secondTabTitle,
    required this.thirdTabTitle,
    required this.onChanged,
  });

  final String firstTabTitle;
  final String secondTabTitle;
  final String thirdTabTitle;
  final void Function(int) onChanged;

  @override
  State<SelectButtonWidget> createState() => _SelectButtonWidgetState();
}

class _SelectButtonWidgetState extends State<SelectButtonWidget> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  final circularRadius = BorderRadius.circular(40.0);

  static const countTabs = 3;
  static const buttonHeight = 48.0;
  static const widthButton = 106.0;
  static const indicatorWeight = 2.0;
  static const widthButtonPlus = 126.0;
  static const space = SizedBox(height: 18);
  static const enabledColor = Color(0xffFBEFB4);
  static const disabledColor = Color(0xffDBDBDB);
  static const spaceInsideButton = EdgeInsets.all(10);
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 3, vsync: this);
  }

  void onTap(int i) {
    _selectedIndex = i;
    widget.onChanged(i);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        space,
        Container(
          height: widthButton,
          width: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: circularRadius,
          ),
          child: Column(
            children: [
              Padding(
                padding: spaceInsideButton,
                child: SizedBox(
                  height: buttonHeight,
                  child: DefaultTabController(
                    length: countTabs,
                    child: TabBar(
                      controller: _controller,
                      onTap: (selected) => setState(() => _selectedIndex = selected),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.black,
                      indicatorColor: Colors.transparent,
                      indicatorWeight: indicatorWeight,
                      indicator: BoxDecoration(
                        borderRadius: circularRadius,
                      ),
                      tabs: [
                        TabWidget(
                          tabsTitle: widget.firstTabTitle,
                          customWidth: _selectedIndex == 0 ? widthButtonPlus : widthButton,
                          customColor: _selectedIndex == 0 ? enabledColor : disabledColor,
                          onChanged: () => onTap(0),
                        ),
                        TabWidget(
                          tabsTitle: widget.secondTabTitle,
                          customWidth: _selectedIndex == 1 ? widthButtonPlus : widthButton,
                          customColor: _selectedIndex == 1 ? enabledColor : disabledColor,
                          onChanged: () => onTap(1),
                        ),
                        TabWidget(
                          tabsTitle: widget.thirdTabTitle,
                          customWidth: _selectedIndex == 2 ? widthButtonPlus : widthButton,
                          customColor: _selectedIndex == 2 ? enabledColor : disabledColor,
                          onChanged: () => onTap(2),
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
