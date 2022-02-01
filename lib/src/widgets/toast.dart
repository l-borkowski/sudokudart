import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class Toast extends StatelessWidget {
  const Toast({
    Key? key,
    this.height = 72,
    this.color = Colors.blue,
    this.child,
  }) : super(key: key);

  final double height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => hide(),
        child: Container(
          alignment: Alignment.centerLeft,
          height: height,
          width: 200,
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 32,
          ).copyWith(bottom: 100),
          padding: const EdgeInsets.only(
            left: 16,
            bottom: 2,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.56),
                offset: const Offset(0, -4),
                blurRadius: 32,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }

  static const _overlayKey = ValueKey('overaly');

  static show(Widget child) => showOverlay(
        (context, value) => AnimatedOpacity(
          opacity: value,
          child: Toast(child: child),
          duration: const Duration(seconds: 0),
          key: _overlayKey,
        ),
        duration: const Duration(seconds: 3),
        animationDuration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.fastLinearToSlowEaseIn,
      );

  static hide() => showOverlay(
        (_, __) => const SizedBox(),
        key: _overlayKey,
      );
}
