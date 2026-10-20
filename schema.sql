-- 1) TABLAS
create table menu_items(
  id serial primary key, category text not null, name text not null,
  description text default '', price int not null,
  popular boolean default false, available boolean default true);

create table orders(
  id uuid primary key default gen_random_uuid(),
  customer_name text, table_label text, note text,
  items jsonb not null, total int not null,
  status text not null default 'recibido',   -- recibido > preparando > listo > entregado
  created_at timestamptz default now());

create table reservations(
  id uuid primary key default gen_random_uuid(),
  name text not null, phone text, party int not null, when_at timestamptz not null,
  status text not null default 'pendiente',  -- pendiente > confirmada / cancelada
  created_at timestamptz default now());

-- 2) SEGURIDAD (RLS). Clientes = anon, personal = usuarios logueados.
alter table menu_items enable row level security;
alter table orders enable row level security;
alter table reservations enable row level security;

create policy "menu publico"      on menu_items   for select using (true);
create policy "staff menu"        on menu_items   for all to authenticated using (true) with check (true);
create policy "cliente crea pedido" on orders     for insert to anon with check (true);
create policy "cliente ve pedido (piloto)" on orders for select to anon using (true);
create policy "staff pedidos"     on orders       for all to authenticated using (true) with check (true);
create policy "cliente reserva"   on reservations for insert to anon with check (true);
create policy "staff reservas"    on reservations for all to authenticated using (true) with check (true);

-- 3) MENU DE EJEMPLO (precios leidos de las fotos: VERIFICAR)
insert into menu_items(category,name,description,price,popular) values
('Entradas y picoteos','Buñuelos de espinaca','',6500,false),
('Entradas y picoteos','Provoleta','',7000,true),
('Entradas y picoteos','Provoleta tricolor','Con salchicha parrillera, rúcula y cherrys confitados',9000,false),
('Entradas y picoteos','Empanada de carne','Cortada a cuchillo (c/u)',2000,false),
('Entradas y picoteos','Langostinos apanados','',9000,false),
('Entradas y picoteos','Rabas','',11000,false),
('Cocina','Milanesa napolitana','Con papas fritas',9900,true),
('Cocina','Risotto de hongos','',10800,false),
('Pastas','Lasagna','A la boloñesa, gratinada al horno de barro',10200,true),
('Pastas','Sorrentinos','De jamón y queso, salsa casera de tomates',9900,false),
('Pastas','Raviolón','De espinaca con queso azul y salsa de champiñones',10300,false),
('Pastas','Ñoquis caseros','Salsa pomodoro / rosa',8700,false),
('Para compartir','Milanesa Barro','Con cebolla caramelizada, queso cheddar y panceta (comen 3)',31000,false),
('Para compartir','Tabla Barro','Pechito de cerdo, tira de asado, provoleta, entraña, ensalada rusa, papas fritas y huevo',34900,true),
('Del horno de barro','Pastel de lomo','A la cerveza con batatas y miel',10400,false),
('Del horno de barro','Bondiola braseada','Con papas fritas',11200,true),
('Del horno de barro','Ribs de cerdo','Con batatas rústicas horneadas',15100,false),
('Parrilla','Asado de tira','Viene con fritas o mix de verdes',16500,true),
('Parrilla','Bife de chorizo','450 g',15500,false),
('Ensaladas','Ensalada César','Con pollo',9300,false),
('Ensaladas','Ensalada Barro','Mix de verdes, tomate, huevo duro, palta y almendras',9800,false),
('Postres','Flan de campo','Con dulce de leche',4600,true),
('Postres','Brownie con helado','',5300,false),
('Postres','Tiramisú','',5000,false),
('Cervezas','Stella Artois 975 cc','',12500,false),
('Cervezas','Corona 710 cc','',13500,false),
('Cervezas','Porrón Stella','',7000,false),
('Sin alcohol','Gaseosa lata','',4000,false),
('Sin alcohol','Limonada','',6000,false),
('Cafetería','Café pocillo','',3600,false),
('Cafetería','Cappuccino','',5000,false),
('Vinos','Alamos Malbec','Bodega Catena Zapata',14400,false),
('Vinos','Salentein Reserva Malbec','Bodega Salentein',21000,true),
('Vinos','Chandon Extra Brut','Espumante',36000,false),
('Vinos','Copa de vino','',6000,false);
