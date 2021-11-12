import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:itg_marvel_task/utils/api.dart';
import 'package:itg_marvel_task/utils/dimens.dart';
import 'package:itg_marvel_task/widgets/loading_widget.dart';

class ScrollViewWithPaginationWidget extends StatefulWidget {
  final Widget contentWidget;
  final Function(int) onPagination;
  final int maxCount;
  final Axis scrollDirection;

  const ScrollViewWithPaginationWidget({
    Key? key,
    required this.contentWidget,
    required this.onPagination,
    required this.maxCount,
    required this.scrollDirection,
  }) : super(key: key);

  @override
  _ScrollViewWithPaginationWidgetState createState() =>
      _ScrollViewWithPaginationWidgetState();
}

class _ScrollViewWithPaginationWidgetState
    extends State<ScrollViewWithPaginationWidget> {
  ScrollController? _listScrollController;
  int _apiCount = 20;

  @override
  void initState() {
    _listScrollController = ScrollController();
    _listScrollController!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollController!.removeListener(_scrollListener);
  }

  bool showLoading = false;

  _scrollListener() async {
    if (_listScrollController!.offset >=
            _listScrollController!.position.maxScrollExtent &&
        !_listScrollController!.position.outOfRange &&
        _apiCount < widget.maxCount) {
     if(_apiCount == widget.maxCount){
     }
      showLoading = true;
      _apiCount = _apiCount + API.kPerPage;
      widget.onPagination(_apiCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(physics: const BouncingScrollPhysics(),
      controller: _listScrollController,
      scrollDirection: widget.scrollDirection,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            widget.contentWidget,
            showLoading ? _apiCount>=widget.maxCount?const SizedBox():Padding(
                    padding: EdgeInsets.only(
                        bottom: setHeight(context, 0.01),
                        top: setHeight(context, 0.01)),
                    child: const LoadingWidget(),
                  )
                : const SizedBox()
          ]),
        ),
      ],
    );
  }
}
