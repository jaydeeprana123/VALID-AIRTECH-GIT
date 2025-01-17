// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../Styles/my_colors.dart';
// import '../Styles/my_font.dart';
// import '../Styles/my_icons.dart';
//
//
// class InternetRealtimeConnectionChecker extends StatefulWidget {
//
//   Widget? layout;
//   Function? onTap;
//
//   var txtColor;
//   var descColor;
//
//   InternetRealtimeConnectionChecker(
//       {Key? key, this.layout, this.onTap, this.txtColor, this.descColor})
//       : super(key: key);
//
//   @override
//   State<InternetRealtimeConnectionChecker> createState() =>
//       _InternetRealtimeConnectionCheckerState();
// }
//
// class _InternetRealtimeConnectionCheckerState
//     extends State<InternetRealtimeConnectionChecker> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: NetworkController().onConnectivityChanged,
//         builder:
//             (BuildContext ctxt, AsyncSnapshot<ConnectivityResult> snapShot) {
//           var result = snapShot.data;
//           switch (result) {
//             case ConnectivityResult.none:
//               print("no Internet");
//
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                // mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                     //  mainAxisSize: MainAxisSize.min,
//                       children: [
//                         SvgPicture.asset(
//                           no_internet,
//                           width: 182.w,
//                           height: 182.w,
//                         ),
//                         SizedBox(height: 15.h),
//                         Text(
//                             "Oops, No Internet Conenction!",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontFamily: fontInterBold,
//                                 color: widget.txtColor)),
//                         SizedBox(height: 9.h),
//                         Text(
//                             "Make sure wifi or cellular data is turned on\nand then try again.",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontFamily: fontInterRegular,
//                                 color: widget.descColor)),
//                         SizedBox(height: 29.h),
//                         ElevatedButton(
//                             onPressed: () {
//                               widget.onTap;
//                             },
//                             style: ElevatedButton.styleFrom(
//                               primary: bg_btn_199a8e,
//                               onPrimary: Colors.white,
//                               elevation: 0,
//                               padding: EdgeInsets.only(
//                                   left: 36.5.w,
//                                   right: 36.5.w,
//                                   top: 13.h,
//                                   bottom: 13.h),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(18.r),
//                                 // side: BorderSide(color: skygreen_24d39e, width: 0),
//                               ),
//                             ),
//                             child: Text(
//                               "Try again",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16.sp,
//                                   fontFamily: fontInterSemiBold),
//                             )),
//                       ],
//                     ),
//
//                     // EmptyStateWidget(
//                     //   image: internetLost,
//                     //   text: "Lost Connection",
//                     //   descText:
//                     //       "Whoops, no internet connection found.\n Please check your connection",
//                     //   buttonText: "Try Again",
//                     //   onTap: () => widget.onTap,
//                     // ),
//                   ),
//                 ],
//               );
//             case ConnectivityResult.mobile:
//               return widget.layout!;
//             case ConnectivityResult.wifi:
//               print("yes Internet");
//               return widget.layout!;
//             default:
//               print("No Default Internet");
//               return widget.layout!;
//             // return Center(
//             //   child: EmptyStateWidget(
//             //     image: internetLost,
//             //     text: "Lost Connection",
//             //     descText:
//             //         "Whoops, no internet connection found.\n Please check your connection",
//             //     buttonText: "Try Again",
//             //     onTap: () => widget.onTap,
//             //   ),
//             // );
//           }
//         });
//   }
// }
