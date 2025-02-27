<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="modele.User, modele.Employe" %>
<%
    // Récupérer l'ID de l'entreprise depuis l'URL
    String entrepriseIdParam = request.getParameter("entrepriseId");
    if (entrepriseIdParam == null) {
        out.println("<p>Aucune entreprise sélectionnée.</p>");
        return;
    }

    int entrepriseId = Integer.parseInt(entrepriseIdParam);

    // Récupérer les employés pour cette entreprise
    List<Employe> employes = new ArrayList<>();
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");
        String sql = "SELECT * FROM employes WHERE entreprise_id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, entrepriseId);
        rs = ps.executeQuery();

        while (rs.next()) {
            Employe employe = new Employe(
                rs.getInt("matricule"),
                rs.getString("nomEmp"),
                rs.getString("prenom"),
                rs.getString("fonction"),
                rs.getString("service"),
                rs.getDate("dateEmbauche"),
                rs.getString("sexe"),
                rs.getDouble("salaire"),
                rs.getInt("entreprise_id")
            );

            employes.add(employe);
        }
    } catch (Exception e) {
        out.println("<p>Erreur : " + e.getMessage() + "</p>");
    } finally {
        // Fermer les ressources
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (ps != null) try { ps.close(); } catch(SQLException ex) {}
        if (con != null) try { con.close(); } catch(SQLException ex) {}
    }

    // Afficher les employés
    if (!employes.isEmpty()) {
%>
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
	<h3>Liste des Employés de l'Entreprise ID <%= entrepriseId %></h3>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Fonction</th>
        <th>Service</th>
        <th>Date d'Embauche</th>
        <th>Sexe</th>
        <th>Salaire</th>
        <th>Actions</th>
    </tr>
    <% for (Employe emp : employes) { %>
    <tr>
        <td><%= emp.getMatricule() %></td>
        <td><%= emp.getNomEmp() %></td>
        <td><%= emp.getPrenom() %></td>
        <td><%= emp.getFonction() %></td>
        <td><%= emp.getService() %></td>
        <td><%= emp.getDateEmbauche() %></td>
        <td><%= emp.getSexe() %></td>
        <td><%= emp.getSalaire() %></td>
        <td>
            <a href="modifierEmploye.jsp?id=<%= emp.getMatricule() %>">Modifier</a> |
            <a href="supprimerEmploye.jsp?id=<%= emp.getMatricule() %>" onclick="return confirm('Voulez-vous vraiment supprimer cet employé ?');">Supprimer</a>
        </td>
    </tr>
    <% } %>
</table>
<%
    } else {
        out.println("<p>Aucun employé trouvé pour cette entreprise.</p>");
    }
%>

<br>
<a href="adminDashboard.jsp">Retour au Dashboard</a>
<a href="ajouterEmploye.jsp?entrepriseId=<%= entrepriseId %>">Ajouter Employé</a>
</div>