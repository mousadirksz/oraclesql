-- debug_facturen.sql
-- Debugbestand voor het achterhalen van beschikbare tabellen/views en kolommen in Oracle ERP Cloud BI Publisher

-- 1. Toon alle beschikbare tabellen/views met 'INVOICE' in de naam
SELECT table_name
FROM all_tables
WHERE table_name LIKE '%INVOICE%';

-- 2. Toon alle beschikbare views met 'SUPPLIER' in de naam
SELECT view_name
FROM all_views
WHERE view_name LIKE '%SUPPLIER%';

-- 3. Toon kolommen van een mogelijke facturen-view (pas de viewnaam aan indien nodig)
SELECT column_name
FROM all_tab_columns
WHERE table_name = 'AP_INVOICES_V';

-- 4. Toon kolommen van een mogelijke leveranciers-view (pas de viewnaam aan indien nodig)
SELECT column_name
FROM all_tab_columns
WHERE table_name = 'AP_SUPPLIERS_V';

-- 5. Test een simpele select op een gevonden view (pas de viewnaam aan indien nodig)
SELECT * FROM AP_INVOICES_V WHERE ROWNUM < 10;
SELECT * FROM AP_SUPPLIERS_V WHERE ROWNUM < 10;

-- Gebruik deze queries in BI Publisher Data Model (SQL View) om te achterhalen welke views en kolommen beschikbaar zijn in jouw omgeving.

-- Extra: geautomatiseerde checks en fout-rapportage (PL/SQL)
SET SERVEROUTPUT ON;
DECLARE
	v_count NUMBER;
BEGIN
	-- Controleer welke van de gangbare views aanwezig zijn
	BEGIN
		SELECT COUNT(*) INTO v_count FROM ALL_VIEWS WHERE VIEW_NAME = 'AP_INVOICES_V';
		DBMS_OUTPUT.PUT_LINE('AP_INVOICES_V present: ' || v_count);
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Fout bij check AP_INVOICES_V: ' || SQLERRM);
	END;

	BEGIN
		SELECT COUNT(*) INTO v_count FROM ALL_VIEWS WHERE VIEW_NAME = 'AP_INVOICES_ALL_V';
		DBMS_OUTPUT.PUT_LINE('AP_INVOICES_ALL_V present: ' || v_count);
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Fout bij check AP_INVOICES_ALL_V: ' || SQLERRM);
	END;

	BEGIN
		SELECT COUNT(*) INTO v_count FROM ALL_VIEWS WHERE VIEW_NAME = 'AP_SUPPLIERS_V';
		DBMS_OUTPUT.PUT_LINE('AP_SUPPLIERS_V present: ' || v_count);
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Fout bij check AP_SUPPLIERS_V: ' || SQLERRM);
	END;

	-- Probeer kort te selecteren uit elke view om ORA-00942 te reproduceren en rapporteren
	BEGIN
		FOR r IN (SELECT * FROM AP_INVOICES_V WHERE ROWNUM = 1) LOOP
			DBMS_OUTPUT.PUT_LINE('AP_INVOICES_V: sample row gevonden');
			EXIT;
		END LOOP;
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Cannot select from AP_INVOICES_V: ' || SQLERRM);
	END;

	BEGIN
		FOR r IN (SELECT * FROM AP_INVOICES_ALL_V WHERE ROWNUM = 1) LOOP
			DBMS_OUTPUT.PUT_LINE('AP_INVOICES_ALL_V: sample row gevonden');
			EXIT;
		END LOOP;
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Cannot select from AP_INVOICES_ALL_V: ' || SQLERRM);
	END;

	BEGIN
		FOR r IN (SELECT * FROM AP_SUPPLIERS_V WHERE ROWNUM = 1) LOOP
			DBMS_OUTPUT.PUT_LINE('AP_SUPPLIERS_V: sample row gevonden');
			EXIT;
		END LOOP;
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Cannot select from AP_SUPPLIERS_V: ' || SQLERRM);
	END;

END;
/;
