#!/bin/bash

# ══════════════════════════════════════════════════════════════════════
# Crown Media · Scaffold de nuevo cliente
# Crea la estructura base en clientes/{slug}/ lista para trabajar
# ══════════════════════════════════════════════════════════════════════

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/_templates"
CLIENTES_DIR="$SCRIPT_DIR/clientes"
TODAY=$(date +%Y-%m-%d)

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Crown Media · Nuevo Cliente            ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── Recopilar datos básicos ─────────────────────────────────────────
read -p "  Nombre del cliente (ej: Marca XYZ):          " CLIENT_NAME
read -p "  Slug de carpeta (ej: marca-xyz, sin espacios): " CLIENT_SLUG
read -p "  País (Colombia/Canada/USA/Mexico/otro):       " CLIENT_COUNTRY
read -p "  Moneda (COP/CAD/USD/MXN):                    " CLIENT_CURRENCY

# Validar slug
if [[ ! "$CLIENT_SLUG" =~ ^[a-z0-9-]+$ ]]; then
  echo ""
  echo "  ❌ El slug solo puede tener letras minúsculas, números y guiones."
  exit 1
fi

CLIENT_DIR="$CLIENTES_DIR/$CLIENT_SLUG"

# Verificar que no exista
if [ -d "$CLIENT_DIR" ]; then
  echo ""
  echo "  ❌ La carpeta '$CLIENT_SLUG' ya existe en clientes/."
  exit 1
fi

echo ""
echo "  Creando estructura para: $CLIENT_NAME ($CLIENT_SLUG)..."
echo ""

# ── Crear carpetas ──────────────────────────────────────────────────
mkdir -p "$CLIENT_DIR/brand"
mkdir -p "$CLIENT_DIR/html"
mkdir -p "$CLIENT_DIR/data"
mkdir -p "$CLIENT_DIR/.claude"

# ── brand.json desde template ───────────────────────────────────────
sed \
  -e "s/<Nombre Comercial del Cliente>/$CLIENT_NAME/g" \
  -e "s/<Colombia|Canada|USA|Mexico|...>/$CLIENT_COUNTRY/g" \
  -e "s/<COP|CAD|USD|MXN>/$CLIENT_CURRENCY/g" \
  -e "s/<COP_compact|CAD|USD>/${CLIENT_CURRENCY}_compact/g" \
  -e "s/<YYYY-MM-DD>/$TODAY/g" \
  "$TEMPLATES_DIR/brand.json" > "$CLIENT_DIR/brand/brand.json"

# ── CLAUDE.md desde template ────────────────────────────────────────
sed \
  -e "s/\[NOMBRE DEL CLIENTE\]/$CLIENT_NAME/g" \
  -e "s/\[Nombre Comercial\]/$CLIENT_NAME/g" \
  -e "s/\[País\], \[Ciudad\]/$CLIENT_COUNTRY, [Ciudad]/g" \
  -e "s/\[YYYY-MM-DD\]/$TODAY/g" \
  "$TEMPLATES_DIR/CLAUDE.md" > "$CLIENT_DIR/CLAUDE.md"

# ── settings.local.json para Claude Code ────────────────────────────
cat > "$CLIENT_DIR/.claude/settings.local.json" << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash(open *)",
      "Bash(node *)",
      "Bash(ls *)",
      "Bash(find *)",
      "Bash(git status)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(git log *)"
    ]
  }
}
EOF

# ── .gitkeep para trackear carpeta data/ vacía ──────────────────────
touch "$CLIENT_DIR/data/.gitkeep"
touch "$CLIENT_DIR/html/.gitkeep"

# ── Resultado ───────────────────────────────────────────────────────
echo "  ✅ Estructura creada exitosamente:"
echo ""
echo "  clientes/$CLIENT_SLUG/"
echo "  ├── CLAUDE.md            ← Rellena con contexto del cliente"
echo "  ├── brand/"
echo "  │   └── brand.json       ← Rellena con IDs reales de plataformas"
echo "  ├── html/                ← Aquí van los reportes HTML"
echo "  └── data/                ← JSONs de datos (opcional)"
echo ""
echo "  📝 Próximos pasos:"
echo "     1. Edita: clientes/$CLIENT_SLUG/brand/brand.json"
echo "        → Agrega: meta_ads_id, google_ads_id, ga4_property, shopify_id"
echo ""
echo "     2. Edita: clientes/$CLIENT_SLUG/CLAUDE.md"
echo "        → Agrega: contexto del negocio, campañas, particularidades"
echo ""
echo "     3. Abre Claude Code en la carpeta del cliente:"
echo "        cd clientes/$CLIENT_SLUG && claude"
echo ""
echo "     4. Haz commit del nuevo cliente:"
echo "        git add clientes/$CLIENT_SLUG && git commit -m 'feat: nuevo cliente $CLIENT_SLUG'"
echo ""
