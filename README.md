# Barro · App piloto de pedidos y reservas (Supabase + GitHub Pages)

Dos páginas que comparten la misma base de datos:
- `index.html` → **clientes**: ven el menú, piden, siguen el estado y piden reserva.
- `staff.html` → **empleados/dueño**: login, pedidos en vivo, reservas, menú (agotado/disponible) e ingresos del día.

> Los precios del menú se leyeron de fotos: **verificalos** y corregilos en `schema.sql` o en Supabase > Table Editor > `menu_items`.

## PARTE 1 · Supabase (la base de datos)
1. Entrá a https://supabase.com, creá cuenta y **New project** (nombre `barro-piloto`, contraseña de base de datos, región más cercana, ej. São Paulo).
2. Menú izquierdo **SQL Editor** > **New query** > pegá todo `schema.sql` > **Run**. Crea las tablas, las reglas de seguridad (RLS) y carga el menú. Revisá en **Table Editor** que aparezca `menu_items` con filas.
3. **Authentication > Users > Add user > Create new user**: email y contraseña del dueño (tildá *Auto Confirm User*). Repetí por cada empleado.
4. **Authentication > Sign In / Providers** (o Settings): **desactivá "Allow new users to sign up"**. Importante: cualquier usuario logueado es personal, así nadie más puede crearse una cuenta.
5. **Project Settings > API**: copiá **Project URL** y la clave **anon public**. Nunca uses la `service_role` en estos archivos.

## PARTE 2 · Conectar los archivos
Abrí `config.js` y reemplazá `url` y `key` por los de tu proyecto.

## PARTE 3 · GitHub
1. En https://github.com creá un repositorio **público** nuevo (`barro-piloto`).
2. Opción fácil: **Add file > Upload files** y subí `index.html`, `staff.html`, `config.js`, `schema.sql`, `README.md`. Commit.
3. Opción terminal: `git init && git add . && git commit -m "Piloto Barro" && git branch -M main && git remote add origin https://github.com/TU-USUARIO/barro-piloto.git && git push -u origin main`

## PARTE 4 · Publicar y obtener los 2 links
**Settings > Pages > Source: Deploy from a branch > main / (root) > Save**. A los 1–2 minutos quedan:
- Clientes: `https://TU-USUARIO.github.io/barro-piloto/`
- Empleados/dueño: `https://TU-USUARIO.github.io/barro-piloto/staff.html`

Para las mesas, generá un QR (ej. qr-code-generator.com) con el link de clientes.

## PARTE 5 · Checklist de pruebas funcionales
1. Cliente: abrir link, elegir categoría, agregar ítems, enviar pedido con nombre y mesa.
2. Staff: iniciar sesión, ver el pedido (se actualiza cada 5 s), pasar a *preparando > listo > entregado*.
3. Cliente: ver que el estado cambia solo.
4. Cliente: pedir una reserva. Staff: confirmarla o cancelarla.
5. Staff > Menú: marcar un plato **Agotado**; recargar el link de clientes y comprobar que desaparece.
6. Probar desde un Android y un iPhone.

## Limitaciones del piloto (no usar en producción tal cual)
- Los clientes pueden leer todos los pedidos (necesario para seguir el estado sin login). Para producción: login anónimo de Supabase o función RPC por ID de pedido.
- Sin pagos, sin avisos por WhatsApp/email, sin impresión de comandas.
- Cualquier usuario logueado tiene permisos totales de personal.
