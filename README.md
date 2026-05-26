# Crown Media — Reportes de Ads

Repositorio de reportes mensuales de performance para los clientes gestionados por **Crown Media** (marketing@crownmediagroup.com.co).

## Estructura

```
clientes/
  familia-fine-foods/
    informe-familia-ff-mayo2026.html   ← Reporte mensual (self-contained HTML)
    brand/
      brand.json                       ← Tokens de marca (colores, tipografías)
      BRAND GUIDELINES CROWN MEDIA.pdf
    data/
      ga4_totals_current.json          ← GA4 período actual
      ga4_totals_prior.json            ← GA4 período anterior (YoY)
      ga4_channels_current.json        ← GA4 desglose por canal
      ga4_funnel_events.json           ← Embudo de conversión
      ga4_daily_sessions.json          ← Sesiones diarias
  lok/
    ...
```

## Tecnologías del reporte HTML
- **Chart.js 4.4.0** — gráficas doughnut, bar, line
- **Google Fonts** — Bodoni Moda, Work Sans, Prompt
- 100% self-contained — abre directo en el navegador sin servidor

## Metodología de atribución
Se usa **Shopify UTM source** como fuente de verdad financiera (no MMM ni plataformas).
- Google Ads ROAS Real = ventas UTM Google / gasto Google web
- Facebook ROAS Real = ventas UTM Facebook / gasto Facebook web
- Campañas `*_RESTAURANTE*` no se miden por ROAS web (objetivo: tráfico físico)

## Contacto
Crown Media — crownmediagroup.com.co
