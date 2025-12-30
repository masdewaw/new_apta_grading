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
              top: 50,
              left: 24,
              right: 24,
              bottom: 20,
            ),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: cBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo',
                          style: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          textScaler: context.textScale(14),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          state.userName,
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: semiBold,
                          ),
                          textScaler: context.textScale(20),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ScaleTransition(
                                  scale: _pulseAnimation,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: state.isOnline ? cGreen : cRed,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  state.isOnline ? 'Online' : 'Offline',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
                                  textScaler: context.textScale(14),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        context.push(const SettingPage());
                      },
                      child: Icon(
                        LucideIcons.settings,
                        color: cWhite,
                        size: 24,
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

    Widget sectionContent() {
      return BlocListener<HomeCCubit, HomeCState>(
        listener: (context, state) {
          if (state.selectedTab == 0) {
            context.read<HomeBloc>().add(HomeLoadTruckRequested());
          } else if (state.selectedTab == 1) {
            context.read<HomeBloc>().add(HomeLoadSortasiRequested());
          }
        },
        child: SizedBox(
          width: context.width * 1,
          height: context.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cGrey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: BlocBuilder<HomeCCubit, HomeCState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<HomeCCubit>().changeTab(0);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: state.selectedTab == 0
                                    ? cWhite
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Center(
                                child: Text(
                                  'Truk',
                                  style: customTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                    color: state.selectedTab == 0
                                        ? cBlue
                                        : cGrey,
                                  ),
                                  textScaler: context.textScale(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<HomeCCubit>().changeTab(1);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: state.selectedTab == 1
                                    ? cWhite
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Center(
                                child: Text(
                                  'Riwayat',
                                  style: customTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                    color: state.selectedTab == 1
                                        ? cBlue
                                        : cGrey,
                                  ),
                                  textScaler: context.textScale(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Section Content
              Expanded(
                child: BlocBuilder<HomeCCubit, HomeCState>(
                  builder: (context, homeCState) {
                    if (homeCState.selectedTab == 0) {
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Daftar Truk Tersedia',
                                  style: customTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: bold,
                                    color: cBlue,
                                  ),
                                  textScaler: context.textScale(16),
                                ),
                                InkWell(
                                  highlightColor: cTransparent,
                                  splashColor: cTransparent,
                                  onTap: () {
                                    context.read<HomeBloc>().add(
                                      HomeLoadTruckRequested(),
                                    );
                                  },
                                  child: Icon(
                                    LucideIcons.refreshCw,
                                    color: cBlue,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  if (state is HomeLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is HomeLoadedTruck) {
                                    if (state.trukSortasi.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'Tidak ada truk tersedia',
                                          style: customTextStyle.copyWith(
                                            fontSize: 16,
                                            color: cGrey,
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: state.trukSortasi.length,
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        10,
                                        0,
                                        16,
                                      ),
                                      itemBuilder: (context, index) {
                                        final truk = state.trukSortasi[index];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cWhite,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: cBlue,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    truk.platKendaraan,
                                                    style: customTextStyle
                                                        .copyWith(
                                                          fontSize: 16,
                                                          fontWeight: semiBold,
                                                          color: cBlue,
                                                        ),
                                                    textScaler: context
                                                        .textScale(16),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    truk.namaSupir,
                                                    style: customTextStyle
                                                        .copyWith(
                                                          fontSize: 14,
                                                          color: cGrey,
                                                        ),
                                                    textScaler: context
                                                        .textScale(14),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                LucideIcons.chevronRight,
                                                color: cBlue,
                                                size: 26,
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
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Riwayat Laporan',
                                  style: customTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: bold,
                                    color: cBlue,
                                  ),
                                  textScaler: context.textScale(16),
                                ),
                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: cBlue,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: PopupMenuButton<int>(
                                          initialValue:
                                              state is HomeLoadedSortasi
                                              ? state.currentPage
                                              : 1,
                                          onSelected: (int page) {
                                            context.read<HomeBloc>().add(
                                              HomeChangePageRequested(page),
                                            );
                                          },
                                          itemBuilder: (BuildContext context) {
                                            final int totalPage =
                                                state is HomeLoadedSortasi
                                                ? state.totalPage
                                                : 1;
                                            return List.generate(totalPage, (
                                              index,
                                            ) {
                                              return PopupMenuItem<int>(
                                                value: index + 1,
                                                child: Text(
                                                  'Halaman ${index + 1}',
                                                ),
                                              );
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state is HomeLoadedSortasi
                                                      ? "Halaman: ${state.currentPage}"
                                                      : "Halaman: 1",
                                                  style: whiteTextStyle
                                                      .copyWith(
                                                        fontSize: 14,
                                                        fontWeight: semiBold,
                                                      ),
                                                  textScaler: context.textScale(
                                                    14,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Icon(
                                                  LucideIcons.chevronDown,
                                                  color: cWhite,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  if (state is HomeLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is HomeLoadedSortasi) {
                                    if (state.sortasi.items.isEmpty) {
                                      return Center(
                                        child: Text(
                                          'Tidak ada data sortasi',
                                          style: customTextStyle.copyWith(
                                            fontSize: 16,
                                            color: cGrey,
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.builder(
                                      itemCount: state.sortasi.items.length,
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        10,
                                        0,
                                        16,
                                      ),
                                      itemBuilder: (context, index) {
                                        final sortasi =
                                            state.sortasi.items[index];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cWhite,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: cBlue,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat(
                                                      'dd MMM yyyy',
                                                      'id_ID',
                                                    ).format(
                                                      DateTime.parse(
                                                        sortasi.tanggal,
                                                      ),
                                                    ),
                                                    style: greyTextStyle
                                                        .copyWith(
                                                          fontSize: 14,
                                                          fontWeight: medium,
                                                        ),
                                                    textScaler: context
                                                        .textScale(14),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    sortasi
                                                        .transaksi
                                                        .platKendaraan,
                                                    style: customTextStyle
                                                        .copyWith(
                                                          fontSize: 18,
                                                          fontWeight: semiBold,
                                                          color: cBlue,
                                                        ),
                                                    textScaler: context
                                                        .textScale(18),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        LucideIcons.view,
                                                        color: cBlue,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        "Lihat Laporan",
                                                        style: customTextStyle
                                                            .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  semiBold,
                                                              color: cBlue,
                                                            ),
                                                        textScaler: context
                                                            .textScale(14),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        LucideIcons.x,
                                                        color: cRed,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        "Batalkan Laporan",
                                                        style: customTextStyle
                                                            .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  semiBold,
                                                              color: cRed,
                                                            ),
                                                        textScaler: context
                                                            .textScale(14),
                                                      ),
                                                    ],
                                                  ),
                                                ],
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
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTop(),
          Expanded(child: sectionContent()),
        ],
      ),
    );
  }
}
