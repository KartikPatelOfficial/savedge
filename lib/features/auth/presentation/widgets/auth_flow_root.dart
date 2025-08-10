import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_status_cubit.dart';

class AuthFlowRoot extends StatefulWidget {
  const AuthFlowRoot({super.key, required this.builder});
  final WidgetBuilder builder;

  @override
  State<AuthFlowRoot> createState() => _AuthFlowRootState();
}

class _AuthFlowRootState extends State<AuthFlowRoot> {
  @override
  void initState() {
    super.initState();
    // Ensure status check triggered (idempotent) after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<AuthStatusCubit>().checkStatus();
    });
  }

  void _redirect(String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ModalRoute.of(context)?.settings.name == route) return; // prevent loops
      Navigator.of(context).pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthStatusCubit, AuthStatusState>(
      listenWhen: (prev, curr) => curr is AuthStatusLoaded,
      listener: (context, state) {
        if (state is AuthStatusLoaded) {
          switch (state.status) {
            case AuthFlowStatus.newUser:
              _redirect('/register/individual');
              break;
            case AuthFlowStatus.employeeFound:
              _redirect('/register/employee');
              break;
            case AuthFlowStatus.existingUser:
              // stay on builder view
              break;
          }
        }
      },
      builder: (context, state) {
        if (state is AuthStatusLoading || state is AuthStatusInitial) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is AuthStatusError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<AuthStatusCubit>().checkStatus(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is AuthStatusLoaded && state.status == AuthFlowStatus.existingUser) {
          return widget.builder(context);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
