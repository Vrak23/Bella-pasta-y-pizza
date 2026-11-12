import 'package:flutter_test/flutter_test.dart';
import 'package:bella_pasta_pizza/main.dart';

void main() {
  testWidgets('Carga inicial del Splash y Bienvenida de Bella Pasta & Pizza',
      (WidgetTester tester) async {
    // Construir la aplicación e iniciar el primer frame
    await tester.pumpWidget(const BellaPastaPizzaApp());

    // Verificar que los textos principales de la marca y el botón estén presentes
    expect(find.text('Bella'), findsOneWidget);
    expect(find.text('PASTA & PIZZA'), findsOneWidget);
    expect(find.text('Comenzar Pedido'), findsOneWidget);
  });
}
