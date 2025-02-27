<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

        PreparedStatement ps = conn.prepareStatement("DELETE FROM employes WHERE matricule = ?");
        ps.setInt(1, id);

        int rows = ps.executeUpdate();
        conn.close();

        if (rows > 0) {
            response.sendRedirect("adminDashboard.jsp?msg=Employé supprimé avec succès");
        } else {
            response.sendRedirect("adminDashboard.jsp?error=Erreur lors de la suppression");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDashboard.jsp?error=Erreur de connexion à la base de données");
    }
%>
