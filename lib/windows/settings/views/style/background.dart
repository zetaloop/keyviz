import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_style.dart';
import 'package:keyviz/windows/shared/shared.dart';

import '../../widgets/widgets.dart';

class BackgroundView extends StatelessWidget {
  const BackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<KeyStyleProvider, bool>(
      selector: (_, keyStyle) => keyStyle.backgroundEnabled,
      builder: (context, enabled, _) {
        return XExpansionTile(
          title: "背景",
          children: [
            SubPanelItemGroup(
              items: [
                RawSubPanelItem(
                  title: "开启",
                  child: XSwitch(
                    value: enabled,
                    onChange: (value) {
                      context.keyStyle.backgroundEnabled = value;
                    },
                  ),
                ),
                RawColorInputSubPanelItem(
                  enabled: enabled,
                  label: "背景颜色",
                  defaultValue: context.keyStyle.backgroundColor,
                  onChanged: (color) {
                    context.keyStyle.backgroundColor = color;
                  },
                ),
              ],
            ),
            const VerySmallColumnGap(),
            SubPanelItem(
              title: "透明度",
              enabled: enabled,
              child: Selector<KeyStyleProvider, double>(
                selector: (_, keyStyle) => keyStyle.backgroundOpacity,
                builder: (context, opacity, _) => XSlider(
                  max: 100,
                  suffix: "%",
                  value: opacity * 100,
                  onChanged: (value) {
                    context.keyStyle.backgroundOpacity = value / 100;
                  },
                ),
              ),
            ),
            Selector<KeyStyleProvider, bool>(
              selector: (_, keyStyle) {
                return keyStyle.keyCapStyle == KeyCapStyle.minimal;
              },
              builder: (context, isMinimal, child) => isMinimal
                  ? Column(
                      children: [
                        const VerySmallColumnGap(),
                        SubPanelItem(
                          enabled: enabled,
                          title: "圆角",
                          child: Selector<KeyStyleProvider, double>(
                            selector: (_, keyStyle) => keyStyle.cornerSmoothing,
                            builder: (context, cornerSmoothing, _) {
                              return XSlider(
                                max: 100,
                                suffix: "%",
                                value: cornerSmoothing * 100,
                                onChanged: (value) {
                                  context.keyStyle.cornerSmoothing =
                                      value / 100;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
