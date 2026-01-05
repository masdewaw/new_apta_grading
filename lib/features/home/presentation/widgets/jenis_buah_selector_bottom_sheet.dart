part of '../../../../../widgets.dart';

class JenisBuahSelectorBottomSheet extends StatefulWidget {
  const JenisBuahSelectorBottomSheet({super.key});

  static Future<JenisBuahModel?> show(BuildContext context) {
    return showModalBottomSheet<JenisBuahModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const JenisBuahSelectorBottomSheet(),
    );
  }

  @override
  State<JenisBuahSelectorBottomSheet> createState() =>
      _JenisBuahSelectorBottomSheetState();
}

class _JenisBuahSelectorBottomSheetState
    extends State<JenisBuahSelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.85,
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
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
          // Header & Search
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilih Jenis Buah',
                      style: customTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                        color: cBlack,
                      ),
                      textScaler: context.textScale(20),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: cGrey.withValues(alpha: 0.1),
                        padding: const EdgeInsets.all(8),
                      ),
                      icon: Icon(LucideIcons.x, size: 20, color: cBlack),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search Bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari jenis buah...',
                    hintStyle: greyTextStyle.copyWith(fontSize: 14),
                    prefixIcon: Icon(LucideIcons.search, color: cGrey),
                    filled: true,
                    fillColor: cGrey.withValues(alpha: 0.05),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: cBlue.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: cGrey.withValues(alpha: 0.1)),
          // Content
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final jenisBuahList = state.jenisBuah;

                // Loading State
                if (jenisBuahList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: cBlue),
                        const SizedBox(height: 16),
                        Text(
                          'Memuat data...',
                          style: greyTextStyle.copyWith(fontSize: 14),
                          textScaler: context.textScale(14),
                        ),
                      ],
                    ),
                  );
                }

                // Filtering
                final filteredList = _searchQuery.isEmpty
                    ? jenisBuahList
                    : jenisBuahList.where((item) {
                        return item.nama.toLowerCase().contains(_searchQuery);
                      }).toList();

                // Empty Search Result
                if (filteredList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(LucideIcons.searchX, size: 48, color: cGrey),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ditemukan',
                          style: customTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                            color: cBlack,
                          ),
                          textScaler: context.textScale(16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Coba kata kunci lain',
                          style: greyTextStyle.copyWith(fontSize: 14),
                          textScaler: context.textScale(14),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return InkWell(
                      onTap: () => Navigator.pop(context, item),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: cGrey.withValues(alpha: 0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: cBlack.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: cBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                LucideIcons
                                    .apple, // Use generic fruit icon if appropriate, or box
                                size: 20,
                                color: cBlue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item.nama,
                                style: customTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                  color: cBlack,
                                ),
                                textScaler: context.textScale(16),
                              ),
                            ),
                            Icon(
                              LucideIcons.chevronRight,
                              size: 18,
                              color: cGrey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
