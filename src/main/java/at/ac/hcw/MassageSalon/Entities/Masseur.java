package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.*;

@Entity
public class Masseur {

    @Id
    private String svNr;
    private Integer lizenznummer;
    private Integer ausbildungszeit;
    private String qualifikation;

    @OneToOne
    @MapsId
    private Angestellter angestellter;
}
