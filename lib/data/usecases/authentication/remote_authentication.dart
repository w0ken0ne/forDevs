import 'package:fordev/domain/entities/account_entity.dart';
import 'package:fordev/domain/helpers/helpers.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/authentication.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({@required this.email, @required this.password});
  factory RemoteAuthenticationParams.fromDomain(
          AuthenticationParams authenticationParams) =>
      RemoteAuthenticationParams(
          email: authenticationParams.email,
          password: authenticationParams.secret);
  Map toJson() => {'email': email, 'password': password};
}
