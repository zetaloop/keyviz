import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/windows/shared/shared.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: defaultBorderRadius,
                border: Border.all(color: context.colorScheme.outline),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/img/logo.svg",
                    height: defaultPadding * 3.5,
                  ),
                  const SmallColumnGap(),
                  Text(
                    "Keyviz 2.0.0-alpha3",
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    "作者 Rahul Mula",
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SmallRowGap(),
            Expanded(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: defaultBorderRadius,
                  border: Border.all(color: context.colorScheme.outline),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SvgPicture.asset(
                        "assets/img/keycap-grid.svg",
                        width: defaultPadding * 9,
                        height: defaultPadding * 9,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        defaultPadding * 1.5,
                      ).copyWith(right: defaultPadding * 4),
                      child: Text(
                        "这是 Alpha 早期测试版，\n出现 bug 🐛 很正常。\n"
                        "如果遇到任何问题，\n请反馈给我们！",
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: defaultPadding * 1.5,
                    //   bottom: defaultPadding * 1.5,
                    //   child: RichText(
                    //     text: const TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: "⌨️",
                    //           style: TextStyle(fontSize: 40),
                    //         ),
                    //         TextSpan(
                    //           text: "🖱️",
                    //           style: TextStyle(fontSize: 30),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      left: defaultPadding * 1.5,
                      bottom: defaultPadding * 1.5,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => launchUrlString(
                              "https://discord.gg/qyrKWCvtEq",
                            ),
                            tooltip: "Discord",
                            icon: const SvgIcon(
                              icon: "assets/img/discord-logo.svg",
                              size: defaultPadding * .8,
                            ),
                          ),
                          IconButton(
                            onPressed: () => launchUrl(
                              Uri.parse("mailto:rahulmula10@gmail.com"),
                            ),
                            tooltip: "邮箱",
                            icon: const SvgIcon(icon: VuesaxIcons.mail),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SmallColumnGap(),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: defaultBorderRadius,
                  border: Border.all(color: context.colorScheme.outline),
                ),
                padding: const EdgeInsets.all(defaultPadding * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "💻 开发者的话",
                      style: context.textTheme.titleLarge,
                    ),
                    const VerySmallColumnGap(),
                    Text(
                      "你好 👋，我是 Keyviz 的开发者 Rahul Mula。"
                      "我也是一名线上讲师，在网上教授课程。\n\n"
                      "在录制教学视频时，我经常需要向观众展示我的键盘操作。"
                      "因此，我决定开发按键可视化软件 Keyviz，"
                      "并将其分享给大家，希望能帮助到有类似需求的朋友们。",
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SmallRowGap(),
            Container(
              height: 250,
              width: 200,
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: defaultBorderRadius,
                border: Border.all(color: context.colorScheme.outline),
              ),
              padding: const EdgeInsets.all(defaultPadding * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "💖 支持",
                    style: context.textTheme.titleLarge,
                  ),
                  const VerySmallColumnGap(),
                  Text(
                    "Keyviz 完全免费，依靠您的慷慨捐助来支持开发。"
                    "您的支持能让我投入更多时间和精力完善这款软件。",
                    style: context.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => launchUrlString(
                          "https://github.com/sponsors/mulaRahul",
                        ),
                        tooltip: "Github Sponsors",
                        icon: const SvgIcon(icon: "assets/img/github-logo.svg"),
                      ),
                      IconButton(
                        onPressed: () => launchUrlString(
                          "https://opencollective.com/keyviz",
                        ),
                        tooltip: "Open Collective",
                        icon: SvgPicture.asset(
                          "assets/img/opencollective-logo.svg",
                          width: defaultPadding,
                          height: defaultPadding,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
