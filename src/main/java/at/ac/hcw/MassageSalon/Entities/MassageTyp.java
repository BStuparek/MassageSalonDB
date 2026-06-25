package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

import java.math.BigDecimal;

@Entity
public class MassageTyp {

    @Id
    private String mTypId;

    private String beschreibung;
    private Integer Dauer;
    private BigDecimal kosten;
}
