package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;

import java.time.LocalDate;

@Entity
public class Sachbearbeiter {

    @Id
    private String svNr;

    private LocalDate einstellungsDatum;

    @OneToOne
    @MapsId
    private Angestellter angestellter;
}
