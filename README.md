<p align="center">
  <img src="./assets/logo.png" width="200px" align="center" alt="Swagger UI Darto logo" />
  <h1 align="center">Swagger UI Darto</h1>
  <br>
  <p align="center">
    <a href="https://github.com/evandersondev/swagger_ui_darto">🐶🟢 Swagger UI Darto Github</a>
    <br/>
    The <strong>Swagger UI Darto</strong> is a plugin developed exclusively for the <a href="https://darto-docs.vercel.app/">Darto</a> framework. It allows you to easily integrate a beautiful Swagger UI into your Darto application, making it simple to visualize your API documentation. <strong>This plugin is intended for use with Darto only.</strong>
  </p>
</p>

<br/>

### Support 💖

If you find Swagger UI Darto useful, please consider supporting its development 🌟[Buy Me a Coffee](https://buymeacoffee.com/evandersondev)🌟. Your support helps improve the framework and make it even better!

<br>
<br>

## Getting Started 🚀

### Installation

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  swagger_ui_darto: 0.0.1
  darto: latest
  path: latest
```

Replace `latest` with the most recent version available.

### Usage

Below is a complete example of how to configure and use Swagger UI Darto in a Darto application with a Todo List API that includes routes for GET, POST, PUT, and DELETE.

```dart
import 'dart:io';
import 'package:darto/darto.dart';
import 'package:path/path.dart';
import 'package:swagger_ui_darto/swagger_ui_darto.dart';

void main() {
  final app = Darto();

  // Swagger UI options configuration is optional 🌟
  final options = SwaggerUiOptions(
    title: 'My API Documentation',
    deepLink: true,
    syntaxHighlightTheme: 'monokai',
    persistAuthorization: true,
  );

  // Define the absolute path to the swagger.json file
  final swaggerJsonPath = join(Directory.current.path, 'swagger.json');

  // Mount the Swagger UI router on "/docs"
  // This will set up:
  //   - GET /docs -> Swagger UI HTML page
  //   - GET /docs/swagger.json -> Swagger JSON document
  app.use('/docs', SwaggerUi.serve(swaggerJsonPath, options: options));

  // Your API routes
  // ...

  app.listen(3000, () {
    print('Server running on http://localhost:3000');
    print('Swagger UI available at http://localhost:3000/docs');
  });
}
```

### Example Swagger JSON 📄

Create a file named `swagger.json` at the root of your project with the following document your API like this:

```json
{
  "swagger": "2.0",
  "info": {
    "title": "My API",
    "version": "1.0.0"
  },
  "paths": {
    // ...
  }
}
```

## Official Documentation 📚

For more details on how to structure your `swagger.json`, please refer to the [Swagger Official Documentation](https://swagger.io/docs/specification/about/).

## License

This project is licensed under the MIT License.

## Have Fun! 🎉

Enjoy building amazing APIs with Darto and the Swagger UI Darto Plugin!

---

Made by evendersondev with ❤️ for Dart/Flutter developers! 🎯
