-- overzicht_facturen.sql
-- Dit SQL-bestand geeft een overzicht van alle facturen uit Oracle ERP Cloud.
-- Pas de tabelnamen en kolomnamen aan indien nodig voor jouw specifieke Oracle Cloud omgeving.

-- BI Publisher Data Model: Overzicht van alle facturen
SELECT
    inv.INVOICE_ID            AS factuur_id,
    inv.INVOICE_NUM           AS factuurnummer,
    inv.ORG_ID                AS business_unit_id, -- Toegevoegd voor context
    inv.INVOICE_DATE          AS factuurdatum,
    sup.SUPPLIER_NAME        AS leverancier,
    inv.INVOICE_AMOUNT        AS bedrag,
    inv.INVOICE_CURRENCY_CODE AS valuta,
    inv.APPROVAL_STATUS       AS goedkeuringsstatus,
    inv.PAYMENT_STATUS_FLAG   AS betaalstatus,
    inv.CREATION_DATE         AS aanmaakdatum,
    inv.LAST_UPDATE_DATE      AS laatste_wijziging
FROM
    AP_INVOICES_ALL inv
    JOIN AP_SUPPLIERS_ALL sup ON inv.VENDOR_ID = sup.VENDOR_ID
ORDER BY
    inv.INVOICE_DATE DESC