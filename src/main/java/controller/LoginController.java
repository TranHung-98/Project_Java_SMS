package controller;

import constants.Constant;
import entities.Account;
import entities.Employee;
import org.jetbrains.annotations.NotNull;
import service.AccountServiceDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "Login-Logout", urlPatterns = {Constant.PATH_LOGIN, Constant.PATH_LOGOUT})
public class LoginController extends BaseController {

    private static final long serialVersionUID = 1L;

    private final AccountServiceDaoImpl accountService;


    public LoginController() {
        accountService = new AccountServiceDaoImpl();
    }


    @Override
    public void service(@NotNull HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        switch (req.getServletPath()) {
            case Constant.PATH_LOGIN:
                loginUser(req, resp);
                break;
            case Constant.PATH_LOGOUT:
                logoutUser(req, resp);
                break;
        }
    }


    private void logoutUser(@NotNull HttpServletRequest req, @NotNull HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {

            session.removeAttribute("Username");

            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + Constant.PATH_PAGE);
    }


    private void loginUser(@NotNull HttpServletRequest req, HttpServletResponse resp) throws  IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");


        HttpSession session = req.getSession(true);

        if (username == null || password == null) {
            saveInsertIntoDatabase();
            resp.sendRedirect(req.getContextPath() + Constant.PATH_PAGE);
            return;
        }

        try {

            if (accountService.checkLogin(username, password)) {

                super.getAllEmployee(req,"" ,Constant.PAGE_NUMBER);
                super.countAllEmployee(req, "");
                session.setAttribute("Username", username);
                session.setAttribute("loginMsg", "Login Successfully!");
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                session.setAttribute("userError",username);
                session.setAttribute("passError",password);
                session.setAttribute("loginError", "Incorrect username or password!");
                resp.sendRedirect(req.getContextPath() + Constant.PATH_PAGE);
            }
        } catch (Exception e) {
            session.setAttribute("loginError", "An error occurred during login.");
            resp.sendRedirect(req.getContextPath() + Constant.PATH_PAGE);
        }

    }


    private void saveInsertIntoDatabase() {

        if (isDataInserted()) {
            Employee employee = Employee.builder()
                    .firstName("Tran Ngoc")
                    .lastName("Hung")
                    .phone("0333947878")
                    .address("Cum 11 - Dan Phuong - Ha Noi")
                    .department("The department on the database")
                    .date(LocalDate.parse("1998-10-20"))
                    .gender(1)
                    .remark("Remark on the star")
                    .build();

            Account account = Account.builder()
                    .account("Admin1998")
                    .email("hung20101998@gmal.com")
                    .password("Admin1998!@")
                    .status(1)
                    .employee(employee)
                    .build();

            if (isDataInserted()) {
                accountService.saveAccount(account);
            }

        }
    }

    private boolean isDataInserted() {
        String email = "hung20101998@gmal.com";
        String account = "Admin1998";


        Account existingEmail = accountService.findByEmail(email);
        boolean emailExists = existingEmail != null;


        Account existingAccount = accountService.findByAccount(account);
        boolean accountExists = existingAccount != null;


        return !emailExists && !accountExists;
    }


}
