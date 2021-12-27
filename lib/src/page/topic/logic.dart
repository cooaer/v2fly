import 'package:get/get.dart';
import 'package:v2fly/src/common/network/http_maker.dart';
import 'package:v2fly/src/api/v2ex_api.dart';

import 'state.dart';

class TopicLogic extends GetxController {
  late V2exApi _api;
  late TopicState state;

  TopicLogic() {
    _api = V2exApi(doHttpMaker);
    state = TopicState();
  }

  Future<void> loadNextPage() async {
    final topic = await _api.getTopic(state.topicId, state.nextPage());
    state.updateTopic(topic);
    state.increasePage();
    update();
  }
}
