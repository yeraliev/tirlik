import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_task/core/widgets/custom_snackbar.dart';
import 'package:secure_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:secure_task/features/auth/presentation/widgets/custom_num_keyboard.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    context.read<AuthBloc>().add(LoginWithPin(pin));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    // Use responsive spacing
    double horizontalPadding = width * 0.06; // 6% of width
    double verticalSpacing = height * 0.02; // 2% of height
    double pinDotSize = width * 0.04; // 4% of width (scales with screen)

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.error != null) {
            _showError(state.error!);
            _controller.clear();
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalSpacing,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Better than fixed spacing
                children: [
                  Column(
                    children: [
                      SizedBox(height: verticalSpacing),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: width * 0.7,
                          child: Text(
                            "Welcome back, ${state.user!.name}!",
                            textAlign: TextAlign.start,
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 3),
                      Text(
                        'Enter Your PIN',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: verticalSpacing),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _controller,
                        builder: (context, value, _) {
                          return _buildPinDisplay(value.text, pinDotSize);
                        },
                      ),
                    ],
                  ),
                  CustomNumKeyboard(
                    controller: _controller,
                    onComplete: _onPinComplete,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPinDisplay(String pin, double dotSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: dotSize * 0.5,
          ), // Scale margin too
          width: dotSize,
          height: dotSize,
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
