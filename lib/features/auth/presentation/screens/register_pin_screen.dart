import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/validators/validators.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/auth/presentation/widgets/custom_num_keyboard.dart';

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(width * 0.05),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tell us about yourself 😊',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: width * 0.053),
            ),
            SizedBox(height: height * 0.049),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: Validators.name, // ✅ Clean!
            ),
            SizedBox(height: height * 0.020),

            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: Validators.age, // ✅ Clean!
            ),
            SizedBox(height: height * 0.020),

            DropdownButtonFormField<String>(
              value: _selectedSex,
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
              validator: (value) =>
                  Validators.required(value, 'your sex'), // ✅ Clean!
            ),
            SizedBox(height: height * 0.020),

            TextFormField(
              controller: _jobController,
              decoration: const InputDecoration(
                labelText: 'Job',
                border: OutlineInputBorder(),
              ),
              validator: Validators.job, // ✅ Clean!
            ),
            const Spacer(),
            ElevatedButton(onPressed: _nextPage, child: const Text('Next')),
          ],
        ),
      ),
    );
  }

  //Pin page
  Widget _buildPinPage() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final controller = _isConfirmingPin
        ? _confirmPinController
        : _pinController;

    return Padding(
      padding: EdgeInsets.all(width * 0.064), // 24/375
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isConfirmingPin ? 'Confirm Your PIN' : 'Create Your PIN',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: width * 0.053, // ~20px on 375px width
            ),
          ),
          SizedBox(height: height * 0.049), // 40/812
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              return _buildPinDisplay(value.text);
            },
          ),
          SizedBox(height: height * 0.074), // 60/812 ≈ 0.074
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
          margin: EdgeInsets.symmetric(horizontal: width * 0.021), // 8/375
          width: width * 0.043, // 16/375 ≈ 0.043
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
