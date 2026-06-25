package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;

import java.time.LocalDate;

@Entity
public class Ort {

    @Id
    private String raumcodierung;

    private String raumbeschreibung;
}
