import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///文本全选、复制
class IBSelectionArea {
  static Widget wrap(Text child, {bool selectAll = true, bool copy = true}) {
    //选择的文本
    var selectedText = '';
    return SelectionArea(
      child: child,
      onSelectionChanged: (SelectedContent? selectContent) =>
          selectedText = selectContent?.plainText ?? "",
      contextMenuBuilder:
          (BuildContext context, SelectableRegionState selectableRegionState) {
        bool selectAllEnable = false;
        //如果还有可选的内容则展示全选菜单
        if (selectedText.length < (child.data?.length ?? 0)) {
          selectAllEnable = true;
        }
        final List<ContextMenuButtonItem> buttonItems = [
          if (selectAll && selectAllEnable)
            ContextMenuButtonItem(
                label: '全选',
                onPressed: () {
                  selectableRegionState
                      .selectAll(SelectionChangedCause.toolbar);
                }),
          if (copy)
            ContextMenuButtonItem(
                label: '复制',
                onPressed: () {
                  selectableRegionState
                      .copySelection(SelectionChangedCause.toolbar);
                })
        ];
        return AdaptiveTextSelectionToolbar.buttonItems(
          buttonItems: buttonItems,
          anchors: selectableRegionState.contextMenuAnchors,
        );
      },
    );
  }
}
