import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/auth/presentation/widgets/custom_num_keyboard.dart';

class RegisterPinScreen extends StatefulWidget {
  const RegisterPinScreen({super.key});

  @override
  State<RegisterPinScreen> createState() => _RegisterPinScreenState();
}

class _RegisterPinScreenState extends State<RegisterPinScreen> {
  final PageController _pageController = PageController();

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

    await Future.delayed(const Duration(milliseconds: 100));

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onPinComplete(String pin) {
    if (pin.length != 4) return;

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
        _showError('PINs do not match');
        setState(() {
          _isConfirmingPin = false;
          _pinController.clear();
          _confirmPinController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tell us about yourself 😊',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 40),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedSex,
            decoration: const InputDecoration(
              labelText: 'Sex',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {
              setState(() => _selectedSex = value);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _jobController,
            decoration: const InputDecoration(
              labelText: 'Job',
              border: OutlineInputBorder(),
            ),
          ),
          const Spacer(),
          ElevatedButton(onPressed: _nextPage, child: const Text('Next')),
        ],
      ),
    );
  }

  //Pin page
  Widget _buildPinPage() {
    final controller = _isConfirmingPin
        ? _confirmPinController
        : _pinController;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isConfirmingPin ? 'Confirm Your PIN' : 'Create Your PIN',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 40),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              return _buildPinDisplay(value.text);
            },
          ),
          const SizedBox(height: 60),
          CustomNumKeyboard(controller: controller, onComplete: _onPinComplete),
        ],
      ),
    );
  }

  Widget _buildPinDisplay(String pin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
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
