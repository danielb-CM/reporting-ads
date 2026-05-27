# Crown Media · Reporting-Ads

Repositorio central de **reportes mensuales HTML** para los clientes de Crown Media.
Agencia boutique de marketing digital — Medellín, Colombia.
Contacto: marketing@crownmediagroup.com.co

---

## Estructura del repo

```
clientes/{slug-cliente}/
  CLAUDE.md              ← LEE ESTO PRIMERO al abrir cualquier cliente
  brand/brand.json       ← IDs de cuentas, colores, config del cliente
  html/                  ← Reportes: informe-{slug}-{mes}{año}.html
  data/                  ← JSONs de datos (si se guardan localmente)
_templates/              ← Plantillas para crear nuevos clientes
nuevo-cliente.sh         ← Script de scaffolding (ejecutar para nuevo cliente)
```

## Regla crítica — Dataslayer MCP

**UNA sola conexión por plataforma. Mezclar conexiones MULTIPLICA los datos.**

| Plataforma       | Conexión obligatoria              |
|------------------|-----------------------------------|
| GA4 / Google Ads | ivan.vargas@crownmedia.com.co     |
| Meta Ads         | daniel.b@crownmedia.com.co        |
| Shopify          | ver `dataslayer_connection` en el brand.json del cliente |

## Fuente de verdad por tipo de cliente

| Tipo de cliente            | Fuente de verdad financiera          |
|----------------------------|--------------------------------------|
| Shopify Colombia (COP)     | GA4 `purchaseRevenue` + Shopify UTM  |
| Shopify Internacional      | Shopify UTM source al checkout       |
| Solo tráfico / branding    | GA4 sesiones + métricas de plataforma |

## Brand del reporte HTML — Crown Media

```
Tipografías:
  Titulares  → Bodoni Moda (font-display, italic)
  Body/tablas → Work Sans (300–700)
  KPIs/números → Prompt (400–900, siempre UPPERCASE)

Paleta:
  --green-dark : #163029   (fondos hero, headers)
  --green-mid  : #41685B   (acento secundario)
  --cream      : #F4EAE1   (fondo páginas internas)
  --gold       : #BC955B   (acento, KPIs destacados — usar con moderación)
  --black      : #101820   (texto principal)
  --muted      : #5C6660   (texto secundario, footnotes)
  --danger     : #8B3A2E   (alertas negativas)
```

Guidelines completas: `clientes/familia-fine-foods/brand/brand.json`

## Workflow — reporte nuevo para cliente existente

1. `cd clientes/{slug}` y abre Claude Code ahí → el `CLAUDE.md` del cliente se carga automáticamente
2. Lee el `brand/brand.json` del cliente para IDs de cuentas
3. Revisa el HTML del mes anterior como referencia de estructura y datos
4. Usa Dataslayer MCP para traer los datos del nuevo período
5. Construye el HTML self-contained (Chart.js + datos embebidos como JS)
6. Nombre del archivo: `html/informe-{slug}-{mes}{año}.html`

## Workflow — crear nuevo cliente

```bash
./nuevo-cliente.sh
```

El script pide los datos básicos, crea la carpeta y copia las plantillas.
Luego completa `brand/brand.json` con los IDs reales y `CLAUDE.md` con el contexto.

## Clientes activos

| Slug                | Cliente            | País     | Moneda |
|---------------------|--------------------|----------|--------|
| lok                 | Lök Foods          | Colombia | COP    |
| familia-fine-foods  | Familia Fine Foods | Canadá   | CAD    |
| *(agregar aquí)*    |                    |          |        |

---
*Último update: Mayo 2026*
