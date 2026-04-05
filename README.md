# nilesoft-shell-file-manage
Nilesoft Shell — Opciones de administración de archivos con funciones avanzadas de renombrado masivo por lotes. // File management options with advanced bulk renaming features.

# file-manage.nss — Qué hace lo añadido / What the extras do

## ESPAÑOL

Extras en el menú **Administrar archivos** de Nilesoft Shell:

**Si seleccionas un acceso directo (.lnk), en “Copiar ruta”**

- **Carpeta del destino (explorador):** abre en una nueva ventana del Explorador la carpeta donde está el archivo al que apunta el .lnk.

**Menú “Renombrar”** (sirve con varios archivos o carpetas seleccionadas.)

- **Limpiar nombre:** deja el nombre más “normal”: quita espacios de más y caracteres que Windows no admite en nombres.
- **Reemplazar espacios por "_":** los espacios del nombre pasan a guiones bajos.
- **Camel Case:** palabras con mayúscula inicial (estilo "Mi Carpeta").
- **snake_case:** todo en minúsculas y espacios en guión bajo.
- **kebab-case:** todo en minúsculas y espacios en guión.
- **minúsculas / MAYÚSCULAS:** cambia solo las letras grandes o pequeñas del nombre completo.
- **Limpiar acentos y diacríticos:** quita acentos y **diacríticos** del nombre (tildes, umlauts, cedillas como marca combinada, etc.) usando normalización Unicode; también pasa **ß** a **ss**. No cambia letras que en Unicode van "de un solo bloque" (por ejemplo: ciertas **ø**, **ł**).
- **Numerar → Prefijo automático:** ordena por nombre y pone delante 0001-, 0002-, etc. (a los que ya tienen número al inicio no les cambia el prefijo).
- **Numerar → Quitar numeración:** quita un prefijo tipo “12- ” del principio del nombre.

**Nueva carpeta** (en el fondo de una carpeta)

- Podes crear carpeta con nombre de **solo fecha**, **fecha y hora** o un **GUID**. Si ese nombre ya existe, añade “ (01)”, “ (02)”, etc.

**Nuevo archivo**

- Hay más tipos de archivo listos para crear (por ejemplo CSV, YAML, CMD, PowerShell, TypeScript, Vue, INI, REG y un ejemplo de `.env`).

---

## ENGLISH

Extras in the Nilesoft Shell **Administrar archivos** (Manage files) menu:

**When a shortcut (.lnk) is selected, under Copy path**

- **Open target in new window:** opens File Explorer in the folder that contains the link target.

**“Rename” submenu** (works with multiple files or folders selected)

- **Clean up name:** cleans the name (extra spaces, characters Windows doesn’t allow in file names).
- **Replace spaces with "_":** turns spaces into underscores.
- **Camel Case:** Title Case style words.
- **snake_case:** lowercase with underscores instead of spaces.
- **kebab-case:** lowercase with hyphens instead of spaces.
- **lowercase / UPPERCASE:** lowercases or uppercases the whole name.
- **Strip accents and diacritics:** strips accents and **combining diacritics** from the name (e.g. acute/grave, umlauts, cedillas when decomposed), using Unicode normalization; **ß** becomes **ss**. Letters that stay a single code point (e.g. some **ø**, **ł**) may be unchanged.
- **Numbering → Auto prefix:** sorts by name and adds prefixes like 0001-, 0002- (skips names that already start with a number prefix).
- **Numbering → Remove numbering:** removes a leading “12- ” style prefix from the name.

**New folder** (folder background)

- Create a folder named with **date only**, **date and time**, or a **GUID**. If the name exists, it appends “ (01)”, “ (02)”, etc.

**New file**

- More starter file types (e.g. CSV, YAML, CMD, PowerShell, TypeScript, Vue, INI, REG, and a sample `.env.example`).
