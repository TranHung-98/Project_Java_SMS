package dao;

import entities.Account;
import org.hibernate.HibernateException;

public interface AccountDao extends BaseDao<Account,Integer> {
    Account getByUser(String username,String password) throws HibernateException;
    Account findByEmail(String email) throws HibernateException;
    Account findByAccount(String account) throws HibernateException;

}