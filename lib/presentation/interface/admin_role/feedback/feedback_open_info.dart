// import 'package:atb_booking/data/services/image_provider.dart';
// import 'package:atb_booking/data/services/network/network_controller.dart';
// import 'package:atb_booking/presentation/constants/styles.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AdminPersonBookingListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     ScrollController scrollController = ScrollController();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Feedback пользователя"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           _PersonInfoWidget(),
//           const _BookingList(), 
//         ],
//       ),
//     );
//   }
// }

// class _PersonInfoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AdminPersonBookingListBloc, AdminPersonBookingListState>(
//         builder: (context, state) {
//       if (state is AdminPersonBookingListLoadedState) {
//         User user = state.user;
//         return Card(
//           margin: EdgeInsets.zero,
//           elevation: 1,
//           shape: RoundedRectangleBorder(
//               side: const BorderSide(width: 0.2, color: Colors.black38),
//               borderRadius: BorderRadius.circular(0.0)),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ClipOval(
//                 child: Container(
//                   height: 90,
//                   width: 90,
//                   child: CachedNetworkImage(
//                       fit: BoxFit.cover,
//                       imageUrl: AppImageProvider.getImageUrlFromImageId(
//                         user.avatarImageId,
//                       ),
//                       httpHeaders: NetworkController().getAuthHeader(),
//                       progressIndicatorBuilder:
//                           (context, url, downloadProgress) => Center(
//                               child: CircularProgressIndicator(
//                                   value: downloadProgress.progress)),
//                       errorWidget: (context, url, error) => Container()),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       user.fullName,
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall
//                           ?.copyWith(
//                               fontSize: 25,
//                               color: appThemeData.colorScheme.primary),
//                     ),
//                     Text(
//                       user.email,
//                       style: appThemeData.textTheme.bodyLarge,
//                     ),
//                     Text(
//                       user.phone,
//                       style: appThemeData.textTheme.bodyLarge,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         );
//       } else {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     });
//   }
// }
