part of '../../../../../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    context.read<HomeCCubit>().init();
    context.read<HomeBloc>().add(HomeLoadTruckRequested());
    context.read<HomeBloc>().add(HomeLoadAsistenRequested());
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionTop() {
      return BlocBuilder<HomeCCubit, HomeCState>(
        builder: (context, state) {
          return Container(
            width: context.width * 1,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 30,
            ),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cBlue, cBlue.withValues(alpha: 0.8)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: cBlue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Selamat Datang! 👋',
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                            color: cWhite.withValues(alpha: 0.8),
                          ),
                          textScaler: context.textScale(14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.userName,
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold,
                          ),
                          textScaler: context.textScale(24),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: cWhite.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: cWhite.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScaleTransition(
                                    scale: _pulseAnimation,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: state.isOnline ? cGreen : cRed,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                (state.isOnline ? cGreen : cRed)
                                                    .withValues(alpha: 0.5),
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    state.isOnline
                                        ? 'Status: Online'
                                        : 'Status: Offline',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: semiBold,
                                    ),
                                    textScaler: context.textScale(12),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        context.push(const SettingPage());
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cWhite.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          LucideIcons.settings,
                          color: cWhite,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    Widget sectionTabSelector() {
      return Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: cGrey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<HomeCCubit, HomeCState>(
          builder: (context, state) {
            return Stack(
              children: [
                // Sliding Indicator
                AnimatedAlign(
                  alignment: state.selectedTab == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: cWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: cBlack.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Tabs
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => context.read<HomeCCubit>().changeTab(0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LucideIcons.truck,
                                size: 18,
                                color: state.selectedTab == 0 ? cBlue : cGrey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Truk',
                                style: customTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                  color: state.selectedTab == 0 ? cBlue : cGrey,
                                ),
                                textScaler: context.textScale(14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => context.read<HomeCCubit>().changeTab(1),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LucideIcons.history,
                                size: 18,
                                color: state.selectedTab == 1 ? cBlue : cGrey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Riwayat',
                                style: customTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: semiBold,
                                  color: state.selectedTab == 1 ? cBlue : cGrey,
                                ),
                                textScaler: context.textScale(14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    Widget sectionTruckContent() {
      return Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Truk Tersedia',
                  style: customTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                    color: cBlack,
                  ),
                  textScaler: context.textScale(18),
                ),
                InkWell(
                  onTap: () {
                    context.read<HomeBloc>().add(HomeLoadTruckRequested());
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(LucideIcons.refreshCw, color: cBlue, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: cBlue),
                    );
                  } else if (state is HomeLoadedTruck) {
                    if (state.trukSortasi.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: cGrey.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.truck,
                                size: 48,
                                color: cGrey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tidak ada truk tersedia',
                              style: customTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                                color: cGrey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: state.trukSortasi.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final truk = state.trukSortasi[index];
                        return InkWell(
                          onTap: () async {
                            final selectedAsisten =
                                await AsistenSelectorBottomSheet.show(
                                  context: context,
                                  asistenList: state.asistenSortasi,
                                  initialSelected: state.selectedAsisten,
                                  onAsistenConfirmed: (_) {},
                                );

                            if (selectedAsisten != null && context.mounted) {
                              context.read<HomeBloc>().add(
                                HomeSelectAsistenRequested(
                                  selectedAsisten: selectedAsisten,
                                  selectedTruk: truk,
                                ),
                              );
                              context.push(const InsertSortasiPage());
                            }
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: cWhite,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: cBlack.withValues(alpha: 0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: cBlue.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    LucideIcons.truck,
                                    color: cBlue,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        truk.platKendaraan,
                                        style: customTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: bold,
                                          color: cBlack,
                                        ),
                                        textScaler: context.textScale(16),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        truk.namaSupir,
                                        style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: medium,
                                        ),
                                        textScaler: context.textScale(14),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  LucideIcons.chevronRight,
                                  color: cGrey.withValues(alpha: 0.5),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget sectionHistoryContent() {
      return Container(
        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Laporan',
                  style: customTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                    color: cBlack,
                  ),
                  textScaler: context.textScale(18),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final isLoaded = state is HomeLoadedSortasi;
                    return InkWell(
                      onTap: isLoaded
                          ? () {
                              PageSelectorBottomSheet.show(
                                context: context,
                                totalPage: state.totalPage > 0
                                    ? state.totalPage
                                    : 1,
                                currentPage: state.currentPage,
                                onPageSelected: (page) {
                                  context.read<HomeBloc>().add(
                                    HomeChangePageRequested(page),
                                  );
                                },
                              );
                            }
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: cBlue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              isLoaded
                                  ? "Halaman: ${state.currentPage + 1}"
                                  : "Loading...",
                              style: customTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: semiBold,
                                color: cBlue,
                              ),
                              textScaler: context.textScale(12),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              LucideIcons.chevronDown,
                              size: 14,
                              color: cBlue,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: cBlue),
                    );
                  } else if (state is HomeLoadedSortasi) {
                    if (state.sortasi.items.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: cGrey.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.fileX,
                                size: 48,
                                color: cGrey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada riwayat',
                              style: customTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                                color: cGrey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: state.sortasi.items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final sortasi = state.sortasi.items[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: cWhite,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: cBlack.withValues(alpha: 0.05),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sortasi.transaksi.platKendaraan,
                                          style: customTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: bold,
                                            color: cBlack,
                                          ),
                                          textScaler: context.textScale(16),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          DateFormat(
                                            'EEEE, dd MMM yyyy',
                                            'id_ID',
                                          ).format(
                                            DateTime.parse(sortasi.tanggal),
                                          ),
                                          style: greyTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: medium,
                                          ),
                                          textScaler: context.textScale(12),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: cBlue.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        LucideIcons.fileText,
                                        color: cBlue,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: cGrey.withValues(alpha: 0.1),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              LucideIcons.eye,
                                              size: 16,
                                              color: cBlue,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Lihat Detail',
                                              style: customTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold,
                                                color: cBlue,
                                              ),
                                              textScaler: context.textScale(14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: cGrey.withValues(alpha: 0.2),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              LucideIcons.trash2,
                                              size: 16,
                                              color: cRed,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Batalkan',
                                              style: customTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold,
                                                color: cRed,
                                              ),
                                              textScaler: context.textScale(14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget sectionContent() {
      return BlocListener<HomeCCubit, HomeCState>(
        listener: (context, state) {
          if (state.selectedTab == 0) {
            context.read<HomeBloc>().add(HomeLoadTruckRequested());
          } else if (state.selectedTab == 1) {
            context.read<HomeBloc>().add(HomeLoadSortasiRequested());
          }
        },
        child: Column(
          children: [
            sectionTabSelector(),
            Expanded(
              child: BlocBuilder<HomeCCubit, HomeCState>(
                builder: (context, state) {
                  if (state.selectedTab == 0) {
                    return sectionTruckContent();
                  } else {
                    return sectionHistoryContent();
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Slightly off-white background
      body: Column(
        children: [
          sectionTop(),
          Expanded(child: sectionContent()),
        ],
      ),
    );
  }
}
