import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_style.dart';
import 'package:keyviz/windows/shared/shared.dart';

import '../../widgets/widgets.dart';

class BorderView extends StatelessWidget {
  const BorderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<KeyStyleProvider, bool>(
      selector: (_, keyStyle) => keyStyle.borderEnabled,
      builder: (context, enabled, _) => XExpansionTile(
        title: "边框",
        children: [
          Selector<KeyStyleProvider, bool>(
              selector: (_, keyStyle) => keyStyle.differentColorForModifiers,
              builder: (context, differentColors, _) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SubPanelItemGroup(
                      items: [
                        RawSubPanelItem(
                          title: "开启",
                          child: XSwitch(
                            value: enabled,
                            onChange: (value) {
                              context.keyStyle.borderEnabled = value;
                            },
                          ),
                        ),
                        if (!differentColors)
                          RawColorInputSubPanelItem(
                            enabled: enabled,
                            label: "边框颜色",
                            defaultValue: context.keyStyle.borderColor,
                            onChanged: (color) {
                              context.keyStyle.borderColor = color;
                            },
                          ),
                      ],
                    ),
                    if (differentColors) ...[
                      const VerySmallColumnGap(),
                      SubPanelItem(
                        enabled: enabled,
                        title: "常规键",
                        child: SizedBox(
                          width: defaultPadding * 10,
                          child: RawColorInputSubPanelItem(
                            label: "常规键边框颜色",
                            defaultValue: context.keyStyle.borderColor,
                            onChanged: (color) {
                              context.keyStyle.borderColor = color;
                            },
                          ),
                        ),
                      ),
                      const VerySmallColumnGap(),
                      SubPanelItem(
                        enabled: enabled,
                        title: "修饰键",
                        child: SizedBox(
                          width: defaultPadding * 10,
                          child: RawColorInputSubPanelItem(
                            label: "修饰键边框颜色",
                            defaultValue: context.keyStyle.mBorderColor,
                            onChanged: (color) {
                              context.keyStyle.mBorderColor = color;
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              }),
          const VerySmallColumnGap(),
          SubPanelItem(
            enabled: enabled,
            title: "厚度",
            child: Selector<KeyStyleProvider, double>(
              selector: (_, keyStyle) => keyStyle.borderWidth,
              builder: (context, borderWidth, _) => XSlider(
                suffix: "px",
                min: 1,
                max: 8,
                value: borderWidth,
                onChanged: (value) => context.keyStyle.borderWidth = value,
              ),
            ),
          ),
          const VerySmallColumnGap(),
          SubPanelItem(
            title: "圆角",
            child: Selector<KeyStyleProvider, double>(
              selector: (_, keyStyle) => keyStyle.cornerSmoothing,
              builder: (context, cornerSmoothing, _) {
                return XSlider(
                  max: 100,
                  suffix: "%",
                  value: cornerSmoothing * 100,
                  onChanged: (value) {
                    context.keyStyle.cornerSmoothing = value / 100;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
