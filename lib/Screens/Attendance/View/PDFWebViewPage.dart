import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valid_airtech/Screens/Appointment/Controller/appointment_controller.dart';
import 'package:valid_airtech/Screens/Appointment/Model/appointment_contact_list_response.dart';
import 'package:valid_airtech/Screens/Appointment/Model/create_appointment_request.dart';
import 'package:valid_airtech/Screens/Attendance/Model/create_attendance_in_request.dart';
import 'package:valid_airtech/Screens/Offices/Model/office_list_response.dart';
import 'package:valid_airtech/Screens/Sites/Model/site_list_response.dart';
import 'package:valid_airtech/Screens/WorkReport/Controller/work_report_controller.dart';

import '../../../Styles/app_text_style.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/CommonButton.dart';
import '../../../Widget/common_widget.dart';
import '../Controller/attendance_controller.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'; // <- Add this
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WebViewWithPDFDownload extends StatefulWidget {
  @override
  _WebViewWithPDFDownloadState createState() => _WebViewWithPDFDownloadState();
}

class _WebViewWithPDFDownloadState extends State<WebViewWithPDFDownload> {
  late WebViewController controller;
  String? currentPdfUrl;
  bool isPdfLoaded = false;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              // Check if the current URL is a PDF
              if (url.contains('.pdf')) {
                currentPdfUrl = url;
                isPdfLoaded = true;
              } else {
                isPdfLoaded = false;
                currentPdfUrl = null;
              }
            });
          },
          onPageFinished: (String url) {
            // Double check when page is finished loading
            setState(() {
              if (url.contains('.pdf')) {
                currentPdfUrl = url;
                isPdfLoaded = true;
              }
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Let all URLs load normally, including PDFs
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://iora.gujarat.gov.in'));
  }

  Future<void> _downloadPDF() async {
    if (currentPdfUrl == null) return;

    try {
      setState(() {
        isDownloading = true;
      });

      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        // Try requesting manage external storage for Android 11+
        status = await Permission.manageExternalStorage.request();
      }

      if (status.isGranted) {
        // Get downloads directory
        Directory? downloadsDirectory;

        if (Platform.isAndroid) {
          downloadsDirectory = Directory('/storage/emulated/0/Download');
          if (!await downloadsDirectory.exists()) {
            downloadsDirectory = await getExternalStorageDirectory();
          }
        } else {
          downloadsDirectory = await getApplicationDocumentsDirectory();
        }

        // Extract filename from URL
        String fileName = currentPdfUrl!.split('/').last;
        if (!fileName.contains('.pdf')) {
          fileName = 'downloaded_file.pdf';
        }

        String filePath = '${downloadsDirectory!.path}/$fileName';

        // Download file using Dio
        Dio dio = Dio();
        await dio.download(
          currentPdfUrl!,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              double progress = received / total;
              // You can show progress here if needed
              print('Download progress: ${(progress * 100).toStringAsFixed(0)}%');
            }
          },
        );

        setState(() {
          isDownloading = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF downloaded successfully!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () => _showFileLocation(filePath),
            ),
          ),
        );
      } else {
        setState(() {
          isDownloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage permission denied'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isDownloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showFileLocation(String filePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('File Downloaded'),
        content: Text('File saved to:\n$filePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _refreshPage() {
    controller.reload();
  }

  void _goBack() {
    controller.goBack();
  }

  void _goForward() {
    controller.goForward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView with PDF Download'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Show download button only when PDF is loaded
          if (isPdfLoaded)
            isDownloading
                ? Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            )
                : IconButton(
              icon: Icon(Icons.download),
              onPressed: _downloadPDF,
              tooltip: 'Download PDF',
            ),
          // Refresh button
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshPage,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Navigation controls
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _goBack,
                  tooltip: 'Back',
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _goForward,
                  tooltip: 'Forward',
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      currentPdfUrl ?? 'Loading...',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // PDF indicator
                if (isPdfLoaded)
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      'PDF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // WebView
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}

// Main app to test the WebView
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView PDF Download Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewWithPDFDownload(),
    );
  }
}

void main() {
  runApp(MyApp());
}


