<%@ page import="com.tictactoe.Sign" %>
<%@ page import="java.util.List" %>
<%@ page import="static java.util.Objects.isNull" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="static/main.css" rel="stylesheet">

<!DOCTYPE html>
<html>
<head>
    <title>Tic-Tac-Toe</title>
</head>
<body>
<h1>Tic-Tac-Toe</h1>


<%!
    private final int NUM_OF_ROWS_AND_COLUMNS = 3;

    private String genCell(int cellId, List<Sign> data) {
        return String.format("<td onclick=\"window.location='/logic?click=%d'\">%s</td>", cellId, data.get(cellId).getSign());
    }

    private String genRow(int startCellId, int length, List<Sign> data) {
        StringBuilder rowSB = new StringBuilder();
        rowSB.append("<tr>");
        for (int i = 0; i < length; i++) {
            rowSB.append(genCell(startCellId + i, data));
        }
        rowSB.append("</tr>");

        return rowSB.toString();
    }

    private String genTable(List<Sign> data) {
        StringBuilder tableSB = new StringBuilder();
        tableSB.append("<table>");
        for (int i = 0; i < NUM_OF_ROWS_AND_COLUMNS; i++) {
            tableSB.append(genRow(i * NUM_OF_ROWS_AND_COLUMNS, NUM_OF_ROWS_AND_COLUMNS, data));
        }
        tableSB.append("</table>");
        return tableSB.toString();
    }
%>
<%
    Object dataAttribute = session.getAttribute("data");
    List<Sign> data = null;

    try {
        data = (List<Sign>) dataAttribute;
    } catch (Exception e) {
        response.sendRedirect("/start");
    }


%>
<%=
genTable(data)
%>

<hr>
<c:set var="CROSSES" value="<%=Sign.CROSS%>"/>
<c:set var="NOUGHTS" value="<%=Sign.NOUGHT%>"/>

<c:if test="${winner == CROSSES}">
    <h1>CROSSES WIN!</h1>
    <button onclick="restart()">Start again</button>
</c:if>
<c:if test="${winner == NOUGHTS}">
    <h1>NOUGHTS WIN!</h1>
    <button onclick="restart()">Start again</button>
</c:if>
<c:if test="${draw}">
    <h1>IT'S A DRAW</h1>
    <br>
    <button onclick="restart()">Start again</button>
</c:if>
<script src="<c:url value="/static/jquery-3.6.0.min.js"/>"></script>

<script>
    function restart() {
        $.ajax({
            url: '/restart',
            type: 'POST',
            contentType: 'application/json;charset=UTF-8',
            async: false,
            success: function () {
                location.reload();
            }
        });
    }
</script>

</body>
</html>