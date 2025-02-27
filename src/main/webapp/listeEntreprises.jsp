<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Liste des entreprises</title>
    <style>
        body {
    background-color: #1a0a0a; /* Fond sombre rouge très foncé */
    color: #ffffff;
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    height: 100vh;
}

.navbar {
    background-color: #3a0000; /* Rouge très sombre */
    color: white;
    padding: 15px;
    text-align: center;
    width: 100%;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1000;
}

.sidebar {
    width: 200px;
    background-color: #2a0000; /* Rouge encore plus sombre */
    color: white;
    padding: 15px;
    height: 100%;
    position: fixed;
    top: 50px;
    left: 0;
    overflow-y: auto;
}

.sidebar a {
    display: inline-block;
    width: 100%;
    background-color: #3a0000; /* Rouge sombre bouton */
    color: white;
    padding: 10px;
    margin: 5px 0;
    text-align: center;
    border-radius: 4px;
    text-decoration: none;
    transition: background-color 0.3s;
}

.sidebar a:hover {
    background-color: #4a0000; /* Rouge plus clair au survol */
}

.main {
    margin-left: 220px;
    margin-top: 70px;
    padding: 20px;
    flex-grow: 1;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #550000;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #3a0000;
    color: white;
}

a {
    display: inline-block;
    background-color: #3a0000; /* Rouge sombre */
    color: white;
    padding: 10px 15px;
    border-radius: 4px;
    text-align: center;
    text-decoration: none;
    transition: background-color 0.3s;
}

a:hover {
    background-color: #4a0000; /* Rouge plus clair au survol */
}
    </style>
</head>
<body>
<div class="navbar">
        <h1>Dashboard Admin</h1>
    </div>

    <div class="sidebar">
        <h2>Menu</h2>
        <a href="adminDashboard.jsp">Tableau de bord</a>
        <a href="ajouterEntreprise.jsp">Ajouter une entreprise</a>
        <a href="listeEntreprises.jsp">Liste des entreprises</a>
        <a href="logout.jsp">Déconnexion</a>
    </div>

    <div class="main">
    	<h2>Liste des entreprises</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Adresse</th>
            <th>Chiffre</th>
            <th>Date Creation</th>
            <th>Actions</th>
        </tr>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Adapter selon ton SGBD
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM entreprises");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("nomEntreprise") %></td>
            <td><%= rs.getString("adresse") %></td>
            <td><%= rs.getString("chiffreAffaire") %></td>
            <td><%= rs.getString("dateCreation") %></td>
            <td>
                <a href="modifierEntreprise.jsp?id=<%= rs.getInt("id") %>">Modifier</a> |
                <a href="supprimerEntreprise.jsp?id=<%= rs.getInt("id") %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette entreprise ?');">Supprimer</a>
                <a href="afficherEmploye.jsp?entrepriseId=<%= rs.getInt("id") %>">Voir les employés</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Erreur : " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            }
        %>
    </table>
    <br>
    <a href="ajouterEntreprise.jsp">Ajouter une entreprise</a>
    </div>
</body>
</html>
