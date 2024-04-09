class PlaceModel {
  final String placeVideo;
  final String name;
  final String desc;
  final List<String> hashtags;
  final int additionalHashtagNums;

  PlaceModel(
      {required this.name,
      required this.desc,
      required this.placeVideo,
      required this.hashtags,
      required this.additionalHashtagNums});
}
