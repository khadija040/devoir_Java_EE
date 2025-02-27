<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");

    if (id != null) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

            String sql = "DELETE FROM entreprises WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();

            out.println("<p>Entreprise supprimée avec succès !</p>");
            out.println("<a href='adminDashboard.jsp'>Retour à la liste</a>");
        } catch (Exception e) {
            out.println("<p>Erreur : " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>
