## SelectionArea实现文本全选复制功能
> FlutterSDK 3.16.0
## 实现一个可复用的文本的全选、复制功能的widget组件
目标明确，为了以后的易用性、可扩展性。单独抽出来一个widget类，功能内聚。
1. 对外方法定义，接受一个子widget（Text文本）、是否全选变量selectAll、是否复制变量copy，通过这两个变量控制是否显示全选、复制功能
2. 当前文本是否全选变量selectAllEnable，只有当selectAll=true&&selectAllEnable=true时，显示全选功能
3. SelectionArea源码：
    > const SelectionArea({
     super.key,
     this.focusNode,
     this.selectionControls,
     this.contextMenuBuilder = _defaultContextMenuBuilder,
     this.magnifierConfiguration,
     this.onSelectionChanged,
     required this.child,
     });
   我们需要的参数child必转、onSelectionChanged选中文本回调、contextMenuBuilder 菜单列表
4. onSelectionChanged源码：
   > final ValueChanged<SelectedContent?>? onSelectionChanged;
   > 回调回来一个可空的SelectedContent
5. contextMenuBuilder源码：
   > static Widget _defaultContextMenuBuilder(BuildContext context, SelectableRegionState selectableRegionState) {
   return AdaptiveTextSelectionToolbar.selectableRegion(
   selectableRegionState: selectableRegionState,
   );
   }
   >（1）、讲一下SelectableRegionState参数：
   >//1
   class SelectableRegionState extends State<SelectableRegion> with TextSelectionDelegate implements SelectionRegistrar {
   //2
   late final Map<Type, Action<Intent>> _actions = <Type, Action<Intent>>{
   SelectAllTextIntent: _makeOverridable(_SelectAllAction(this)),
   CopySelectionTextIntent: _makeOverridable(_CopySelectionAction(this)),
   ...
   }; 

   >@override
   void selectAll([SelectionChangedCause? cause]) {
   _clearSelection();
   _selectable?.dispatchSelectionEvent(const SelectAllSelectionEvent());
   if (cause == SelectionChangedCause.toolbar) {
   _showToolbar();
   _showHandles();
   }
   _updateSelectedContentIfNeeded();
   }

   >@Deprecated(
   'Use `contextMenuBuilder` instead. '
   'This feature was deprecated after v3.3.0-0.5.pre.',
   )
   @override
   void copySelection(SelectionChangedCause cause) {
   _copy();
   _clearSelection();
   }

   >@override
   Widget build(BuildContext context) {
   assert(debugCheckHasOverlay(context));
   Widget result = SelectionContainer(
   registrar: this,
   delegate: _selectionDelegate,
   child: widget.child,
   );
   if (kIsWeb) {
   result = PlatformSelectableRegionContextMenu(
   child: result,
   );
   }
   return CompositedTransformTarget(
   link: _toolbarLayerLink,
   child: RawGestureDetector(
   gestures: _gestureRecognizers,
   behavior: HitTestBehavior.translucent,
   excludeFromSemantics: true,
   child: Actions(
   actions: _actions,//初始化action如:全选、复制
   child: Focus(
   includeSemantics: false,
   focusNode: widget.focusNode,
   child: result,
   ),
   ),
   ),
   );
   }
   }

   > 1. with TextSelectionDelegate
      TextSelectionDelegate属于text_input类
      mixin TextSelectionDelegate {
      ...
      //全选
      void selectAll(SelectionChangedCause cause);
      //复制
      void copySelection(SelectionChangedCause cause);
      }

   > 2. _SelectAllAction、_CopySelectionAction
      class _SelectAllAction extends _NonOverrideAction<SelectAllTextIntent> {
      _SelectAllAction(this.state);
      final SelectableRegionState state;
      //invokeAction回调到SelectableRegionState的selectAll实现全选
      @override
      void invokeAction(SelectAllTextIntent intent, [BuildContext? context]) {
      state.selectAll(SelectionChangedCause.keyboard);
      }
      }
      class _CopySelectionAction extends _NonOverrideAction<CopySelectionTextIntent> {
      _CopySelectionAction(this.state);
      final SelectableRegionState state;
      //invokeAction回调到SelectableRegionState的_copy实现复制
      @override
      void invokeAction(CopySelectionTextIntent intent, [BuildContext? context]) {
      state._copy();
      }
      }
      （2）、_defaultContextMenuBuilder返回的是一个widget
      我们最终用AdaptiveTextSelectionToolbar.buttonItems源码如下:
      const AdaptiveTextSelectionToolbar.buttonItems({
      super.key,
      required this.buttonItems,
      required this.anchors,
      }) : children = null;
      buttonItems是ContextMenuButtonItem菜单集合，anchors是 contextMenuAnchors。
看看最终现实结果吧，源码如下。

## Tips
CSDN 

