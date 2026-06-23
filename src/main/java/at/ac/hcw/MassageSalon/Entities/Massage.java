package at.ac.hcw.MassageSalon.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.slf4j.LoggerFactory;

import java.util.logging.Logger;

@Entity
@Table(name="MASSAGE")
public class Massage {
    private static final Logger log = LoggerFactory.getLogger(Massage.class);

}
