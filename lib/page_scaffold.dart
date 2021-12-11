library page_scaffold;

import 'package:flutter/material.dart';

class PageScaffoldItem {
  final String lable;
  final Icon icon;
  final Icon? activeIcon;
  final bool keepAlive;
  final WidgetBuilder builder;

  const PageScaffoldItem({
    required this.lable,
    required this.icon,
    this.activeIcon,
    this.keepAlive = false,
    required this.builder,
  });
}

class KeepAliveView extends StatefulWidget {
  final Widget child;
  const KeepAliveView({Key? key, required this.child}) : super(key: key);
  @override
  KeepAliveViewState createState() => KeepAliveViewState();
}

class KeepAliveViewState extends State<KeepAliveView>
    with AutomaticKeepAliveClientMixin<KeepAliveView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

enum _ScreenType {
  small,
  lage,
}

class PageScaffold extends StatefulWidget {
  const PageScaffold({
    Key? key,
    required this.leftNavigationBarBuilder,
    required this.bottomNavigationBarBuilder,
    required this.pageBuilder,
    this.pageCount,
    this.controller,
    this.leftNavigationBarWidth = 300,
  }) : super(key: key);
  final PageController? controller;
  final IndexedWidgetBuilder bottomNavigationBarBuilder;
  final IndexedWidgetBuilder leftNavigationBarBuilder;
  final double leftNavigationBarWidth;
  final IndexedWidgetBuilder pageBuilder;
  final int? pageCount;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PageController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  _ScreenType _getScreenType(BuildContext context) {
    if (MediaQuery.of(context).size.width < 768) {
      return _ScreenType.small;
    } else {
      return _ScreenType.lage;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenType = _getScreenType(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _buildBody(context, screenType),
      bottomNavigationBar: _buildBottomNavigationBar(screenType),
    );
  }

  Widget? _buildBottomNavigationBar(_ScreenType screenType) {
    if (screenType == _ScreenType.small) {
      return _MenuBar(
        controller: _controller,
        builder: widget.bottomNavigationBarBuilder,
      );
    }
  }

  Widget _buildLeftNavigationBar(BuildContext context) {
    return SizedBox(
      width: widget.leftNavigationBarWidth,
      child: _MenuBar(
        controller: _controller,
        builder: widget.leftNavigationBarBuilder,
      ),
    );
  }

  Widget _buildPages(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      itemBuilder: widget.pageBuilder,
      itemCount: widget.pageCount,
    );
  }

  Widget _buildBody(BuildContext context, _ScreenType screenType) {
    return Row(
      children: [
        ...(screenType == _ScreenType.small)
            ? []
            : [
                _buildLeftNavigationBar(context),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                )
              ],
        Expanded(
          child: _buildPages(context),
        ),
      ],
    );
  }
}

class _MenuBar extends StatefulWidget {
  final PageController controller;
  final IndexedWidgetBuilder builder;

  const _MenuBar({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<_MenuBar> {
  late int _index;

  @override
  void initState() {
    if (widget.controller.hasClients && widget.controller.page != null) {
      _index = widget.controller.page!.round();
    } else {
      _index = widget.controller.initialPage;
    }
    widget.controller.addListener(_indexChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_indexChange);
    super.dispose();
  }

  void _indexChange() {
    int page = widget.controller.page!.round();
    if (_index != page) {
      setState(() {
        _index = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _index,
    );
  }
}
