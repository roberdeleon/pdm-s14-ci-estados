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

## 2026-10-18 · @EmmanuelC-04 — modelo y repositorio de productos

- **Herramienta:** Codex.
- **Especificación:** Implementar únicamente el modelo `Producto`, el contrato `ProductosRepository`, un repositorio simulado con datos, vacío, error y demora configurable, y sus pruebas unitarias. Permitir una consulta exitosa después de un error sin añadir interfaz, servicios externos ni dependencias.
- **Resultado:** Se crearon `lib/features/productos/producto.dart`, `productos_repository.dart`, `productos_repository_fake.dart` y `test/features/productos/productos_repository_test.dart`.
- **Aceptado:** Campos inmutables en `Producto`; contrato asíncrono para inyección; escenario modificable en el repositorio simulado para que una nueva consulta pueda recuperarse de un error; copia de la lista configurada al devolver datos.
- **Rechazado / corregido:** No hubo propuestas rechazadas ni correcciones de código durante esta implementación.
- **Problemas detectados:** El primer intento de ejecutar Flutter no pudo abrir el archivo de bloqueo del SDK por las restricciones del entorno. Se ejecutaron las validaciones con acceso al SDK habilitado. La rama asignada no existía localmente ni en remoto; se creó desde `main`, que coincidía con `origin/main` después de actualizar las referencias.
- **Verificación:** `dart format lib test` no cambió archivos; `flutter analyze` terminó sin problemas; `flutter test` aprobó las seis pruebas nuevas y la prueba de widget existente.
- **Commit / PR:** Pendiente de revisión; no se creó commit ni PR.



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
