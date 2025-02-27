<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String id = request.getParameter("id");
    String nomEntreprise = "", adresse = "", chiffreAffaire = "", dateCreation = "";

    if (id != null) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

            String sql = "SELECT * FROM entreprises WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            rs = ps.executeQuery();

            if (rs.next()) {
                nomEntreprise = rs.getString("nomEntreprise");
                adresse = rs.getString("adresse");
                chiffreAffaire = rs.getString("chiffreAffaire");
                dateCreation = rs.getString("dateCreation");
            }
        } catch (Exception e) {
            out.println("<p>Erreur : " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>

<html>
<head>
    <title>Modifier une entreprise</title>
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
    
    <form action="modifierEntreprise.jsp" method="post">
    <h2>Modifier une entreprise</h2>
        <input type="hidden" name="id" value="<%= id %>">

        <label for="nomEntreprise">Nom :</label>
        <input type="text" id="nomEntreprise" name="nomEntreprise" value="<%= nomEntreprise %>" required><br><br>

        <label for="adresse">Adresse :</label>
        <input type="text" id="adresse" name="adresse" value="<%= adresse %>" required><br><br>

        <label for="chiffreAffaire">Chiffre d'affaires (€) :</label>
        <input type="number" id="chiffreAffaire" name="chiffreAffaire" value="<%= chiffreAffaire %>" required><br><br>

        <label for="dateCreation">Date de création :</label>
        <input type="date" id="dateCreation" name="dateCreation" value="<%= dateCreation %>" required><br><br>

        <input type="submit" value="Modifier">
         <br>
    <a href="listeEntreprises.jsp">Retour à la liste</a>
    </form>
    <%
    String idModif = request.getParameter("id");
    String nomModif = request.getParameter("nomEntreprise");
    String adresseModif = request.getParameter("adresse");
    String chiffreAffaireModif = request.getParameter("chiffreAffaire");
    String dateCreationModif = request.getParameter("dateCreation");

    if (idModif != null && nomModif != null && adresseModif != null && chiffreAffaireModif != null && dateCreationModif != null) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

            String sql = "UPDATE entreprises SET nomEntreprise = ?, adresse = ?, chiffreAffaire = ?, dateCreation = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, nomModif);
            ps.setString(2, adresseModif);
            ps.setDouble(3, Double.parseDouble(chiffreAffaireModif));
            ps.setString(4, dateCreationModif);
            ps.setInt(5, Integer.parseInt(idModif));

            ps.executeUpdate();

            out.println("<p>Entreprise modifiée avec succès !</p>");
        } catch (Exception e) {
            out.println("<p>Erreur : " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
%>
    
   
</body>
</html>
