package service;

import dao.EmployeeDao;
import dao.impl.EmployeeDaoImpl;
import entities.Employee;
import org.hibernate.HibernateException;
import org.jetbrains.annotations.NotNull;

import java.io.Serializable;
import java.util.List;


public class EmployeeServiceDaoImpl implements Serializable, EmployeeServiceDao {

    private final EmployeeDao employeeDao;

    public EmployeeServiceDaoImpl() {
        employeeDao =  new EmployeeDaoImpl();
    }



    @Override
    public long countResultByNameEmployee(String name) throws HibernateException {
        return employeeDao.countResultByNameEmployee(name);
    }

    public List<Employee> getAllEmployee(int pageNumber, int pageSize) {
        return employeeDao.getAllEmployee(pageNumber, pageSize);
    }

    public List<Employee> getAllEmployee(String keyword, int pageNumber, int pageSize) {
        return employeeDao.getAllEmployee(keyword, pageNumber, pageSize);
    }

    public boolean saveEmployee(Employee employee){
        return employeeDao.saveOrUpdate(employee);
    }

   public boolean deleteEmployee(@NotNull Employee employee) {
        return employeeDao.deleteById(employee.getId(), Employee.class);
   }

}
