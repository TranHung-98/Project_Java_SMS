package dao.impl;

import dao.AccountDao;
import entities.Account;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import utils.HibernateUtil;


public class AccountDaoImpl implements AccountDao {
    @Override
    public Account getByUser(String username, String password) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String queryString = "FROM Account A WHERE A.account = :account AND A.password = :password";
            Query<Account> query = session.createQuery(queryString, Account.class);
            query.setParameter("account", username);
            query.setParameter("password", password);

            return query.uniqueResult();
        }
    }

    @Override
    public Account findByEmail(String email) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Account> query = session.createQuery("FROM Account a WHERE a.email = :email", Account.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        } catch (HibernateException ignored) {

        }
        return null;
    }

    @Override
    public Account findByAccount(String account) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Account> query = session.createQuery("FROM Account a WHERE  a.account = :account", Account.class);
            query.setParameter("account", account);
            return query.uniqueResult();
        } catch (HibernateException ignored) {

        }
        return null;
    }


}
