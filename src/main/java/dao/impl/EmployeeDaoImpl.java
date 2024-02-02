package dao.impl;

import dao.EmployeeDao;
import entities.Employee;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import utils.HibernateUtil;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDaoImpl implements EmployeeDao {

    @Override
    public List<Employee> getAllEmployee(int pageNumber, int pageSize) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Employee";
            Query<Employee> query = session.createQuery(hql, Employee.class);

            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);

            return query.getResultList();
        }
    }

    @Override
    public List<Employee> getAllEmployee(String keyword, int pageNumber, int pageSize) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Employee e WHERE CONCAT(e.firstName, ' ', e.lastName) LIKE :empName";
            Query<Employee> query = session.createQuery(hql, Employee.class);
            query.setParameter("empName", "%" + keyword + "%");
            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        }
    }


    @Override
    public long countResultByNameEmployee(String name) throws HibernateException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String hql = "SELECT COUNT(*) FROM Employee e WHERE CONCAT(e.firstName, ' ', e.lastName) LIKE :empName";
            Query hqlQuery = session.createQuery(hql);
            hqlQuery.setParameter("empName", "%" + name + "%");

            long totalResult = (long) hqlQuery.getSingleResult();

            return totalResult;
        }
    }

}
