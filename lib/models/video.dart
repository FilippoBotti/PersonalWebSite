class YoutubeVideo {
  final String name;
  final String? description;
  final String defaultImageUrl;
  final String mediumImageUrl;
  final String highImageUrl;
  final String standardImageUrl;
  final String videoId;

  YoutubeVideo({
    required this.name,
    required this.description,
    required this.defaultImageUrl,
    required this.mediumImageUrl,
    required this.highImageUrl,
    required this.standardImageUrl,
    required this.videoId,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      name: json['snippet']['title'],
      description: json['snippet']['description'],
      defaultImageUrl: json['snippet']['thumbnails']['default']['url'],
      mediumImageUrl: json['snippet']['thumbnails']['medium']['url'],
      highImageUrl: json['snippet']['thumbnails']['high']['url'],
      standardImageUrl: json['snippet']['thumbnails']['standard']['url'],
      videoId: json['contentDetails']['videoId'],
    );
  }

  @override
  String toString() {
    return 'YoutubeVideo{name: $name, description: $description, defaultImageUrl: $defaultImageUrl, mediumImageUrl: $mediumImageUrl, highImageUrl: $highImageUrl, standardImageUrl: $standardImageUrl}';
  }
}

class YoutubeChannel {
  final String name;
  final String description;
  final String viewCount;
  final String subscriberCount;
  final String videoCount;
  final String videoId;

  YoutubeChannel({
    required this.name,
    required this.description,
    required this.videoCount,
    required this.viewCount,
    required this.subscriberCount,
    required this.videoId,
  });

  factory YoutubeChannel.fromJson(Map<String, dynamic> json) {
    return YoutubeChannel(
        name: json['snippet']['title'],
        description: json['snippet']['description'],
        viewCount: json['statistics']['viewCount'],
        videoCount: json['statistics']['videoCount'],
        subscriberCount: json['statistics']['subscriberCount'],
        videoId: json['id'],
    );
  }
}
