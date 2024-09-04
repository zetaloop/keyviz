import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keyviz/config/config.dart';
import 'package:keyviz/providers/key_event.dart';
import 'package:keyviz/providers/key_style.dart';

import '../widgets/widgets.dart';

class MouseTabView extends StatelessWidget {
  const MouseTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PanelItem(
          title: "可视化鼠标点击",
          subtitle: "鼠标按钮按下时显示动画",
          action: Selector<KeyEventProvider, bool>(
            selector: (_, keyEvent) => keyEvent.showMouseClicks,
            builder: (context, showMouseClicks, _) => XSwitch(
              value: showMouseClicks,
              onChange: (value) {
                context.keyEvent.showMouseClicks = value;
              },
            ),
          ),
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (context, enabled, _) {
            return PanelItem(
              enabled: enabled,
              title: "动画类型",
              action: Selector<KeyStyleProvider, MouseClickAnimation>(
                selector: (_, keyStyle) => keyStyle.clickAnimation,
                builder: (context, value, _) {
                  return XDropdown<MouseClickAnimation>(
                    value: value,
                    options: MouseClickAnimation.values,
                    onChanged: (value) {
                      context.keyStyle.clickAnimation = value;
                    },
                  );
                },
              ),
            );
          },
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (context, enabled, _) => PanelItem(
            enabled: enabled,
            title: "动画颜色",
            subtitle: "光标动画的颜色",
            actionFlex: 2,
            action: RawColorInputSubPanelItem(
              label: "鼠标点击动画颜色",
              defaultValue: context.keyStyle.clickColor,
              onChanged: (color) => context.keyStyle.clickColor = color,
            ),
          ),
        ),
        const Divider(),
        Selector<KeyEventProvider, bool>(
          selector: (_, keyEvent) => keyEvent.showMouseClicks,
          builder: (_, enabled, __) => PanelItem(
            enabled: enabled,
            title: "保持显示",
            subtitle: "一直显示光标周围的动画",
            action: Selector<KeyEventProvider, bool>(
              selector: (_, keyEvent) => keyEvent.highlightCursor,
              builder: (context, highlightCursor, _) => XSwitch(
                value: highlightCursor,
                onChange: (value) {
                  context.keyEvent.highlightCursor = value;
                },
              ),
            ),
          ),
        ),
        const Divider(),
        PanelItem(
          title: "显示鼠标动作",
          subtitle: "将鼠标按钮的动作，比如点击、拖动等，跟快捷键一起显示",
          action: Selector<KeyEventProvider, bool>(
            selector: (_, keyEvent) => keyEvent.showMouseEvents,
            builder: (context, showMouseEvents, _) => XSwitch(
              value: showMouseEvents,
              onChange: (value) {
                context.keyEvent.showMouseEvents = value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
