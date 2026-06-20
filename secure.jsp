<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Secure Account Balance Lookup</title>
</head>
<body>

<%
String accountNo = request.getParameter("accountNo");

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
Class.forName("com.mysql.cj.jdbc.Driver");

```
conn = DriverManager.getConnection(
    "jdbc:mysql://db:3306/testdb?useSSL=false&serverTimezone=UTC",
    "root",
    "root"
);

// SECURE QUERY (NO SQL INJECTION)
String query = "SELECT account_no, customer_name, balance FROM accounts WHERE account_no = ?";

ps = conn.prepareStatement(query);
ps.setString(1, accountNo);

out.println("<b>Safe Query (PreparedStatement)</b><br><br>");

rs = ps.executeQuery();

if(rs.next()) {

    out.println("<h3>Account Details</h3>");

    out.println("Account Number: "
        + rs.getString("account_no") + "<br>");

    out.println("Customer Name: "
        + rs.getString("customer_name") + "<br>");

    out.println("Balance: ₹"
        + rs.getDouble("balance") + "<br>");

} else {
    out.println("Account not found.");
}
```

} catch(Exception e) {

```
out.println("<b>Error:</b> " + e);
```

} finally {

```
try { if(rs != null) rs.close(); } catch(Exception e){}
try { if(ps != null) ps.close(); } catch(Exception e){}
try { if(conn != null) conn.close(); } catch(Exception e){}
```

}
%>

</body>
</html>
