import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/core/model/invoice/invoice.dart';

class PaymentOSService {
  String getSignature(Invoice invoice) {
    var enKey = utf8.encode(dotenv.env['checksum_payos']!);
    var enBytes = utf8.encode(
        'amount=${invoice.amountRoom}&cancelUrl=${invoice.cancelUrl}&description=${invoice.description}&orderCode=${invoice.orderCode}&returnUrl=${invoice.returnUrl}');
    var hmacSha256 = Hmac(sha256, enKey);

    return hmacSha256.convert(enBytes).toString();
  }
}
