package modele;

import java.util.Date;

public class Employe {
    private int matricule;
    private String nomEmp;
    private String prenom;
    private String fonction;
    private String service;
    private Date dateEmbauche;
    private String sexe; // 'M' ou 'F'
    private double salaire;
    private int entrepriseId; // L'entreprise à laquelle il appartient

    // Constructeurs, getters et setters
    public Employe() {}
    
    public Employe(int matricule, String nomEmp, String prenom, String fonction, String service, Date dateEmbauche, String sexe, double salaire, int entrepriseId) {
        this.matricule = matricule;
        this.nomEmp = nomEmp;
        this.prenom = prenom;
        this.fonction = fonction;
        this.service = service;
        this.dateEmbauche = dateEmbauche;
        this.sexe = sexe;
        this.salaire = salaire;
        this.entrepriseId = entrepriseId;
    }


    public Employe(String nomEmp, String prenom, String fonction, String service, Date dateEmbauche, String sexe, double salaire, int entrepriseId) {
        this.nomEmp = nomEmp;
        this.prenom = prenom;
        this.fonction = fonction;
        this.service = service;
        this.dateEmbauche = dateEmbauche;
        this.sexe = sexe;
        this.salaire = salaire;
        this.entrepriseId = entrepriseId;
    }

    public int getMatricule() { return matricule; }
    public void setMatricule(int matricule) { this.matricule = matricule; }

    public String getNomEmp() { return nomEmp; }
    public void setNomEmp(String nomEmp) { this.nomEmp = nomEmp; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getFonction() { return fonction; }
    public void setFonction(String fonction) { this.fonction = fonction; }

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }

    public Date getDateEmbauche() { return dateEmbauche; }
    public void setDateEmbauche(Date dateEmbauche) { this.dateEmbauche = dateEmbauche; }

    public String getSexe() { return sexe; }
    public void setSexe(String sexe) { this.sexe = sexe; }

    public double getSalaire() { return salaire; }
    public void setSalaire(double salaire) { this.salaire = salaire; }

    public int getEntrepriseId() { return entrepriseId; }
    public void setEntrepriseId(int entrepriseId) { this.entrepriseId = entrepriseId; }
}