## SelectionArea实现文本全选复制功能
> FlutterSDK 3.16.0
## 实现一个可复用的文本的全选、复制功能的widget组件
目标明确，为了以后的易用性、可扩展性。单独抽出来一个widget类，功能内聚。
1. 对外方法定义，接受一个子widget（Text文本）、是否全选变量selectAll、是否复制变量copy，通过这两个变量控制是否显示全选、复制功能
2. 当前文本是否全选变量selectAllEnable，只有当selectAll=true&&selectAllEnable=true时，显示全选功能
3. SelectionArea源码分析略
4. onSelectionChanged源码分析略
5. contextMenuBuilder源码分析略
## Tips
详情请看CSDN https://ibrave.blog.csdn.net/article/details/134768351?spm=1001.2014.3001.5502

