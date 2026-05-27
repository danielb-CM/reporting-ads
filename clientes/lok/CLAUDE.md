# Lök Foods · Crown Media

## Quién es el cliente

- **Nombre:** Lök Foods
- **País / Ciudad:** Colombia, Medellín
- **Industria:** Food & Beverage · E-commerce
- **Web:** lokfoods.com
- **Instagram:** @lok.foods

## Cuentas de plataformas

| Plataforma   | ID / Propiedad              | Conexión Dataslayer              |
|--------------|-----------------------------|----------------------------------|
| GA4          | properties/384818907        | ivan.vargas@crownmedia.com.co    |
| Google Ads   | 762-337-6244                | ivan.vargas@crownmedia.com.co    |
| Meta Ads     | act_1127236737996269        | daniel.b@crownmedia.com.co       |
| Shopify      | lok-col                     | daniel.b@crownmedia.com.co       |

⚠️ **REGLA CRÍTICA:** Una sola conexión por plataforma. Nunca mezclar — multiplica los datos.

## Moneda y región

- Moneda principal: **COP**
- Formato: `es-CO`, compactar a M/K → $2.3M, $491K
- Función en JS: `fmtCOP(v)` / `fmtCOPFull(v)`

## Fuente de verdad financiera

GA4 `purchaseRevenue` como fuente de ingresos.
Google Ads y Meta Ads via Dataslayer para gasto.
**Meta Ads no tiene granularidad diaria** → prorratear por ratio `sessions / TOTAL_SESSIONS_ALL`.

## Contexto del negocio

Lök Foods es una marca de alimentación saludable con tienda en línea (Shopify) en Colombia.
Modelo de negocio: e-commerce directo con campañas en Google y Meta.
Reporte cubre el período Abril–Mayo 2026 con filtros de fecha dinámicos.

## Estructura de campañas Google Ads

| Índice | Nombre | Tipo |
|--------|--------|------|
| 0 | LOK_COL_G_PEF_PMAX_PFMAX_MAX_PURCHASE | Performance Max |
| 1 | LOK_COL_G_PEF_CPC_SALES_SHOPPING_AON  | Shopping Always On |
| 2 | LOK_COL_G_PEF_SEM_B_MAX_PURCHASE      | SEM Branded |

## Estructura campañas Meta Ads

| Clave | Nombre | Tipo |
|-------|--------|------|
| rmk | RMK · Remarketing | Remarketing |
| max | MAX PURCHASE · Adquisición | Prospecting |
| awn | ALWAYS ON · Siempre activa | Always On |

## Canales GA4 — Canales Lök Foods (grupo personalizado)

GA4 tiene el grupo **"Canales Lök Foods"** / **"Session Canales Lök Foods"**.
**Dataslayer NO puede acceder** — siempre retorna `sessionDefaultChannelGroup`.

### Remapeo implementado (función `lkRows()` en el HTML)

| Canal Lök Foods | Índices `sessionDefaultChannelGroup` |
|-----------------|--------------------------------------|
| Google cpc      | 0 (Cross-network) + 4 (Paid Shopping) + 6 (Paid Search) |
| Orgánico        | 1 (Organic Search) |
| Directo         | 2 (Direct) |
| Meta cpc        | 3 (Paid Social) |
| Email           | 5 (Email) |
| Social          | 7 (Organic Social) |
| Unassigned      | 8 (Unassigned) **menos Revie** |
| Referral        | 9 (Referral) + 10 (Other) |
| **Revie**       | Extraído por `source=revie` via `sessionSourceMedium` |

### Canal Revie (plataforma de reseñas colombiana)
- Mediums: `revie_carousel` y `revie_star`
- En GA4 default → clasificado como **Unassigned** (medium no estándar)
- Embebido en el HTML como constante `RV` con datos diarios por fecha
- Abril 2026: 62 sesiones · 4 transacciones · $561,840 COP
- Mayo 2026 (1–13): 46 sesiones · 2 transacciones · $341,290 COP

## Arquitectura del reporte HTML

El reporte tiene **filtros de fecha dinámicos** — todos los datos, charts y tablas se recalculan en tiempo real.

### Constantes de datos (JS embebido)

| Constante | Contenido |
|-----------|-----------|
| `CH`      | Sesiones por canal (11 índices) por fecha |
| `CHU`     | Usuarios por canal por fecha |
| `FN`      | Funnel: [view_item, add_to_cart, begin_checkout, purchase] por fecha |
| `GG`      | Google Ads: 3 campañas × [spend, impr, clicks, conv, val] por fecha |
| `META`    | Meta totals: {rmk, max, awn} con {s, i, c, p, v, roas} — sin granularidad diaria |
| `DAILY`   | Sessions + revenue por fecha |
| `RV`      | Revie: {s, t, r} por fecha |

### Funciones clave

| Función | Qué hace |
|---------|----------|
| `aggregate(start, end)` | Calcula todas las métricas para cualquier rango de fechas |
| `lkRows(chSess, chUsers, rvSess)` | Remapea canales default → Canales Lök Foods (incluye Revie) |
| `applyDateRange()` | Aplica filtro de fecha y actualiza todos los componentes |
| `fmtCOP(v)` | Formatea COP compacto ($2.3M) |

## Reportes creados

| Archivo | Período | Páginas | Estado |
|---|---|---|---|
| `html/informe-lok-abr-may2026.html` | 1 Abr – 13 May 2026 | 9 | ✅ Activo · filtros dinámicos |

## Notas técnicas

- `TOTAL_SESSIONS_ALL = DAILY.reduce((a,d)=>a+d.s,0)` — calculado al cargar para prorratear Meta
- Revie se descuenta de `chSess[8]` (Unassigned) en `lkRows()` para evitar doble conteo
- `buildChannelChart(rows)` y `buildCompareChart(rows)` reciben `lkRows()` directamente
- Compare chart usa `LK_LABELS` como eje X fijo, Marzo 2026 como período de comparación (9,352 sesiones)
