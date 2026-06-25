package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Person {

    @Id
    private String svNr;


    private String vorname;
    private String nachname;
    private String plz;
    private String ort;
    private String strasse;
    private String hausnummer;

    public Person(){

    }

    public Person(String svNr, String vorname, String nachname, String plz, String ort, String strasse, String hausnummer){
        this.svNr = svNr;
        this.vorname = vorname;
        this.nachname = nachname;
        this.plz = plz;
        this.ort = ort;
        this.strasse = strasse;
        this.hausnummer = hausnummer;
    }


    public String getSvNr() {
        return svNr;
    }
    public String getVorname() {
        return vorname;
    }
    public String getNachname() {
        return nachname;
    }
    public String getPlz() {
        return plz;
    }
    public String getOrt(){
        return ort;
    }
    public String getStrasse(){
        return strasse;
    }
    public String getHausnummer() {
        return hausnummer;
    }


    public void setSvNr(String svNr) {
        this.svNr = svNr;
    }
    public void setVorname(String vorname) {
        this.vorname = vorname;
    }
    public void setNachname(String nachname) {
        this.nachname = nachname;
    }
    public void setPlz(String plz) {
        this.plz = plz;
    }
    public void setOrt(String ort) {
        this.ort = ort;
    }
    public void setStrasse(String strasse) {
        this.strasse = strasse;
    }
    public void setHausnummer(String hausnummer) {
        this.hausnummer = hausnummer;
    }
}
