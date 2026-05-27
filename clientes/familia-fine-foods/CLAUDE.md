# Familia Fine Foods · Crown Media

## Quién es el cliente

- **Nombre:** Familia Fine Foods
- **País / Ciudad:** Canadá (origen colombiano)
- **Industria:** Restaurant · Food & Beverage · E-commerce (Shopify)
- **Web:** familiafinefoods.com (pendiente confirmar URL exacta)
- **Instagram:** @familiafinefoods (pendiente confirmar)

## Cuentas de plataformas

| Plataforma   | ID / Propiedad              | Conexión Dataslayer              |
|--------------|-----------------------------|----------------------------------|
| GA4          | pendiente confirmar         | ivan.vargas@crownmedia.com.co    |
| Google Ads   | pendiente confirmar         | ivan.vargas@crownmedia.com.co    |
| Meta Ads     | pendiente confirmar         | daniel.b@crownmedia.com.co       |
| Shopify      | pendiente confirmar         | daniel.b@crownmedia.com.co       |

⚠️ **REGLA CRÍTICA:** Una sola conexión por plataforma. Nunca mezclar — multiplica los datos.

## Moneda y región

- Moneda principal: **CAD**
- Formato: `en-CA`, 2 decimales → $5,752.35 CAD

## Fuente de verdad financiera

**Shopify UTM source al checkout** — cada orden captura `utm_source` en el momento de pago.
Es más confiable que GA4, Meta o Google Ads (elimina doble conteo entre plataformas).

- **Google ROAS Real** = ventas_utm_google / gasto_google_web
- **Facebook ROAS Real** = ventas_utm_facebook / gasto_facebook_web
- **Campañas `*_RESTAURANTE*`** → objetivo tráfico físico, **NO medir por ROAS web**

## Contexto del negocio

Familia Fine Foods es un restaurante colombiano en Canadá con tienda Shopify.
Modelo mixto: restaurante físico (POS) + e-commerce online (Shopify).

### Mix de ventas online (Mayo 2026)
| Categoría | Ventas | Share | AOV |
|---|---|---|---|
| 🥘 Frozen (comidas congeladas) | $3,627 CAD | 63% | $151 |
| 🎉 Catering & Events | $2,073 CAD | 36% | $188 |
| Restaurant, Delivery, Gift Cards, Wholesale | $0 | 0% | — |

**Implicación táctica:** el 100% del paid media digital debe enfocarse en Frozen y Catering.
Restaurant, Delivery, Wholesale se venden exclusivamente vía POS/local.

## Estructura de campañas Google Ads (Mayo 2026)

- **AON SEM** — ROAS Real 20.73x · motor del e-commerce · mantener y escalar
- **PFMAX-AON** — complementario
- **Campañas `*_RESTAURANTE*`** — objetivo físico, no medir por ROAS web

## Estructura de campañas Facebook (Mayo 2026)

- **AON** — único con ROAS positivo (16.12x plataforma) · mantener
- **Taco Bar** — ROAS = 0 · **Pausar inmediatamente**
- **Taco Bar B2B** — ROAS = 0 · **Pausar inmediatamente**
- ROAS Real global Facebook: **0.52x** (bajo break-even)

## Particularidades técnicas — Bug de tracking GA4

### ⚠️ GA4 API reporta ~5× más transacciones que la realidad
- **GA4 UI y Shopify:** ~33 transacciones reales
- **GA4 API (Dataslayer):** ~165 transacciones
- **Causa:** 2 Web Pixels personalizados en Shopify Customer Events disparando doble el evento `purchase` al mismo GA4 ID (G-846E3TWVXL)
- **Regla:** NO usar GA4 API para contar transacciones — usar Shopify directamente
- El AOV coincide; solo el conteo de eventos está duplicado

### Comparativa de modelos de atribución (Mayo 2026)
| Modelo | Ventas | Fiabilidad |
|---|---|---|
| Last-Click GA4 | $6,017 | Moderada |
| Data-Driven Facebook | $5,317 | Baja |
| Data-Driven Google | $8,431 | Muy baja |
| ⭐ **Shopify UTM** | **$5,752** | **Alta — fuente única honesta** |

## Comparativa YoY Mayo 2026 vs Mayo 2025

| Métrica | 2025 | 2026 | Δ |
|---|---|---|---|
| Sesiones | 3,017 | 6,653 | +121% 🟢 |
| Usuarios | 2,516 | 5,912 | +135% 🟢 |
| Engagement Rate | 45.11% | 60.47% | +34% 🟢 |
| Inversión | $435 | $406 | -7% 🟢 |
| CVR | 1.06% | 0.50% | ▼ ⚠️ |

El tráfico creció mucho pero la conversión bajó → el embudo necesita optimización, no más tráfico.

## Reportes creados

| Archivo | Período | Páginas | Estado |
|---|---|---|---|
| `informe-familia-ff-mayo2026.html` | 1–12 Mayo 2026 | 20 | ✅ Activo |
| `familia_ff_dashboard_2026.html`   | 2026 (dashboard) | — | ⚠️ Pendiente revisar |

## Notas del equipo

- El reporte actual **no tiene filtros dinámicos** (datos estáticos en HTML) — diferente a Lök Foods
- **Pendiente:** corregir el bug de doble disparo de Web Pixels en GA4
- **Pendiente:** pausar campañas Taco Bar y Taco Bar B2B en Meta
- **Pendiente:** confirmar IDs de plataformas en brand.json (están como "pendiente")

---
*Cliente activo desde: Mayo 2026 · Crown Media*
