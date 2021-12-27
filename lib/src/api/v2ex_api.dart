import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:v2fly/src/api/v2ex_http_maker.dart';
import 'package:v2fly/src/common/date.dart';
import 'package:v2fly/src/common/extensions/list.dart';
import 'package:v2fly/src/common/network/http_maker.dart';
import 'package:v2fly/src/common/network/response.dart';
import 'package:v2fly/src/model/home.dart';
import 'package:v2fly/src/model/node.dart' as entity;
import 'package:v2fly/src/model/result.dart';
import 'package:v2fly/src/model/topic.dart';
import 'package:v2fly/src/model/user.dart';

class V2exApi {
  static const String baseUrl = "https://v2ex.com";
  static V2exApi? _instance;

  V2exApi._();

  factory V2exApi.getInstance() => _getInstance();

  static V2exApi _getInstance() {
    _instance ??= V2exApi._();
    return _instance!;
  }

  Future<ResponseResult<HomeData>> getHome(String tabId) async {
    final homeUrl = tabId.isEmpty ? baseUrl : baseUrl + "/?tab=$tabId";

    final result = await V2exHttpMaker.getInstance().htmlGet<HomeData>(
        (element) => HomeData.fromHtml(element), homeUrl,
        headers: {
          HttpMakerParams.method: HttpMakerParams.methodGet,
        });

    return result;
  }

  Future<NetworkResponse<String?>> getTopic(String topicId, int page) async {
    final topicUrl = "https://v2ex.com/t/$topicId?p=$page";
    final result = await doHttpMaker<String>({
      HttpMakerParams.url: topicUrl,
      HttpMakerParams.method: HttpMakerParams.methodGet,
    });
    return result;
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

  final boxNodes = dom.querySelectorAll("#Main > .box");

  final topics = boxNodes.firstOrNull
      ?.querySelectorAll("div > table > tbody > tr")
      .map((e) {
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

    final latestReplyTimeText = e
        .querySelector(".topic_info > span")
        ?.attributes['title']
        ?.replaceFirst(' +08:00', "");
    final latestReplyTime = dateTimeFromString(latestReplyTimeText ?? "");

    final countNode = e.querySelector(".count_livid");
    final totalNumberOfReplies = int.tryParse(countNode?.text ?? "");

    return Topic(topicId, topicTitle ?? "",
        creator: creator,
        totalNumberOfReplies: totalNumberOfReplies ?? 0,
        latestReplyTime: latestReplyTime,
        node: topicNode);
  }).toList();

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

Topic _parseTopicDetailHtml(String html) {
  final dom = parse(html);
  final boxNode = dom.querySelectorAll("#Main > .box");
  final firstBoxNode = boxNode.first;

  final headerNode = firstBoxNode.firstChild;
  final nodeNode = firstBoxNode.children.get(3);
  final nodeId = nodeNode?.attributes["href"];
  final nodeName = nodeNode?.text;
  final node = entity.Node(nodeId ?? "", nodeName ?? "");

  final creatorNode = firstBoxNode.firstChild?.firstChild?.firstChild;
  final creatorName = creatorNode?.attributes["alt"];
  final creatorAvatar = creatorNode?.attributes["src"];
  final creator = User(creatorName ?? "", creatorAvatar ?? "");

  final topicId = headerNode?.children
      .get(6)
      ?.id
      .replaceFirst("topic_", "")
      .replaceFirst("_votes", "");
  final topicTitle = headerNode?.children.get(5)?.text;

  final grayNode = firstBoxNode.querySelector(".header > .gray");
  final numberOfHitsText = grayNode?.children
      .get(2)
      ?.text
      .replaceFirst(" · ", "")
      .replaceFirst(" 次点击", "");
  final numberOfHits =
      numberOfHitsText == null ? 0 : int.tryParse(numberOfHitsText);
  final createTime =
      dateTimeFromString(grayNode?.children.get(3)?.attributes["title"] ?? "");

  final content =
      dom.querySelector(".topic_content > .markdown_body")?.innerHtml;

  final postscripts = dom.querySelectorAll(".subtle").map((subtleNode) {
    final createTimeText =
        subtleNode.getElementsByClassName("fade").get(2)?.attributes['title'];
    final createTime = dateTimeFromString(createTimeText ?? "");
    final content = subtleNode
        .getElementsByClassName("topic_content")
        .firstOrNull
        ?.innerHtml;
    return Postscript(createTime, content ?? "");
  }).toList();

  final secondBoxNode = boxNode.get(1);

  final replyNode = secondBoxNode?.querySelector(".cell > .gray");
  final latestReplyTimeText = replyNode?.children.get(2)?.text;
  final latestReplyTime = latestReplyTimeText == null
      ? null
      : dateTimeFromString(latestReplyTimeText);
  final replyNumberText = replyNode?.firstChild?.text;
  final replyNumber = int.tryParse(replyNumberText ?? "") ?? 0;

  final replies = secondBoxNode?.children
      .where((element) => element.attributes["id"] != null)
      .map((e) {
    final replyId = e.attributes['id']?.replaceFirst("r_", "");

    final replyNode = secondBoxNode.querySelector(".cell > table > tbody > tr");

    final creatorNode = replyNode?.firstChild?.firstChild;
    final creatorName = creatorNode?.attributes["alt"];
    final creatorAvatar = creatorNode?.attributes["src"];
    final creator = User(creatorName ?? "", creatorAvatar ?? "");

    final contentNode = replyNode?.children.get(2);
    final agoNode = contentNode?.getElementsByClassName("ago").firstOrNull;
    final createTimeText = agoNode?.attributes["title"];
    final createTime = dateTimeFromString(createTimeText ?? "");
    final via = _parseViaFromText(agoNode?.text);

    final numberOfThanksText =
        contentNode?.getElementsByClassName("small fade").get(1)?.text.trim();
    final numberOfThanks = int.tryParse(numberOfThanksText ?? "");
    final content = contentNode
        ?.getElementsByClassName("reply_content")
        .firstOrNull
        ?.innerHtml;

    return Reply(replyId ?? "", creator, createTime, numberOfThanks ?? 0,
        content ?? "", via);
  }).toList();

  return Topic(topicId ?? "", topicTitle ?? "",
      content: content ?? "",
      creator: creator,
      createTime: createTime,
      numberOfHits: numberOfHits ?? 0,
      postscripts: postscripts,
      totalNumberOfReplies: replyNumber,
      latestReplyTime: latestReplyTime,
      replies: replies ?? [],
      node: node);
}

String _parseViaFromText(String? text) {
  if (text == null) {
    return "";
  }
  final viaIndex = text.lastIndexOf("via");
  return text.substring(viaIndex + 3).trim();
}
