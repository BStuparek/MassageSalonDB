package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.LocalTime;

@Embeddable
public class MassageId implements Serializable {

    private String mTypId;
    private LocalTime tageszeit;
    private String raumcodierung;
}
