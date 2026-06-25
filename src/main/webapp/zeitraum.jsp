<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <title>Massagesalon - Zeit & Raum auswählen (Seite 2)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; color: #333; }
        h1, h3 { color: #2b7a78; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 15px; margin-top: 20px; }

        /* Toggle-Button Styling */
        .toggle-card { position: relative; }
        .toggle-card input[type="radio"] { position: absolute; opacity: 0; width: 0; height: 0; }
        .card-label { display: block; padding: 15px; background: white; border: 2px solid #ddd; border-radius: 6px; cursor: pointer; transition: all 0.2s ease; }
        .card-label:hover { border-color: #aaa; background: #f0f0f0; }
        .toggle-card input[type="radio"]:checked + .card-label { border-color: #2b7a78; background: #def2f1; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }

        .date-picker { margin: 10px 0 20px 0; padding: 10px; font-size: 16px; border: 2px solid #ddd; border-radius: 5px; width: 100%; max-width: 300px; }
        .btn-next { margin-top: 30px; padding: 12px 25px; background: #2b7a78; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-next:hover { background: #17252a; }
        .info-box { background: #e9ecef; padding: 15px; border-radius: 5px; margin-bottom: 20px; display: inline-block; border-left: 5px solid #2b7a78; }
    </style>
</head>
<body>

<c:if test="${not empty param.mTypID}">
    <c:set var="sessionMTypID" value="${param.mTypID}" scope="session" />
</c:if>

<h1>Schritt 2: Wann möchten Sie Ihren Termin?</h1>

<div class="info-box">
    Ausgewählter Massagetyp (gespeichert in der Session): <b>${sessionScope.sessionMTypID}</b>
</div>

<sql:setDataSource dataSource="jdbc/MassagesalonDB" />

<sql:query var="termine" sql="SELECT m.Tageszeit, m.Raumcodierung, o.Raumbeschreibung FROM Massage m JOIN Ort o ON m.Raumcodierung = o.Raumcodierung WHERE m.MTypID = ? ORDER BY m.Tageszeit">
    <sql:param value="${sessionScope.sessionMTypID}" />
</sql:query>

<form method="POST" action="masseur.jsp">

    <h3>Wunschdatum festlegen:</h3>
    <input type="date" name="datum" class="date-picker" required>

    <!-- Diese zwei Felder tragen die echten, getrennten Werte -->
    <input type="hidden" name="zeit" id="hiddenZeit">
    <input type="hidden" name="raum" id="hiddenRaum">

    <h3>Verfügbare Uhrzeiten:</h3>
    <c:choose>
        <c:when test="${termine.rowCount == 0}">
            <p style="color: red;">Für diesen Massagetyp sind aktuell keine freien Termine hinterlegt.</p>
        </c:when>
        <c:otherwise>
            <div class="grid">
                <c:forEach var="term" items="${termine.rows}">
                    <div class="toggle-card">
                        <input type="radio" name="terminAuswahl"
                               id="t_${term.Tageszeit}_${term.Raumcodierung}"
                               data-zeit="${term.Tageszeit}"
                               data-raum="${term.Raumcodierung}"
                               onclick="document.getElementById('hiddenZeit').value=this.dataset.zeit; document.getElementById('hiddenRaum').value=this.dataset.raum;"
                               required>
                        <label for="t_${term.Tageszeit}_${term.Raumcodierung}" class="card-label">
                            <h3 style="margin-top:0;">${term.Tageszeit} Uhr</h3>
                            <span style="color: #666; font-size: 0.9em;">Raum: ${term.Raumcodierung} <br>(${term.Raumbeschreibung})</span>
                        </label>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <button type="submit" class="btn-next">Auswahl an Server senden & Weiter ➔</button>
</form>

</body>
</html>