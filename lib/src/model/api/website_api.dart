import 'package:flutter/foundation.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:v2fly/src/common/date.dart';
import 'package:v2fly/src/common/extensions/list_extensions.dart';
import 'package:v2fly/src/common/network/http_maker.dart';
import 'package:v2fly/src/model/entity/home.dart';
import 'package:v2fly/src/model/entity/node.dart' as entity;
import 'package:v2fly/src/model/entity/topic.dart';
import 'package:v2fly/src/model/entity/user.dart';

class WebsiteApi {
  static const String BASE_URL = "https://v2ex.com";

  final HttpMaker _httpMaker;

  WebsiteApi(this._httpMaker);

  Future<HomeData> getHome(String tabId) async {
    final homeUrl = tabId.isEmpty ? BASE_URL : BASE_URL + "/?tab=$tabId";
    final String response = await _httpMaker({
      HttpMakerParams.url: homeUrl,
      HttpMakerParams.method: HttpMakerParams.methodGet,
    });
    return await compute(_parseHomeHtml, response);
  }
}

HomeData _parseHomeHtml(String html) {
  final dom = parse(html);

  final tabs = dom.querySelector("#Tabs")?.children.map((element) {
    final id = element.attributes['href']?.replaceFirst("/?tab=", "");
    final name = element.text;
    final selected = element.className.contains("current");
    return HomeTab(id ?? "", name, selected);
  }).toList();

  print("tabs" + tabs.toString());

  final boxNodes = dom.querySelectorAll("#Main > .box");

  final topics =
      boxNodes.get(0)?.querySelectorAll("div > table > tbody > tr").map((e) {
    final elementNodes = e.children
        .takeWhile((node) => node.nodeType == Node.ELEMENT_NODE)
        .toList();

    final creatorNode = elementNodes.get(0)?.firstChild?.firstChild;
    final createName = creatorNode?.attributes['alt'];
    final creatorAvatar = creatorNode?.attributes['src'];
    final creator = User(createName ?? "", creatorAvatar ?? "");

    final middleNode = e.children.get(2)?.firstChild?.firstChild;
    final topicId = _parseTopicId(middleNode?.attributes['href'] ?? "");
    final topicTitle = middleNode?.text;

    final nodeNode = e.querySelector(".topic_info > .node");
    final nodeId = nodeNode?.attributes['href']?.replaceFirst("/go/", "");
    final nodeName = nodeNode?.text;
    final topicNode = entity.Node(nodeId ?? "", nodeName ?? "");

    final latestReplyTimeText =
        e.querySelector(".topic_info > span")?.attributes['title']?.replaceFirst(' +08:00', "");
    final latestReplyTime = dateTimeFromString(latestReplyTimeText ?? "");

    final countNode = e.querySelector(".count_livid");
    final totalNumberOfReplies = int.tryParse(countNode?.text ?? "");

    return Topic(topicId, topicTitle ?? "",
        creator: creator,
        totalNumberOfReplies: totalNumberOfReplies ?? 0,
        latestReplyTime: latestReplyTime,
        node: topicNode);
  }).toList();

  print("topics : " + topics.toString());

  //节点
  final nodes = boxNodes
      .get(1)
      ?.querySelectorAll("div > table > tbody > tr")
      .map((element) {
    final categoryName = element.firstChild?.firstChild?.text;
    final nodes = element.children.get(1)?.children.map((e) {
      final nodeId = e.attributes['href']?.replaceFirst("/go/", "");
      final nodeName = e.text;
      return entity.Node(nodeId ?? "", nodeName);
    }).toList();
    return entity.NodeCategory(categoryName ?? "", nodes ?? const []);
  }).toList();

  print("nodes : " + nodes.toString());

  return HomeData(
    tabs ?? const [],
    topics ?? const [],
    nodes ?? const [],
  );
}

String _parseTopicId(String path) {
  final regex = RegExp("^/t/(\\d+)#reply\\d+\$");
  final match = regex.firstMatch(path);
  return match?.group(1) ?? "";
}
