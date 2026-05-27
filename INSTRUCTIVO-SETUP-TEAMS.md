# Crown Media · Instructivo de Setup — Cuenta Teams
### Sesión de onboarding del equipo · Mayo 2026

> **Para el facilitador (Daniel):** Este documento cubre todo lo que el equipo necesita para quedar operativo en la cuenta Teams de Anthropic y el repositorio compartido. Ir sección por sección, en orden.

---

## ¿Qué vamos a tener al final de esta sesión?

Cada persona del equipo (5 en total) quedará con:

- ✅ El repositorio `Reporting-Ads` en su computador
- ✅ Claude Code funcionando con la cuenta Teams
- ✅ Cowork (Claude desktop) apuntando al repositorio
- ✅ Entender cuál herramienta usar para cada tipo de reporte
- ✅ Saber cómo crear un cliente nuevo desde cero

---

## PARTE 1 · El repositorio — qué es y para qué sirve

El repositorio `Reporting-Ads` es la **carpeta central de trabajo de Crown Media**. Vive en GitHub y en el computador de cada persona. Contiene:

```
Reporting-Ads/
│
├── clientes/                    ← Una carpeta por cada cliente
│   ├── lok/                     ← Lök Foods
│   ├── familia-fine-foods/      ← Familia Fine Foods
│   └── [nuevo-cliente]/         ← Se irán agregando
│
├── _templates/                  ← Plantillas para flujo Claude Code + MCP
├── _plantillas/                 ← Plantillas para flujo Cowork + Google Sheets
│
├── nuevo-cliente.sh             ← Script para crear carpeta de cliente nuevo
├── CLAUDE.md                    ← Contexto global (Claude lo lee automáticamente)
└── README.md                    ← Descripción del proyecto
```

Cada carpeta de cliente tiene:
```
clientes/lok/
├── CLAUDE.md         ← Contexto completo del cliente (cuentas, campañas, quirks)
├── brand/
│   └── brand.json    ← IDs de plataformas, colores, tipo de workflow
├── html/             ← Reportes mensuales HTML
└── data/             ← JSONs de datos (cuando aplique)
```

---

## PARTE 2 · Las dos herramientas y cuándo usar cada una

**Este es el punto más importante. Hay dos flujos de trabajo distintos.**

### 🖥️ Flujo 1 — Claude Code (terminal)
- **Cuándo usarlo:** Informes mensuales de performance (GA4, Meta Ads, Google Ads, Shopify)
- **Cómo funciona:** Claude se conecta directo a las plataformas via Dataslayer MCP y construye el reporte con datos reales
- **Output:** `informe-{cliente}-{mes}{año}.html` — archivo autocontenido, abre en el browser
- **Plantillas:** carpeta `_templates/`
- **Ejemplo:** `clientes/lok/html/informe-lok-abr-may2026.html`

### 🤖 Flujo 2 — Cowork (Claude desktop / claude.ai)
- **Cuándo usarlo:** Dashboards semanales automáticos basados en Google Sheets
- **Cómo funciona:** Claude lee el Google Sheet del cliente y construye el dashboard. Se puede programar para que corra solo cada martes a las 8AM
- **Output:** `{cliente}_dashboard_{año}.html` — dashboard con pestañas interactivas
- **Plantillas:** carpeta `_plantillas/`
- **Ejemplo:** `clientes/familia-fine-foods/familia_ff_dashboard_2026.html`

### ¿Cómo sé cuál flujo usa cada cliente?

Abre `clientes/{slug}/brand/brand.json` y busca el campo `workflow`:

```json
"workflow": {
  "type": "mcp"       ← solo Claude Code
}
```
```json
"workflow": {
  "type": "sheets"    ← solo Cowork
}
```
```json
"workflow": {
  "type": "ambos"     ← los dos (como Familia Fine Foods)
}
```

---

## PARTE 3 · Setup inicial — hacer una sola vez por persona

