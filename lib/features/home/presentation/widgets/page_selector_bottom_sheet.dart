part of '../../../../../widgets.dart';

/// Widget untuk menampilkan ModalBottomSheet pemilih halaman
class PageSelectorBottomSheet extends StatelessWidget {
  final int totalPage;
  final int currentPage;
  final Function(int) onPageSelected;

  const PageSelectorBottomSheet({
    super.key,
    required this.totalPage,
    required this.currentPage,
    required this.onPageSelected,
  });

  /// Menampilkan bottom sheet untuk memilih halaman
  static Future<int?> show({
    required BuildContext context,
    required int totalPage,
    required int currentPage,
    required Function(int) onPageSelected,
  }) {
    return showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PageSelectorBottomSheet(
        totalPage: totalPage,
        currentPage: currentPage,
        onPageSelected: onPageSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * 0.6),
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: cGrey.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Halaman',
                  style: customTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                    color: cBlue,
                  ),
                  textScaler: context.textScale(18),
                ),
                Text(
                  'Total: $totalPage halaman',
                  style: greyTextStyle.copyWith(fontSize: 14),
                  textScaler: context.textScale(14),
                ),
              ],
            ),
          ),
          // Divider
          Divider(height: 1, color: cGrey.withValues(alpha: 0.2)),
          // List of pages
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: totalPage,
              itemBuilder: (context, index) {
                final isSelected = index == currentPage;
                return InkWell(
                  onTap: () {
                    onPageSelected(index);
                    Navigator.pop(context, index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? cBlue.withValues(alpha: 0.1)
                          : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Halaman ${index + 1}',
                          style: customTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: isSelected ? semiBold : regular,
                            color: isSelected ? cBlue : cBlack,
                          ),
                          textScaler: context.textScale(16),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: cBlue, size: 22),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }
}
