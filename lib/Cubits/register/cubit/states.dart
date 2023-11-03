import 'package:test_shop_app/models/Login%20Model.dart';

abstract class register_states{}
class intialRegister_state extends register_states{}
class lodingRigister_state extends register_states{}
class sucsessRegister_state extends register_states{
  shopLoginModel ? loginModel;
 sucsessRegister_state(this.loginModel);
}
class errorRegister_state extends register_states{}