### Requisito previo
Tener una cuenta en GitHub (gratuita personal). Si no tienes: [github.com/signup](https://github.com/signup)

Decirle a Daniel tu usuario de GitHub para que te agregue como colaborador del repo.

---

### Paso 1 — Clonar el repositorio

Abre la app **Terminal** en tu Mac y corre:

```bash
git clone git@github.com:danielb-CM/reporting-ads.git ~/Documents/Reporting-Ads
```

> Si ya tienes la carpeta `Reporting-Ads` (como Daniel), saltarte este paso.

Verificar que quedó bien:
```bash
ls ~/Documents/Reporting-Ads/clientes/
```
Debe mostrar: `familia-fine-foods` y `lok`

---

### Paso 2 — Instalar Claude Code (si no lo tienes)

```bash
npm install -g @anthropic-ai/claude-code
```

Verificar que quedó instalado:
```bash
claude --version
```

---

### Paso 3 — Autenticarse en Claude Code con la cuenta Teams

```bash
claude login
```

Abre el browser automáticamente. **Importante:** entrar con el email de la cuenta Teams de Anthropic (no tu cuenta personal).

Verificar que quedó con la cuenta correcta:
```bash
claude whoami
```
Debe mostrar el email de la cuenta Teams.

---

### Paso 4 — Conectar Cowork al repositorio

1. Abre **Claude desktop** en tu Mac (o entra a **claude.ai** en el browser)
2. Asegúrate de estar en la **organización Teams** (esquina superior izquierda, cambiar de cuenta personal a la org)
3. En la barra lateral: **"+ New Project"** o **"Connect folder"**
4. Selecciona la carpeta: `~/Documents/Reporting-Ads`
5. Claude ahora puede leer y escribir todos los archivos del proyecto

---

## PARTE 4 · Workflow diario del equipo

### Antes de empezar a trabajar — sincronizar cambios

Cada vez que vayas a trabajar, primero actualiza con los cambios del resto del equipo:

```bash
cd ~/Documents/Reporting-Ads
git pull origin main
```

---

### Para trabajar en un cliente con Claude Code

```bash
cd ~/Documents/Reporting-Ads/clientes/lok
claude
```

Claude lee automáticamente el `CLAUDE.md` del cliente y ya sabe:
- Qué plataformas tiene conectadas
- Qué tipo de workflow usa
- El historial de reportes anteriores
- Las particularidades técnicas del cliente

---

### Para trabajar en un cliente con Cowork

Abre Cowork y escribe directamente:
> *"Actualiza el dashboard de lok con los datos de la semana del [fecha]"*
> *"Genera el informe mensual de Familia Fine Foods para junio 2026"*

Cowork lee el `CLAUDE.md` del cliente automáticamente si la carpeta está conectada.

---

### Después de trabajar — subir cambios al repo

```bash
cd ~/Documents/Reporting-Ads
git add -A
git commit -m "[code] feat: informe lok junio 2026"
git push origin main
```

**Convención de commits — siempre empezar con la herramienta usada:**

| Prefijo | Cuándo usarlo |
|---|---|
| `[code]` | Trabajo hecho con Claude Code desde la terminal |
| `[cowork]` | Trabajo hecho con Cowork / Claude desktop |
| `[manual]` | Cambios hechos a mano (edición de configs, brand.json, etc.) |

Ejemplos:
```
[code] feat: informe lok mayo 2026 — datos Abril-Mayo completo
[cowork] update: dashboard familia-fine-foods semana 21
[manual] chore: nuevo cliente nutrisa — config inicial
[code] fix: corregir canal Revie en gráfica de canales lok
```

---

## PARTE 5 · Crear un cliente nuevo

### Opción A — Desde Claude Code (flujo MCP)

```bash
cd ~/Documents/Reporting-Ads
./nuevo-cliente.sh
```

El script pregunta:
- Nombre del cliente
- Slug (nombre de carpeta, ej: `nutrisa`, `grupo-familia`)
- País
- Moneda

Crea automáticamente:
```
clientes/[slug]/
├── CLAUDE.md         ← listo para completar
├── brand/brand.json  ← listo para completar con IDs
├── html/
└── data/
```

Luego completar en `brand/brand.json`:
- `meta_ads_id` → ID de la cuenta Meta Ads
- `google_ads_id` → ID de Google Ads
- `ga4_property` → ID de la propiedad GA4
- `workflow.type` → `mcp`, `sheets` o `ambos`

Y en `CLAUDE.md`:
- Contexto del negocio
- Estructura de campañas
- Particularidades técnicas

---

### Opción B — Desde Cowork (flujo Sheets)

En Cowork escribir exactamente:
> *"Nuevo cliente: [Nombre]. Slug: [slug]. Lee `_plantillas/SKILL.md` y crea la estructura completa en `clientes/[slug]/`"*

Cowork crea la carpeta, copia las plantillas y pide los datos faltantes.

---

### Después de crear el cliente — commit

```bash
git add clientes/[slug]/
git commit -m "[manual] chore: nuevo cliente [nombre] — config inicial"
git push origin main
```

---

## PARTE 6 · Reglas del equipo

| Regla | Por qué |
|---|---|
| **Siempre `git pull` antes de empezar** | Evita conflictos con cambios de otros |
| **Un commit por tarea, mensaje descriptivo** | El equipo sabe qué cambió sin abrir archivos |
| **Nunca subir archivos `.env` o con tokens** | Seguridad — el `.gitignore` ya los bloquea |
| **Usar el prefijo `[code]`, `[cowork]` o `[manual]`** | Trazabilidad de qué herramienta hizo qué |
| **El `CLAUDE.md` del cliente siempre actualizado** | Claude necesita contexto fresco para trabajar bien |
| **`workflow.type` correcto en `brand.json`** | Las dos herramientas saben qué les corresponde |

---

## PARTE 7 · Referencia rápida

### Comandos git más usados

```bash
# Sincronizar antes de empezar
git -C ~/Documents/Reporting-Ads pull origin main

# Ver qué archivos cambiaron
git -C ~/Documents/Reporting-Ads status

# Subir todo
git -C ~/Documents/Reporting-Ads add -A
git -C ~/Documents/Reporting-Ads commit -m "[code] descripción"
git -C ~/Documents/Reporting-Ads push origin main

# Ver historial reciente
git -C ~/Documents/Reporting-Ads log --oneline -10
```

### Abrir Claude Code en un cliente

```bash
cd ~/Documents/Reporting-Ads/clientes/lok && claude
cd ~/Documents/Reporting-Ads/clientes/familia-fine-foods && claude
cd ~/Documents/Reporting-Ads/clientes/[nuevo-slug] && claude
```

### Crear cliente nuevo

```bash
cd ~/Documents/Reporting-Ads && ./nuevo-cliente.sh
```

---

## Clientes activos hoy

| Slug | Cliente | País | Moneda | Workflow |
|---|---|---|---|---|
| `lok` | Lök Foods | Colombia | COP | `mcp` — Claude Code + Dataslayer |
| `familia-fine-foods` | Familia Fine Foods | Canadá | CAD | `ambos` — Code + Cowork |

---

## Contacto y accesos

- **Repo GitHub:** github.com/danielb-CM/reporting-ads
- **Cuenta Teams Anthropic:** marketing@crownmediagroup.com.co
- **Conexión GA4/Google:** ivan.vargas@crownmedia.com.co
- **Conexión Meta:** daniel.b@crownmedia.com.co

---

*Crown Media · Instructivo preparado: Mayo 2026*
*Cualquier duda durante el setup: abrir este archivo y seguir desde donde se quedaron*
