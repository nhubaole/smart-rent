import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final double cornerRadius;

  const Skeleton({
    super.key,
    this.height = 20,
    this.width = 200,
    this.cornerRadius = 4,
  });

  @override
  SkeletonState createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.cornerRadius),
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: const Alignment(-1, 0),
          colors: isDarkTheme
              ? [
                  const Color(0x66000000),
                  const Color(0x99000000),
                  const Color(0x66000000)
                ]
              : [
                  const Color(0x0D000000),
                  const Color(0x1A000000),
                  const Color(0x0D000000)
                ],
        ),
      ),
    );
  }
}
