import 'package:jefit/core/utils/app_assets.dart';

class LowerBodyModel {
  final String title;
  final String image;
  final String? videoAsset;

  LowerBodyModel({required this.title, required this.image, this.videoAsset});
}

List<LowerBodyModel> legsLowerBody = [
  LowerBodyModel(title: "squat", image: AppAssets.legSquat,
      videoAsset: AppAssets.legSquatVideo
  ),
  LowerBodyModel(title: "lunges", image: AppAssets.legLunges),
];
List<LowerBodyModel> kneeLowerBody = [
  LowerBodyModel(title: "long arc quad", image: AppAssets.kneeQuad),
  LowerBodyModel(title: "Heel Slides", image: AppAssets.kneeHeel),
  LowerBodyModel(title: "Squat", image: AppAssets.kneeSquat),
];

List<LowerBodyModel> ankleLowerBody = [
  LowerBodyModel(title: "Ankle Mobility", image: AppAssets.ankleMobility),
  LowerBodyModel(title: "Toe Raise", image: AppAssets.ankleRaise),
];
