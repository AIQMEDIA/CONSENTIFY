import 'package:get/get.dart';

import '../controller/past_agreement_controller.dart';
import '../repository/past_agreement_repository.dart';

class PastAgreementBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PastAgreementController>(() => PastAgreementController(
     PastAgreementRepository()));
  }
}