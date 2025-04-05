import 'dart:io';

import 'package:darto/darto.dart';

/// Options for configuring Swagger UI.
class SwaggerUiOptions {
  final String title;
  final String docExpansion;
  final bool deepLink;
  final String syntaxHighlightTheme;
  final bool persistAuthorization;

  const SwaggerUiOptions({
    this.title = 'API Swagger',
    this.docExpansion = 'list',
    this.deepLink = false,
    this.syntaxHighlightTheme = 'agate',
    this.persistAuthorization = false,
  });
}

/// The SwaggerUi class provides a function to integrate Swagger UI,
/// similar to swagger-ui-express, returning a Router that contains:
/// - A GET route for '/swagger.json'
/// - A GET route for '/' (the mount point) that serves the Swagger UI HTML page.
class SwaggerUi {
  /// Returns a Router that serves the swagger.json file and the Swagger UI HTML page.
  static Router serve(String swaggerJsonPath,
      {SwaggerUiOptions options = const SwaggerUiOptions()}) {
    final router = Router();

    // Route to serve swagger.json
    router.get('/swagger.json', (Request req, Response res) {
      final file = File(swaggerJsonPath);
      if (file.existsSync()) {
        res.set('Content-Type', 'application/json');
        res.sendFile(file.path);
      } else {
        res
            .status(HttpStatus.notFound)
            .send({'error': 'Swagger JSON not found'});
      }
    });

    // Route to serve the Swagger UI HTML page.
    router.get('/', (Request req, Response res) {
      res.set('Content-Type', 'text/html');
      res.send(_swaggerUiHtml(options));
    });

    return router;
  }

  static String _swaggerUiHtml(SwaggerUiOptions options) {
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="SwaggerUI" />
  <title>${options.title}</title>
  <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui.css" />
</head>
<body>
  <div id="swagger-ui"></div>
  <script src="https://unpkg.com/swagger-ui-dist@4.5.0/swagger-ui-bundle.js" crossorigin></script>
  <script>
    window.onload = function() {
      // Construct the URL for swagger.json relative to the current window location
      let baseUrl = window.location.href;
      if(!baseUrl.endsWith('/')) {
        baseUrl += '/';
      }
      const swaggerJsonUrl = baseUrl + 'swagger.json';
      fetch(swaggerJsonUrl)
        .then(response => response.json())
        .then(spec => {
          const ui = SwaggerUIBundle({
            dom_id: '#swagger-ui',
            deepLinking: ${options.deepLink},
            docExpansion: '${options.docExpansion}',
            spec: spec,
            syntaxHighlight: {
              activate: true,
              theme: '${options.syntaxHighlightTheme}'
            },
            persistAuthorization: ${options.persistAuthorization}
          });
          window.ui = ui;
        });
    }
  </script>
</body>
</html>
''';
  }
}
