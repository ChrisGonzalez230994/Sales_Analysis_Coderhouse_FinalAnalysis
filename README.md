# 📊 Proyecto Final — Análisis de Datos con SQL y Power BI
### CoderHouse | Curso de Análisis de Datos

---

## 📋 Descripción

Proyecto final del curso de Análisis de Datos de CoderHouse. 
El objetivo fue aplicar el flujo completo de análisis de datos sobre 
una base de ventas real: desde la limpieza y preprocesamiento del 
dataset hasta la construcción de un dashboard interactivo en Power BI, 
pasando por el modelado relacional y la consulta SQL.

---

## 🗂️ Dataset

Dataset provisto por la plataforma en formato Excel con 4 hojas:

| Tabla | Descripción |
|---|---|
| Clientes | Información personal y comercial de cada cliente |
| Ventas | Transacciones con fechas, productos, montos y vendedores |
| Productos | Catálogo con descripción, tamaño, empaque y dimensiones |
| Vendedores | Datos del equipo de ventas y sus sucursales |

---

## 🛠️ Herramientas utilizadas

- **Excel** — Limpieza manual del dataset
- **SQL Server Management Studio (SSMS)** — Importación, 
  modelado y consultas
- **Power BI Desktop** — Visualización y dashboard interactivo

---

## 🔄 Flujo del proyecto

### 1. Limpieza y preprocesamiento
- Eliminación manual de filas de título y celdas vacías en Excel
- Importación del dataset a SQL Server via Task → Import Data
- Renombrado de tablas (eliminación del sufijo `$`)
- Verificación de nulos en columnas clave
- Creación de columna `Apellido` extrayendo el texto 
  después del `-` en la columna `Nombre completo`

### 2. Modelado relacional
- Identificación de claves primarias (PK) y foráneas (FK)
- Definición de relaciones entre tablas:
  - `Clientes` 1 → N `Ventas`
  - `Productos` 1 → N `Ventas`
  - `Vendedores` 1 → N `Ventas`
- Construcción del Diagrama Entidad-Relación (ER)

### 3. Consulta SQL
Consulta que extrae nombre, apellido, fecha de compra y total 
de venta de los últimos 30 días desde la última transacción 
del dataset:

```sql
SELECT 
    c.Nombre    AS NombreCliente,
    c.Apellido  AS ApellidoCliente,
    v.[Fecha compra]                AS FechaCompra,
    (v.[Valor Unidad] * v.Cantidad) AS TotalVenta
FROM
    Ventas v
    INNER JOIN Clientes c ON v.[ID_Cliente ] = c.Codigo
WHERE
    v.[Fecha compra] >= (
        SELECT DATEADD(DAY, -30, MAX([Fecha compra]))
        FROM Ventas
    )
ORDER BY
    v.[Fecha compra] DESC;
```

### 4. Dashboard en Power BI
- Conexión directa a SQL Server
- Medidas DAX creadas:
  - `TotalVenta = SUMX(Ventas, Ventas[Valor Unidad] * Ventas[Cantidad ])`
  - `CantidadVentas = COUNTROWS(Ventas)`
  - `TicketPromedio = DIVIDE([TotalVenta], [CantidadVentas])`
  - `Ganancia = SUMX(Ventas, (Ventas[Valor Unidad] * Ventas[Cantidad ]) - Ventas[Costos Directos] - Ventas[Costos Indirectos])`
- Visualizaciones:
  - 📈 Gráfico de líneas — Evolución mensual de ventas
  - 📊 Barras horizontales — Top 10 productos más vendidos
  - 🥧 Torta — Distribución de ventas por zona
  - 🔢 Tarjetas KPI — Total ventas y cantidad de transacciones
  - 🔍 Slicer — Filtro interactivo por Mes/Año

---

## 💡 Principales insights

- Diciembre registró el pico máximo de ventas ($0,36 mil M), 
  casi el doble que noviembre, evidenciando estacionalidad 
  de fin de año
- La zona **Sur** concentra el 36% del total de ventas
- **Termómetro** y **Olla** lideran el Top 10 de productos 
  con $57 mill. cada uno
- El dataset abarca **89,89 mil transacciones** con un total 
  de **$1.462 mil millones** en ventas

---

## 📁 Estructura del repositorio



---

## 👤 Autor

**Christian**
Curso de Análisis de Datos — CoderHouse

---

## 🏷️ Tags

`SQL` `Power BI` `DAX` `Análisis de Datos` `ETL` 
`Modelado Relacional` `Diagrama ER` `CoderHouse` 
`SQL Server` `Excel` `Storytelling`
