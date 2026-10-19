# Bitácora de uso de IA

Cada uso de IA que termina en el repo se registra aquí (el más reciente arriba).
El objetivo no es justificar el uso, sino demostrar **criterio**:
qué especificaste, qué revisaste y qué rechazaste.

| Campo | Qué escribir |
|---|---|
| Fecha / autor | `2026-10-15 · @usuario` |
| Herramienta | Claude, Copilot, ChatGPT, Big Pickle… |
| Especificación | Qué pediste y con qué restricciones (pegar el prompt o resumirlo) |
| Resultado | Qué devolvió, en una frase |
| Aceptado | Qué quedó en el código y por qué |
| Rechazado / corregido | Qué cambiaste y por qué. **Esta es la columna más importante.** |
| Verificación | Cómo comprobaste que funciona (pruebas, dispositivo) |
| Commit / PR | Enlace |

---



## 2026-10-18 · @kenrivsan — Modelo, interfaz y repositorio simulado de categorías

- **Herramienta:** Claude (Claude Code).
- **Especificación:** Crear el modelo `Categoria`, la interfaz `CategoriasRepository` y un repositorio simulado cuya consulta devuelve un `Future` y permite simular demora, error, lista vacía y datos, con pruebas unitarias. Solo en `lib/features/categorias/` y `test/features/categorias/`, sin modificar `lib/main.dart` ni agregar servicios externos.
- **Resultado:** `categoria.dart`, `categorias_repository.dart`, `categorias_repository_fake.dart` (escenarios `datos`, `vacio` y `error`, `demora` y contador `llamadas`) y 8 pruebas unitarias.
- **Aceptado:** La estructura paralela a la de productos (interfaz, repositorio simulado y enum de escenarios); el `escenario` modificable para simular la recuperación tras un error; el contador `llamadas` para comprobar que Reintentar vuelve a consultar; y una prueba de la demora que verifica que la consulta no termina antes de tiempo en vez de medir con cronómetro, para evitar pruebas inestables.
- **Rechazado / corregido:**
  - Flutter 3.44.8 (Dart 3.12.2) no resolvía el `pubspec.yaml` (`^3.13.5`); se descartó verificar con ese SDK y se instaló Flutter 3.47.7 en una carpeta aparte, sin actualizar la instalación existente.
  - La rama local se creó con `origin/main` como upstream; se quitó para evitar un push accidental a `main`.
  - Los nombres propuestos para la pantalla antes de que existiera (`CategoriasScreen`, parámetro `repository`) no coincidían con los reales (`PantallaCategorias`, parámetro `repositorio`); se usan los reales en la información para Robert.
  - Una versión del PR dejó la bitácora sin las entradas de Robert y otra sin la de Víctor; se reconstruyó con las entradas de Robert, la de Víctor y la de Kenneth.
- **Verificación:** Con Flutter 3.47.7, `dart format` sin cambios, `flutter analyze` sin problemas y `flutter test` con 13 de 13 pruebas aprobadas (8 del repositorio, 4 de la pantalla y la prueba base). El job "Formato, análisis y pruebas" del CI del PR #5 pasó con el commit 8e47b63.
- **Commit / PR:** 8e47b63 · https://github.com/roberdeleon/pdm-s14-ci-estados/pull/5

## 2026-10-18 · @victordeleon172003 — Pantalla de categorías

- **Herramienta:** ChatGPT.
- **Especificación:** Crear una pantalla Flutter con cuatro estados y pruebas de widget.
- **Resultado:** Pantalla de categorías y pruebas automáticas.
- **Aceptado:** FutureBuilder, botón Reintentar y acción Actualizar.
- **Rechazado / corregido:** Se reemplazó List<String> por List<Categoria> para utilizar el repositorio de Kenri. Se adaptaron las pruebas.
- **Verificación:** dart format y flutter analyze sin errores. flutter test bloqueado localmente por la seguridad de Windows; pendiente verificar en CI.
- **Commit / PR:** PR #5.

