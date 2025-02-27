<%@ page import="java.sql.*" %>
<%@ page import="modele.User" %>
<%@ page import="java.sql.*, modele.User" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evaluation_entreprise", "root", "");

    PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
    ps.setString(1, username);
    ps.setString(2, password);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        User user = new User();
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        
        session.setAttribute("user", user); // Stocker l'objet dans la session
        
        if ("admin".equals(user.getRole())) {
            response.sendRedirect("adminDashboard.jsp");
        } else {
            response.sendRedirect("userDashboard.jsp");
        }
    } else {
        out.println("<script>alert('Nom d'utilisateur ou mot de passe incorrect');</script>");
    }
    con.close();

} catch (Exception e) {
    out.println(e);
}
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
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
    <form action="login.jsp" method="post">
    	<div><h2>Connexion</h2></div>
        Nom d'utilisateur : <input type="text" name="username" required/><br/>
        Mot de passe : <input type="password" name="password" required/><br/>
        <input type="submit" value="Se connecter"/>
        <% if (request.getAttribute("error") != null) { %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>
    <p><a href="register.jsp">S'inscrire</a></p>
    </form>
    
</body>
</html>
