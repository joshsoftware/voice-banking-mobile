import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'voice_bank_home_view_model.dart';

String _formatCurrency(double amount) {
  final parts = amount.toStringAsFixed(2).split('.');
  final intPart = parts[0];
  final decPart = parts[1];
  final buffer = StringBuffer();
  int count = 0;
  for (int i = intPart.length - 1; i >= 0; i--) {
    buffer.write(intPart[i]);
    count++;
    if (i > 0 && (count == 3 || (count > 3 && (count - 3) % 2 == 0))) {
      buffer.write(',');
    }
  }
  return '₹${buffer.toString().split('').reversed.join()}.$decPart';
}

class _HomeColors {
  static const gradientStart = Color(0xFF2072B2);
  static const gradientMid = Color(0xFF18405F);
  static const gradientEnd = Color(0xFF163955);
  static const balanceAmount = Color(0xFF163954);
  static const balanceLabel = Color(0xFF0F3468);
  static const sectionTitle = Color(0xFF1A476A);
  static const linkBlue = Color(0xFF2072B2);
  static const sheetGradientTop = Color(0xFF2072B2);
  static const sheetGradientBottom = Color(0xFF13324A);

  // Old tokens (kept for commented-out widgets below)
  static const accentGreen = Color(0xFF4ADE80);
  static const cardBg = Colors.white;
  static const textMuted = Color(0xFF6B7C93);
}

class VoiceBankHomeScreen extends ConsumerWidget {
  const VoiceBankHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceBankHomeViewModelProvider);
    final vm = ref.read(voiceBankHomeViewModelProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    // ── Old build body (commented out, kept per request) ──
    // return Scaffold(
    //   backgroundColor: const Color(0xFFF5F7FA),
    //   bottomNavigationBar: Container(
    //     color: const Color(0xFFF5F7FA),
    //     padding: EdgeInsets.only(
    //       top: 8,
    //       bottom: MediaQuery.of(context).padding.bottom + 16,
    //     ),
    //     child: _VoiceAssistantButton(label: l10n.sayHeyFin),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           decoration: const BoxDecoration(
    //             gradient: LinearGradient(
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //               colors: [
    //                 _HomeColors.gradientStart,
    //                 _HomeColors.gradientMid,
    //                 _HomeColors.gradientEnd,
    //               ],
    //               stops: [0.065, 0.456, 0.773],
    //             ),
    //             borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(28),
    //               bottomRight: Radius.circular(28),
    //             ),
    //           ),
    //           child: SafeArea(
    //             bottom: false,
    //             child: Column(
    //               children: [
    //                 _HomeHeader(
    //                   greeting: _greeting(l10n),
    //                   userName: state.userName,
    //                   onLanguageTap: () => context.push('/language'),
    //                   onProfileTap: () {},
    //                   onVoiceRegTap: () =>
    //                       context.push('/voice-consent'),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
    //                   child: _BalanceCard(
    //                     balance: state.balance,
    //                     accountType: state.accountType,
    //                     maskedAccount: state.maskedAccountNumber,
    //                     isBalanceVisible: state.isBalanceVisible,
    //                     onToggleVisibility: vm.toggleBalanceVisibility,
    //                     l10n: l10n,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         // _VoiceConsentBanner(...),
    //         Padding(
    //           padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
    //           child: _TransactionsSection(
    //             transactions: state.recentTransactions,
    //             l10n: l10n,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FF),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.65, -0.76),
                end: Alignment(0.65, 0.76),
                colors: [
                  _HomeColors.gradientStart,
                  _HomeColors.gradientMid,
                  _HomeColors.gradientEnd,
                ],
                stops: [0.065, 0.456, 0.773],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
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
                              _greeting(l10n),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.7),
                                height: 16 / 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              state.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 24 / 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _CircleIconButton(
                              icon: Icons.record_voice_over_rounded,
                              onTap: () => context.push('/voice-consent'),
                            ),
                            const SizedBox(width: 8),
                            _CircleIconButton(
                              icon: Icons.language,
                              onTap: () => context.push('/language'),
                            ),
                            const SizedBox(width: 8),
                            _CircleIconButton(
                              icon: Icons.person_outline,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _FigmaBalanceCard(
                      balance: state.balance,
                      accountType: state.accountType,
                      maskedAccount: state.maskedAccountNumber,
                      isBalanceVisible: state.isBalanceVisible,
                      onToggleVisibility: vm.toggleBalanceVisibility,
                      l10n: l10n,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(child: _VoiceBottomSheet()),
        ],
      ),
    );
  }

  static String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}

// ---------------------------------------------------------------------------
// Figma 85:716 — Header icon button
// ---------------------------------------------------------------------------
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Figma 85:803 — Balance card
// ---------------------------------------------------------------------------
class _FigmaBalanceCard extends StatelessWidget {
  final double balance;
  final String accountType;
  final String maskedAccount;
  final bool isBalanceVisible;
  final VoidCallback onToggleVisibility;
  final AppLocalizations l10n;

