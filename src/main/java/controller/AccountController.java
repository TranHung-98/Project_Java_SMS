package controller;


import constants.Constant;
import dto.AccountDto;
import dto.EmployeeDto;
import exception.DuplicateRecordException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import service.AccountServiceDaoImpl;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet(name = "insert", urlPatterns = "/insert")
public class AccountController extends BaseController {

    private final AccountServiceDaoImpl accountService;

    private static final Logger LOGGER = LogManager.getLogger(AccountController.class);

    public AccountController() {
        this.accountService = new AccountServiceDaoImpl();
    }

    @Override
    protected void doPost(@NotNull HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String phone = req.getParameter("phone");
        String date = req.getParameter("date");
        String gender = req.getParameter("gender");
        String account1 = req.getParameter("account");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String status = req.getParameter("status");
        String department = req.getParameter("department");
        String remark = req.getParameter("remark");

        status = (status != null && !status.trim().isEmpty()) ? status : "0";

        remark = (remark != null && !remark.trim().isEmpty()) ? remark : "Please update this information!";

        address = (address != null && !address.trim().isEmpty()) ? address : "Please update this information!";

        AccountDto accountDto = new AccountDto(account1,email,password,Integer.parseInt(status));

        EmployeeDto employeeDto = new EmployeeDto(firstName, lastName, Integer.parseInt(gender), LocalDate.parse(date), phone, address, department, remark);

        String errorMsg = "";

        try {
            accountService.saveAccount(accountDto, employeeDto);
        } catch (DuplicateRecordException e) {
            LOGGER.error(e.getMessage());
            errorMsg = e.getMessage();
        }


        if (!errorMsg.isEmpty()) {
            HttpSession session = req.getSession(false);
            session.setAttribute("errorMsg", errorMsg);
            resp.sendRedirect(req.getContextPath() + Constant.PATH_ADD_EMPLOYEE);
        } else {
            errorMsg = "Add employee successfully.";
            HttpSession session = req.getSession(true);
            super.getAllEmployee(req, "", Constant.PAGE_NUMBER);
            super.countAllEmployee(req, "");
            session.setAttribute("createMsg", errorMsg);
            resp.sendRedirect(req.getContextPath() + Constant.PATH_HOME);
        }
    }

}
