import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'dart:math';

class RadarPainter extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final bool fastMode;

  const RadarPainter({
    Key? key,
    required this.color,
    this.width = 200,
    this.height = 200,
    this.fastMode = false,
  }) : super(key: key);

  @override
  _RadarPainterState createState() => _RadarPainterState();
}

class _RadarPainterState extends State<RadarPainter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fastMode) {
      return Center(
        child: Text(
          "Found",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final now = DateTime.now();
        final iTime = now.difference(_startTime).inMilliseconds / 1000.0;
        final second = now.second + (now.millisecond / 1000.0);

        return ShaderBuilder(
          assetKey: 'shaders/radar.frag',
          (context, shader, child) {
            // Set the resolution uniform
            shader.setFloat(0, widget.width);
            shader.setFloat(1, widget.height);

            // Set the time uniform (10 times faster if fastMode is true)
            shader.setFloat(2, widget.fastMode ? iTime * 10 : iTime);

            // Set the second uniform (10 times faster if fastMode is true)
            shader.setFloat(3, widget.fastMode ? second * 10 : second);

            // Set the color uniform
            shader.setFloat(4, widget.color.red / 255.0);
            shader.setFloat(5, widget.color.green / 255.0);
            shader.setFloat(6, widget.color.blue / 255.0);

            return CustomPaint(
              painter: _ShaderPainter(shader, widget.color),
              size: Size(widget.width, widget.height),
            );
          },
        );
      },
    );
  }
}

class _ShaderPainter extends CustomPainter {
  final Shader shader;
  final Color color;

  _ShaderPainter(this.shader, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
