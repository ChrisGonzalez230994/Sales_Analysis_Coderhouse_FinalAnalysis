SELECT 
    c.Nombre AS NombreCliente,
    c.Apellido AS ApellidoCliente,
    v.[Fecha compra] AS FechaCompra,
    (v.[Valor Unidad] * v.Cantidad) AS TotalVenta
FROM
    Ventas v
    INNER JOIN Clientes c ON v.ID_Cliente = c.Codigo
WHERE
    v.[Fecha compra] >= (
        SELECT DATEADD(DAY, -30, MAX([Fecha compra]))
        FROM Ventas
    )
ORDER BY
    v.[Fecha compra] DESC;