  const _FigmaBalanceCard({
    required this.balance,
    required this.accountType,
    required this.maskedAccount,
    required this.isBalanceVisible,
    required this.onToggleVisibility,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 244,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 50,
            spreadRadius: -12,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.availableBalance,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _HomeColors.balanceLabel.withValues(alpha: 0.8),
                      height: 20 / 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: onToggleVisibility,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: Icon(
                          isBalanceVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                          color:
                              _HomeColors.balanceLabel.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                isBalanceVisible
                    ? _formatCurrency(balance)
                    : '₹ ••••••',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: _HomeColors.balanceAmount,
                  height: 40 / 36,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                accountType,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _HomeColors.balanceLabel.withValues(alpha: 0.8),
                  height: 20 / 14,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    maskedAccount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _HomeColors.balanceLabel.withValues(alpha: 0.7),
                      height: 20 / 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      l10n.viewDetails,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _HomeColors.balanceLabel,
                        height: 20 / 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Figma 114:1725 — Voice bottom sheet ("Say Hey, Fin")
// ---------------------------------------------------------------------------
class _VoiceBottomSheet extends StatelessWidget {
  const _VoiceBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAEAEAE).withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(-0.5, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 76),
              const _MicPillButton(),
              const SizedBox(height: 60),
              const Text(
                'Say "Hey, Fin" \nto start conversation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _HomeColors.sectionTitle,
                  height: 28 / 18,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Tap to mute',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: _HomeColors.sectionTitle.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.volume_up,
                      size: 20,
                      color: _HomeColors.linkBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Figma 114:1730 — Mic pill button inside voice sheet
// ---------------------------------------------------------------------------
class _MicPillButton extends StatelessWidget {
  const _MicPillButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 207,
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(52),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
          const BoxShadow(
            color: Color(0xFFEFEFEF),
            blurRadius: 4,
            offset: Offset(0.5, -5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _HomeColors.sheetGradientTop,
              _HomeColors.sheetGradientBottom,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A4568).withValues(alpha: 0.5),
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.mic, size: 28, color: Colors.white),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Old widgets below — commented out / marked unused. Kept per request.
// ═══════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _HomeHeader extends StatelessWidget {
  final String greeting;
  final String userName;
  final VoidCallback onLanguageTap;
  final VoidCallback onProfileTap;
  final VoidCallback onVoiceRegTap;

  const _HomeHeader({
    required this.greeting,
    required this.userName,
    required this.onLanguageTap,
    required this.onProfileTap,
    required this.onVoiceRegTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: _HomeColors.accentGreen,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _HeaderIconButton(
                icon: Icons.record_voice_over_rounded,
                onTap: onVoiceRegTap,
              ),
              const SizedBox(width: 12),
              _HeaderIconButton(
                icon: Icons.language,
                onTap: onLanguageTap,
              ),
              const SizedBox(width: 12),
              _HeaderIconButton(
                icon: Icons.person_outline,
                onTap: onProfileTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ignore: unused_element
class _BalanceCard extends StatelessWidget {
  final double balance;
  final String accountType;
  final String maskedAccount;
  final bool isBalanceVisible;
  final VoidCallback onToggleVisibility;
  final AppLocalizations l10n;

  const _BalanceCard({
    required this.balance,
    required this.accountType,
    required this.maskedAccount,
    required this.isBalanceVisible,
    required this.onToggleVisibility,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _HomeColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.availableBalance,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _HomeColors.textMuted,
                  height: 1.4,
                ),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  isBalanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 22,
                  color: _HomeColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isBalanceVisible ? _formatCurrency(balance) : '₹ ••••••',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            accountType,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: _HomeColors.textMuted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE8ECF0)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                maskedAccount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _HomeColors.textMuted,
                  height: 1.4,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  l10n.viewDetails,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _HomeColors.linkBlue,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _TransactionsSection extends StatelessWidget {
  final List<Transaction> transactions;
  final AppLocalizations l10n;

  const _TransactionsSection({
    required this.transactions,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recentTransactions,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                l10n.viewAll,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _HomeColors.linkBlue,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...transactions.map((tx) => _TransactionTile(transaction: tx)),
      ],
    );
  }
}

// ignore: unused_element
class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isCredit
        ? AppColors.balancePositive
        : AppColors.balanceNegative;
    final sign = transaction.isCredit ? '+' : '-';
    final amountStr = _formatAmount(transaction.amount);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F8),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              transaction.iconLabel,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.date,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: _HomeColors.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$sign₹$amountStr',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: amountColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toInt().toString().replaceAllMapped(
            RegExp(r'(\d)(?=(\d{2})+(\d)(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    final parts = amount.toStringAsFixed(1).split('.');
    final intFormatted = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{2})+(\d)(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$intFormatted.${parts[1]}';
  }
}

// ignore: unused_element
class _VoiceConsentBanner extends StatelessWidget {
  final VoidCallback onTap;
  final AppLocalizations l10n;

  const _VoiceConsentBanner({
    required this.onTap,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF2072B2), Color(0xFF1B5A8F)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2072B2).withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.mic, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.setupVoiceBanking,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.setupVoiceBankingDesc,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.8),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _VoiceAssistantButton extends StatelessWidget {
  final String label;

  const _VoiceAssistantButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          decoration: BoxDecoration(
            color: _HomeColors.gradientMid,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: _HomeColors.gradientMid.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _HomeColors.accentGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
