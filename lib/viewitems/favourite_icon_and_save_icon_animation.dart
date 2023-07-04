import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/resources/colors.dart';

import '../resources/dimens.dart';

const kAnimationDuration = Duration(milliseconds: 500);

class FavouriteIconAnimation extends StatefulWidget {
  const FavouriteIconAnimation({Key? key}) : super(key: key);

  @override
  State<FavouriteIconAnimation> createState() => _FavouriteIconAnimationState();
}

class _FavouriteIconAnimationState extends State<FavouriteIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });

    if (_isLiked) {
      _animationController.velocity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_animation.value),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : PRIMARY_COLOR,
              size: 24.0,
            ),
            Text(
              "10",
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _isLiked ? Colors.red : PRIMARY_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}

class SaveIconAnimation extends StatefulWidget {
  const SaveIconAnimation({super.key});

  @override
  State<SaveIconAnimation> createState() => _SaveIconAnimationState();
}

class _SaveIconAnimationState extends State<SaveIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });

    if (_isLiked) {
      _animationController.velocity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_animation.value),
        child: Icon(
          _isLiked ?  Icons.bookmark_outlined : Icons.bookmark_border_outlined,
          color: _isLiked ? Colors.red : PRIMARY_COLOR,
          size: 24.0,
        ),
      ),
    );
  }
}
