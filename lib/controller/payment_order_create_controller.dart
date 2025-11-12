// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:vts_price/controller/device_api_controller.dart';
// import 'package:vts_price/presentation/widgets/custom_controller_alert_dialog.dart';
// import 'package:vts_price/services/storage/order_storage.dart';
// import 'package:vts_price/utils/logger.dart';
// import 'package:vts_price/utils/network_constants.dart';

// class OrderCreateController {
//   static Future<bool> createOrder(
//     BuildContext context,
//     List<Map<String, dynamic>> paymentItems,
//   ) async {
//     try {
//       final body = {"payment_items": paymentItems};

//       Logger.log("OrderCreateController → REQUEST BODY: $body");

//       final response = await http.post(
//         Uri.parse("${NetworkConstants.baseUrl}/api/auth/order/create"),
//         headers: DeviceApiController.headers,
//         body: jsonEncode(body),
//       );

//       Logger.log(
//         "OrderCreateController → RESPONSE [${response.statusCode}]: ${response.body}",
//       );

//       dynamic decoded;
//       try {
//         decoded = jsonDecode(response.body);
//       } catch (e) {
//         decoded = {};
//       }

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (decoded["status"] == "success" && decoded["order_id"] != null) {
//           final orderId = decoded["order_id"].toString();
//           await OrderStorage.saveOrderId(orderId);
//           Logger.log("OrderCreateController → ORDER CREATED: ID=$orderId");
//           return true;
//         } else {
//           CustomControllerAlertDialog.show(
//             context,
//             title: "Order Creation Failed",
//             message: "Unknown error",
//           );

//           return false;
//         }
//       } else {
//         CustomControllerAlertDialog.show(
//           context,
//           title: "Server Error",
//           message: "Internal Server error",
//         );

//         return false;
//       }
//     } catch (e) {
//       Logger.log("OrderCreateController → ERROR: $e");

//       CustomControllerAlertDialog.show(
//         context,
//         title: "Unexpected Error",
//         message: "Something went wrong. Please try again.",
//       );

//       return false;
//     }
//   }
// }
