class AbsenModel {
  final int id;
  final int userId;
  final String? checkIn;
  final String? checkInLocation;
  final String? checkInAddress;
  final String? checkOut;
  final String? checkOutLocation;
  final String? checkOutAddress;
  final String? status;
  final String? alasanIzin;
  final String? createdAt;
  final String? updatedAt;
  final double? checkInLat;
  final double? checkInLng;
  final double? checkOutLat;
  final double? checkOutLng;

  AbsenModel({
    required this.id,
    required this.userId,
    this.checkIn,
    this.checkInLocation,
    this.checkInAddress,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutAddress,
    this.status,
    this.alasanIzin,
    this.createdAt,
    this.updatedAt,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
  });

  factory AbsenModel.fromJson(Map<String, dynamic> json) {
    return AbsenModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      userId: json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id'].toString()) ?? 0,
      checkIn: json['check_in'],
      checkInLocation: json['check_in_location'],
      checkInAddress: json['check_in_address'],
      checkOut: json['check_out'],
      checkOutLocation: json['check_out_location'],
      checkOutAddress: json['check_out_address'],
      status: json['status'],
      alasanIzin: json['alasan_izin'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      checkInLat: json['check_in_lat'] is double ? json['check_in_lat'] : double.tryParse(json['check_in_lat']?.toString() ?? ''),
      checkInLng: json['check_in_lng'] is double ? json['check_in_lng'] : double.tryParse(json['check_in_lng']?.toString() ?? ''),
      checkOutLat: json['check_out_lat'] is double ? json['check_out_lat'] : double.tryParse(json['check_out_lat']?.toString() ?? ''),
      checkOutLng: json['check_out_lng'] is double ? json['check_out_lng'] : double.tryParse(json['check_out_lng']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'check_in': checkIn,
      'check_in_location': checkInLocation,
      'check_in_address': checkInAddress,
      'check_out': checkOut,
      'check_out_location': checkOutLocation,
      'check_out_address': checkOutAddress,
      'status': status,
      'alasan_izin': alasanIzin,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'check_in_lat': checkInLat,
      'check_in_lng': checkInLng,
      'check_out_lat': checkOutLat,
      'check_out_lng': checkOutLng,
    };
  }
}
