<%@ page import="java.sql.*, modele.Employe" %>
<%
	String idParam = request.getParameter("id");
	int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : -1;
	if (id == -1) {
	    out.println("<p style='color:red;'>Erreur : ID de l'employé non spécifié.</p>");
	    return;
	}

    Employe employe = null;

    try {
        id = Integer.parseInt(request.getParameter("id"));
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "")) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM employes WHERE matricule = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                employe = new Employe(
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
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (employe == null) {
%>
        <p style="color:red;">Erreur : Aucun employé trouvé.</p>
        <a href="adminDashboard.jsp">Retour</a>
<%
        return;
    }
%>

<html>
<head>
    <title>Modifier Employé</title>
    <style>
        body {
            background-color: #121212; /* Couleur de fond sombre */
            color: #ffffff; /* Couleur du texte */
            font-family: Arial, sans-serif; /* Police élégante */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Prend toute la hauteur de la fenêtre */
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        form {
            background-color: #1e1e1e; /* Fond du formulaire */
            padding: 20px;
            border-radius: 8px; /* Coins arrondis */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5); /* Ombre */
            width: 300px; /* Largeur fixe du formulaire */
        }

        input[type="text"],
        input[type="number"],
        input[type="sexe"],
        input[type="date"],
        select {
            width: 100%; /* Prend toute la largeur */
            padding: 10px;
            margin: 10px 0; /* Espacement entre les champs */
            border: 1px solid #444; /* Bordure sombre */
            border-radius: 4px; /* Coins arrondis */
            background-color: #2a2a2a; /* Fond des champs */
            color: #ffffff; /* Couleur du texte dans les champs */
        }

        input[type="submit"] {
            background-color: #6200ea; /* Couleur du bouton */
            color: #ffffff; /* Couleur du texte du bouton */
            border: none; /* Pas de bordure */
            border-radius: 4px; /* Coins arrondis */
            padding: 10px;
            cursor: pointer; /* Curseur pointer */
            transition: background-color 0.3s; /* Transition pour l'effet hover */
            width: 100%; /* Prend toute la largeur */
        }

        input[type="submit"]:hover {
            background-color: #3700b3; /* Couleur du bouton au survol */
        }

        p {
            text-align: center; /* Centrer le texte */
        }

        a {
        	margin-top: 20px;
		    display: inline-block; /* Permet d'appliquer des styles de bloc */
		    background-color: #6200ea; /* Couleur de fond du bouton */
		    color: #ffffff; /* Couleur du texte */
		    padding: 10px 15px; /* Espacement interne */
		    border-radius: 4px; /* Coins arrondis */
		    text-decoration: none; /* Supprime le soulignement */
		    transition: background-color 0.3s; /* Transition pour l'effet hover */
		}

		a:hover {
		    background-color: #3700b3; /* Couleur au survol */
		}
    </style>
</head>
<body>
    
    <form action="modifierEmployeAction.jsp" method="post">
    <h2>Modifier Employé</h2>
        <input type="hidden" name="matricule" value="<%= employe.getMatricule() %>">
        Nom: <input type="text" name="nomEmp" value="<%= employe.getNomEmp() %>" required><br>
        Prénom: <input type="text" name="prenom" value="<%= employe.getPrenom() %>" required><br>
        Fonction: <input type="text" name="fonction" value="<%= employe.getFonction() %>" required><br>
        Service: <input type="text" name="service" value="<%= employe.getService() %>" required><br>
        Date Embauche: <input type="date" name="dateEmbauche" value="<%= employe.getDateEmbauche().toString() %>" required><br>
        Sexe:
        <select name="sexe" required>
            <option value="M" <%= "M".equals(employe.getSexe()) ? "selected" : "" %>>M</option>
            <option value="F" <%= "F".equals(employe.getSexe()) ? "selected" : "" %>>F</option>
        </select><br>
        Salaire: <input type="number" name="salaire" step="0.01" value="<%= employe.getSalaire() %>" required><br>
        <input type="submit" value="Modifier">
    </form>
</body>
</html>
