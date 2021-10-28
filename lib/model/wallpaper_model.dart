class WallpaperModel{

  late String photographer;
  late String photographer_url;
  late int photographer_id;
  SrcModel src;

  WallpaperModel({ required this.src, required this.photographer_url,
    required this.photographer_id, required this.photographer})

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(src: jsonData['src'],
        photographer_url: jsonData['photographer_url'],
        photographer_id: jsonData['photographer_id'],
        photographer: jsonData['photographer']);
  }
}

class SrcModel {
  late String original;
  late String small;
  late String portrait;

  SrcModel({ required this.original, required this.portrait, required this.small})

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(original: jsonData['original'],
        portrait: jsonData['portrait'],
        small: jsonData['small']);
  }
}