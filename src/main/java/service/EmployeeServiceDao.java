package service;


import entities.Employee;
import org.hibernate.HibernateException;

import java.util.List;

public interface EmployeeServiceDao {

    long countResultByNameEmployee(String name) throws HibernateException;


}
