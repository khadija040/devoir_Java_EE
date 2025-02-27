<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>
<%
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");
        
        // Récupérer toutes les entreprises
        String sql = "SELECT id, nom FROM entreprises";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        int entreprise_id = Integer.parseInt(request.getParameter("entreprise_id"));
        
        PreparedStatement stmtInsert = null;
        try {
            String insertSql = "INSERT INTO users (username, password, email, role, entreprise_id) VALUES (?, ?, ?, ?, ?)";
            stmtInsert = conn.prepareStatement(insertSql);
            stmtInsert.setString(1, username);
            stmtInsert.setString(2, password);
            stmtInsert.setString(3, email);
            stmtInsert.setString(4, "user");  // inscription classique : rôle "user"
            stmtInsert.setInt(5, entreprise_id);
            
            int rows = stmtInsert.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("login.jsp");
                return;
            } else {
                request.setAttribute("error", "Erreur lors de l'inscription");
            }
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur : " + e.getMessage());
        } finally {
            if(stmtInsert != null) try { stmtInsert.close(); } catch(SQLException ex) {}
        }
    }
    
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
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
        input[type="password"],
        input[type="email"],
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
		    transition: background-color 0.3s; /* Transition pour l'effet hover */
		}

		a:hover {
		    background-color: #3700b3; /* Couleur au survol */
		}
    </style>
</head>
<body>
    <form method="post" action="register.jsp">
    	<div> <h2>Inscription</h2></div>
        Nom d'utilisateur : <input type="text" name="username" required/><br/>
        Mot de passe : <input type="password" name="password" required/><br/>
        Email : <input type="email" name="email" required/><br/>
        Entreprise :
        <select name="entreprise_id">
            <option value="">-- Sélectionnez une entreprise --</option>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");
                    
                    String sql = "SELECT id, nomEntreprise FROM entreprises"; // Vérifie bien que ta table et colonnes existent
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
                    
                    while (rs.next()) {
            %>
                        <option value="<%= rs.getInt("id") %>"><%= rs.getString("nomEntreprise") %></option>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
            %>
                    <option value="">Erreur lors du chargement</option>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                    if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
                    if (conn != null) try { conn.close(); } catch(SQLException ex) {}
                }
            %>
        </select><br/>
        
        <input type="submit" value="S'inscrire"/>
        
        
        <%
        if (request.getAttribute("error") != null) {
    %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <%
        }
    %>
    
      <p><a href="login.jsp">Retour à la connexion</a></p>
    </form>

    
</body>
</html>