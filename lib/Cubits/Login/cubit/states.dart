import 'package:test_shop_app/models/Login%20Model.dart';

abstract class Login_states{}
class intial_state extends Login_states{}
class loding_state extends Login_states{}
class sucsess_state extends Login_states{
 late shopLoginModel loginModel;
 sucsess_state(this.loginModel);
}
class error_state extends Login_states{}

