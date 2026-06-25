package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.*;
import org.slf4j.LoggerFactory;

import java.util.logging.Logger;

@Entity
public class Massage {
    @EmbeddedId
    private MassageId id;

    @ManyToOne
    @MapsId("mTypId")
    private MassageTyp massageTyp;

    @ManyToOne
    @MapsId("raumcodierung")
    private Ort ort;

}
