import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool liked;
  final double sizeButton;
  final void Function(bool) onPressed;

  const LikeButton({
    super.key,
    required this.onPressed,
    this.liked = false,
    required this.sizeButton,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.liked;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: _isFavorite ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
          widget.onPressed(_isFavorite);
        });
        if (_isFavorite) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        ),
        child: _isFavorite
            ? Icon(
                Icons.favorite,
                size: widget.sizeButton,
                color: Colors.red,
              )
            : Icon(
                Icons.favorite_border,
                size: widget.sizeButton,
              ),
      ),
    );
  }
}
