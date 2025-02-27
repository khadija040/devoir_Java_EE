<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    int matricule = Integer.parseInt(request.getParameter("matricule"));
    String nomEmp = request.getParameter("nomEmp");
    String prenom = request.getParameter("prenom");
    String fonction = request.getParameter("fonction");
    String service = request.getParameter("service");
    String dateEmbauche = request.getParameter("dateEmbauche");
    String sexe = request.getParameter("sexe");
    double salaire = Double.parseDouble(request.getParameter("salaire"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "")) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE employes SET nomEmp=?, prenom=?, fonction=?, service=?, dateEmbauche=?, sexe=?, salaire=? WHERE matricule=?"
            );
            ps.setString(1, nomEmp);
            ps.setString(2, prenom);
            ps.setString(3, fonction);
            ps.setString(4, service);
            ps.setString(5, dateEmbauche);
            ps.setString(6, sexe);
            ps.setDouble(7, salaire);
            ps.setInt(8, matricule);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("adminDashboard.jsp?msg=Employé modifié avec succès");
            } else {
                response.sendRedirect("adminDashboard.jsp?error=Erreur lors de la modification");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("adminDashboard.jsp?error=Erreur de connexion à la base de données");
    }
%>
