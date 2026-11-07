# 🎮 SnapPrice MX

### Estimaciones orientativas para videojuegos y consolas en México

> SnapPrice MX identifica productos con IA y consulta anuncios activos de Mercado Libre MX. Requiere confirmar las variantes que Gemini marque como inciertas y filtra candidatos por modelo/códigos/variantes presentes en el título. Una mediana de 3 o más anuncios sigue siendo una referencia orientativa, no comparables verificados manualmente ni ventas cerradas; no es un avalúo oficial.

---

## 📌 Tabla de Contenidos

1. [Problema y Propuesta de Valor](#-problema-y-propuesta-de-valor)
2. [Características Principales](#-características-principales)
3. [Especialización Gamer](#-especialización-gamer)
4. [Arquitectura y Stack Tecnológico](#-arquitectura-y-stack-tecnológico)
5. [Endpoints de la API](#-endpoints-de-la-api)
6. [Resiliencia y Blindaje Técnico](#-resiliencia-y-blindaje-técnico)
7. [Historial de Versiones (Changelog)](#-historial-de-versiones-changelog)
8. [Roadmap y Posibles Mejoras Futuras](#-roadmap-y-posibles-mejoras-futuras)
9. [Instalación y Configuración](#-instalación-y-configuración)

---

## 💡 Problema y Propuesta de Valor

En México, el comercio entre particulares (C2C) y la reventa en plataformas como **Facebook Marketplace, Mercado Libre MX, Amazon México y eBay** sufren de:

1. **Asimetría de Precios:** Vendedores que regalan su dinero por desconocimiento o compradores que caen en sobreprecios abusivos.
2. **Estafas Recurrentes:** Comprobantes falsos de OXXO, transferencias SPEI fantasma no liquidadas o envíos fraudulentos por taxi de aplicación.
3. **Complejidad de Modelos Gamer:** Diferencias sutiles que cambian radicalmente el valor (ej. PS5 Fat vs Slim vs Pro; Nintendo Switch V1 hackeable vs V2 vs OLED; controles con o sin drift en análogos).

SnapPrice MX permite capturar o escribir un producto y propone una identificación con IA. El backend consulta anuncios activos de Mercado Libre cuando la API está disponible. Esos precios son precios solicitados, no transacciones; no se generan recomendaciones de compra o venta.

---

## ⚡ Características Principales

### 📸 1. Flujo Guiado por la Cámara (Viewfinder Asistido)

Visor con 4 retículas holográficas de encuadre láser diseñadas específicamente para hardware gamer:

- **Consola Completa:** Encuadre panorámico para evaluar carcasas, ventilas y puertos.
- **Portada / Caja:** Encuadre vertical para carátulas de juegos físicos y estado de sellos/empaque.
- **Control / Mandos:** Retícula oval centrada en los joysticks análogos para inspección visual de desgaste y drift.
- **Etiqueta de Serie:** Macro-guía para capturar números de modelo (ej. CFI-xxxx, CUH-xxxx, HAC-xxxx).

### 📊 2. Consulta de anuncios activos

- La búsqueda usa el nombre, modelo y condición identificados por IA en la API de Mercado Libre México.
- Si se detectan variantes inciertas, primero requiere respuestas del usuario; los títulos se filtran por variante conocida y código de modelo.
- Se muestran enlaces de origen y hora de consulta. La mediana orientativa requiere al menos 3 anuncios candidatos en MXN y no implica revisión manual.
- Los resultados son precios anunciados, no ventas cerradas ni garantía de que todos los productos sean idénticos.

### 🔍 3. Datos de mercado (`TransparentMarketPanel`)

- El backend consulta anuncios activos de Mercado Libre México y exige autorización OAuth de una cuenta operativa de SnapPrice.
- Si Gemini devuelve preguntas para distinguir modelo o variante, no se consulta ninguna fuente hasta que el usuario responda todas y vuelva a confirmar.
- Los títulos se filtran por modelo, variantes conocidas (por ejemplo, Slim/Pro, OLED/Lite o Series X/S) y códigos de modelo cuando están presentes. Un título coincidente no demuestra que la publicación sea realmente comparable; los resultados siguen siendo candidatos pendientes de inspección.
- Solo se calcula una mediana orientativa con al menos 3 anuncios en MXN que pasaron el filtro. Si OAuth, la fuente o la búsqueda fallan, se explica el motivo y no se presenta un precio de reemplazo.
- Los anuncios no son ventas cerradas. Las recomendaciones de compra, venta y margen siguen desactivadas hasta contar con datos transaccionales y validar el método.

### 🎨 4. Exportación de reportes y pósters

- Temporalmente desactivada en la interfaz para evitar exportar precios no validados como recomendaciones.

### 📄 5. Reporte imprimible

- Se reactivará cuando las recomendaciones de precio se validen con datos de transacciones.

### 🛡️ 6. Radar Antifraude para México (`AntiFraudSection`)

- Alertas contextuales contra estafas comunes en México: entrega en puntos seguros (plazas comerciales o estaciones concurridas de Metro/Metrobús), verificación de transferencias SPEI en la app bancaria antes de entregar, y advertencias sobre envíos forzados por paquetería express.

### ☁️ 7. Persistencia en la Nube con Firebase

- Inicio de sesión rápido con **Google One-Tap**.
- Historial de avalúos sincronizado en tiempo real mediante **Cloud Firestore**, permitiendo consultar cotizaciones pasadas desde cualquier dispositivo.

---

## 🕹️ Especialización Gamer

SnapPrice MX está afinado para identificar las especificaciones que determinan el precio en el ecosistema de videojuegos:

- **PlayStation:** PS5 Pro, PS5 Slim (con lector / digital), PS5 Fat (CFI-1000/1200), PS4 Pro, PS4 Slim, PS3 retrocompatible, PS Vita, PSP.
- **Nintendo:** Switch OLED (Edición Zelda, Pokémon, Mario), Switch V2 (batería extendida), Switch V1 (unpatched), Switch Lite, 3DS XL, 2DS, Game Boy.
- **Xbox:** Xbox Series X (1TB / 2TB Galaxy), Xbox Series S (512GB blanco / 1TB negro), Xbox One X, Xbox 360 (Slim / E).
- **Micro-Factores de Desempate:**
  - ✅ Incluye caja original con manuales (+10% a +15% de valor).
  - ✅ Mandos originales probados sin _stick drift_.
  - ✅ Cables originales (HDMI de alta velocidad / alimentación).
  - ❌ Consolas con sello de garantía violado o sin lector físico.

---

## 🛠️ Arquitectura y Stack Tecnológico

```
┌─────────────────────────────────────────────────────────────┐
│                       SNAPPRICE MX                          │
└──────────────────────────────┬──────────────────────────────┘
                               │
       ┌───────────────────────┴───────────────────────┐
       ▼                                               ▼
┌──────────────────────────────┐         ┌──────────────────────────────┐
│       Frontend (Vite)        │         │       Backend (Express)      │
│  - React 19 + TypeScript     │         │  - Node.js Full-Stack        │
│  - Tailwind CSS v4           │◄───────►│  - Gemini API integration   │
│  - Motion + Lucide React     │  /api/  │  - Explicit AI failure errors│
│  - HTML5 Canvas 2D           │         │  - 12s Promise.race Timeout  │
└──────────────┬───────────────┘         └──────────────────────────────┘
               │
               ▼
┌──────────────────────────────┐
│      Firebase Services       │
│  - Google Authentication     │
│  - Cloud Firestore (DB)      │
│  - Security Rules Audited    │
└──────────────────────────────┘
```

- **Frontend:** React 19, TypeScript, Tailwind CSS v4, Lucide React, Motion.
- **Backend:** Express 4 montado sobre Node.js con Vite middleware en desarrollo.
- **Inteligencia Artificial:** integración con `@google/genai`. Gemini identifica productos y posibles variantes; el servidor consulta anuncios por separado. Si falta confirmar una variante, no se consultan precios.
- **Nube:** Firebase Authentication & Cloud Firestore (Reglas de acceso por usuario y cuota optimizada).

---

## 🔌 Endpoints de la API

### 1. `GET /api/health`

Informa si la clave de Gemini, la configuración OAuth y el proveedor de mercado están configurados. No realiza llamadas de prueba a Gemini, Firebase Auth, Firestore ni Mercado Libre; por eso `configured` no garantiza que esas integraciones estén accesibles o autorizadas.

- **Respuesta (200 OK):**

```json
{
  "status": "configured",
  "service": "SnapPrice Central Intelligence API",
  "hasKey": true,
  "currency": "MXN",
  "marketplaces": [],
  "marketSearch": {
    "provider": "Mercado Libre MX",
    "oauthConfigured": false,
    "setupKeyConfigured": false,
    "verifiedPerEvaluation": false
  },
  "googleShopping": {
    "provider": "Google Shopping vía SerpApi",
    "enabled": false,
    "apiKeyConfigured": false,
    "verifiedPerEvaluation": false
  },
  "timestamp": "2026-11-06T17:31:40.000Z"
}
```

### 2. `POST /api/evaluate`

Requiere una sesión activa de Google mediante Firebase Authentication. El servidor verifica el token y aplica una cuota atómica en Firestore de 5 solicitudes por minuto y 30 por día por usuario, además de un máximo de 100 solicitudes diarias para toda la aplicación (reinicia a medianoche UTC). Los contadores son documentos privados administrados solo por el backend.

- **Encabezado requerido:** `Authorization: Bearer <Firebase ID token>`
- **Payload:**

```json
{
  "imageBase64": "data:image/jpeg;base64,...",
  "mimeType": "image/jpeg",
  "description": "PlayStation 5 Slim con Lector 1TB",
  "userIntent": "c2c",
  "selectedCondition": "Como nuevo",
  "microAnswers": {
    "caja": "Sí, completa",
    "controles": "2 DualSense originales",
    "drift": "Sin drift"
  }
}
```

- **Respuesta (200 OK):** Objeto `ValuationResult` con identificación sugerida por IA y estado de consulta. Si el modelo requiere confirmar variantes, `marketData.status` será `needs_confirmation` y no se consultarán anuncios ni Google Shopping. Si se reciben al menos 3 anuncios que pasan el filtro de título/modelo, puede mostrar una mediana orientativa de precios anunciados, no de ventas cerradas ni de comparables revisados manualmente.
- **Errores:** `400 INVALID_JSON` para JSON malformado; `401 AUTH_REQUIRED` o `AUTH_INVALID` si falta una sesión válida; `503 AUTH_VERIFICATION_UNAVAILABLE` si Firebase Auth no puede verificarla; `429 EVALUATION_LIMIT_REACHED` al exceder la cuota; `503 EVALUATION_LIMIT_UNAVAILABLE` si Firestore no puede verificarla; `400 INVALID_EVALUATION_INPUT` para campos inválidos; `413 REQUEST_TOO_LARGE` si el cuerpo supera 16 MB; `503 AI_NOT_CONFIGURED` si falta la clave de Gemini; `502 AI_INVALID_RESPONSE` si la IA devuelve datos incompletos; `502 AI_REQUEST_FAILED` si falla el proveedor o expira el timeout. En esos casos no se devuelve una valuación de respaldo.

### OAuth de Mercado Libre

- `POST /api/mercadolibre/oauth/start`: requiere una clave administrativa backend en el encabezado `Authorization` con esquema Bearer. Devuelve una URL para que el operador autorice la cuenta operativa; el estado aleatorio vence en 10 minutos y solo se puede usar una vez.
- `GET /api/mercadolibre/oauth/callback`: URL HTTPS exacta que debe registrarse en Mercado Libre. Intercambia el código por tokens y los almacena únicamente en Firestore del backend.
- `GET /api/mercadolibre/oauth/status`: exige la misma clave administrativa y devuelve si existe un token, su expiración y si está vigente. No realiza una consulta al API de anuncios.

---

## 🛡️ Resiliencia y Blindaje Técnico

1. **Fallos de IA explícitos:** Si falta `GEMINI_API_KEY` o el proveedor de IA falla, `/api/evaluate` devuelve un error HTTP. No se genera una valuación heurística de respaldo.
2. **Autenticación del backend:** `/api/evaluate` exige y verifica un Firebase ID token de Google en el servidor; ocultar botones en el cliente no se considera control de acceso.
3. **Cuota compartida:** Firestore aplica límites atómicos por cuenta (5/minuto, 30/día) y para toda la aplicación (100/día UTC), incluso con varias instancias. Si Firestore no está disponible, la evaluación falla de forma cerrada antes de llamar a Gemini. El timeout del cliente no garantiza que el proveedor deje de procesar o facturar una solicitud ya recibida.
4. **Límites y validación de entrada:** JSON limitado a 16 MB, imagen limitada a 10 MB, límite de longitud para texto y respuestas auxiliares, y comprobación de codificación, formato y coincidencia MIME antes del envío a Gemini.
5. **Respuesta de IA validada:** El servidor comprueba estructura, tipos, rangos y tamaños de la respuesta del modelo antes de acceder a sus campos; una respuesta incompleta falla explícitamente.
6. **Mercado Libre OAuth:** La autorización de la cuenta operativa se inicia con `POST /api/mercadolibre/oauth/start` usando `Authorization: Bearer <MELI_OAUTH_SETUP_KEY>`. La respuesta contiene la URL de autorización; tras el consentimiento, Mercado Libre redirige a la URL HTTPS configurada. Los tokens y estados OAuth se guardan en colecciones de backend no accesibles por el cliente según `firestore.rules`; el backend renueva tokens expirados y serializa renovaciones concurrentes. El endpoint `GET /api/mercadolibre/oauth/status` devuelve solo conexión/expiración y exige la misma clave. Nunca expongas credenciales ni tokens en el cliente.
7. **Filtrado de anuncios:** No se buscan resultados hasta que las preguntas de variante estén respondidas. La API y la interfaz filtran título por modelo/variante y evitan mezclar variantes conocidas; el filtro es conservador, pero no sustituye una revisión manual de cada publicación.
8. **Google Shopping (prueba opcional):** SerpApi puede consultar ofertas de Google Shopping para México. Requiere `SERPAPI_API_KEY` y activación explícita con `SERPAPI_ENABLED=true`; está desactivada por defecto. La consulta envía a SerpApi el nombre identificado del producto, no la imagen. Las ofertas se muestran por separado, con precio tal como lo devuelve el proveedor, sin convertirlo a MXN ni incorporarlo a medianas o estrategias de reventa. No se guardan en el historial. Antes de habilitar en producción, revisa las condiciones de SerpApi, la licencia/retención de los datos y el coste por consulta.
9. **Persistencia de historial:** Sanitizador en `saveValuationToCloud` que elimina cadenas base64 grandes del resultado antes de guardarlo en Firestore.
10. **Defensa del servidor:** Helmet configura encabezados seguros y una política CSP en modo de reporte; `X-Powered-By` está desactivado. La política se debe revisar en producción antes de cambiarla de reporte a bloqueo.
11. **Protección de llamadas:** Firebase ID tokens se verifican incluyendo revocación. App Check puede exigirse con `APP_CHECK_ENFORCED=true` después de configurar el proveedor reCAPTCHA Enterprise en la app web.
12. **Procesamiento de imágenes:** Antes de enviarlas a Gemini, el backend limita dimensiones y píxeles, reescala y vuelve a codificar las imágenes admitidas; esto elimina metadatos como EXIF y reduce archivos maliciosos o sobredimensionados.
13. **Contenedor:** La imagen Docker instala solo dependencias de producción en su etapa final y ejecuta el proceso con el usuario sin privilegios `node`.

---

## 📜 Historial de Versiones (Changelog)

|  Versión   |   Fecha    | Hitos y Cambios Clave                                                                                                                                                                         |
| :--------: | :--------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **v1.4.1** | _Nov 2026_ | **Auditoría Exhaustiva de Endpoints y Resiliencia:** Inyección de `Promise.race` de 12s, sanitización base64 para Firestore, blindaje CORS en Canvas y sincronización del recálculo dinámico. |
| **v1.4.0** | _Nov 2026_ | **Especialización Gamer:** Visor guiado con 4 retículas y atajos táctiles. Las afirmaciones originales sobre benchmarks en vivo no correspondían a una integración real.                      |
| **v1.3.0** | _Nov 2026_ | **Exportación Social:** Se crearon componentes de fichas y reportes; la exportación está pausada hasta validar precios.                                                                       |
| **v1.2.0** | _Nov 2026_ | **Diseño Cyber-Techno Neón:** Tarjetas 3D reversibles (Flip Card), modo oscuro de alto contraste y documentación exhaustiva de funciones.                                                     |
| **v1.1.0** | _Nov 2026_ | **Persistencia Cloud:** Integración de Google Auth y Cloud Firestore, compresión de imágenes en cliente (1280px).                                                                             |
| **v1.0.0** | _Nov 2026_ | **Lanzamiento Inicial:** Motor algorítmico base con calibración de precios en pesos mexicanos (MXN).                                                                                          |

---

## 🚀 Roadmap y Posibles Mejoras Futuras

A continuación se listan las mejoras prioritarias planificadas para próximas versiones:

- [ ] **Escáner de Código de Barras UPC / EAN:** Lectura instantánea de códigos de barras de cajas de videojuegos para identificar edición, región (NTSC/PAL) y año de tiraje sin necesidad de tipeo.
- [ ] **Valuador de Paquetes / Lotes Gamer (Bundle Pricing):** Algoritmo para tasar paquetes completos (ej. _Consola + 6 juegos + 2 mandos + base de carga_) con descuento sugerido por venta en bulto.
- [ ] **Calculadora de Comisiones de Comercio Electrónico:** Desglose interactivo de comisiones netas de Mercado Libre (Publicación Clásica vs Premium, costo de guía de Mercado Envíos e ISR/IVA retenido).
- [ ] **Modo Offline PWA (Progressive Web App):** Instalación como aplicación nativa en Android/iOS con funcionamiento local del motor heurístico en zonas con baja señal celular.
- [ ] **Alertas de Oportunidades (Marketplace Radar):** Notificaciones push cuando un producto objetivo baje de su Fair Market Value (FMV) para _flippers_ y coleccionistas.

---

## 💻 Instalación y Configuración

### Prerrequisitos

- Node.js v20 o superior
- Cuenta y proyecto de Firebase (Authentication + Cloud Firestore)
- API Key de Google Gemini (`GEMINI_API_KEY`)

### Pasos para Ejecutar Localmente

1. **Clonar el repositorio e instalar dependencias:**

```bash
git clone https://github.com/tu-usuario/snapprice-mx.git
cd snapprice-mx
npm install
```

2. **Configurar variables de entorno (`.env`):**
   Crea un archivo `.env` basado en `.env.example`. Además de Gemini, el backend necesita credenciales de administrador de Firebase para verificar identidad, aplicar cuotas y guardar los tokens OAuth de Mercado Libre. En Cloud Run, asigna a la cuenta de servicio el rol `roles/datastore.user`. En desarrollo local, configura Application Default Credentials con `gcloud auth application-default login` o define `GOOGLE_APPLICATION_CREDENTIALS` con una ruta fuera del repositorio. Nunca subas el archivo de credenciales. `FIREBASE_PROJECT_ID` debe coincidir con `VITE_FIREBASE_PROJECT_ID` y `src/firebase-config.json`; `FIRESTORE_DATABASE_ID` debe coincidir con la base del cliente. `.env` y los archivos de credenciales se excluyen del contexto Docker.

   Para exigir App Check en producción, registra la app web con reCAPTCHA Enterprise en Firebase App Check, configura `VITE_RECAPTCHA_ENTERPRISE_SITE_KEY` durante la compilación y activa `APP_CHECK_ENFORCED=true` en el backend. No actives el enforcement hasta que la app desplegada ya envíe tokens válidos.

```env
GEMINI_API_KEY=tu_api_key_de_gemini
FIREBASE_PROJECT_ID=tu-proyecto-firebase
FIRESTORE_DATABASE_ID=tu-base-de-datos
APP_CHECK_ENFORCED=false
MELI_CLIENT_ID=id_de_aplicacion_de_mercado_libre
MELI_CLIENT_SECRET=secreto_de_aplicacion_de_mercado_libre
MELI_REDIRECT_URI=https://tu-dominio.example/api/mercadolibre/oauth/callback
MELI_OAUTH_SETUP_KEY=clave_aleatoria_de_al_menos_32_caracteres
SERPAPI_API_KEY=clave_privada_de_serpapi
SERPAPI_ENABLED=false
VITE_RECAPTCHA_ENTERPRISE_SITE_KEY=clave_publica_reCAPTCHA_Enterprise
PORT=3000
```

#### Conectar la cuenta operativa de Mercado Libre

Después de registrar `MELI_REDIRECT_URI` exactamente en la aplicación de Mercado Libre y desplegar el backend bajo ese dominio HTTPS:

1. Inicia el servidor con `MELI_CLIENT_ID`, `MELI_CLIENT_SECRET`, `MELI_REDIRECT_URI` y una clave aleatoria privada `MELI_OAUTH_SETUP_KEY` (mínimo 32 caracteres).
2. Envía `POST /api/mercadolibre/oauth/start` autenticando la solicitud con la clave administrativa en el encabezado `Authorization` con esquema Bearer. Copia `authorizationUrl` de la respuesta y ábrela para autorizar la cuenta operativa de SnapPrice.
3. Mercado Libre volverá a `/api/mercadolibre/oauth/callback`. Para comprobar el estado, consulta `GET /api/mercadolibre/oauth/status` con el mismo encabezado; solo informa si hay un token guardado y vigente, y cuándo expira. No comprueba conectividad en vivo con el API de anuncios.

4. **Iniciar el servidor de desarrollo:**

```bash
npm run dev
```

La aplicación estará disponible en `http://localhost:3000`.

4. **Ejecutar suite de pruebas unitarias (Vitest):**

```bash
npm run test
```

5. **Compilación y ejecución para producción:**

```bash
npm run build
npm run start
```

---

## 🐳 Despliegue en Producción (Docker & Cloud Run)

El proyecto incluye un `Dockerfile` multi-etapa optimizado para producción:

```bash
# Construir la imagen Docker
docker build --build-arg VITE_RECAPTCHA_ENTERPRISE_SITE_KEY="tu_clave_publica" -t snapprice-mx .

# Ejecutar el contenedor
docker run -p 3000:3000 -e GEMINI_API_KEY="tu_clave_gemini" -e APP_CHECK_ENFORCED="true" snapprice-mx
```

- **Google Cloud Run:** Compatible de forma nativa desplegando la imagen en Artifact Registry.
- **VPS / Node.js:** Ejecuta `npm ci`, `npm run build` y luego `npm start` bajo un usuario de sistema sin privilegios.
- El contenedor instala dependencias con `npm ci`, ejecuta un bundle JavaScript y usa el usuario sin privilegios `node`.
- **Archivo `metadata.json`:** Requerido por la plataforma Google AI Studio para declarar permisos del contenedor, proxy de IA del servidor (`MAJOR_CAPABILITY_SERVER_SIDE_GEMINI_API`) y metadatos de despliegue.

---

<p align="center">
  <b>SnapPrice MX</b> · Cotización inteligente, transparente y segura en México 🇲🇽
</p>
