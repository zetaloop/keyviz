import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_style.dart';
import 'package:keyviz/windows/shared/shared.dart';

import '../../widgets/widgets.dart';

class TypographyView extends StatelessWidget {
  const TypographyView({super.key});

  @override
  Widget build(BuildContext context) {
    return XExpansionTile(
      title: "文本",
      children: [
        Selector<KeyStyleProvider, bool>(
          selector: (_, keyStyle) => keyStyle.differentColorForModifiers,
          builder: (context, differentColorForModifiers, _) {
            return differentColorForModifiers
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SubPanelItem(
                        title: "文字大小",
                        child: Selector<KeyStyleProvider, double>(
                          selector: (_, keyStyle) => keyStyle.fontSize,
                          builder: (context, fontSize, _) => XSlider(
                            max: 128,
                            suffix: "px",
                            value: fontSize,
                            onChanged: (value) {
                              context.keyStyle.fontSize = value;
                            },
                          ),
                        ),
                      ),
                      const VerySmallColumnGap(),
                      SubPanelItem(
                        title: "常规键颜色",
                        child: SizedBox(
                          width: defaultPadding * 10,
                          child: RawColorInputSubPanelItem(
                            label: "常规键文字颜色",
                            defaultValue: context.keyStyle.fontColor,
                            onChanged: (Color value) {
                              context.keyStyle.fontColor = value;
                            },
                          ),
                        ),
                      ),
                      const VerySmallColumnGap(),
                      SubPanelItem(
                        title: "修饰键颜色",
                        child: SizedBox(
                          width: defaultPadding * 10,
                          child: RawColorInputSubPanelItem(
                            label: "修饰键文字颜色",
                            defaultValue: context.keyStyle.mFontColor,
                            onChanged: (Color value) {
                              context.keyStyle.mFontColor = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : SubPanelItemGroup(
                    items: [
                      RawInputSubPanelItem(
                        title: "文字大小",
                        suffix: "px",
                        defaultValue: context.keyStyle.fontSize.toInt(),
                        onChanged: (value) {
                          context.keyStyle.fontSize = value.toDouble();
                        },
                      ),
                      RawColorInputSubPanelItem(
                        label: "文字颜色",
                        defaultValue: context.keyStyle.fontColor,
                        onChanged: (color) {
                          context.keyStyle.fontColor = color;
                        },
                      ),
                    ],
                  );
          },
        ),
        const VerySmallColumnGap(),
        SubPanelItemGroup(
          items: [
            RawSubPanelItem(
              title: "大小写",
              child: Selector<KeyStyleProvider, TextCap>(
                selector: (_, keyStyle) => keyStyle.textCap,
                builder: (context, textCap, _) => Row(
                  children: [
                    for (final value in TextCap.values)
                      Tooltip(
                        message: value.toString(),
                        child: TextButton(
                          onPressed: () {
                            context.keyStyle.textCap = value;
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * .25,
                              horizontal: defaultPadding * .5,
                            ),
                          ),
                          child: Text(
                            value.symbol,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: value == textCap
                                  ? context.colorScheme.primary
                                  : context.colorScheme.tertiary,
                              fontWeight: value == textCap
                                  ? FontWeight.w700
                                  : FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            RawSubPanelItem(
              title: "修饰键",
              child: SizedBox(
                width: defaultPadding * 5,
                child: Selector<KeyStyleProvider, ModifierTextLength>(
                  selector: (_, keyStyle) => keyStyle.modifierTextLength,
                  builder: (context, modifierTextLength, _) {
                    return XDropdown<ModifierTextLength>(
                      decorated: false,
                      value: modifierTextLength,
                      options: ModifierTextLength.values,
                      onChanged: (value) {
                        context.keyStyle.modifierTextLength = value;
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
