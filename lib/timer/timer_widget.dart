import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_app/core/const_colour.dart';
import 'package:timer_app/core/const_textfiled.dart';
import 'package:timer_app/model/timer_list_model.dart';

class CountdownTimerList extends StatefulWidget {
  const CountdownTimerList({super.key});

  @override
  State<CountdownTimerList> createState() => _CountdownTimerListState();
}

class _CountdownTimerListState extends State<CountdownTimerList> {
  final List<TimerItem> _timers = [];

  @override
  void initState() {
    super.initState();
    _addNewTimer();
  }

  void _addNewTimer() {
    setState(() {
      _timers.add(TimerItem(seconds: 0));
    });
  }

  void _toggleTimer(int index) {
    setState(() {
      if (_timers[index].isPaused) {
        _timers[index].isPaused = false;
        _startTimer(index);
      } else if (_timers[index].isRunning) {
        _timers[index].isPaused = true;
        _stopTimer(index);
      } else {
        _startTimer(index);
      }
    });
  }

  void _startTimer(int index) {
    setState(() {
      _timers[index].isRunning = true;
    });

    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_timers[index].isPaused) {
          timer.cancel();
        } else if (_timers[index].seconds > 0) {
          _timers[index].seconds--;
        } else {
          _timers[index].isRunning = false;
          timer.cancel();
        }
      });
    });
  }

  void _stopTimer(int index) {
    setState(() {
      _timers[index].isRunning = false;
    });
  }

  void _updateTimerSeconds(int index, int seconds) {
    setState(() {
      _timers[index].seconds = seconds;
    });
  }

  String _formatTimer(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds ~/ 60) % 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      body: SafeArea(
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _timers.length,
              itemBuilder: (context, index) {
                return _buildTimerItem(context, index);
              }),
        ),
      ),
    );
  }

  Widget _buildTimerItem(BuildContext context, int index) {
    final timerItem = _timers[index];
    final isTimerRunning = timerItem.isRunning && !timerItem.isPaused;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(children: [
          Expanded(
            child: ConstTextField(
              text: 'Enter seconds',
              onChanged: (value) =>
                  _updateTimerSeconds(index, int.tryParse(value) ?? 0),
            ),
          ),
          SizedBox(width: 10.w),
          Center(child: Text(_formatTimer(timerItem.seconds))),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () => _toggleTimer(index),
            child: Container(
              height: 30.h,
              width: isTimerRunning ? 55.w : 50.w,
              decoration: BoxDecoration(
                  color: KColor.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: KColor.green, width: 1.5)),
              child: Center(
                  child: Text(isTimerRunning ? 'Pause' : 'Start',
                      style: TextStyle(
                        color: KColor.green,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ))),
            ),
          ),
          SizedBox(width: 7.w),
          GestureDetector(
            onTap: () => _addNewTimer(),
            child: Container(
              height: 30.h,
              width: 50.w,
              decoration: BoxDecoration(
                  color: KColor.green, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                'Add',
                style: TextStyle(
                  color: KColor.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              )),
            ),
          ),
        ]));
  }
}
