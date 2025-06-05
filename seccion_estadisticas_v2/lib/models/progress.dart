class Progress {
  final String date;
  final int bookings;
  final double billedAmount;

  Progress({required this.date, required this.bookings, required this.billedAmount});

  factory Progress.fromJson(Map<String, dynamic> json){
    return Progress(
      date:json['date'],
      bookings:json['bookings'],
      billedAmount:json['billedAmount']
    );
  }
}