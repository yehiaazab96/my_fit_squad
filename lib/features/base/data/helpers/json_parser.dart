import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

extension JsonParser on Map<String, dynamic> {
  V? parse<V>() {
    switch (V) {
      case User:
        return User.fromJson(this) as V;
    }

    return null;
  }
}
