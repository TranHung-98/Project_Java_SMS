package service;

import entities.Account;
import static org.junit.jupiter.api.Assertions.*;

import entities.Employee;
import org.junit.Before;
import org.junit.Test;

import java.time.LocalDate;
import java.util.List;

public class EmployeeServiceTest  {

    private static EmployeeServiceDaoImpl employeeService;
    private static AccountServiceDaoImpl accountService;
    private static Account account;
    private static Employee employee;

    @Before
    public  void setUp(){
        employeeService = new EmployeeServiceDaoImpl();
        accountService = new AccountServiceDaoImpl();
        account = new Account();
        employee = new Employee();
    }

    @Test
    public void testGetAllEmployee() {
    }

    @Test
    public void testSaveEmployeeSuccessfully() {

        employee.setFirstName("John");
        employee.setLastName("lastName");
        employee.setGender(Integer.valueOf("1"));
        employee.setDate(LocalDate.of(2015,10,20));
        employee.setPhone("0348405007");
        employee.setAddress("address");
        employee.setDepartment("department");
        employee.setRemark("remark");


        account.setAccount("account1");
        account.setEmail("email@gmail.com");
        account.setPassword("password");
        account.setStatus(Integer.valueOf("1"));
        account.setEmployee( employee);

        employee.setAccount(account);

        boolean result = employeeService.saveEmployee(employee);

        accountService.saveAccount(account);


        assertTrue(result,"Record is not save");

    }
}