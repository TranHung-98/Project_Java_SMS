package service;

import entities.Account;
import entities.Employee;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.Before;
import org.junit.Test;

import java.time.LocalDate;
import java.util.List;

public class AccountServiceTest  {

    private static AccountServiceDaoImpl accountService;

    private static  Employee employee;

    private static Account account;

    @Before
    public  void setUp()  {
       accountService = new AccountServiceDaoImpl();
       employee = new Employee();
       account  = new Account();
    }

    @Test
    public void test_checkLoginSuccessfully() {

    }


    @Test
    public void test_checkLoginFaild() {
    }

    @Test
    public void test_saveAccountSuccessfully() {

        employee.setFirstName("John");
        employee.setLastName("lastName");
        employee.setGender(Integer.valueOf("1"));
        employee.setDate(LocalDate.of(2015,10,20));
        employee.setPhone("0348405007");
        employee.setAddress("address");
        employee.setDepartment("department");
        employee.setRemark("remark");


        account.setAccount("Admin1998");
        account.setEmail("email@gmail.com");
        account.setPassword("Admin1998!@");
        account.setStatus(Integer.valueOf("1"));
        account.setEmployee(employee);

        boolean result = accountService.saveAccount(account);

        assertTrue(result,"Record is not save");
    }


    @Test
    public void test_saveAccountFaild() {

    }


}