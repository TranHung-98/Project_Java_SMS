package utils;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

    private static SessionFactory sessionFactory;

    private HibernateUtil() {
    }

    public static synchronized SessionFactory getSessionFactory() {
        Configuration cfg = new Configuration();
        cfg.configure();

        if(sessionFactory == null || sessionFactory.isClosed()) {
            sessionFactory = cfg.buildSessionFactory();
        }
        return sessionFactory;
    }
}
