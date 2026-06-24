<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <title>Massagesalon - Masseur wählen (Seite 3)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; color: #333; }
        h1, h3 { color: #2b7a78; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 15px; margin-top: 10px; }

        /* Toggle-Button Styling für Masseure */
        .toggle-card { position: relative; }
        .toggle-card input[type="radio"] { position: absolute; opacity: 0; width: 0; height: 0; }
        .card-label { display: block; padding: 15px; background: white; border: 2px solid #ddd; border-radius: 6px; cursor: pointer; transition: all 0.2s ease; }
        .card-label:hover { border-color: #aaa; background: #f0f0f0; }
        .toggle-card input[type="radio"]:checked + .card-label { border-color: #2b7a78; background: #def2f1; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }

        .info-box { background: #e9ecef; padding: 15px; border-radius: 5px; margin-bottom: 30px; border-left: 5px solid #2b7a78; }

        .btn-submit { margin-top: 30px; padding: 12px 25px; background: #2b7a78; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background: #17252a; }
    </style>
</head>
<body>

<c:if test="${not empty param.datum}">
    <c:set var="sessionDatum" value="${param.datum}" scope="session" />
    <c:set var="sessionZeit" value="${param.zeit}" scope="session" />
    <c:set var="sessionRaum" value="${param.raum}" scope="session" />
</c:if>

<h1>Schritt 3: Masseur auswählen</h1>

<div class="info-box">
    <h4 style="margin-top:0;">Ihre bisherige Auswahl (gespeichert in der Session):</h4>
    <ul style="margin-bottom:0;">
        <li>Massagetyp: <b>${sessionScope.sessionMTypID}</b></li>
        <li>Datum: <b>${sessionScope.sessionDatum}</b></li>
        <li>Zeit: <b>${sessionScope.sessionZeit}</b></li>
        <li>Raum: <b>${sessionScope.sessionRaum}</b></li>
    </ul>
</div>

<sql:setDataSource dataSource="jdbc/MassagesalonDB" />

<sql:query var="masseure" sql="SELECT m.SV_Nummer, p.Vorname, p.Nachname, m.Qualifikation FROM Masseur m JOIN Person p ON m.SV_Nummer = p.SVNr" />

<form method="POST" action="jsp4.jsp">

    <h3>Welcher Masseur soll die Behandlung durchführen?</h3>
    <div class="grid">
        <c:forEach var="m" items="${masseure.rows}">
            <div class="toggle-card">
                <input type="radio" name="svnrMasseur" id="m_${m.SV_Nummer}" value="${m.SV_Nummer}" required>
                <label for="m_${m.SV_Nummer}" class="card-label">
                    <h3 style="margin-top:0;">${m.Vorname} ${m.Nachname}</h3>
                    <p style="color: #666; font-size: 0.9em; margin-bottom:0;"><b>Fokus:</b> ${m.Qualifikation}</p>
                </label>
            </div>
        </c:forEach>
    </div>

    <button type="submit" class="btn-submit">Auswahl bestätigen & Zur Identifikation ➔</button>
</form>

</body>
</html>