import 'package:flutter/material.dart';
import 'package:weather_app/model/data.dart';
import 'package:weather_app/utils/colors_utils.dart';

/// [RequestHandler] show widgets due to the [Data] object status.
/// [stream]] accepts [Stream] of [Future<Data>], [stream] is required.
/// [mainContent] is the main widget that you want to handle requests from.
/// [onSuccess] is the main widget when [Data] status is succeed, [onSuccess] is required.
/// [onFailed] is thw widget that appears when [Data] status is failed, [onFailed] has a default widget.
/// [inProgress] is the widget that appears when the [Data] status is in-progress, [inProgress] has a default value.
/// [isDismissible] is a boolean variable that indicates if you want user to
/// dismiss messages that shows upon the [mainContent] or not.
/// [other] is the widget that appears when the [Data] status is not one of the previous statuses, [other] has a default value.
class RequestHandler<T> extends StatefulWidget {
  final Stream<Data<T>> _stream;
  final Widget Function(BuildContext, T?) _onSuccess;
  final Widget? _onFailed;
  final Widget? _inProgress;
  final Widget? _other;

  RequestHandler(
      {@required main,
      @required onSuccess,
      Widget? onFailed,
      Widget? inProgress,
      other,
      isDismissible,
      @required stream})
      : _onSuccess = onSuccess,
        _onFailed = onFailed,
        _inProgress = inProgress,
        _other = other,
        _stream = stream;

  @override
  _RequestHandlerState<T> createState() => _RequestHandlerState<T>();
}

class _RequestHandlerState<T> extends State<RequestHandler<T>> {
  // Join close stream and the provided stream to one stream.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Data<T>>(
          stream: widget._stream,
          builder: (context, AsyncSnapshot<Data<T>> snapshot) {
            // If request has not been initialized yet;
            if (!snapshot.hasData || snapshot.data?.status == DataStatus.none)
              return SizedBox(
                width: 0,
              );
            // If the request is in progress
            if (snapshot.data?.status == DataStatus.inProgress) {
              return widget._inProgress ??
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Center(child: CircularProgressIndicator()),
                  );

              // If the response has been received
            } else {
              switch (snapshot.data?.status) {
                case DataStatus.faild:
                  return snapshot.data?.data != null
                      ? widget._onSuccess(context, snapshot.data?.data)
                      : widget._onFailed ??
                          _InfoWidget.failed(message: snapshot.data?.message);
                case DataStatus.none:
                  return snapshot.data?.data != null
                      ? widget._onSuccess(context, snapshot.data?.data)
                      : widget._onFailed ??
                          _InfoWidget.failed(message: "Empty Response");
                case DataStatus.succeed:
                  // Build content widget on the data provided by the stream
                  return widget._onSuccess(context, snapshot.data?.data);
                default:
                  return widget._other ??
                      _InfoWidget(message: "Unhandled Error");
              }
            }
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _InfoWidget extends StatelessWidget {
  final String _message;
  final TextStyle? _textStyle;
  final Color? _bgColor;

  _InfoWidget({@required message, messageTextStyle})
      : _message = message,
        _textStyle = messageTextStyle,
        _bgColor = null;

  _InfoWidget.failed({@required message})
      : _message = message,
        _textStyle = null,
        _bgColor = AppColors.error;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _bgColor ?? Theme.of(context).colorScheme.background,
          ),
          padding: EdgeInsets.all(24),
          child: Text(_message, style: _textStyle),
        ),
      ),
    );
  }
}
