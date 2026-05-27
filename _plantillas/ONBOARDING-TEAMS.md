# Guía de onboarding — Cuenta Teams de Claude · Crown Media

> Sigue este documento cuando abras la cuenta Teams de Claude.
> Aplica tanto para Carolina como para cada miembro del equipo que se agregue.

---

## PARTE 1 — Configuración inicial (una sola vez por persona)

### Paso 1 — Clonar el repositorio

Abre la app **Terminal** en tu Mac y corre:

```bash
git clone git@github.com:danielb-CM/reporting-ads.git ~/Documents/Reporting-Ads
```

Esto descarga toda la estructura del proyecto (clientes, plantillas, dashboards) en tu computador.

> Si ya tienes la carpeta `Reporting-Ads` (como Carolina), no es necesario clonar — ya la tienes.

---

### Paso 2 — Conectar la carpeta en Cowork

1. Abre **Claude desktop** (Cowork)
2. En la barra lateral, haz clic en **"+ Folder"** o **"Seleccionar carpeta"**
3. Navega a `Documents/Reporting-Ads` y selecciónala
4. Claude ahora puede leer y escribir todos los archivos del proyecto

---

### Paso 3 — Abrir el proyecto en Claude Code (terminal)

Si vas a trabajar con código o hacer commits desde Claude Code:

```bash
cd ~/Documents/Reporting-Ads
claude
```

Claude Code leerá automáticamente el `CLAUDE.md` del proyecto y sabrá:
- Qué clientes existen
- Qué metodología de atribución usa Crown Media
- Cómo nombrar archivos y carpetas

---

## PARTE 2 — Workflow diario del equipo

### Para trabajar en un cliente existente

Antes de empezar, sincroniza los últimos cambios del repo:

```bash
cd ~/Documents/Reporting-Ads
git pull origin main
```

Luego abre Cowork y dile a Claude:
> *"Abre el cliente familia-fine-foods y muéstrame el dashboard más reciente"*
> *"Actualiza el reporte de Lök con los datos de junio"*

---

### Para subir tus cambios al repo (después de trabajar)

```bash
cd ~/Documents/Reporting-Ads
git add -A
git commit -m "feat: [descripción breve de lo que hiciste]"
git push origin main
```

Ejemplos de mensajes de commit:
- `"feat: add cliente nutrisa reporting setup"`
- `"update: lok dashboard mayo 2026"`
- `"fix: corregir datos catering familia-fine-foods"`

---

## PARTE 3 — Agregar un cliente nuevo

### Paso 1 — Crear la carpeta del cliente

En Terminal:
```bash
cd ~/Documents/Reporting-Ads
mkdir -p clientes/[slug-cliente]/brand clientes/[slug-cliente]/data
cp _plantillas/client-config.template.json clientes/[slug-cliente]/config.json
```

Reemplaza `[slug-cliente]` por el nombre en minúsculas sin espacios.
Ejemplos: `nutrisa`, `casa-editorial`, `grupo-familia`

---

### Paso 2 — Completar el config.json del cliente

Abre `clientes/[slug-cliente]/config.json` y completa:

| Campo | Qué poner |
|---|---|
| `client.name` | Nombre completo del cliente |
| `client.slug` | El mismo nombre de la carpeta |
| `client.currency` | COP, USD, CAD, MXN, EUR |
| `client.sheet_url` | Link completo del Google Sheet |
| `modules.catering` | true si tiene campaña de catering |
| `modules.adquisicion_clientes` | true si tiene hoja "Clientes Nuevos" |
| `reporting.months_active` | Meses con datos: ["Ene", "Feb"...] |

---

### Paso 3 — Pedirle a Claude que construya el dashboard

En Cowork, escribe exactamente esto:
> *"Configura el reporting para [nombre cliente] — lee el config en clientes/[slug]/config.json y sigue las instrucciones en _plantillas/SKILL.md"*

Claude va a:
1. Leer el config del cliente
2. Conectarse al Google Sheet
3. Extraer los datos de las 4 hojas
4. Construir el dashboard HTML con los colores y tipografía de Crown Media
5. Programar la tarea semanal (martes 8AM)
6. Guardar el archivo en `clientes/[slug]/[slug]_dashboard_2026.html`

---

### Paso 4 — Subir al repo

```bash
cd ~/Documents/Reporting-Ads
git add clientes/[slug-cliente]/
git commit -m "feat: add [nombre cliente] reporting setup"
git push origin main
```

---

## PARTE 4 — Otros proyectos en paralelo dentro de Reporting-Ads

La carpeta `Reporting-Ads` puede contener más que solo reportes de clientes.
Estructura recomendada si tienen más proyectos en paralelo:

```
Reporting-Ads/
├── _plantillas/          ← Plantillas compartidas del equipo
├── clientes/             ← Un cliente por subcarpeta
│   ├── familia-fine-foods/
│   ├── lok/
│   └── [nuevo-cliente]/
├── _internos/            ← Proyectos internos de Crown Media (no clientes)
│   ├── crown-media-kpis/
│   └── plantillas-canva/
├── _assets/              ← Logos, fuentes, recursos compartidos
│   └── fonts/
└── README.md
```

Para agregar una carpeta de proyecto paralelo:
```bash
mkdir -p _internos/[nombre-proyecto]
```

---

## PARTE 5 — Reglas del equipo para el repo

| Regla | Por qué |
|---|---|
| Siempre `git pull` antes de empezar | Evita conflictos con cambios de otros |
| Un cliente por carpeta, siempre con `config.json` | Claude necesita el config para trabajar |
| Nunca subir archivos con passwords o tokens | Seguridad |
| Mensajes de commit descriptivos | El equipo sabe qué cambió sin abrir los archivos |
| El dashboard siempre es el archivo `[slug]_dashboard_[año].html` | Consistencia entre clientes |

---

## Referencia rápida — Comandos más usados

```bash
# Sincronizar antes de empezar
git pull origin main

# Ver qué archivos cambiaron
git status

# Subir cambios
git add -A && git commit -m "mensaje" && git push origin main

# Ver historial de cambios
git log --oneline -10

# Crear cliente nuevo desde cero
mkdir -p clientes/[slug]/brand clientes/[slug]/data
cp _plantillas/client-config.template.json clientes/[slug]/config.json
```

---

*Crown Media · marketing@crownmediagroup.com.co · Última actualización: Mayo 2026*
