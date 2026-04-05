menu(where=sel.count>0 type='file|dir|drive|namespace|back' mode="multiple" title='Administrar archivos' image=\uE253)
{
	menu(separator="after" title='Copiar ruta' image=icon.copy_path)
	{
		item(where=sel.count > 1 title='Copiar (@sel.count) elementos' cmd=command.copy(sel(false, "\n")))
		item(mode="single" title=@sel.path tip=sel.path cmd=command.copy(sel.path))
		item(mode="single" type='file' find='.lnk' title='Abrir destino en una nueva ventana' cmd-ps=`-NoProfile -Command $d = '@sel.lnk.dir'; if ($d) { try { Start-Process explorer.exe -ArgumentList $d } catch { } }`)
	}

	item(mode="single" type="file" title="Cambiar extensión" image=\uE0B5
		cmd=if(input("Cambiar extensión", "Nueva extensión"),
		io.rename(sel.path, path.join(sel.dir, sel.file.title + "." + input.result))))

	menu(separator="after" image=\uE290 title='Seleccionar')
	{
		item(title="Todo" image=icon.select_all cmd=command.select_all)
		item(title="Invertir" image=icon.invert_selection cmd=command.invert_selection)
		item(title="Ninguno" image=icon.select_none cmd=command.select_none)
	}

	menu(title='Renombrar' type='file|dir' where=sel.count>0 image=image.mdl(\uE0B5))
	{
		item(title='Limpiar nombre' image=\uE0CE
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = $f.Name.Trim(); $n = $n -replace '\s+', ' '; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; if ($f.Name -ceq $n) { continue }; try { Rename-Item -LiteralPath $f.FullName -NewName $n } catch { } }`)

		separator

		item(title='Reemplazar espacios por "_"'
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = if ($f.PSIsContainer) { $f.Name } else { $f.BaseName }; $n = $n -replace ' ', '_'; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $nn = if ($f.PSIsContainer) { $n } else { $n + $f.Extension }; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { } }`)

		item(title='Camel Case'
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = if ($f.PSIsContainer) { $f.Name } else { $f.BaseName }; $n = $n -replace '-', ' '; $n = $n -replace '_', ' '; $parts = $n -split ' ' | Where-Object { $_ }; $r = $parts | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() }; $n = $r -join ' '; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $nn = if ($f.PSIsContainer) { $n } else { $n + $f.Extension }; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { } }`)

		item(title='snake_case'
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = if ($f.PSIsContainer) { $f.Name } else { $f.BaseName }; $n = $n.ToLower() -replace '\s+', '_'; $n = $n -replace '-', '_'; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $nn = if ($f.PSIsContainer) { $n } else { $n + $f.Extension }; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { } }`)

		item(title='kebab-case'
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = if ($f.PSIsContainer) { $f.Name } else { $f.BaseName }; $n = $n.ToLower() -replace '\s+', '-'; $n = $n -replace '_', '-'; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $nn = if ($f.PSIsContainer) { $n } else { $n + $f.Extension }; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { } }`)

		separator

		item(title='minúsculas' image=image.mdl(\uE84A)
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = $f.Name.Trim().ToLowerInvariant(); $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $final = $n; if ($f.Name -ceq $final) { continue }; $orig = $f.Name; $src = $f.FullName; $dir = Split-Path $f.FullName -Parent; if (-not $dir) { continue }; $origFull = Join-Path $dir $orig; $destFull = Join-Path $dir $final; if ($f.Name -eq $final -and $f.Name -cne $final) { $tmp = '__ns_' + (New-Guid).ToString().Replace('-','') + $f.Extension; $mid = Join-Path $dir $tmp; try { Rename-Item -LiteralPath $src -NewName $tmp -ErrorAction Stop; Start-Sleep -Milliseconds 200; Move-Item -LiteralPath $mid -Destination $destFull -Force -ErrorAction Stop } catch { if (Test-Path -LiteralPath $mid) { try { Move-Item -LiteralPath $mid -Destination $origFull -Force } catch { } } } } else { try { Rename-Item -LiteralPath $src -NewName $final } catch { } } }`)

		item(title='MAYÚSCULAS' image=image.mdl(\uE84B)
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = $f.Name.Trim().ToUpperInvariant(); $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $final = $n; if ($f.Name -ceq $final) { continue }; $orig = $f.Name; $src = $f.FullName; $dir = Split-Path $f.FullName -Parent; if (-not $dir) { continue }; $origFull = Join-Path $dir $orig; $destFull = Join-Path $dir $final; if ($f.Name -eq $final -and $f.Name -cne $final) { $tmp = '__ns_' + (New-Guid).ToString().Replace('-','') + $f.Extension; $mid = Join-Path $dir $tmp; try { Rename-Item -LiteralPath $src -NewName $tmp -ErrorAction Stop; Start-Sleep -Milliseconds 200; Move-Item -LiteralPath $mid -Destination $destFull -Force -ErrorAction Stop } catch { if (Test-Path -LiteralPath $mid) { try { Move-Item -LiteralPath $mid -Destination $origFull -Force } catch { } } } } else { try { Rename-Item -LiteralPath $src -NewName $final } catch { } } }`)

		item(title='Limpiar acentos y diacríticos' image=image.mdl(\uE8C1)
			cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (-not (Test-Path -LiteralPath $p)) { continue }; $f = Get-Item -LiteralPath $p; $n = if ($f.PSIsContainer) { $f.Name } else { $f.BaseName }; $raw = $n; $n = ($raw.Normalize(2) -replace '\p{Mn}','').Normalize(1); $n = $n -creplace 'ß','ss' -creplace 'ẞ','SS'; $n = $n -creplace '\\','_' -creplace '/','_' -creplace '<','_' -creplace '>','_' -creplace ':','_' -creplace '\u0022','_' -creplace '\|','_' -creplace '\?','_' -creplace '\*','_'; while ($n.Length -gt 0 -and ($n.EndsWith(' ') -or $n.EndsWith('.'))) { $n = $n.Substring(0, $n.Length - 1) }; if ($n.Length -lt 1) { $n = '_' }; $nn = if ($f.PSIsContainer) { $n } else { $n + $f.Extension }; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { } }`)

		separator

		menu(title='Numerar')
		{
			item(title='Prefijo automático (0001-)' image=image.mdl(\uF146)
				cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); $items = New-Object System.Collections.ArrayList; foreach ($pp in $paths) { $p = $pp.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (Test-Path -LiteralPath $p) { $null = $items.Add((Get-Item -LiteralPath $p)) } }; $items = $items | Sort-Object Name; $cnt = ($items | Measure-Object).Count; if ($cnt -lt 1) { exit }; $pad = $cnt.ToString().Length; if ($pad -lt 2) { $pad = 2 }; $i = 1; foreach ($f in $items) { if ($f.Name -notmatch '^\d+-\s') { $prefix = $i.ToString().PadLeft($pad, '0') + '- '; $nn = $prefix + $f.Name; try { Rename-Item -LiteralPath $f.FullName -NewName $nn } catch { }; $i = $i + 1 } }`)

			item(title='Quitar numeración' image=image.mdl(\uE894)
				cmd-ps=`-NoProfile -Command $paths = '@(sel(false, "|"))'.Split('|'); foreach ($p in $paths) { $p = $p.Trim().Trim('"'); if (-not $p) { continue }; if (-not (Test-Path -LiteralPath $p)) { $ppar = Split-Path $p -Parent; $pn = ($p -replace '\s+', ' '); if ($ppar -and (Test-Path -LiteralPath $ppar)) { $pf = Get-ChildItem -LiteralPath $ppar -Force -ErrorAction SilentlyContinue | Where-Object { ($_.FullName -replace '\s+', ' ') -eq $pn } | Select-Object -First 1; if ($pf) { $p = $pf.FullName } } }; if (Test-Path -LiteralPath $p) { $f = Get-Item -LiteralPath $p; $new = $f.Name -replace '^\d+-\s', ''; if ($new -ne $f.Name) { try { Rename-Item -LiteralPath $f.FullName -NewName $new } catch { } } } }`)
		}
	}

	item(type='file|dir|back.dir|drive' title='Tomar control' image=[\uE194,#f00] admin
		cmd='cmd.exe' args='/K takeown /f "@sel.path" @if(sel.type==1,null,"/r /d y") && icacls "@sel.path" /grant *S-1-5-32-544:F @if(sel.type==1,"/c /l","/t /c /l /q")')

	separator

	menu(title="Mostrar / Ocultar" image=icon.show_hidden_files)
	{
		item(title="Archivos ocultos" image=inherit cmd='@command.togglehidden')
		item(title="Extensiones de archivo" image=icon.show_file_extensions cmd='@command.toggleext')
	}

	menu(mode="single" type='back' expanded=true)
	{
		menu(separator="before" title='Nueva carpeta' image=icon.new_folder)
		{
			item(title='Fecha' cmd-ps=`-NoProfile -Command $parent = '@sel.dir'; $base = Get-Date -Format 'yyyy-MM-dd'; $candidate = $base; $i = -1; while (Test-Path -LiteralPath (Join-Path $parent $candidate)) { $i = $i + 1; if ($i -gt 10000) { exit }; $num = ''; if ($i -lt 100) { $num = $i.ToString().PadLeft(2, '0') } else { $num = $i.ToString() }; $candidate = $base + ' (' + $num + ')' }; New-Item -ItemType Directory -Path (Join-Path $parent $candidate) | Out-Null`)
			item(title='Fecha y hora' cmd-ps=`-NoProfile -Command $parent = '@sel.dir'; $base = Get-Date -Format 'yyyy-MM-dd HH.mm'; $candidate = $base; $i = -1; while (Test-Path -LiteralPath (Join-Path $parent $candidate)) { $i = $i + 1; if ($i -gt 10000) { exit }; $num = ''; if ($i -lt 100) { $num = $i.ToString().PadLeft(2, '0') } else { $num = $i.ToString() }; $candidate = $base + ' (' + $num + ')' }; New-Item -ItemType Directory -Path (Join-Path $parent $candidate) | Out-Null`)
			item(title='GUID' cmd-ps=`-NoProfile -Command $parent = '@sel.dir'; $base = (New-Guid).ToString(); $candidate = $base; $i = -1; while (Test-Path -LiteralPath (Join-Path $parent $candidate)) { $i = $i + 1; if ($i -gt 10000) { exit }; $num = ''; if ($i -lt 100) { $num = $i.ToString().PadLeft(2, '0') } else { $num = $i.ToString() }; $candidate = $base + ' (' + $num + ')' }; New-Item -ItemType Directory -Path (Join-Path $parent $candidate) | Out-Null`)
		}

		menu(title='Nuevo archivo' image=icon.new_file)
		{
			$fdh = sys.datetime("Y") + "-" + sys.datetime("m") + "-" + sys.datetime("d") + " " + sys.datetime("H") + "." + sys.datetime("M") + "." + sys.datetime("S")

			menu(title='General')
			{
				item(title='TXT' cmd=io.file.create('@(fdh).txt', "Hello World!\n"))
				item(title='MD' cmd=io.file.create('@(fdh).md', "# Título\n\nContenido\n"))
				item(title='CSV' cmd=io.file.create('@(fdh).csv', "columna1,columna2,columna3\n"))
			}

			menu(title='Web')
			{
				item(title='HTML' cmd=io.file.create('@(fdh).html', "<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n\t<meta charset=\"utf-8\">\n\t<title></title>\n</head>\n<body>\n\n</body>\n</html>\n"))
				item(title='CSS' cmd=io.file.create('@(fdh).css', "/* Estilos */\n\n"))
				item(title='JS' cmd=io.file.create('@(fdh).js', "// Script\n\n'use strict';\n\n"))
			}

			menu(title='Datos')
			{
				item(title='JSON' cmd=io.file.create('@(fdh).json', "{\n\n}\n"))
				item(title='XML' cmd=io.file.create('@(fdh).xml', "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<root>\n</root>\n"))
				item(title='YAML' cmd=io.file.create('@(fdh).yaml', "# YAML\n\n---\n\n"))
			}

			menu(title='Scripts')
			{
				item(title='BAT' cmd=io.file.create('@(fdh).bat', "@echo off\nsetlocal EnableDelayedExpansion\n"))
				item(title='CMD' cmd=io.file.create('@(fdh).cmd', "@echo off\nsetlocal EnableDelayedExpansion\n"))
				item(title='PS1' cmd=io.file.create('@(fdh).ps1', "# PowerShell\n\n"))
			}

			menu(title='Código')
			{
				item(title='TypeScript' cmd=io.file.create('@(fdh).ts', "// TypeScript\n\n"))
				item(title='TSX' cmd=io.file.create('@(fdh).tsx', "import React from 'react';\n\nexport function Component() {\n  return null;\n}\n"))
				item(title='Vue (SFC)' cmd=io.file.create('@(fdh).vue', "<template>\n  <div></div>\n</template>\n\n<script setup lang='ts'>\n</script>\n\n<style scoped>\n</style>\n"))
			}

			menu(title='Sistema')
			{
				item(title='INI' cmd=io.file.create('@(fdh).ini', "[seccion]\nclave=valor\n"))
				item(title='REG' cmd=io.file.create('@(fdh).reg', "Windows Registry Editor Version 5.00\n\n"))
			}

			menu(title='Config')
			{
				item(title='.env.example' cmd=io.file.create('@(fdh).env.example', "# Variables de entorno (copiar a .env y completar)\n#\n# EJEMPLO=valor\n"))
			}
		}
	}

	item(where=!wnd.is_desktop title='Opciones de carpeta' image=icon.folder_options cmd=command.folder_options)
}
