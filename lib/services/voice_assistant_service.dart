import 'dart:async';
// import 'package:flutter/material.dart';

enum VoiceAssistantState {
  idle,
  listening,
  processing,
  speaking,
}

class VoiceAssistantService {
  VoiceAssistantState _state = VoiceAssistantState.idle;
  String _recognizedText = '';
  String _responseText = '';
  String _selectedLanguage = 'English';
  final List<String> _supportedLanguages = ['English', 'Hindi', 'Tamil', 'Telugu', 'Bengali', 'Marathi'];
  
  final StreamController<VoiceAssistantState> _stateController = StreamController<VoiceAssistantState>.broadcast();
  final StreamController<String> _recognizedTextController = StreamController<String>.broadcast();
  final StreamController<String> _responseTextController = StreamController<String>.broadcast();
  
  Stream<VoiceAssistantState> get stateStream => _stateController.stream;
  Stream<String> get recognizedTextStream => _recognizedTextController.stream;
  Stream<String> get responseTextStream => _responseTextController.stream;
  
  VoiceAssistantState get state => _state;
  String get recognizedText => _recognizedText;
  String get responseText => _responseText;
  String get selectedLanguage => _selectedLanguage;
  List<String> get supportedLanguages => _supportedLanguages;
  
  void setLanguage(String language) {
    if (_supportedLanguages.contains(language)) {
      _selectedLanguage = language;
    }
  }
  
  Future<void> startListening() async {
    _setState(VoiceAssistantState.listening);
    
    // Simulate speech recognition
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock recognized text based on selected language
    switch (_selectedLanguage) {
      case 'Hindi':
        _setRecognizedText('मुझे डॉक्टर की जरूरत है');
        break;
      case 'Tamil':
        _setRecognizedText('எனக்கு டாக்டர் தேவை');
        break;
      default:
        _setRecognizedText('I need a doctor');
        break;
    }
    
    await _processCommand();
  }
  
  Future<void> _processCommand() async {
    _setState(VoiceAssistantState.processing);
    
    // Simulate processing
    await Future.delayed(const Duration(seconds: 1));
    
    // Generate response based on recognized text
    if (_recognizedText.toLowerCase().contains('doctor') || 
        _recognizedText.contains('डॉक्टर') ||
        _recognizedText.contains('டாக்டர்')) {
      _setResponseText('I can help you find a doctor nearby. Would you like me to search for you?');
    } else if (_recognizedText.toLowerCase().contains('emergency') ||
               _recognizedText.contains('आपातकालीन') ||
               _recognizedText.contains('அவசர')) {
      _setResponseText('I\'ll connect you to emergency services right away.');
    } else if (_recognizedText.toLowerCase().contains('medicine') ||
               _recognizedText.contains('दवा') ||
               _recognizedText.contains('மருந்து')) {
      _setResponseText('I can help you find medicine shops nearby or order medicines online.');
    } else {
      _setResponseText('I\'m sorry, I didn\'t understand. Could you please repeat?');
    }
    
    _setState(VoiceAssistantState.speaking);
    
    // Simulate text-to-speech
    await Future.delayed(const Duration(seconds: 2));
    
    _setState(VoiceAssistantState.idle);
  }
  
  void stopListening() {
    if (_state == VoiceAssistantState.listening) {
      _setState(VoiceAssistantState.idle);
    }
  }
  
  void _setState(VoiceAssistantState state) {
    _state = state;
    _stateController.add(state);
  }
  
  void _setRecognizedText(String text) {
    _recognizedText = text;
    _recognizedTextController.add(text);
  }
  
  void _setResponseText(String text) {
    _responseText = text;
    _responseTextController.add(text);
  }
  
  void dispose() {
    _stateController.close();
    _recognizedTextController.close();
    _responseTextController.close();
  }
}