part of '../../../../../widgets.dart';

/// Widget untuk menampilkan ModalBottomSheet pemilih asisten sortasi (multiple selection)
class AsistenSelectorBottomSheet extends StatefulWidget {
  final List<AsistenSortasiModel> asistenList;
  final List<AsistenSortasiModel> initialSelected;
  final Function(List<AsistenSortasiModel>) onAsistenConfirmed;

  const AsistenSelectorBottomSheet({
    super.key,
    required this.asistenList,
    this.initialSelected = const [],
    required this.onAsistenConfirmed,
  });

  /// Menampilkan bottom sheet untuk memilih asisten sortasi
  static Future<List<AsistenSortasiModel>?> show({
    required BuildContext context,
    required List<AsistenSortasiModel> asistenList,
    List<AsistenSortasiModel> initialSelected = const [],
    required Function(List<AsistenSortasiModel>) onAsistenConfirmed,
  }) {
    return showModalBottomSheet<List<AsistenSortasiModel>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AsistenSelectorBottomSheet(
        asistenList: asistenList,
        initialSelected: initialSelected,
        onAsistenConfirmed: onAsistenConfirmed,
      ),
    );
  }

  @override
  State<AsistenSelectorBottomSheet> createState() =>
      _AsistenSelectorBottomSheetState();
}

class _AsistenSelectorBottomSheetState
    extends State<AsistenSelectorBottomSheet> {
  late List<AsistenSortasiModel> _selectedAsisten;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedAsisten = List.from(widget.initialSelected);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _isSelected(AsistenSortasiModel asisten) {
    return _selectedAsisten.any((a) => a.id == asisten.id);
  }

  void _toggleSelection(AsistenSortasiModel asisten) {
    setState(() {
      if (_isSelected(asisten)) {
        _selectedAsisten.removeWhere((a) => a.id == asisten.id);
      } else {
        _selectedAsisten.add(asisten);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = widget.asistenList.isEmpty;
    final bool canConfirm = _selectedAsisten.isNotEmpty;

    // Filter Logic
    final filteredList = _searchQuery.isEmpty
        ? widget.asistenList
        : widget.asistenList.where((asisten) {
            return asisten.nama.toLowerCase().contains(_searchQuery);
          }).toList();

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Asisten Sortasi',
                          style: customTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: bold,
                            color: cBlue,
                          ),
                          textScaler: context.textScale(18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Minimal pilih 1 asisten',
                          style: greyTextStyle.copyWith(fontSize: 12),
                          textScaler: context.textScale(12),
                        ),
                      ],
                    ),
                    if (!isLoading)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: cBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_selectedAsisten.length} dipilih',
                          style: customTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                            color: cBlue,
                          ),
                          textScaler: context.textScale(14),
                        ),
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
                    hintText: 'Cari asisten...',
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
          // Divider
          Divider(height: 1, color: cGrey.withValues(alpha: 0.2)),
          // Content
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  CircularProgressIndicator(color: cBlue),
                  const SizedBox(height: 16),
                  Text(
                    'Mohon ditunggu\nsedang memuat data asisten...',
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            )
          else if (filteredList.isEmpty)
            Padding(
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
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final asisten = filteredList[index];
                  final isSelected = _isSelected(asisten);
                  return InkWell(
                    onTap: () => _toggleSelection(asisten),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? cBlue.withValues(alpha: 0.1)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          // Checkbox
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? cBlue : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isSelected ? cBlue : cGrey,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          // Name
                          Expanded(
                            child: Text(
                              asisten.nama,
                              style: customTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: isSelected ? semiBold : regular,
                                color: isSelected ? cBlue : cBlack,
                              ),
                              textScaler: context.textScale(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          // Confirm Button
          if (!isLoading)
            Container(
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: cWhite,
                boxShadow: [
                  BoxShadow(
                    color: cBlack.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: context.width * 1,
                child: ElevatedButton(
                  onPressed: canConfirm
                      ? () {
                          widget.onAsistenConfirmed(_selectedAsisten);
                          Navigator.pop(context, _selectedAsisten);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cBlue,
                    disabledBackgroundColor: cGrey.withValues(alpha: 0.3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    canConfirm
                        ? 'Lanjutkan (${_selectedAsisten.length} asisten)'
                        : 'Pilih minimal 1 asisten',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                    textScaler: context.textScale(16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
