# Skill: Nuevo Cliente Crown Media — Onboarding de Reporting

## Cuándo usar este skill
Cuando Carolina o alguien del equipo diga:
- "Agrega el cliente X"
- "Nuevo cliente: [nombre]"
- "Configura el reporting para [cliente]"
- "Replica el dashboard para [cliente]"

---

## PASO 1 — Recopilar información del cliente

Pedir (o leer del `config.json` si ya existe):

| Campo | Ejemplo |
|---|---|
| Nombre del cliente | Lök |
| Slug (carpeta) | lok |
| Industry | ecommerce / restaurante / retail |
| Moneda | COP / USD |
| Google Sheet URL | https://docs.google.com/... |
| Módulos activos | ecommerce, paid_media, catering, seo... |
| ¿Tiene hoja Catering? | Sí / No |
| ¿Tiene hoja Adquisición? | Sí / No |
| Meses activos (datos disponibles) | Ene, Feb, Mar... |

---

## PASO 2 — Crear estructura de carpetas

```
clientes/[slug]/
├── config.json          ← Copiar de _plantillas/client-config.template.json y completar
├── brand/               ← Logos, colores propios si los tiene (opcional)
└── data/                ← JSONs de GA4/Shopify si se exportan localmente
```

Comando para crear:
```bash
mkdir -p clientes/[slug]/brand clientes/[slug]/data
cp _plantillas/client-config.template.json clientes/[slug]/config.json
```

---

## PASO 3 — Leer el Google Sheet

El sheet siempre tiene hasta 4 hojas activas (algunas opcionales):

| Hoja | Campo en config | Contenido |
|---|---|---|
| Mes en curso | `sheets.mes_actual` | Canales × ventas, sesiones, órdenes, conv, Δ vs mes anterior |
| YoY [año] | `sheets.yoy` | KPIs 2025 vs 2026 por mes: sesiones, órdenes, ventas, ROAS, inversión, ticket, conv |
| Clientes Nuevos | `sheets.adquisicion` | Nuevos, recurrentes, pagados/orgánicos, % |
| Catering (opcional) | `sheets.catering` | Inversión Meta+Google, impresiones, clics, CTR, CPM, CPC |

Leer con Google Sheets MCP si está disponible. Si no, pedir que la data se pegue en el chat.

---

## PASO 4 — Construir el dashboard HTML

### Variables JavaScript a poblar (copiar del template de Familia Fine Foods):

```javascript
const CLIENT = config.client;
const MONTHS = [...];   // meses con datos

// YoY
const yoy = {
  sessions_25: [...], sessions_26: [...],
  orders_25:   [...], orders_26:   [...],
  sales_25:    [...], sales_26:    [...],
  roas_25:     [...], roas_26:     [...],
  inv_25:      [...], inv_26:      [...],
  ticket_25:   [...], ticket_26:   [...],
  conv_25:     [...], conv_26:     [...],
};

// Paid Media
const paid = {
  sales_25: [...], sales_26: [...],
  roas_25:  [...], roas_26:  [...],
  inv_google_26: [...], inv_meta_26: [...],
  ticket_25: [...], ticket_26: [...],
};

// Mes actual por canal
const channels_mes = [
  { name:'Organic', sales:0, sessions:0, orders:0, conv:0, delta_sales:0, delta_sessions:0, delta_orders:0 },
  // ... un objeto por canal
];

// Adquisición (solo si módulo activo)
const acq = {
  new_26: [...], ret_26: [...], paid_26: [...],
  new_25: [...], pct_new_26: [...], pct_ret_26: [...],
};

// Catering (solo si módulo activo)
const catering = {
  inv: [...], meta: [...], google: [...],
  imps: [...], clicks: [...], ctr: [...], cpm: [...], cpc: [...],
};
```

### Pestañas del dashboard (activar según módulos en config):
1. **Resumen ejecutivo** — siempre presente
2. **Canales** — siempre presente si ecommerce: true
3. **Paid Media** — si paid_media: true
4. **Adquisición** — si adquisicion_clientes: true
5. **Catering** — si catering: true
6. **Tabla YoY** — siempre presente

### Paleta de marca Crown Media (siempre la misma, leer de brand.json si hay override):
```javascript
const C = {
  green_dark: '#163029', green_mid: '#41685B', gold: '#BC955B',
  muted: '#8B7355', sage: '#A8C5BB', danger: '#8B3A2E', cream: '#F4EAE1',
};
```

### Archivo de referencia base:
`clientes/familia-fine-foods/familia_ff_dashboard_2026.html`
Usar como punto de partida: copiar, cambiar `CLIENT_NAME`, datos, y activar/desactivar pestañas según módulos.

---

## PASO 5 — Guardar el dashboard

Ruta de salida:
```
clientes/[slug]/[slug]_dashboard_[año].html
```

Ejemplo: `clientes/lok/lok_dashboard_2026.html`

---

## PASO 6 — Crear tarea programada (martes 8AM)

Usar `mcp__scheduled-tasks__create_scheduled_task` con:
- `taskId`: `[slug]-dashboard-semanal`
- `cronExpression`: `"0 8 * * 2"` (martes 8AM hora local)
- Prompt: descripción completa del cliente incluyendo sheet URL, módulos activos, ruta de output y notas de anomalías conocidas.

---

## PASO 7 — Commit al repo

```bash
cd /Users/crownmediadanielb/Documents/Reporting-Ads
git add clientes/[slug]/
git commit -m "feat: add [nombre cliente] reporting setup"
git push origin main
```

---

## Notas de calidad

- **Moneda**: siempre leer de `config.json → client.currency`. Compactar valores: $14.6K, $1.2M.
- **Flechas**: ▲ verde para positivo, ▼ rojo para negativo en todos los comparativos.
- **Anomalías**: documentar en `config.json → notas` y agregar flag ⚠️ en la tabla YoY.
- **Sin 3D**: todas las gráficas Chart.js en 2D limpio, grilla alpha 0.06.
- **Catering ROAS**: si el cliente no conecta CRM físico, ROAS catering = 0. Agregar insight card explicando.
- **Cero datos**: si un módulo no tiene datos aún, mostrar la pestaña con estado vacío ("Sin datos aún — disponible desde [mes]").
