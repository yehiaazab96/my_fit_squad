import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class UserNetworkDataSource {
  Future<BaseApiResult<User>> login(String email, String password) async {
    return await ApiMethods<User>().post(ApiUrls.user + ApiUrls.login,
        hasToken: false, data: {'email': email, 'password': password});
  }

  Future<BaseApiResult<User>> signUp(User user, {XFile? profileImage}) async {
    Map<String, dynamic> map = user.toJson();
    if (profileImage != null) {
      File file = File(profileImage.path);
      String fileName = file.path.split('/').last;

      map['profile_img'] = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
    }
    FormData formdata = FormData.fromMap(map);

    return await ApiMethods<User>().postWithFormData(
        ApiUrls.user + ApiUrls.signup,
        hasToken: false,
        data: formdata);
  }

  Future<BaseApiResult<User>> getUser(String id) async {
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);
    return await ApiMethods<User>().get(
      '${ApiUrls.user}${user?.role == 'client' ? ApiUrls.clients : ApiUrls.coaches}/$id',
      hasToken: true,
    );
  }
}
