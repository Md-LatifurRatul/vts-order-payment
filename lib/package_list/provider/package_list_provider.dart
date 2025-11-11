import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vts_price/package_list/model/package_model.dart';
import 'package:vts_price/utils/network_constants.dart';

class PackageProvider extends ChangeNotifier {
  bool isLoading = false;
  PackageResponse? packageResponse;

  // ✅ New fields for package detail
  bool isDetailLoading = false;
  DevicePackage? packageDetail;

  // Fetch package list
  Future<void> fetchPackages() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      '${NetworkConstants.baseUrl}/api/auth/device-packages',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'x-api-key': NetworkConstants.xApiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        packageResponse = packageResponseFromJson(response.body);
        // log('API Status: ${packageResponse?.status}');
        // log('Message: ${packageResponse?.message}');
        packageResponse?.data?.forEach((package) {
          // log(' - ${package.name} | Price: ${package.formattedPrice}');
        });
      } else {
        log('Failed to fetch packages. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching packages: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // ✅ Fetch package detail by ID
  Future<void> fetchPackageDetail(int packageId) async {
    isDetailLoading = true;
    notifyListeners();

    final url = Uri.parse(
      '${NetworkConstants.baseUrl}/api/auth/device-package/$packageId',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'x-api-key': NetworkConstants.xApiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        packageDetail = DevicePackage.fromJson(
          data['data'],
        ); // adjust according to API response
        // log('Package detail fetched: ${packageDetail?.name}');
      } else {
        log('Failed to fetch package detail. Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching package detail: $e');
    }

    isDetailLoading = false;
    notifyListeners();
  }
}
