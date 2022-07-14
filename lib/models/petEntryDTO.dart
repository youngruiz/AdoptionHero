class PetEntryDTO{
  late String name;
  late String type;
  late String breed;
  late String disposition;
  late String availability;
  late String description;
  late String userId;
  late String imgUrl;
  late int liked;
  late String dateCreated;
  late String newsItem;

  PetEntryDTO({
    required this.name,
    required this.type,
    required this.breed,
    required this.disposition,
    required this.availability,
    required this.description,
    required this.userId,
    required this.imgUrl,
    required this.liked,
    required this.dateCreated,
    required this.newsItem
  });
}