import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jefit/core/common/widget/app_text_button.dart';
import 'package:jefit/features/practice/data/lower_body_model.dart';
import 'package:jefit/main.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class PracticeVideoView extends StatefulWidget {
  const PracticeVideoView({super.key, required this.model});
  final LowerBodyModel model;

  @override
  State<PracticeVideoView> createState() => _PracticeVideoViewState();
}

class _PracticeVideoViewState extends State<PracticeVideoView>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _showCamera = false;

  late AnimationController _countdownController;
  late Animation<double> _countdownAnimation;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.model.videoAsset ?? "")
      ..initialize().then((_) {
        setState(() {});
      });

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _countdownAnimation =
        Tween<double>(begin: 3.0, end: 0.0).animate(_countdownController)
          ..addListener(() {
            setState(() {});
          });
  }

  Future<void> _initializeCamera() async {
    final firstCamera = cameras.last;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      if (await Permission.camera.request().isGranted) {
        _initializeCamera().then((_) {
          setState(() {
            _showCamera = true;
          });
        });
      } else if (await Permission.camera.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Camera Permission'),
              content:
                  const Text('Please enable camera permission from settings'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: const Text('OK'))
              ],
            );
          },
        );
      }
    } else if (status.isGranted) {
      _initializeCamera().then((_) {
        setState(() {
          _showCamera = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cameraController?.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.model.title),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _controller.value.isInitialized
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        height: _controller.value.size.height / 2.3,
                        width: _controller.value.size.width / 2.3,
                        child: Stack(
                          children: [
                            VideoPlayer(_controller),
                            Center(
                              child: IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 50,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 10),
              _isCameraInitialized && _showCamera
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: AppTextButton(
                        buttonText: "Stop Training",
                        onPressed: () {
                          _cameraController?.stopImageStream();
                          setState(() {
                            _showCamera = false;
                          });
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: AppTextButton(
                        buttonText: "Start Training",
                        onPressed: () {
                          _requestCameraPermission();
                        },
                      ),
                    ),
            ],
          ),
          if (_showCamera && _isCameraInitialized)
            Positioned(
              top: 180.0, // Adjust this value based on your layout
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 220,
                  left: 25,
                  right: 25,
                ),
                child: CameraPreview(
                  _cameraController!,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
