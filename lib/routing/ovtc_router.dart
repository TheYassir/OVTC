import 'package:go_router/go_router.dart';
import 'package:ovtc_app/models/channel_model.dart';
import 'package:ovtc_app/models/contact_model.dart';
import 'package:ovtc_app/models/detail_other_user_model.dart';
import 'package:ovtc_app/pages/account_page.dart';
import 'package:ovtc_app/pages/add_contact_page.dart';
import 'package:ovtc_app/pages/contact_page.dart';
import 'package:ovtc_app/pages/create_mission_page.dart';
import 'package:ovtc_app/pages/home_page.dart';
import 'package:ovtc_app/pages/login_page.dart';
import 'package:ovtc_app/pages/notifications_page.dart';
import 'package:ovtc_app/pages/register_page.dart';
import 'package:ovtc_app/pages/messages_page.dart';
import 'package:ovtc_app/pages/channels_page.dart';

class OVTCRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String account = '/account';
  static const String notifications = '/notifications';
  static const String channels = '/channels';
  static const String messages = '/messages';
  static const String contact = '/contact';
  static const String createMission = '/create_mission';
  static const String addContact = '/add_contact';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => HomePage(authId: state.extra as String),
      ),
      GoRoute(
        path: account,
        builder: (context, state) => AccountPage(
          authId: state.extra as String,
        ),
      ),
      GoRoute(
        path: notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: channels,
        builder: (context, state) =>
            ChannelsPage(authId: state.extra as String),
      ),
      GoRoute(
        path: messages,
        builder: (context, state) {
          var datas = state.extra as Map<String, dynamic>;
          return MessagesPage(
            channel: datas["channel"] as ChannelModel,
            authId: datas["authId"] as String,
            users: datas["users"] as List<DetailOtherUserModel>,
          );
        },
      ),
      GoRoute(
        path: contact,
        builder: (context, state) => ContactPage(authId: state.extra as String),
      ),
      GoRoute(
        path: addContact,
        builder: (context, state) => const AddContactPage(),
      ),
      GoRoute(
          path: createMission,
          builder: (context, state) {
            var datas = state.extra as Map<String, dynamic>;
            return CreateMissionPage(
              authId: datas["authId"] as String,
              roleId: datas["roleId"] as String,
              contacts: datas["contacts"] as List<ContactModel>,
            );
          }),
    ],
  );
}
