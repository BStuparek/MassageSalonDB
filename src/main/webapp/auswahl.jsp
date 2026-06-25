<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <title>Massagesalon - Typ auswählen</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; margin-top: 20px; }

        /* Toggle-Button Styling für die Auswahl */
        .toggle-card { position: relative; }
        .toggle-card input[type="radio"] { position: absolute; opacity: 0; width: 0; height: 0; }
        .card-label { display: block; padding: 20px; background: white; border: 2px solid #ddd; border-radius: 8px; cursor: pointer; transition: all 0.2s ease; }
        .card-label:hover { border-color: #aaa; background: #f0f0f0; }

        /* Optisches Feedback, wenn ausgewählt */
        .toggle-card input[type="radio"]:checked + .card-label {
            border-color: #2b7a78;
            background: #def2f1;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .price { font-weight: bold; color: #2b7a78; margin-top: 10px; }
        .btn-next { margin-top: 30px; padding: 12px 25px; background: #2b7a78; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-next:hover { background: #17252a; }
    </style>
</head>
<body>

<h1>Schritt 1: Wählen Sie einen verfügbaren Massagetyp</h1>

<sql:setDataSource dataSource="jdbc/MassagesalonDB" />

<sql:query var="typen" sql="SELECT DISTINCT t.MTypID, t.Beschreibung, t.Dauer, t.Kosten FROM Massagetyp t INNER JOIN Massage m ON t.MTypID = m.MTypID" />

<form method="POST" action="zeitraum.jsp">
    <div class="grid">
        <c:forEach var="t" items="${typen.rows}">
            <div class="toggle-card">
                <input type="radio" name="mTypID" id="m\_${t.MTypID}" value="${t.MTypID}" required>
                <label for="m\_${t.MTypID}" class="card-label">
                    <h3>${t.Beschreibung}</h3>
                    <p>Dauer: ${t.Dauer} Min.</p>
                    <div class="price">${t.Kosten} €</div>
                </label>
            </div>
        </c:forEach>
    </div>

    <button type="submit" class="btn-next">Auswahl an Server senden & Weiter ➔</button>
</form>

</body>
</html>