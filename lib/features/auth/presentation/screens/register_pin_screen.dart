import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/locale/locale_cubit.dart';
import 'package:secure_task/core/validators/validators.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/auth/presentation/widgets/custom_num_keyboard.dart';
import 'package:secure_task/l10n/app_localizations.dart';

class RegisterPinScreen extends StatefulWidget {
  const RegisterPinScreen({super.key});

  @override
  State<RegisterPinScreen> createState() => _RegisterPinScreenState();
}

class _RegisterPinScreenState extends State<RegisterPinScreen> {
  final PageController _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  String? _selectedSex;
  bool _isConfirmingPin = false;

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _jobController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _nextPage() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 100));

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackbar.errorSnackbar(
        error: message,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  void _onPinComplete(String pin) {
    if (pin.length != 4) return;
    final l10n = AppLocalizations.of(context)!;

    if (!_isConfirmingPin) {
      setState(() => _isConfirmingPin = true);
    } else {
      if (_pinController.text == pin) {
        context.read<AuthBloc>().add(
          RegisterWithPin(
            pin,
            _nameController.text.trim(),
            int.tryParse(_ageController.text) ?? 0,
            _jobController.text.trim(),
            _selectedSex ?? '',
          ),
        );
      } else {
        _showError(l10n.pinsDoNotMatch);
        setState(() {
          _isConfirmingPin = false;
          _pinController.clear();
          _confirmPinController.clear();
        });
      }
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = context.read<LocaleCubit>().state;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.language),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'en',
              languageName: 'English 🇺🇸',
              currentLocale: currentLocale,
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'ru',
              languageName: 'Русский 🇷🇺',
              currentLocale: currentLocale,
            ),
            const SizedBox(height: 8),
            _buildLanguageOption(
              context: context,
              dialogContext: dialogCtx,
              languageCode: 'kk',
              languageName: 'Қазақша 🇰🇿',
              currentLocale: currentLocale,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required BuildContext dialogContext,
    required String languageCode,
    required String languageName,
    required Locale currentLocale,
  }) {
    final isSelected = currentLocale.languageCode == languageCode;

    return Material(
      color: isSelected
          ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          context.read<LocaleCubit>().setLocale(Locale(languageCode));
          Navigator.pop(dialogContext);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                )
              else
                const Icon(Icons.circle_outlined, size: 20, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.onboarding),
        leading: _currentPage == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _isConfirmingPin = false;
                    _pinController.clear();
                    _confirmPinController.clear();
                  });
                  _previousPage();
                },
              )
            : const SizedBox.shrink(),
        actions: [
          Tooltip(
            message: l10n.language,
            child: IconButton(
              icon: Icon(
                Icons.language,
                size: 24,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => _showLanguageSelector(context),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            _showError(state.error!);
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: [_buildUserInfoPage(), _buildPinPage()],
        ),
      ),
    );
  }

  //User onboarding
  Widget _buildUserInfoPage() {
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.tellUsAboutYourself,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontSize: width * 0.053),
                    ),
                    SizedBox(height: height * 0.049),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.name,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => Validators.of(context).name(value),
                    ),
                    SizedBox(height: height * 0.020),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.age,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => Validators.of(context).age(value),
                    ),
                    SizedBox(height: height * 0.020),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedSex,
                      decoration: InputDecoration(
                        labelText: l10n.sex,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(value: 'Male', child: Text(l10n.male)),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text(l10n.female),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text(l10n.other),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedSex = value);
                      },
                      validator: (value) => value == null || value.isEmpty
                          ? l10n.pleaseSelectYourSex
                          : null,
                    ),
                    SizedBox(height: height * 0.020),
                    TextFormField(
                      controller: _jobController,
                      decoration: InputDecoration(
                        labelText: l10n.job,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => Validators.of(context).job(value),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: _nextPage, child: Text(l10n.next)),
        ],
      ),
    );
  }

  //Pin page
  Widget _buildPinPage() {
    final l10n = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final controller = _isConfirmingPin
        ? _confirmPinController
        : _pinController;

    return Padding(
      padding: EdgeInsets.all(width * 0.064),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isConfirmingPin ? l10n.confirmYourPin : l10n.createYourPin,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: width * 0.053),
          ),
          SizedBox(height: height * 0.049),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              return _buildPinDisplay(value.text);
            },
          ),
          SizedBox(height: height * 0.074),
          CustomNumKeyboard(controller: controller, onComplete: _onPinComplete),
        ],
      ),
    );
  }

  Widget _buildPinDisplay(String pin) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.021),
          width: width * 0.043,
          height: width * 0.043,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < pin.length
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade400,
          ),
        );
      }),
    );
  }
}
