class Person {
  final String? c_id; //character_id
  final String? name;
  final String? mbti; // Nullable type
  final String? birth_Date; // Nullable type
  final String? death_Date; // Nullable type
  final String? era; // Nullable type
  final String? description; // Nullable type
  final String imageFileName;

  Person({
    required this.c_id,
    required this.name,
    this.mbti,
    this.birth_Date,
    this.death_Date,
    this.era,
    this.description,
    required this.imageFileName,
  });
}
