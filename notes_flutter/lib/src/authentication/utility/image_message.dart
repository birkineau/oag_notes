import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notes_flutter/notes_flutter.dart';
import 'package:oag_utils/oag_utils.dart';

class ImageMessage extends StatefulWidget {
  const ImageMessage({
    super.key,
    required this.duration,
    required this.imageAssetPath,
    required this.message,
  });

  final Duration duration;
  final String imageAssetPath;
  final String message;

  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage> {
  final _animatedOffsetSwitcherKey = GlobalKey<AnimatedOffsetSwitcherState>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (_animatedOffsetSwitcherKey.currentState
            case final AnimatedOffsetSwitcherState state) {
          await state.show();
          await state.hide();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const assetPath = "lib/assets/images/success_512.png";

    final successMessage = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final dimension = constraints.maxWidth * .6;

            return SizedBox(
              width: dimension,
              height: dimension,
              child: const Image(
                fit: BoxFit.scaleDown,
                image: AssetImage(assetPath),
              ),
            );
          },
        ),
        const SizedBox(height: 24.0),
        Text(
          widget.message,
          textAlign: TextAlign.center,
          style: NotesTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    const beginEndDuration = Duration(milliseconds: 350);
    final middleDuration = widget.duration - beginEndDuration * 2;

    return ColoredBox(
      color: NotesTheme.colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedOffsetSwitcher(
          key: _animatedOffsetSwitcherKey,
          settings: const AnimatedOffsetSwitcherSettings.topToBottom().copyWith(
            beginDuration: beginEndDuration,
            middleDuration: middleDuration,
            endDuration: beginEndDuration,
            manual: true,
          ),
          itemCount: 1,
          itemBuilder: (context, index) {
            return successMessage;
          },
        ),
      ),
    );
  }
}
