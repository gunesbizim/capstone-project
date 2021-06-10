import 'dart:math' as _math;

import 'package:capstone_project/core/constants/values/date_time_constants.dart';
import 'package:capstone_project/core/enums/joystick_type.dart';
import 'package:capstone_project/views/flight_controller/view_model/flight_controller_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/log/flightlog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'circle_view.dart';

typedef JoystickDirectionCallback = void Function(
    double degrees, double distance);
typedef Repositioner = Offset Function(Offset localTapPoint);

class JoystickViewUpdated extends StatelessWidget {
  /// The size of the joystick.
  ///
  /// Defaults to half of the width in the portrait
  /// or half of the height in the landscape mode
  final double? size;

  /// Color of the icons
  ///
  /// Defaults to [Colors.white54]
  final Color iconsColor;

  /// Color of the joystick background
  ///
  /// Defaults to [Colors.blueGrey]
  final Color backgroundColor;

  /// Color of the inner (smaller) circle background
  ///
  /// Defaults to [Colors.blueGrey]
  final Color innerCircleColor;

  /// Opacity of the joystick
  ///
  /// The opacity applies to the whole joystick including icons
  ///
  /// Defaults to [null] which means there will be no [Opacity] widget used
  late double? opacity;

  /// Callback to be called when user pans the joystick
  ///
  /// Defaults to [null]
  final JoystickDirectionCallback? onDirectionChanged;

  /// Indicates how often the [onDirectionChanged] should be called.
  ///
  /// Defaults to [null] which means there will be no lower limit.
  /// Setting it to ie. 1 second will cause the callback to be not called more often
  /// than once per second.
  ///
  /// The exception is the [onDirectionChanged] callback being called
  /// on the [onPanStart] and [onPanEnd] callbacks. It will be called immediately.
  final Duration? interval;

  /// Shows top/right/bottom/left arrows on top of Joystick
  ///
  /// Defaults to [true]
  final bool showArrows;

  final FlightControllerViewModel flightControllerViewModel;
  late final Repositioner repositioner;
  late Offset _initializedXY;
  late final Offset _sizeXY;
  late final Offset _midSizeXY;
  late final double  _actualSize;
  late final double _innerCircleSize;
  final JoystickType joystickType;
  JoystickViewUpdated(
      {this.size,
      this.iconsColor = Colors.white54,
      this.backgroundColor = Colors.blueGrey,
      this.innerCircleColor = Colors.blueGrey,
      this.opacity,
      this.onDirectionChanged,
      this.interval,
      this.showArrows = true,
      required this.flightControllerViewModel,
      required this.joystickType
      });

