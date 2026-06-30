<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.InitialContext" %>

<c:if test="${not empty param.svnrMasseur}">
    <c:set var="sessionMasseur" value="${param.svnrMasseur}" scope="session" />
</c:if>

<c:if test="${not empty param.svnrKunde}">
    <%
        boolean success = false;
        String errorMsg = "";
        try {
            InitialContext ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/MassagesalonDB");

            String terminCombined = (String) session.getAttribute("sessionTermin");
            if (terminCombined != null) {

                try (Connection conn = ds.getConnection()) {
                    String sql = "INSERT INTO Kunde_für_Massage_bei_Masseur_vorgemerkt " +
                            "(MTypID, Tageszeit, Raumcodierung, SVNr_Masseur, SVNr_Kunde, Datum) " +
                            "VALUES (?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, (String) session.getAttribute("sessionMTypID"));
                        java.sql.Time sqlZeit = java.sql.Time.valueOf((String) session.getAttribute("sessionZeit"));
                        ps.setTime(2, sqlZeit);

                        ps.setString(3, (String) session.getAttribute("sessionRaum"));
                        ps.setString(4, (String) session.getAttribute("sessionMasseur"));
                        ps.setString(5, request.getParameter("svnrKunde"));
                        ps.setString(6, (String) session.getAttribute("sessionDatum"));

                        ps.executeUpdate();
                        success = true;
                    }
                }
            } else {
                errorMsg = "Sitzungsdaten unvollständig. Bitte starten Sie die Auswahl erneut.";
            }
        } catch (SQLException e) {
            success = false;
            errorMsg = "Datenbankfehler: " + e.getMessage();
        } catch (Exception e) {
            success = false;
            errorMsg = "Systemfehler: " + e.getMessage();
        }
        session.setAttribute("bookingSuccess", success);
        session.setAttribute("bookingError", errorMsg);
    %>
    <c:redirect url="erfolg.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Massagesalon - Identifikation (Seite 4)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; color: #333; }
        h1, h3 { color: #2b7a78; }
        .info-box { background: #e9ecef; padding: 15px; border-radius: 5px; margin-bottom: 30px; border-left: 5px solid #2b7a78; }
        input[type="text"] { padding: 10px; font-size: 16px; border: 2px solid #ddd; border-radius: 5px; width: 250px; }
        .btn-submit { margin-top: 20px; padding: 12px 25px; background: #2b7a78; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; }
        .btn-submit:hover { background: #17252a; }
    </style>
</head>
<body>

<h1>Schritt 4: Identifikation</h1>

<div class="info-box">
    <h4 style="margin-top:0;">Ihre bisherige Auswahl (gespeichert in der Session):</h4>
    <ul style="margin-bottom:0;">
        <li>Massagetyp: <b><c:out value="${sessionScope.sessionMTypID}"/></b></li>
        <li>Datum: <b><c:out value="${sessionScope.sessionDatum}"/></b></li>
        <li>Zeit: <b><c:out value="${sessionScope.sessionZeit}"/> Uhr</b></li>
        <li>Raum: <b><c:out value="${sessionScope.sessionRaum}"/></b></li>
        <li>Masseur (SVNr): <b><c:out value="${sessionScope.sessionMasseur}"/></b></li>
    </ul>
</div>

<form method="POST" action="identifikation.jsp">
    <h3>Bitte geben Sie Ihre SV-Nummer ein, um den Termin verbindlich zu buchen:</h3>
    <input type="text" name="svnrKunde" required maxlength="10" placeholder="z.B. 1234567890">
    <br>
    <button type="submit" class="btn-submit">Termin verbindlich buchen ➔</button>
</form>

</body>
</html>