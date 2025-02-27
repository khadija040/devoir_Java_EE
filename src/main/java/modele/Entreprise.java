package modele;

import java.util.Date;

public class Entreprise {
    private int id;
    private String nomEntreprise;
    private String adresse;
    private double chiffreAffaire;
    private Date dateCreation;

    // Constructeurs, getters et setters
    public Entreprise() {}

    public Entreprise(String nomEntreprise, String adresse, double chiffreAffaire, Date dateCreation) {
        this.nomEntreprise = nomEntreprise;
        this.adresse = adresse;
        this.chiffreAffaire = chiffreAffaire;
        this.dateCreation = dateCreation;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNomEntreprise() { return nomEntreprise; }
    public void setNomEntreprise(String nomEntreprise) { this.nomEntreprise = nomEntreprise; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public double getChiffreAffaire() { return chiffreAffaire; }
    public void setChiffreAffaire(double chiffreAffaire) { this.chiffreAffaire = chiffreAffaire; }

    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }
}