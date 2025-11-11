import 'dart:convert';

PackageResponse packageResponseFromJson(String str) =>
    PackageResponse.fromJson(json.decode(str));

class PackageResponse {
  final String? status;
  final String? message;
  final Pagination? pagination;
  final List<DevicePackage>? data;

  PackageResponse({this.status, this.message, this.pagination, this.data});

  factory PackageResponse.fromJson(Map<String, dynamic> json) =>
      PackageResponse(
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
        data: json["data"] == null
            ? []
            : List<DevicePackage>.from(
                json["data"].map((x) => DevicePackage.fromJson(x)),
              ),
      );
}

class Pagination {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;

  Pagination({this.total, this.perPage, this.currentPage, this.lastPage});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"] ?? 0,
    perPage: json["per_page"] ?? 0,
    currentPage: json["current_page"] ?? 0,
    lastPage: json["last_page"] ?? 0,
  );
}

class DevicePackage {
  final int? id;
  final String? name;
  final String? iconPath;
  final List<String>? features;
  final double? regularPrice;
  final String? formattedPrice;
  final double? payableAmount;
  final String? formattedPayableAmount;
  final bool? discountActive;
  final dynamic discountPercent;
  final bool? hasActiveDiscount;
  final SubscriptionPackage? subscriptionPackage;

  DevicePackage({
    this.id,
    this.name,
    this.iconPath,
    this.features,
    this.regularPrice,
    this.formattedPrice,
    this.payableAmount,
    this.formattedPayableAmount,
    this.discountActive,
    this.discountPercent,
    this.hasActiveDiscount,
    this.subscriptionPackage,
  });

  factory DevicePackage.fromJson(Map<String, dynamic> json) => DevicePackage(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    iconPath: json["icon_path"] ?? "",
    features: json["features"] != null
        ? List<String>.from(json["features"].map((x) => x.toString()))
        : [],
    regularPrice: (json["regular_price"] ?? 0).toDouble(),
    formattedPrice: json["formatted_price"] ?? "",
    payableAmount: (json["payable_amount"] ?? 0).toDouble(),
    formattedPayableAmount: json["formatted_payable_amount"] ?? "",
    discountActive: json["discount_active"] ?? false,
    discountPercent: json["discount_percent"] ?? 0,
    hasActiveDiscount: json["has_active_discount"] ?? false,
    subscriptionPackage: json["subscription_package"] != null
        ? SubscriptionPackage.fromJson(json["subscription_package"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon_path": iconPath,
    "features": features,
    "regular_price": regularPrice,
    "formatted_price": formattedPrice,
    "payable_amount": payableAmount,
    "formatted_payable_amount": formattedPayableAmount,
    "discount_active": discountActive,
    "discount_percent": discountPercent,
    "has_active_discount": hasActiveDiscount,
    "subscription_package": subscriptionPackage?.toJson(),
  };

  DevicePackage copyWith({
    int? id,
    String? name,
    String? iconPath,
    List<String>? features,
    double? regularPrice,
    String? formattedPrice,
    double? payableAmount,
    String? formattedPayableAmount,
    bool? discountActive,
    dynamic discountPercent,
    bool? hasActiveDiscount,
    SubscriptionPackage? subscriptionPackage,
  }) {
    return DevicePackage(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      features: features ?? this.features,
      regularPrice: regularPrice ?? this.regularPrice,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      payableAmount: payableAmount ?? this.payableAmount,
      formattedPayableAmount:
          formattedPayableAmount ?? this.formattedPayableAmount,
      discountActive: discountActive ?? this.discountActive,
      discountPercent: discountPercent ?? this.discountPercent,
      hasActiveDiscount: hasActiveDiscount ?? this.hasActiveDiscount,
      subscriptionPackage: subscriptionPackage ?? this.subscriptionPackage,
    );
  }
}

class SubscriptionPackage {
  final int? id;
  final String? name;
  final double? price;
  final String? formattedPrice;
  final int? durationMonths;
  final String? description;

  SubscriptionPackage({
    this.id,
    this.name,
    this.price,
    this.formattedPrice,
    this.durationMonths,
    this.description,
  });

  factory SubscriptionPackage.fromJson(Map<String, dynamic> json) =>
      SubscriptionPackage(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        price: (json["price"] ?? 0).toDouble(),
        formattedPrice: json["formatted_price"] ?? "",
        durationMonths: json["duration_months"] ?? 0,
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "formatted_price": formattedPrice,
    "duration_months": durationMonths,
    "description": description,
  };
}
