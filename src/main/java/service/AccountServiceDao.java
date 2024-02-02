package service;

import dto.AccountDto;
import dto.EmployeeDto;
import exception.DuplicateRecordException;

public interface AccountServiceDao {
    String saveAccount(AccountDto accountDto, EmployeeDto employeeDto) throws DuplicateRecordException;
}
