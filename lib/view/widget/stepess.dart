import 'package:dalile_customer/constants.dart';
import 'package:dalile_customer/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class StepProgressView extends StatelessWidget {
  final List<String> _icons;

  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor = whiteColor;
  final double lineWidth = 3.0;

  const StepProgressView(
      {Key? key,
      required List<String> icons,
      required int curStep,
      required Color color})
      : _icons = icons,
        _curStep = curStep,
        _activeColor = color,
        assert(curStep > -1 && curStep <= icons.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _iconViews(),
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _icons.asMap().forEach((i, icon) {
      //colors according to state
      var circleColor = _curStep == 0
          ? _inactiveColor
          : (i == 0 || _curStep > i)
              ? _activeColor
              : _inactiveColor;

      var lineColor =
          _curStep > i + 1 ? primaryColor : text1Color.withOpacity(0.2);

      var iconColor = _curStep == 0
          ? _activeColor
          : (i == 0 || _curStep > i)
              ? _inactiveColor
              : _activeColor;

      list.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Container(
            width: 35.0,
            height: 35.0,
            padding: const EdgeInsets.all(8),
            child: _icons.isEmpty
                ? Image.asset(
                    'assets/images/dalilee.png',
                    color: iconColor,
                    height: 1,
                    width: 1,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    icon,
                    color: iconColor,
                    height: 1,
                    width: 1,
                    fit: BoxFit.fill,
                  ),
            decoration: BoxDecoration(
              color: circleColor,
              borderRadius: const BorderRadius.all(Radius.circular(90.0)),
              border: Border.all(
                color: _activeColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      );

      //line between icons
      if (i != _icons.length - 1) {
        list.add(Expanded(
            child: _curStep > i + 1
                ? Container(
                    height: lineWidth,
                    color: lineColor,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        alignment: Alignment.center,
                        text: '-',
                        color: text1Color.withOpacity(0.4),
                      ),
                      CustomText(
                        alignment: Alignment.center,
                        text: '-',
                        color: text1Color.withOpacity(0.4),
                      ),
                    ],
                  )));
      }
    });

    return list;
  }
}
