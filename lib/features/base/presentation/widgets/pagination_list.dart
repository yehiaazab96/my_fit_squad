import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'list_loading.dart';

class PaginationList extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool? hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int fixedItemsCount;
  final bool loading;
  final Widget? loadingPlaceholder;
  final double? placeholderHeight;
  final EdgeInsetsGeometry? padding;
  final double? cacheExtent;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final SliverGridDelegate? gridDelegate;
  final ScrollController? scrollController;

  const PaginationList({
    Key? key,
    this.onLoadMore,
    this.onRefresh,
    this.hasMore,
    this.fixedItemsCount = 0,
    required this.itemBuilder,
    this.itemCount = 0,
    this.loadingPlaceholder,
    this.placeholderHeight,
    this.loading = false,
    this.padding,
    this.cacheExtent,
    this.scrollController,
  })  : separatorBuilder = null,
        gridDelegate = null,
        super(key: key);

  const PaginationList.separated({
    Key? key,
    this.onLoadMore,
    this.onRefresh,
    this.hasMore,
    this.loadingPlaceholder,
    this.placeholderHeight,
    this.fixedItemsCount = 0,
    required this.itemBuilder,
    this.itemCount = 0,
    this.loading = false,
    this.padding,
    this.cacheExtent,
    required this.separatorBuilder,
    this.scrollController,
  })  : gridDelegate = null,
        super(key: key);

  const PaginationList.grid({
    Key? key,
    this.onLoadMore,
    this.onRefresh,
    this.hasMore,
    this.loadingPlaceholder,
    this.placeholderHeight,
    this.fixedItemsCount = 0,
    required this.itemBuilder,
    this.itemCount = 0,
    this.loading = false,
    this.padding,
    this.cacheExtent,
    required this.gridDelegate,
    this.scrollController,
  })  : separatorBuilder = null,
        super(key: key);

  @override
  PaginationListState createState() {
    return PaginationListState();
  }
}

class PaginationListState extends State<PaginationList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    initScrollController();
    addPaginationListener();
  }

  void initScrollController() {
    _scrollController = widget.scrollController ?? ScrollController();
  }

  Future<void> addPaginationListener() async {
    _scrollController.addListener(() async {
      var pos = _scrollController.position;
      var onLoadMore = widget.onLoadMore;
      if (pos.pixels == pos.maxScrollExtent &&
          (widget.hasMore ?? true) &&
          onLoadMore != null) {
        await onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var placeHolder = widget.loadingPlaceholder;
    var height = widget.placeholderHeight ?? 0;
    var crossFadeState = (widget.loading && placeHolder != null && height != 0)
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;

    return AnimatedCrossFade(
        firstChild: LoadingList(
          padding: widget.padding,
          childHeight: height,
          enabled: widget.loading,
          child: placeHolder!,
        ),
        secondChild: getList(),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 700));
  }

  Widget getList() {
    var physics = widget.scrollController == null
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics();
    var itemCount =
        (widget.itemCount > widget.fixedItemsCount && (widget.hasMore ?? false))
            ? (widget.itemCount + 1)
            : widget.itemCount;
    itemBuilder(context, index) {
      if (widget.itemCount > widget.fixedItemsCount &&
          index == (widget.itemCount)) {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   widget.onLoadMore?.call();
        // });
        return buildLoadMoreWidget(context);
      }
      return widget.itemBuilder(context, index);
    }

    var list = widget.separatorBuilder != null
        ? ListView.separated(
            cacheExtent: widget.cacheExtent,
            physics: physics,
            controller:
                widget.scrollController == null ? _scrollController : null,
            padding: widget.padding,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            separatorBuilder: widget.separatorBuilder!,
            shrinkWrap: widget.scrollController == null ? false : true,
          )
        : widget.gridDelegate == null
            ? ListView.builder(
                cacheExtent: widget.cacheExtent,
                physics: physics,
                controller:
                    widget.scrollController == null ? _scrollController : null,
                padding: widget.padding,
                itemBuilder: itemBuilder,
                itemCount: itemCount,
                shrinkWrap: widget.scrollController == null ? false : true,
              )
            : GridView.builder(
                gridDelegate: widget.gridDelegate!,
                cacheExtent: widget.cacheExtent,
                physics: physics,
                controller:
                    widget.scrollController == null ? _scrollController : null,
                padding: widget.padding,
                itemBuilder: itemBuilder,
                itemCount: itemCount,
                shrinkWrap: widget.scrollController == null ? false : true,
              );

    var onRefresh = widget.onRefresh;

    return Builder(
      builder: (cx) => SizedBox(
        height: widget.scrollController != null
            ? null
            : MediaQuery.of(cx).size.height,
        child: onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh,
                color: Theme.of(context).primaryColor,
                child: list,
              )
            : list,
      ),
    );
  }

  Widget buildLoadMoreWidget(BuildContext context) {
    if (!(widget.hasMore ?? false))
      return const SizedBox(
        height: 0,
        width: 0,
      );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: SpinKitChasingDots(
        color: Theme.of(context).primaryColor,
        size: 30,
      )
          // CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,)

          ),
    );
  }
}
