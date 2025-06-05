class PostModel {
  final String title;
  final String subtitle;
  final String date;
  final String hour;
  final String image;

  PostModel({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.hour,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'date': date,
    'hour': hour,
    'image': image,
  };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    title: json['title'],
    subtitle: json['subtitle'],
    date: json['date'],
    hour: json['hour'],
    image: json['image'],
  );
}
