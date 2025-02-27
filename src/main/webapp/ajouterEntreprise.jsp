<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String nomEntreprise = request.getParameter("nomEntreprise");
    String adresse = request.getParameter("adresse");
    String chiffreAffaireStr = request.getParameter("chiffreAffaire");
    String dateCreation = request.getParameter("dateCreation");

    if (nomEntreprise != null && adresse != null && chiffreAffaireStr != null && dateCreation != null) {
        double chiffreAffaire = Double.parseDouble(chiffreAffaireStr);
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

            String sql = "INSERT INTO entreprises (nomEntreprise, adresse, chiffreAffaire, dateCreation) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, nomEntreprise);
            ps.setString(2, adresse);
            ps.setDouble(3, chiffreAffaire);
            ps.setString(4, dateCreation);
            ps.executeUpdate();

            out.println("<p>Entreprise ajoutée avec succès !</p>");
        } catch (Exception e) {
            out.println("<p>Erreur : " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>

<html>
<head>
    <title>Ajouter une entreprise</title>
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
		    display: inline-block; /* Permet d'appliquer des styles de bloc */
		    background-color: #6200ea; /* Couleur de fond du bouton */
		    color: #ffffff; /* Couleur du texte */
		    padding: 10px 15px; /* Espacement interne */
		    border-radius: 4px; /* Coins arrondis */
		    text-decoration: none; /* Supprime le soulignement */
		    transition: background-color 0.3s;
		    margin-top : 20px;
		}

		a:hover {
		    background-color: #3700b3; /* Couleur au survol */
		}
    </style>
</head>
<body>
    
    <form action="ajouterEntreprise.jsp" method="post">
    <h2>Ajouter une entreprise</h2>
        <label for="nom">Nom :</label>
        <input type="text" id="nomEntreprise" name="nomEntreprise" required><br><br>

        <label for="adresse">Adresse :</label>
        <input type="text" id="adresse" name="adresse" required><br><br>

        <label for="chiffreAffaire">Chiffre d'affaires (€) :</label>
        <input type="number" id="chiffreAffaire" name="chiffreAffaire" required><br><br>

        <label for="dateCreation">Date de création :</label>
        <input type="date" id="dateCreation" name="dateCreation" required><br><br>

        <input type="submit" value="Ajouter">
        <br>
    <a href="adminDashboard.jsp">Retour à la liste</a>
    </form>
    
</body>
</html>
