import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/managers/color_manager.dart';
import '../../../core/constants/managers/icon_manager.dart';
import '../../../core/constants/managers/spacing_manager.dart';
import '../../../core/constants/text_styles/heading_style.dart';


enum AnimationType {
  slide,
  scale;
}

class MiniInfoDialog extends StatefulWidget {
  final Alignment _alignment;
  final String _title;
  final String _body;
  final AnimationType _animationType;
  const MiniInfoDialog(
      {required String title, required String body, Alignment alignment = Alignment.center, AnimationType animationType = AnimationType.scale, super.key})
      : _animationType = animationType,
        _body = body,
        _title = title,
        _alignment = alignment;

  @override
  State<MiniInfoDialog> createState() => _MiniInfoDialogState();
}

class _MiniInfoDialogState extends State<MiniInfoDialog> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.fastLinearToSlowEaseIn);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.decelerate));
    _slideController.forward();
    _scaleController.forward();
    super.initState();
  }

  @override
  dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Widget _getAnimation({required Widget body}) {
    if (widget._animationType == AnimationType.scale) {
      return ScaleTransition(scale: _scaleAnimation, alignment: Alignment.center, filterQuality: FilterQuality.high, child: body);
    }
    return SlideTransition(position: _slideAnimation, child: body);
  }

  @override
  Widget build(BuildContext context) {
    return _getAnimation(
      body: Dialog(
        elevation: 10,
        alignment: widget._alignment,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(IconManager.informationCircle),
                  SpacingManager.w8,
                  Expanded(child: Text(widget._title, style: HeadingSmall.semiBold.copyWith(color: ColorManager.lightBlue))),
                  SpacingManager.w8,
                  // ignore: deprecated_member_use
                  GestureDetector(onTap: Navigator.of(context).pop, child: SvgPicture.asset(IconManager.xMark, color: ColorManager.lightBlue,)),
                ],
              ),
              SpacingManager.h32,
              Text(widget._body, style: BodyTextSmall.regular.copyWith(color: ColorManager.darkBlue2)),
            ],
          ),
        ),
      ),
    );
  }
}
