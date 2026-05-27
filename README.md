# Crown Media — Reporting de Clientes

Repositorio central de dashboards interactivos y configuraciones de reporting para todos los clientes de **Crown Media** (marketing@crownmediagroup.com.co).

---

## Estructura del repositorio

```
Reporting-Ads/
├── _plantillas/
│   ├── SKILL.md                          ← Instrucciones para Claude: cómo montar un cliente nuevo
│   └── client-config.template.json       ← Plantilla JSON de configuración por cliente
├── clientes/
│   ├── familia-fine-foods/
│   │   ├── config.json                   ← Configuración del cliente ✅
│   │   ├── familia_ff_dashboard_2026.html ← Dashboard interactivo ✅
│   │   ├── brand/
│   │   └── data/
│   ├── lok/
│   │   └── (por configurar)
│   └── [nuevo-cliente]/
│       ├── config.json
│       └── [slug]_dashboard_2026.html
└── README.md
```

---

## Cómo agregar un cliente nuevo

1. **Copia la plantilla de config:**
   ```bash
   mkdir -p clientes/[slug]/brand clientes/[slug]/data
   cp _plantillas/client-config.template.json clientes/[slug]/config.json
   ```

2. **Completa el `config.json`** con los datos del cliente (nombre, sheet URL, módulos activos, moneda, meses).

3. **Abre Cowork (Claude desktop)** y escribe:
   > "Configura el reporting para el cliente [nombre] — lee el config en `clientes/[slug]/config.json`"

   Claude leerá `_plantillas/SKILL.md` automáticamente y seguirá el proceso completo:
   leer el sheet → extraer datos → construir el dashboard → programar la tarea semanal.

4. **Haz commit:**
   ```bash
   git add clientes/[slug]/
   git commit -m "feat: add [nombre cliente] reporting setup"
   git push origin main
   ```

---

## Clientes activos

| Cliente | Módulos | Dashboard | Tarea semanal | Estado |
|---|---|---|---|---|
| Familia Fine Foods | ecommerce, paid, catering, adquisición | ✅ | ✅ martes 8AM | Activo |
| Lök | — | — | — | Por configurar |

---

## Metodología de atribución

Fuente de verdad financiera: **Shopify UTM source** (no plataformas de ads).

- **Google Ads ROAS real** = ventas UTM Google / gasto Google (solo campañas web)
- **Meta ROAS real** = ventas UTM Facebook / gasto Meta (solo campañas web)
- **Campañas `*_RESTAURANTE*`**: objetivo tráfico físico — no se mide ROAS web

---

## Tecnologías

- **Chart.js 4.5.1** (CDN con SRI hash) — gráficas doughnut, bar, line, mixed
- **Google Fonts** — Work Sans + Prompt (tipografía Crown Media)
- **HTML autocontenido** — abre directo en el navegador, sin servidor
- **Datos embebidos** como constantes JS — sin llamadas externas en runtime

---

## Equipo

Crown Media · Medellín, Colombia · crownmediagroup.com.co
Account: marketing@crownmediagroup.com.co
