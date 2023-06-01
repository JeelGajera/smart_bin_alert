import 'package:mobx/mobx.dart';
import 'package:smartbin_alert/models/user_model.dart';

class UserStore {
  Observable<bool> isLoading = Observable(true);
  Observable<bool> isError = Observable(false);
  Observable<String> errorMessage = Observable('');
  Observable<UserModal> user = Observable(UserModal());

  @action
  Future<void> setUser({required UserModal user}) async {
    try {
      runInAction(() {
        this.user.value = user;
        isLoading.value = false;
      });
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
    }
    isLoading.value = false;
  }
}
