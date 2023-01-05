class BooklyModel
{
  final String date;
  final String interest;
  final String address;
  final String title;
  final String trainerInfo;
  final String occasionDetail;
  final String trainerName;
  final List<String> img;
  final List reservationTypes;
  final String trainerImg;
  final String latitude;
  final String longitude;

  BooklyModel({
    required this.latitude,
    required this.longitude,
    required this.reservationTypes,
    required this.img,
    required this.trainerImg,
    required this.date,
    required this.interest,
    required this.address,
    required this.title,
    required this.trainerInfo,
    required this.occasionDetail,
    required this.trainerName,
  });

}
class ReservationType
{
  final int id;
  final String name;
  final int count;
  final double price;

  ReservationType({required this.id, required this.name, required this.count,required this.price});

}