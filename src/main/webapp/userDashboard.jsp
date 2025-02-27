<%@ page import="modele.User" %>
<%
    // Vérification de l'utilisateur connecté
    User user = (User ) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Utilisateur</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #fdf1f4; /* Fond pastel rosé très clair */
    margin: 0;
    padding: 20px;
    color: #5c5c5c; /* Couleur de texte doux */
}

h2 {
    color: #b5838d; /* Rose pastel élégant */
    text-align: center;
    letter-spacing: 1px;
}

.content {
    margin-top: 20px;
    padding: 20px;
    background-color: #ffffff; /* Fond blanc pour contraste léger */
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border: 1px solid #f0d1d4; /* Bordure légère rosée */
    text-align: center;
}

.footer {
    margin-top: 20px;
    text-align: center;
    font-size: 0.9em;
    color: #a79292; /* Ton pastel doux */
}

a {
    color: #b5838d; /* Lien élégant rose pastel */
    text-decoration: none;
    padding: 8px 12px;
    border-radius: 6px;
    transition: background-color 0.3s ease;
    background-color: #f3dfe3; /* Fond bouton léger */
}

a:hover {
    text-decoration: none;
    background-color: #eac4c7; /* Survol rose pastel plus foncé */
}
        
    </style>
</head>
<body>
    <div class="content">
        <h2>Bienvenue, <%= user.getUsername() %></h2>
        <p>Ceci est votre espace utilisateur.</p>
        <p>Vous pouvez accéder à vos informations personnelles ici.</p>
        <p><strong>Adresse e-mail :</strong> <%= user.getEmail() %></p>
        <p><strong>Rôle :</strong> <%= user.getRole() %></p>
        <p>Utilisez le lien ci-dessous pour vous déconnecter.</p>
        <br/>
        <a href="logout.jsp">Déconnexion</a>
    </div>

    <div class="footer">
        <p>&copy; 2023 Votre Entreprise. Tous droits réservés.</p>
    </div>
</body>
</html>