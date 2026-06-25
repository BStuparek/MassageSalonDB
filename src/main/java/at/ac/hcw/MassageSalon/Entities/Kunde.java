package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;

@Entity
public class Kunde {

    @Id
    private String svNr;

    private Integer kundennummer;

    @OneToOne
    @MapsId
    private Person person;
}
