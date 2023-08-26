import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_loader.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_no_connection.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/injection/injection_container.dart' as di;

class ScreenHandler extends StatefulWidget {
  final StateNotifierProvider<dynamic, BaseState<dynamic>> screenProvider;
  final void Function()? onDeviceReconnected;
  final String? noDataMessage;
  final IconData? noDataIcon;
  final Size? dialogSize;
  final bool? fromDialog;
  final bool? showLoading;

  const ScreenHandler({
    Key? key,
    required this.screenProvider,
    this.onDeviceReconnected,
    this.noDataMessage,
    this.dialogSize,
    this.noDataIcon,
    this.fromDialog = false,
    this.showLoading = true,
  }) : super(key: key);

  @override
  ScreenHandlerState createState() {
    return ScreenHandlerState();
  }
}

class ScreenHandlerState extends State<ScreenHandler> with BaseViewModel {
  bool isConnectedAtLastTime = true;

  late final _isLoadingProvider = Provider<bool>((ref) {
    return ref.watch(widget.screenProvider).isLoading;
  });

  // late final _actionSucceededProvider = Provider<bool>((ref) {
  //   return ref.watch(widget.screenProvider).actionSucceeded;
  // });

  // late final _successMessageProvider = Provider<String?>((ref) {
  //   return ref.watch(widget.screenProvider).successMessage;
  // });

  late final Provider<bool> _noConnectionProvider = Provider<bool>((ref) {
    return ref.watch(widget.screenProvider).hasNoConnection;
  });

  late final Provider<bool> _noDataProvider = Provider<bool>((ref) {
    return (ref.watch(widget.screenProvider).hasNoData);
  });

  late final Provider<bool> _isPerformingRequestProvider =
      Provider<bool>((ref) {
    return ref.watch(widget.screenProvider).isPerformingRequest;
  });

  late final _isReconnectedProvider = Provider<bool>((ref) {
    bool isConnected = ref.watch(di.isConnectedProvider);
    bool isPerformingRequest = ref.read(_isPerformingRequestProvider);
    if (isConnected &&
        !isConnectedAtLastTime &&
        widget.onDeviceReconnected != null &&
        !isPerformingRequest) {
      Future.delayed(Duration.zero, () {
        widget.onDeviceReconnected!();
      });
    }
    isConnectedAtLastTime = isConnected;
    return isConnected;
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Consumer(
          builder: (_, ref, __) {
            final bool noData = ref.watch(_noDataProvider);
            print(noData);
            print('this is the noData');
            return noData
                ? AppNoData(
                    message: widget.noDataMessage, icon: widget.noDataIcon)
                : const SizedBox();
          },
        ),
        Consumer(
          builder: (_, ref, __) {
            final bool noConnection = ref.watch(_noConnectionProvider);
            ref.watch(_isReconnectedProvider);
            return noConnection
                ? AppNoConnection(onTap: widget.onDeviceReconnected)
                : const SizedBox();
          },
        ),
        if (widget.showLoading ?? false)
          Consumer(
            builder: (_, ref, __) {
              final bool isLoading = ref.watch(_isLoadingProvider);
              return isLoading ? AppLoader() : const SizedBox();
            },
          ),
      ],
    );
  }
}
