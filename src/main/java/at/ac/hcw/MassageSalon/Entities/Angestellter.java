package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name="Angesteller_hat_Gehaltskonto")
public class Angestellter {
    @Id
    private String svNr;
    private String kontonummer;
    private BigDecimal kontostand;

    @ManyToOne
    private Bank bank;

    @OneToOne
    @MapsId
    private Person person;

    public Angestellter(){

    }
    public Angestellter(String svNr, String kontonummer, BigDecimal kontostand, Bank bank, Person person){

    }
}
