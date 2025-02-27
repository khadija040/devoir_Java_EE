<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="modele.User, modele.Employe" %>

<%
    // Récupération de l'ID de l'entreprise à laquelle l'employé sera ajouté
    String entrepriseId = request.getParameter("entrepriseId");

    if (entrepriseId == null) {
        out.println("<p>Aucune entreprise sélectionnée.</p>");
        return;
    }

    // Connexion à la base de données
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

        // Ajouter l'employé
        if (request.getMethod().equals("POST")) {
            String nomEmp = request.getParameter("nomEmp");
            String prenom = request.getParameter("prenom");
            String fonction = request.getParameter("fonction");
            String service = request.getParameter("service");
            String dateEmbauche = request.getParameter("dateEmbauche");
            String sexe = request.getParameter("sexe").substring(0, 1);
            double salaire = Double.parseDouble(request.getParameter("salaire"));

            String sql = "INSERT INTO employes (nomEmp, prenom, fonction, service, dateEmbauche, sexe, salaire, entreprise_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, nomEmp);
            ps.setString(2, prenom);
            ps.setString(3, fonction);
            ps.setString(4, service);
            ps.setDate(5, java.sql.Date.valueOf(dateEmbauche));
            ps.setString(6, sexe);
            ps.setDouble(7, salaire);
            ps.setInt(8, Integer.parseInt(entrepriseId));

            int rows = ps.executeUpdate();

            if (rows > 0) {
                out.println("<p>Employé ajouté avec succès !</p>");
            } else {
                out.println("<p>Erreur : Aucun employé ajouté.</p>");
            }
        }

    } catch (Exception e) {
        out.println("<p>Erreur : " + e.getMessage() + "</p>");
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Employé</title>
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
        	margin-top : 20px;
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
    
    <form method="POST">
    <h2>Ajouter un employé à l'entreprise ID <%= entrepriseId %></h2>
        <label for="nomEmp">Nom :</label>
        <input type="text" id="nomEmp" name="nomEmp" required><br><br>

        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required><br><br>

        <label for="fonction">Fonction :</label>
        <input type="text" id="fonction" name="fonction" required><br><br>

        <label for="service">Service :</label>
        <input type="text" id="service" name="service" required><br><br>

        <label for="dateEmbauche">Date d'embauche :</label>
        <input type="date" id="dateEmbauche" name="dateEmbauche" required><br><br>

        <label for="sexe">Sexe :</label>
        <select id="sexe" name="sexe" required>
            <option value="M">Masculin</option>
            <option value="F">Féminin</option>
        </select><br><br>

        <label for="salaire">Salaire :</label>
        <input type="number" id="salaire" name="salaire" step="0.01" required><br><br>

        <input type="submit" value="Ajouter l'employé">
        
         <br>
    <a href="adminDashboard.jsp">Retour au dashboard</a>
    </form>

   
</body>
</html>
