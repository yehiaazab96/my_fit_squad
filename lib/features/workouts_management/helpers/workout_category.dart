import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum WorkoutCategory {
  muscleGain,
  fatLoss,
  rehabilitation,
  athlete;

  static WorkoutCategory getWorkoutCategory(String category) {
    switch (category) {
      case 'Muscle Gain':
        return WorkoutCategory.muscleGain;
      case 'Fat Loss':
        return WorkoutCategory.fatLoss;
      case 'Rehabilitation':
        return WorkoutCategory.rehabilitation;
      // case 'Athlete':
      //   return WorkoutCategory.athlete;
      case 'Athelete':
        return WorkoutCategory.athlete;
      default:
        return WorkoutCategory.muscleGain;
    }
  }

  Widget get image {
    switch (this) {
      case muscleGain:
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Assets.images.muscleGain
                  .image(fit: BoxFit.fitWidth)
                  .animate()
                  .fade(duration: 1.seconds, end: 0.6)
                  .shimmer(duration: 3.seconds, delay: 1.seconds),
            ),
            Positioned(
                child: Text(
              title,
              style: Theme.of(Constants.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    color: Theme.of(Constants.navigatorKey.currentContext!)
                        .colorScheme
                        .inversePrimary,
                    backgroundColor:
                        Theme.of(Constants.navigatorKey.currentContext!)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.7),
                  ),
            ))
          ],
        );
      case fatLoss:
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Assets.images.fatLoss
                  .image(fit: BoxFit.fitWidth)
                  .animate()
                  .fade(duration: 1.seconds, end: 0.6)
                  .shimmer(duration: 3.seconds, delay: 1.seconds),
            ),
            Positioned(
                child: Text(
              title,
              style: Theme.of(Constants.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    color: Theme.of(Constants.navigatorKey.currentContext!)
                        .colorScheme
                        .inversePrimary,
                    backgroundColor:
                        Theme.of(Constants.navigatorKey.currentContext!)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.7),
                  ),
            ))
          ],
        );
      case rehabilitation:
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Assets.images.rehabilitation
                  .image(fit: BoxFit.fitWidth)
                  .animate()
                  .fade(duration: 1.seconds, end: 0.6)
                  .shimmer(duration: 3.seconds, delay: 1.seconds),
            ),
            Positioned(
                child: Text(
              title,
              style: Theme.of(Constants.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    color: Theme.of(Constants.navigatorKey.currentContext!)
                        .colorScheme
                        .inversePrimary,
                    backgroundColor:
                        Theme.of(Constants.navigatorKey.currentContext!)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.7),
                  ),
            ))
          ],
        );

      case athlete:
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Assets.images.athelete
                  .image(fit: BoxFit.fitWidth)
                  .animate()
                  .fade(duration: 1.seconds, end: 0.6)
                  .shimmer(duration: 3.seconds, delay: 1.seconds),
            ),
            Positioned(
                child: Text(
              title,
              style: Theme.of(Constants.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                      color: Theme.of(Constants.navigatorKey.currentContext!)
                          .colorScheme
                          .inversePrimary,
                      backgroundColor:
                          Theme.of(Constants.navigatorKey.currentContext!)
                              .colorScheme
                              .inverseSurface
                              .withOpacity(0.7)),
            ))
          ],
        );
      default:
        return Assets.images.muscleGain
            .image(fit: BoxFit.fitWidth)
            .animate()
            .fade(duration: 1.seconds, end: 0.6)
            .shimmer(duration: 3.seconds, delay: 1.seconds);
    }
  }

  String get title {
    switch (this) {
      case muscleGain:
        return "Muscle Gain";
      case fatLoss:
        return "Fat Loss";
      case rehabilitation:
        return "Rehabilitation";
      case athlete:
        return "Athelete";
      default:
        return '';
    }
  }

  BorderRadiusGeometry get borderRadius {
    switch (this) {
      case muscleGain:
        return BorderRadius.only(
            topLeft: Radius.circular(3.w), bottomRight: Radius.circular(3.w));
      case fatLoss:
        return BorderRadius.only(
            topRight: Radius.circular(3.w), bottomLeft: Radius.circular(3.w));
      case rehabilitation:
        return BorderRadius.only(
            bottomLeft: Radius.circular(3.w), topRight: Radius.circular(3.w));
      case athlete:
        return BorderRadius.only(
            bottomRight: Radius.circular(3.w), topLeft: Radius.circular(3.w));
      default:
        return BorderRadius.only(
            topLeft: Radius.circular(3.w), bottomRight: Radius.circular(3.w));
    }
  }
}
