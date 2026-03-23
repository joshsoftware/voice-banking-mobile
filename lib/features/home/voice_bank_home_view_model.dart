import 'package:flutter_riverpod/flutter_riverpod.dart';

class Transaction {
  final String id;
  final String title;
  final String date;
  final double amount;
  final bool isCredit;
  final String iconLabel;

  const Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.iconLabel,
  });
}

class VoiceBankHomeState {
  final String userName;
  final double balance;
  final String accountType;
  final String maskedAccountNumber;
  final bool isBalanceVisible;
  final List<Transaction> recentTransactions;

  const VoiceBankHomeState({
    this.userName = 'Isha Kulkarni',
    this.balance = 45250.75,
    this.accountType = 'Savings Account',
    this.maskedAccountNumber = '****7890',
    this.isBalanceVisible = true,
    this.recentTransactions = const [],
  });

  VoiceBankHomeState copyWith({
    String? userName,
    double? balance,
    String? accountType,
    String? maskedAccountNumber,
    bool? isBalanceVisible,
    List<Transaction>? recentTransactions,
  }) =>
      VoiceBankHomeState(
        userName: userName ?? this.userName,
        balance: balance ?? this.balance,
        accountType: accountType ?? this.accountType,
        maskedAccountNumber: maskedAccountNumber ?? this.maskedAccountNumber,
        isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
        recentTransactions: recentTransactions ?? this.recentTransactions,
      );
}

class VoiceBankHomeViewModel extends AutoDisposeNotifier<VoiceBankHomeState> {
  @override
  VoiceBankHomeState build() {
    return VoiceBankHomeState(
      recentTransactions: _mockTransactions,
    );
  }

  void toggleBalanceVisibility() {
    state = state.copyWith(isBalanceVisible: !state.isBalanceVisible);
  }

  static const _mockTransactions = [
    Transaction(
      id: '1',
      title: 'Amazon India',
      date: '17 Feb',
      amount: 1299,
      isCredit: false,
      iconLabel: '🛒',
    ),
    Transaction(
      id: '2',
      title: 'Salary Credit',
      date: '15 Feb',
      amount: 45000,
      isCredit: true,
      iconLabel: '💰',
    ),
    Transaction(
      id: '3',
      title: 'Swiggy',
      date: '16 Feb',
      amount: 450.5,
      isCredit: false,
      iconLabel: '🍔',
    ),
    Transaction(
      id: '4',
      title: 'Netflix',
      date: '14 Feb',
      amount: 649,
      isCredit: false,
      iconLabel: '🎬',
    ),
  ];
}

final voiceBankHomeViewModelProvider = NotifierProvider.autoDispose<
    VoiceBankHomeViewModel, VoiceBankHomeState>(VoiceBankHomeViewModel.new);
