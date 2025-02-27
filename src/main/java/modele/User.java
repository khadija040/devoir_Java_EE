package modele;

public class User {
    private int id;
    private String username;
    private String password;
    private String email;
    private String role; // "admin" ou "user"
    private int entrepriseId; // Lien vers l'entreprise pour un utilisateur classique

    // Constructeurs, getters et setters
    public User() {}
    
    

    public User(String username, String password, String email) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
	}



	public User(String username, String password, String email, String role, int entrepriseId) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
        this.entrepriseId = entrepriseId;
    }

    // Getters et setters...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public int getEntrepriseId() { return entrepriseId; }
    public void setEntrepriseId(int entrepriseId) { this.entrepriseId = entrepriseId; }
}