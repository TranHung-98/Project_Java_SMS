import org.hibernate.SessionFactory;
import utils.HibernateUtil;

public class Application {

    public static void main(String[] args) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        System.out.println(sessionFactory);
    }
}
