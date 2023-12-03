import 'package:flutter/material.dart';
import 'package:selection_area/ib_selection_area.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectionArea实现文本全选复制功能',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SelectionArea实现文本全选复制功能'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String content =
      "5G的设想最早在2008年就由美国提出来了，但是当时4G还没有建设好，因此各国真正坐下来讨论5G的标准其实是在2012年前后。\n注：主管标准制定的机构叫做3GPP（第三代合作伙伴计划），它成立于1998年，最初只是为各国协调3G通信标准的组织，后来就负责其历代移动通信标准的制定了。今天世界上主要的通信厂家，包括中国的华为等企业，都在其中。    标准的制定过程和我们编写软件，或者写书很相像。参与者各自提供自己的想法，大家讨论、修改，形成共同的意见。由于技术不断发展，大家的想法也在改变，运营商的需求也不断增加，因此总有新的东西加进来。于是，主管标准制定的机构也就是3GPP，在某一个阶段，就必须冻结所有的需求，然后发布一个版本，叫做一个Release，中文常常把它简写成R。\n关于5G的标准，目前大家讨论的是15版（3GPP-R15）。在这个标准中，将5G的建设分为了两步走，这两步走得都很艰辛。第一步经过78次开会，无数的讨价还价和妥协，最后在去年底总算是确定下来了。第二步，在2019年6月份才确定。注：第一步是所谓的非独立组网模式NSA，即采用现有4G作为核心网，4G为主，5G为辅，对应的标准则是3GPP-R15-NSA，这是设想的前期做法。第二步是独立组网模式SA，5G作为核心网，只有5G基站工作，对应的标准是3GPP-R15-SA。这部分标准2019年6月份在高通所在地圣地亚哥才正式确定。";

  get _listView => ListView(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 15),
        children: [_textContent],
      );

  get _textContent => IBSelectionArea.wrap(Text(
        content,
        style: const TextStyle(fontSize: 16),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _listView,
    );
  }
}
