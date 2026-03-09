import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import '../styles/style.dart';

class NoInternetOverlay extends StatefulWidget {
  const NoInternetOverlay({super.key});

  @override
  State<NoInternetOverlay> createState() => _NoInternetOverlayState();
}

class _NoInternetOverlayState extends State<NoInternetOverlay> {
  late final StreamSubscription _sub;
  bool _show = false;
  bool _checking = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _checkInternet();

    _sub = Connectivity().onConnectivityChanged.listen((results) {
      // Debounce connectivity change
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 250), () async {
        if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
          _update(true);
        } else {
          final ok = await _checkInternet();
          _update(!ok);
        }
      });
    });
  }

  Future<bool> _checkInternet() async {
    if (_checking) return !_show;
    _checking = true;

    try {
      final res = await InternetAddress.lookup('google.com');
      final ok = res.isNotEmpty && res.first.rawAddress.isNotEmpty;
      return ok;
    } catch (_) {
      return false;
    } finally {
      _checking = false;
    }
  }

  void _update(bool value) {
    if (!mounted) return;
    if (_show != value) {
      setState(() => _show = value);
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_show) return const SizedBox.shrink();

    final offset = MediaQuery.of(context).padding.top + kToolbarHeight;
    final bottomOffset = MediaQuery.of(context).padding.bottom + 80.0;

    return Positioned(
      bottom: bottomOffset,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: true,
        child: AnimatedOpacity(
          opacity: _show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedSlide(
            offset: _show ? Offset.zero : const Offset(0, -0.2),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.backgroundTransparencyInverse,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Icon
                      // SvgFixedSize(path: ImageConstant.noInternetIcon, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'No internet connection'.tr,
                        style:  localizedTextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