## 2026-10-18 · @roberdeleon — configuración inicial del laboratorio

- **Herramienta:** ChatGPT/Codex.
- **Especificación:** Guiar paso a paso la instalación de Flutter en Windows y preparar el repositorio del equipo con CI, protección de main y trabajo mediante PR.
- **Resultado:** Aplicación Flutter base ejecutada en Edge, CI integrado mediante el PR #1 y ruleset proteger-main activo.
- **Aceptado:** Flutter 3.47.7, comprobación SHA256 de la descarga, análisis estático y pruebas obligatorias en CI, una aprobación y revisión de Code Owners.
- **Rechazado / corregido:**
  - La primera dirección de descarga proporcionada por IA era incorrecta; se corrigió usando el índice oficial de versiones.
  - Se cambió la descarga a curl porque la realizada desde PowerShell era lenta.
  - Se corrigió la lectura de CODEOWNERS a UTF-8 porque los comentarios mostraban acentos dañados.
  - Se corrigió el reparto individual por trabajo en parejas al revisar el enunciado.
  - El primer PR se integró sin revisión de otro integrante y con merge convencional; no cumple ese requisito del laboratorio. La rama chore/ci prepara un nuevo PR que deberá tener revisión de otro integrante e integrarse con Squash and merge.
  - Se adaptó la plantilla del docente para quitar requisitos específicos de su aplicación que no corresponden a nuestro MVP.
- **Verificación realizada:** La aplicación abrió en Edge y el contador funcionó; flutter analyze terminó sin problemas; flutter test aprobó la prueba inicial; el CI del PR #1 quedó en verde.
- **Pendiente:** Completar la adaptación del workflow de referencia, verificar los cambios de chore/ci, obtener revisión, comprobar el rechazo del push directo y desarrollar las pantallas con sus pruebas.
- **Commit / PR:** Base: 03f4e02. CI inicial: https://github.com/roberdeleon/pdm-s14-ci-estados/pull/1 . PR de chore/ci pendiente.

## Limpieza de CI · @roberdeleon
- **Herramienta:** ChatGPT/Codex.
- **Especificación:** Retirar el workflow inicial tras integrar el del docente.
- **Resultado:** Eliminación de .github/workflows/flutter-ci.yml.
- **Aceptado:** Conservar ci.yml con formato, análisis, pruebas y APK.
- **Rechazado / corregido:** Se corrigió la duplicación de workflows después de cambiar el check obligatorio a Formato, análisis y pruebas.
- **Verificación:** El workflow conservado pasó los checks del PR #2. El CI de esta limpieza está pendiente.
- **Commit / PR:** Pendiente.

## Corrección de CODEOWNERS · @roberdeleon
- **Herramienta:** ChatGPT/Codex.
- **Especificación:** Corregir el usuario de Kenri.
- **Resultado:** Reemplazo de @kenriysan por @kenrivsan en las cuatro reglas.
- **Aceptado:** Usuario confirmado mediante los metadatos de GitHub.
- **Rechazado / corregido:** La IA transcribió incorrectamente el usuario desde la captura.
- **Verificación:** Lectura local de CODEOWNERS con el usuario corregido; subida y CI pendientes.
- **Commit / PR:** https://github.com/roberdeleon/pdm-s14-ci-estados/pull/3


## 2026-10-18 · @victordeleon172003 — Pantalla de categorías

- **Herramienta:** ChatGPT.
- **Especificación:** Crear pantalla Flutter con cuatro estados y pruebas de widget.
- **Resultado:** Pantalla de categorías con FutureBuilder y pruebas.
- **Aceptado:** Estados cargando, error, vacío y datos; botones Reintentar y Actualizar.
- **Rechazado / corregido:** Se cambió List<String> por List<Categoria> para integrar el repositorio de Kenneth.
- **Verificación:** dart format y flutter analyze sin errores. Pruebas locales bloqueadas por seguridad de Windows; verificación mediante CI.
- **Commit / PR:** PR #5.