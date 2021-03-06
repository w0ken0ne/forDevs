import 'package:flutter/material.dart';
import 'package:fordev/ui/components/components.dart';
import 'package:fordev/ui/helpers/errors/errors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../pages.dart';
import 'components/login_button.dart';
import 'components/login_components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading == true) {
              showLoading(context, "Aguarde");
            } else {
              hideLoading(context);
            }
          });
          presenter.mainErrorStream.listen((UIError hasMainError) {
            if (hasMainError != null) {
              showSnackBar(context, hasMainError.description);
            } else {
              hideLoading(context);
            }
          });
          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });
          return GestureDetector(
            onTap: hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text: "Login"),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Provider<LoginPresenter>(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 32),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            CreateAccountButton(
                              presenter: presenter,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
