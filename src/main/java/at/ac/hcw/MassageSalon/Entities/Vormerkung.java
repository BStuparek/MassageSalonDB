package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import java.time.LocalDate;

@Entity
@Table(name="Kunde_für_Massage_bei_Masseur_vorgemerkt")
public class Vormerkung {
    private LocalDate datum;

    @ManyToOne
    private Kunde kunde;

    @ManyToOne
    private Masseur masseur;

    @ManyToOne
    private Massage massage;

}
