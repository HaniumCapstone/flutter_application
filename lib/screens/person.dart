class Person {
  final String? name;
  final String? mbti; // Nullable type
  final String? birth_Date; // Nullable type
  final String? death_Date; // Nullable type
  final String? era; // Nullable type
  final String? description; // Nullable type

  Person({
    required this.name,
    this.mbti,
    this.birth_Date,
    this.death_Date,
    this.era,
    this.description,
  });
}