  void init(){
    _actualSize = size!;
    _innerCircleSize = _actualSize / 2;
    
    // innerCircleSize = _actualSize / 2;
    _sizeXY = Offset(_actualSize,_actualSize);
    _midSizeXY = Offset(_innerCircleSize,_innerCircleSize);
    if(joystickType == JoystickType.Movement){
      repositioner = flightControllerViewModel.setPositionLeft; 
    }else{
      repositioner = flightControllerViewModel.setPositionRight; 
    }
  }
  @override
  Widget build(BuildContext context) {
    print("JoystickViewUpdated: build");
    Offset lastPosition = Offset(_innerCircleSize, _innerCircleSize);
    Offset joystickInnerPosition = _calculatePositionOfInnerCircle(
        lastPosition, _innerCircleSize, _actualSize, Offset(0, 0));

    DateTime? _callbackTimestamp = DateTimeConstants.timeCheck;
    MediaQueryData queryData = MediaQuery.of(context);
    double screenHeight = queryData.size.height;
    double screenWidth = queryData.size.width/3;

    print("screenHeight: $screenHeight");
    return Center(
        child: StatefulBuilder(
          builder: (context, setState) {
            Widget joystick = _buildJoystickStack(_actualSize, joystickInnerPosition);

            return GestureDetector(
              onPanStart: (details) {
                opacity = 1;
                //RenderBox renderBox = context.findRenderObject() as RenderBox;
                _initializedXY = repositioner(details.localPosition);
                Offset trueXY = _initializedXY - _sizeXY;
                Offset initializedInnerXY = details.localPosition;
                Offset trueMidXY =  initializedInnerXY- _midSizeXY;
                Offset absoluteXY = trueMidXY - trueXY;
                

                //Offset trueLocal = initializedOffset-details.localPosition;
                // print("********On Pan Start********");
                // print("##onPanStart: initializedXY $initializedXY");
                // print("##onPanStart: sizeXY $sizeXY");
                // print("##onPanStart: trueXY $trueXY");
                // print("-----------------------------");
                // print("##onPanStart: initializedInnerXY  $initializedInnerXY");
                // print("##onPanStart: midSizeXY $midSizeXY");
                // print("##onPanStart: trueMidXY $trueMidXY");
                // print("-----------------------------");
                // print("##onPanStart: trueMidXY $trueMidXY");
                // print("##onPanStart: trueXY $trueXY");
                // print("##onPanStart: absoluteXY $absoluteXY");
                // print("##onPanStart: details.local  ${details.localPosition}");
                // print("##onPanStart: lastPostion $lastPosition");

                _callbackTimestamp = _processGesture(_actualSize, _actualSize / 2,
                    absoluteXY,//details.localPosition,
                     _callbackTimestamp!);

                setState(() => lastPosition = absoluteXY);
              },
             
              onPanUpdate: (details) {
                Offset trueXY = _initializedXY - _sizeXY;
                Offset initializedInnerXY = details.localPosition;
                Offset trueMidXY =  initializedInnerXY - _midSizeXY;
                Offset absoluteXY = trueMidXY - trueXY;
                //Offset trueLocal = initializedOffset-details.localPosition;
                // print("********On Pan Update********");
                // print("##onPanUpdate: initializedXY $initializedXY");
                // print("##onPanUpdate: sizeXY $sizeXY");
                // print("##onPanUpdate: trueXY $trueXY");
                // print("-----------------------------");
                // print("##onPanUpdate: initializedInnerXY  $initializedInnerXY");
                // print("##onPanUpdate: midSizeXY $midSizeXY");
                // print("##onPanUpdate: trueMidXY $trueMidXY");
                // print("-----------------------------");
                // print("##onPanUpdate: trueMidXY $trueMidXY");
                // print("##onPanUpdate: trueXY $trueXY");
                // print("##onPanUpdate: absoluteXY $absoluteXY");
                _callbackTimestamp = _processGesture(_actualSize, _actualSize / 2,
                   absoluteXY, _callbackTimestamp!);
                
                joystickInnerPosition = _calculatePositionOfInnerCircle(
                    lastPosition,
                    _innerCircleSize,
                    _actualSize,
                    absoluteXY);

                //print("##onPanUpdate: joystickInnerPosition $joystickInnerPosition");

                setState(() => lastPosition = absoluteXY);
              },
               onPanEnd: (details) {
                 opacity = 0.25;
                _callbackTimestamp = DateTimeConstants.timeCheck;
                if (onDirectionChanged != null) {
                  onDirectionChanged!(0, 0);
                }
                joystickInnerPosition = _calculatePositionOfInnerCircle(
                    Offset(_innerCircleSize, _innerCircleSize),
                    _innerCircleSize,
                    _actualSize,
                    Offset(0, 0));
                setState(() =>
                    lastPosition = Offset(_innerCircleSize, _innerCircleSize));
              },

              child: Stack(children: [
                      Container(
                        padding: EdgeInsets.all(25),
                        height: screenHeight,
                        width: screenWidth,
                        decoration: BoxDecoration(color: Colors.red[900]!.withOpacity(0.1)),
                      ),
                      Observer(builder: (_){
                        if(joystickType == JoystickType.Movement)
                          return Positioned(
                                  top: flightControllerViewModel.leftY-_actualSize/2,
                                  left: flightControllerViewModel.leftX-_actualSize/2,
                                  //child:OverflowBox(
                                    child: Opacity(
                                      opacity: opacity==null? 1: opacity!,
                                      child: joystick
                              ),
                            );
                        else
                           return Positioned(
                                  top: flightControllerViewModel.rightY-_actualSize/2,
                                  left: flightControllerViewModel.rightX-_actualSize/2,
                                  //child:OverflowBox(
                                    child: Opacity(
                                      opacity: opacity==null? 1: opacity!,
                                      child: joystick 
                              ),
                            );
                       // );
                      }),
                    ], 
                    clipBehavior: Clip.none,
                  )
              
            );
          },
        ),
      );
  }

  Stack _buildJoystickStack(double actualSize, Offset joystickInnerPosition) {
    return Stack(
      children: <Widget>[
        CircleView.joystickCircle(
          actualSize,
          backgroundColor,
        ),
        Positioned(
          child: CircleView.joystickInnerCircle(
            actualSize / 2,
            innerCircleColor,
          ),
          top: joystickInnerPosition.dy,
          left: joystickInnerPosition.dx,
        ),
        if (showArrows) 
        ...createArrows()
      ],
                  );
  }

