part of '../../../../pages.dart';

class InsertSortasiPage extends StatefulWidget {
  const InsertSortasiPage({super.key});

  @override
  State<InsertSortasiPage> createState() => _InsertSortasiPageState();
}

class _InsertSortasiPageState extends State<InsertSortasiPage> {
  TextEditingController jenisController = TextEditingController();
  TextEditingController duraController = TextEditingController();
  TextEditingController beratTandanController = TextEditingController();
  TextEditingController brondolanController = TextEditingController();
  TextEditingController airController = TextEditingController();
  TextEditingController sampahController = TextEditingController();
  TextEditingController tangkaiController = TextEditingController();
  TextEditingController pasirController = TextEditingController();
  TextEditingController mutuController = TextEditingController();
  TextEditingController kosongController = TextEditingController();
  TextEditingController busukController = TextEditingController();
  TextEditingController mentahController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  TextEditingController kecilController = TextEditingController();
  TextEditingController lainlainController = TextEditingController();
  FocusNode potonganAirNode = FocusNode();
  FocusNode potonganMutuNode = FocusNode();
  FocusNode potonganSampahNode = FocusNode();
  FocusNode potonganTangkaiNode = FocusNode();
  FocusNode potonganPasirNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeLoadJenisBuahRequested());
  }

  @override
  Widget build(BuildContext context) {
    Widget buildInput({
      required String title,
      required TextEditingController controller,
      Widget? suffixIcon,
      String? suffixText,
      TextInputType keyboardType = TextInputType.text,
      bool readOnly = false,
      Function()? onTap,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: greyTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            textScaler: context.textScale(14),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            style: customTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
              color: cBlack,
            ),
            decoration: InputDecoration(
              hintText: "Masukkan $title",
              hintStyle: greyTextStyle.copyWith(fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: cGrey.withValues(alpha: 0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: cGrey.withValues(alpha: 0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: cBlue),
              ),
              suffixIcon:
                  suffixIcon ??
                  (suffixText != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              suffixText,
                              style: customTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                                color: cGrey,
                              ),
                              textScaler: context.textScale(14),
                            ),
                          ],
                        )
                      : null),
            ),
          ),
        ],
      );
    }

    Widget sectionHeader() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tanggal Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(LucideIcons.calendar, color: cBlue, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggal Penginputan",
                      style: greyTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      ),
                      textScaler: context.textScale(12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat(
                        'EEEE, dd MMMM yyyy',
                        'id_ID',
                      ).format(DateTime.now()),
                      style: customTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                        color: cBlack,
                      ),
                      textScaler: context.textScale(14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Petugas Section
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Petugas Sortasi (${state.selectedAsisten.length})",
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                          textScaler: context.textScale(14),
                        ),
                        InkWell(
                          onTap: () {
                            AsistenSelectorBottomSheet.show(
                              context: context,
                              asistenList: state.asistenSortasi,
                              initialSelected: state.selectedAsisten,
                              onAsistenConfirmed: (selectedAsisten) {
                                if (state.selectedTruk != null) {
                                  context.read<HomeBloc>().add(
                                    HomeSelectAsistenRequested(
                                      selectedAsisten: selectedAsisten,
                                      selectedTruk: state.selectedTruk!,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.pencil,
                                  size: 14,
                                  color: cBlue,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Ubah",
                                  style: customTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                    color: cBlue,
                                  ),
                                  textScaler: context.textScale(12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.selectedAsisten.map((asisten) {
                          return Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: cBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: cBlue),
                            ),
                            child: Text(
                              asisten.nama,
                              style: customTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: medium,
                                color: cBlue,
                              ),
                              textScaler: context.textScale(14),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    Widget sectionTruck() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cGrey.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: cBlack.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Kolom No. Polisi
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(LucideIcons.truck, size: 16, color: cGrey),
                                const SizedBox(width: 8),
                                Text(
                                  "No. Polisi Truk",
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: medium,
                                  ),
                                  textScaler: context.textScale(12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                return Text(
                                  state.selectedTruk?.platKendaraan ?? "-",
                                  style: customTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: bold,
                                    color: cBlack,
                                  ),
                                  textScaler: context.textScale(16),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Divider Vertical
                      Container(
                        width: 1,
                        height: 40,
                        color: cGrey.withValues(alpha: 0.2),
                      ),
                      const SizedBox(width: 20),
                      // Kolom Bruto
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(LucideIcons.scale, size: 16, color: cGrey),
                                const SizedBox(width: 8),
                                Text(
                                  "Bruto",
                                  style: greyTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: medium,
                                  ),
                                  textScaler: context.textScale(12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                final bruto = state
                                    .selectedTruk
                                    ?.timbangMasukMaterial
                                    .bruto;
                                return RichText(
                                  textScaler: context.textScale(16),
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: bruto?.toString() ?? "-",
                                        style: customTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: bold,
                                          color: cBlack,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Kg",
                                        style: greyTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: cGrey.withValues(alpha: 0.2), height: 1),
                  const SizedBox(height: 16),
                  // Supplier Row
                  Row(
                    children: [
                      Icon(LucideIcons.warehouse, size: 16, color: cGrey),
                      const SizedBox(width: 8),
                      Text(
                        "Nama Supplier",
                        style: greyTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                        textScaler: context.textScale(12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return Text(
                          state.selectedTruk?.supplier.nama ?? "-",
                          style: customTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                            color: cBlack,
                          ),
                          textScaler: context.textScale(16),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildInput(
              title: "Jenis",
              controller: jenisController,
              readOnly: true,
              onTap: () async {
                final result = await JenisBuahSelectorBottomSheet.show(context);
                if (result != null) {
                  jenisController.text = result.nama;
                }
              },
              suffixIcon: Icon(LucideIcons.chevronDown, color: cGrey, size: 20),
            ),
            const SizedBox(height: 16),
            buildInput(
              title: "Jumlah Tandan (Janjang)",
              controller: beratTandanController,
              suffixText: "kg",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: buildInput(
                    title: "Dura",
                    controller: duraController,
                    suffixText: "%",
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: buildInput(
                    title: "Brondolan",
                    controller: brondolanController,
                    suffixText: "%",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cWhite,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(LucideIcons.arrowLeft, color: cBlue),
        ),
        title: Text(
          'Penginputan Sortasi',
          style: customTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
            color: cBlue,
          ),
          textScaler: context.textScale(18),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(24, 30, 24, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionHeader(),
              Divider(height: 1, color: cGrey.withValues(alpha: 0.2)),
              sectionTruck(),
              Divider(height: 1, color: cGrey.withValues(alpha: 0.2)),
            ],
          ),
        ),
      ),
    );
  }
}
