import 'dart:async';
import 'package:flutter/material.dart';
import 'package:goarogya_app/utils/app_theme.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onVerificationComplete;

  const VerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.onVerificationComplete,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (_) => FocusNode(),
  );
  
  int _resendSeconds = 30;
  Timer? _timer;
  bool _isVerifying = false;
  bool _isFaceVerification = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    
    // Check if all fields are filled
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      _verifyOtp();
    }
  }

  void _verifyOtp() {
    setState(() {
      _isVerifying = true;
    });
    
    // Simulate verification
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
        _isFaceVerification = true;
      });
    });
  }

  void _onFaceVerificationComplete() {
    // Simulate face verification
    Future.delayed(const Duration(seconds: 2), () {
      widget.onVerificationComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _isFaceVerification
              ? _buildFaceVerification()
              : _buildOtpVerification(),
        ),
      ),
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'We have sent a verification code to +91 ${widget.phoneNumber}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 60,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
                onChanged: (value) => _onOtpChanged(value, index),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        if (_isVerifying)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          Center(
            child: TextButton(
              onPressed: _resendSeconds == 0
                  ? () {
                      setState(() {
                        _resendSeconds = 30;
                      });
                      _startResendTimer();
                    }
                  : null,
              child: Text(
                _resendSeconds > 0
                    ? 'Resend code in $_resendSeconds seconds'
                    : 'Resend code',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFaceVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Face Verification',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Please look at the camera and hold still',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Face outline
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.face,
                      size: 80,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
              
              // Progress indicator
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'Verifying identity...',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: LinearProgressIndicator(
                        value: 0.86,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '86%',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Refresh button
              Positioned(
                bottom: 16,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Refresh',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              
              // Complete button for demo
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  onPressed: _onFaceVerificationComplete,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onFaceVerificationComplete,
            child: const Text('Complete Verification'),
          ),
        ),
      ],
    );
  }
}