  List<Widget> createArrows() {
    return [
      Positioned(
        child: Icon(
          Icons.arrow_upward,
          color: iconsColor,
        ),
        top: 16.0,
        left: 0.0,
        right: 0.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_back,
          color: iconsColor,
        ),
        top: 0.0,
        bottom: 0.0,
        left: 16.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_forward,
          color: iconsColor,
        ),
        top: 0.0,
        bottom: 0.0,
        right: 16.0,
      ),
      Positioned(
        child: Icon(
          Icons.arrow_downward,
          color: iconsColor,
        ),
        bottom: 16.0,
        left: 0.0,
        right: 0.0,
      ),
    ];
  }

  DateTime _processGesture(double size, double ignoreSize, Offset offset,
      DateTime callbackTimestamp) {
    double middle = size / 2.0;

    double angle = _math.atan2(offset.dy - middle, offset.dx - middle);
    double degrees = angle * 180 / _math.pi + 90;
    if (offset.dx < middle && offset.dy < middle) {
      degrees = 360 + degrees;
    }

    double dx = _math.max(0, _math.min(offset.dx, size));
    double dy = _math.max(0, _math.min(offset.dy, size));

    double distance =
        _math.sqrt(_math.pow(middle - dx, 2) + _math.pow(middle - dy, 2));

    double normalizedDistance = _math.min(distance / (size / 2), 1.0);

    DateTime _callbackTimestamp = callbackTimestamp;
    if (onDirectionChanged != null &&
        _canCallOnDirectionChanged(callbackTimestamp)) {
      _callbackTimestamp = DateTime.now();
      onDirectionChanged!(degrees, normalizedDistance);
    }

    return _callbackTimestamp;
  }

  /// Checks if the [onDirectionChanged] can be called.
  ///
  /// Returns true if enough time has passed since last time it was called
  /// or when there is no [interval] set.
  bool _canCallOnDirectionChanged(DateTime callbackTimestamp) {
    if (interval != null && callbackTimestamp != DateTimeConstants.timeCheck) {
      int intervalMilliseconds = interval!.inMilliseconds;
      int timestampMilliseconds = callbackTimestamp.millisecondsSinceEpoch;
      int currentTimeMilliseconds = DateTime.now().millisecondsSinceEpoch;

      if (currentTimeMilliseconds - timestampMilliseconds <=
          intervalMilliseconds) {
        return false;
      }
    }

    return true;
  }

  Offset _calculatePositionOfInnerCircle(
      Offset lastPosition, double innerCircleSize, double size, Offset localPosition) {
        
    double middle = size / 2.0;

    double angle = _math.atan2(localPosition.dy - middle, localPosition.dx - middle);
    double degrees = angle * 180 / _math.pi;
    if (localPosition.dx < middle && localPosition.dy < middle) {
      degrees = 360 + degrees;
    }
    bool isStartPosition = lastPosition.dx == innerCircleSize &&
        lastPosition.dy == innerCircleSize;
    double lastAngleRadians =
        (isStartPosition) ? 0 : (degrees) * (_math.pi / 180.0);

    var rBig = size / 2;
    var rSmall = innerCircleSize / 2;

    var x = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * _math.cos(lastAngleRadians);
    var y = (lastAngleRadians == -1)
        ? rBig - rSmall
        : (rBig - rSmall) + (rBig - rSmall) * _math.sin(lastAngleRadians);

    var xPosition = lastPosition.dx - rSmall;
    var yPosition = lastPosition.dy - rSmall;

    var angleRadianPlus = lastAngleRadians + _math.pi / 2;
    if (angleRadianPlus < _math.pi / 2) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < _math.pi) {
      if (xPosition > x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else if (angleRadianPlus < 3 * _math.pi / 2) {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition > y) {
        yPosition = y;
      }
    } else {
      if (xPosition < x) {
        xPosition = x;
      }
      if (yPosition < y) {
        yPosition = y;
      }
    }
    return Offset(xPosition, yPosition);
  }
}

/*
I/flutter (12830): ##onPanStart: local Offset(152.3, 117.6)
I/flutter (12830): ##onPanStart: details.local  Offset(212.3, 177.6)
I/flutter (12830): ##onPanStart: lastPostion Offset(60.0, 60.0)

I/flutter (12830): -----------------------------------------

I/flutter (12830): ##onPanUpdate lastPosition Offset(152.3, 117.6)
I/flutter (12830): ##onPanUpdate localPosition Offset(212.3, 177.2)
I/flutter (12830): ##onPanUpdate joystickInnerPosition Offset(53.8, 48.3)

I/flutter (12830): -----------------------------------------

I/flutter (12830): ##onPanUpdate lastPosition Offset(84.1, 64.9)
I/flutter (12830): ##onPanUpdate localPosition Offset(83.6, 64.9)
I/flutter (12830): ##onPanUpdate joystickInnerPosition Offset(54.1, 34.9)

 */