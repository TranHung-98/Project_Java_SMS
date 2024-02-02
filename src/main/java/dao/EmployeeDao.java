package dao;

import entities.Employee;
import org.hibernate.HibernateException;

import java.time.LocalDate;
import java.util.List;

public interface EmployeeDao extends BaseDao<Employee,Integer>{
    List<Employee> getAllEmployee(int pageNumber, int pageSize) throws HibernateException;

    List<Employee> getAllEmployee(String keyword, int pageNumber, int pageSize) throws HibernateException;

    long countResultByNameEmployee(String name) throws HibernateException;


}
