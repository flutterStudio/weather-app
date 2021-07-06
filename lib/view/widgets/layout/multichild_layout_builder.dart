import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/extensions.dart';

class ResponsiveMultiChildLayout extends StatelessWidget {
  final int _onXSm;
  final int _onSm;
  final int _onMd;
  final int _onLg;
  final int _onXLg;
  final int _onXXLg;
  final bool _extendsLastChild;
  final List<ResponsiveMultiChildLayoutChild> _children;

  /// A wrapper widget that helps to writes a customizable responsive design,
  /// This widget uses the bootstrap's standard web breakpoints.
  ///
  /// *** parameters ***
  /// * [onXSm] the number of columns when `screen size is < 576`.
  /// * [onSm] the number of columns when `screen size is >= 576`.
  /// * [onMd] the number of columns when `screen size is >= 768`.
  /// * [onLg] the number of columns when `screen size is >= 992`.
  /// * [onXLg] the number of columns when `screen size is >= 1200`.
  /// * [onXXLg] the number of columns when `screen size is >= 1400`.
  ///
  /// *** Example ***
  /// ```dart
  /// ResponsiveMultiChildLayout(
  ///     onXSm: 1,
  ///     onMd: 2,
  ///     onXLg: 5,
  ///     children: [
  ///   ResponsiveMultiChildLayoutChild(
  ///       child: Container(
  ///     height: 100,
  ///     color: Colors.red,
  ///   )),
  ///   ResponsiveMultiChildLayoutChild(
  ///       child: Container(
  ///     height: 100,
  ///     color: Colors.black,
  ///   )),
  ///   ResponsiveMultiChildLayoutChild(
  ///       child: Container(
  ///     height: 200,
  ///     color: Colors.green,
  ///   )),
  ///   ResponsiveMultiChildLayoutChild(
  ///       child: Container(
  ///     height: 200,
  ///     color: Colors.amber,
  ///   )),
  ///   ResponsiveMultiChildLayoutChild(
  ///       flex: 1,
  ///       child: Container(
  ///         height: 100,
  ///         color: Colors.red,
  ///       )),
  /// ])
  /// ```
  ///
  ResponsiveMultiChildLayout(
      {required List<ResponsiveMultiChildLayoutChild> children,
      required int onXSm,
      bool extendsLastchild = false,
      int? onSm,
      int? onMd,
      int? onLg,
      int? onXLg,
      int? onXXLg})
      : _children = children,
        _extendsLastChild = extendsLastchild,
        _onXSm = onXSm,
        _onSm = onSm ?? onXSm,
        _onMd = onMd ?? onSm ?? onXSm,
        _onLg = onLg ?? onMd ?? onSm ?? onXSm,
        _onXLg = onXLg ?? onLg ?? onMd ?? onSm ?? onXSm,
        _onXXLg = onXXLg ?? onXLg ?? onLg ?? onMd ?? onSm ?? onXSm;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomMultiChildLayout(
            delegate: _CutomLayout(_children, _extendsLastChild, _onXSm, _onSm,
                _onMd, _onLg, _onXLg, _onXXLg),
            children: _children
                .mapIndexed((e, i) => LayoutId(id: i, child: e.child))
                .toList()));
  }
}

/// A custom child widget for `ResponsiveMultiChildLayout` widget.
/// This widget uses the bootstrap's standard web breakpoints.
///
/// *** parameters ***
/// * [child] `Widget` The widget to be rendered inside `MultiChildLayoutDelegate`.
/// * [flex] `int` The value the represents `child's` width comparing to other
/// children.
class ResponsiveMultiChildLayoutChild {
  int flex;
  Widget child;
  ResponsiveMultiChildLayoutChild({required this.child, this.flex = 1});
}

class _CutomLayout extends MultiChildLayoutDelegate {
  final int onXSm;
  final int onSm;
  final int onMd;
  final int onLg;
  final int onXLg;
  final int onXXLg;
  final bool extendsLastChild;
  final List<ResponsiveMultiChildLayoutChild> children;

  _CutomLayout(this.children, this.extendsLastChild, this.onXSm, this.onSm,
      this.onMd, this.onLg, this.onXLg, this.onXXLg);
  @override
  void performLayout(Size size) {
    int colsCount = size.width < 576
        ? onXSm
        : size.width >= 576 && size.width < 768
            ? onSm
            : size.width >= 768 && size.width < 992
                ? onMd
                : size.width >= 992 && size.width < 1200
                    ? onLg
                    : size.width >= 1200 && size.width < 1400
                        ? onXLg
                        : onXXLg;

    drawChildren(colsCount, size);
  }

  /// Calculate flex values for each row.
  ///
  /// *** Parameters ***
  /// * [cols] columns number.
  /// * [size] parent size.
  ///
  /// *** Return ***
  /// * Return a `List<int>` that represents each row's flex count.
  List<int> getFlexes(int cols, Size size) {
    List<int> result = [];
    int rowsCount = (children.length / cols).ceil();
    int flexes = 0;
    for (int row = 1; row <= rowsCount; row++) {
      flexes = 0;
      for (int col = 0; col < cols; col++) {
        if (row * col >= children.length) {
          break;
        }
        flexes += children.elementAt(row * col).flex;
      }
      result.add(flexes);
    }

    return result;
  }

  void drawChildren(int cols, Size size) {
    // Get flex values of each row.
    List<int> rowsFlexes = getFlexes(cols, size);

    // Max height of each row
    double rowHeight = 0.0;
    double yOffset = 0.0;
    double xOffset = 0.0;
    for (int child = 0; child < children.length; child++) {
      int row = (child / cols).floor();
      int col = child % cols;
      // Item width
      // If all the children will be layouted in the same row, The shall expand
      // to use the whole width

      double width =
          size.width / rowsFlexes.elementAt(row) * children[child].flex;
      // child positioning offset.
      if (this.hasChild(child)) {
        Size rowItemSize = this.layoutChild(
            child,
            BoxConstraints(
              maxWidth: child == children.length - 1 && extendsLastChild
                  ? size.width
                  : width,
            ));
        this.positionChild(child, Offset(xOffset, row == 0 ? 0 : yOffset));
        rowHeight =
            rowItemSize.height > rowHeight ? rowItemSize.height : rowHeight;
        // Increase `yOffset` value when moving to the next column.
        yOffset += col == (cols - 1) ? rowHeight : 0;
        // Positon the next widget to right of this child.
        xOffset += width;

        // print(
        //     "Element $child  row : $row, col : $col --- rowheight = $rowHeight --- x = $x --- yOffset = $yOffset ");

        // Reset the max row height when moving to a new row.
        rowHeight = col == (cols - 1) ? 0 : rowHeight;
      }

      // Reset the x offset value for the child when moving to a new row.
      xOffset = col == (cols - 1) ? 0 : xOffset;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
