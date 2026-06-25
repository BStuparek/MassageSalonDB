<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Massagesalon - Ergebnis (Seite 5)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; color: #333; }
        h1 { color: #2b7a78; }
        .result-box { padding: 20px; border-radius: 5px; margin-bottom: 30px; }
        .success { background: #def2f1; border-left: 5px solid #2b7a78; color: #17252a; }
        .error { background: #f8d7da; border-left: 5px solid #c0392b; color: #58151c; }
        .btn-home { display: inline-block; margin-top: 10px; padding: 12px 25px; background: #2b7a78; color: white;
            border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; }
        .btn-home:hover { background: #17252a; }
    </style>
</head>
<body>

<%-- Werte VOR session.invalidate() sichern, sonst sind sie weg --%>
<c:set var="success" value="${sessionScope.bookingSuccess}" />
<c:set var="errorMsg" value="${sessionScope.bookingError}" />

<h1>Buchungsergebnis</h1>

<c:if test="${success == true}">
    <div class="result-box success">
        <h3 style="margin-top:0;">Ihr Termin wurde erfolgreich gebucht!</h3>
        <p style="margin-bottom:0;">Wir freuen uns auf Ihren Besuch.</p>
    </div>
</c:if>

<c:if test="${success != true}">
    <div class="result-box error">
        <h3 style="margin-top:0;">Die Buchung konnte nicht durchgeführt werden.</h3>
        <p>Möglicherweise war die angegebene SV-Nummer ungültig oder der Termin existiert nicht mehr.</p>
        <c:if test="${not empty errorMsg}">
            <p style="font-size: 0.85em; color: #888;">Technische Details: ${errorMsg}</p>
        </c:if>
    </div>
</c:if>

<a href="auswahl.jsp" class="btn-home">Zurück zur Startseite</a>

<%
    // Session zerstören, wie laut Ablaufbeschreibung gefordert
    session.invalidate();
%>

</body>
</html>