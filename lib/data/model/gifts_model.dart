import 'package:academic/l10n/l10n.dart';
import '../api/gifts/model/my_gifts_model.dart';

class GiftModel {
  String tracking_code;
  int amount;
  String type;
  String created_at;

  GiftModel({
    required this.tracking_code,
    required this.amount,
    required this.type,
    required this.created_at,
  });

  factory GiftModel.fromApiItem(MyGiftItem item) {
    return GiftModel(
      tracking_code: item.tracking_code,
      amount: item.amount,
      type: item.type,
      created_at: item.created_at,
    );
  }

  // Helper method to format amount
  String get formattedAmount {
    if (amount >= 1000000) {
      return l10n.amountMillionToman((amount / 1000000).toStringAsFixed(1));
    } else if (amount >= 1000) {
      return l10n.amountThousandToman((amount / 1000).toStringAsFixed(0));
    } else {
      return l10n.amountToman(amount.toString());
    }
  }

  // Helper method to get type display name
  String get typeDisplayName {
    switch (type) {
      case 'active':
        return l10n.active;
      case 'used':
        return l10n.used;
      case 'expired':
        return l10n.expiredStatus;
      default:
        return type;
    }
  }

  // Helper method to get type color
  String get typeColor {
    switch (type) {
      case 'active':
        return 'green';
      case 'used':
        return 'blue';
      case 'expired':
        return 'red';
      default:
        return 'gray';
    }
  }
}
