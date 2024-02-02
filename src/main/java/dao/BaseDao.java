package dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.jetbrains.annotations.NotNull;
import utils.HibernateUtil;

import java.io.Serializable;
import java.util.List;

public interface BaseDao <T,ID> {

    default boolean saveOrUpdate(final T object) throws HibernateException {
        if (object == null) {
            return false;
        }

        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();
            session.saveOrUpdate(object);
            transaction.commit();

        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
        return true;
    }

    default List<T> getAll(@NotNull Class<T> clazz) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String queryString = String.format("FROM %s", clazz.getName());
            List<T> query = session.createQuery(queryString, clazz).list();
            return query;
        }
    }

    default boolean deleteById(ID id, Class<T> clazz) throws HibernateException {
        if (id == null) {
            return false;
        }
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {


            transaction = session.beginTransaction();
            T object = session.get(clazz, (Serializable) id);
            if (object == null) {
                System.out.printf("[INFO] %s with id %s does not exist\n", clazz.getName(), id);
                return false;
            }
            session.delete(object);
            transaction.commit();

        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
        return true;
    }
}

