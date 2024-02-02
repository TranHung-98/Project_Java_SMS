package service;

import dao.AccountDao;
import dao.impl.AccountDaoImpl;
import dto.AccountDto;
import dto.EmployeeDto;
import entities.Account;
import entities.Employee;
import exception.DuplicateRecordException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import java.io.Serializable;
import java.time.LocalDate;


public class AccountServiceDaoImpl implements Serializable, AccountServiceDao {

    private final AccountDao accountDao;

    private static final Logger LOGGER = LogManager.getLogger(AccountServiceDaoImpl.class);

    public AccountServiceDaoImpl() {
        accountDao = new AccountDaoImpl();
    }


    public Account findByEmail (String email) {
        return accountDao.findByEmail(email);
    }

    public Account findByAccount(String account) {
        return accountDao.findByAccount(account);
    }

    public boolean checkLogin(String username, String password) {
        return accountDao.getByUser(username,password) != null;
    }

    public boolean saveAccount(Account account) {
        return accountDao.saveOrUpdate(account);
    }


    @Override
    public String saveAccount(@NotNull AccountDto accountDto, @NotNull EmployeeDto employeeDto) throws DuplicateRecordException {

        LOGGER.info("Error save accountDto and employeeDto" + accountDto + employeeDto);

        StringBuilder msg = new StringBuilder();


        Account checkAccount = accountDao.findByAccount(accountDto.getAccount());
        if (checkAccount != null) {
            msg.append("Account ").append(accountDto.getAccount()).append(" already existed.!");
        }

        Account checkEmail = accountDao.findByEmail(accountDto.getEmail());
        if (checkEmail != null) {
            msg.append("Email ").append(accountDto.getEmail()).append(" already existed.!");
        }

        if (msg.length() > 0) {
            throw new DuplicateRecordException(msg.toString());
        }



        Employee employee = new Employee();
        employee.setRemark(employeeDto.getRemark());
        employee.setDepartment(employeeDto.getDepartment());
        employee.setPhone(employeeDto.getPhone());
        employee.setDate(employeeDto.getDate());
        employee.setGender(employeeDto.getGender());
        employee.setLastName(employeeDto.getLastName());
        employee.setFirstName(employeeDto.getFirstName());
        employee.setAddress(employeeDto.getAddress());


        Account account = new Account();
        account.setAccount(accountDto.getAccount());
        account.setStatus(accountDto.getStatus());
        account.setEmail(accountDto.getEmail());
        account.setPassword(accountDto.getPassword());
        account.setEmployee(employee);

        if (accountDao.saveOrUpdate(account)) {
            msg.append("Save successfully....!");
        }else {
            msg.append("Error save record...!");
        }

        return msg.toString();
    }
}
