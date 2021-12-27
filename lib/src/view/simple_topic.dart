import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2fly/src/common/date.dart';
import 'package:v2fly/src/model/topic.dart';
import 'package:v2fly/src/page/typedef.dart';
import 'package:v2fly/src/res/colors.dart';

class SimpleTopicView extends StatelessWidget {
  final Topic topic;
  final TopicCallback? onTapTopic;
  final UserCallback? onTapUser;

  const SimpleTopicView(this.topic, {this.onTapTopic, this.onTapUser, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      color: AppColors.black85,
      fontSize: 15,
      fontWeight: FontWeight.normal,
      height: 1.6,
    );

    const subtitleStyle = TextStyle(color: AppColors.black45, fontSize: 13);

    const numberStyle = TextStyle(
        color: AppColors.white100, fontWeight: FontWeight.bold, fontSize: 13);

    return InkWell(
      onTap: () {
        onTapTopic?.call(topic);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: const BoxDecoration(
                            color: AppColors.black5,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          topic.node?.name ?? "",
                          style: const TextStyle(color: AppColors.black45),
                        ),
                      )),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(text: topic.title, style: titleStyle),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  child: CachedNetworkImage(
                      width: 24,
                      height: 24,
                      imageUrl: topic.creator?.avatar ?? ""),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(topic.creator?.name ?? "", style: subtitleStyle),
                if (topic.latestReplyTime != null)
                  const Text(
                    "  •  ",
                    style: subtitleStyle,
                  ),
                if (topic.latestReplyTime != null)
                  Text(
                    dateTimeToDisplay(topic.latestReplyTime!),
                    // topic.latestReplyTime.toString(),
                    style: subtitleStyle,
                  ),
                const Spacer(),
                Container(
                    height: 18,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        color: AppColors.black20,
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    child: Text(
                      topic.totalNumberOfReplies.toString(),
                      style: numberStyle,
                    ))
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
