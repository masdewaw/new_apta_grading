part of '../../../../../pages.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(LucideIcons.arrowLeft, size: 24, color: cBlue),
        ),
        title: Text(
          "Pengaturan Aplikasi",
          style: customTextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
            color: cBlue,
          ),
          textScaler: context.textScale(14),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .center,
              children: [
                Icon(LucideIcons.monitorDown, size: 24, color: cBlue),
                const SizedBox(width: 12),
                Text(
                  "Update Aplikasi",
                  style: customTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                    color: cBlue,
                  ),
                  textScaler: context.textScale(14),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: .center,
              children: [
                Icon(LucideIcons.logOut, size: 24, color: cRed),
                const SizedBox(width: 12),
                Text(
                  "Keluar Aplikasi",
                  style: customTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                    color: cRed,
                  ),
                  textScaler: context.textScale(14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
