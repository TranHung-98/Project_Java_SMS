package controller;


import constants.Constant;
import entities.Account;
import entities.Employee;
import exception.DuplicateRecordException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jetbrains.annotations.NotNull;
import service.EmployeeServiceDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "employee", urlPatterns = {Constant.PATH_HOME, Constant.PATH_ADD_EMPLOYEE, "/update","/delete"})
public class EmployeeController extends BaseController {

    private final EmployeeServiceDaoImpl employeeService;

    private static final Logger LOGGER = LogManager.getLogger(EmployeeController.class);

    public EmployeeController() {
        this.employeeService = new EmployeeServiceDaoImpl();
    }


    @Override
    public void service(@NotNull HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        switch (req.getServletPath()) {
            case "/update":
                updateEmployee(req, resp);
                break;
            case Constant.PATH_HOME:
                employeeList(req, resp);
                break;
            case Constant.PATH_ADD_EMPLOYEE:
                openPageAddEmployee(req, resp);
                break;
            case "/delete":
               deleteEmployee(resp,req);
                break;
        }
    }

    private void openPageAddEmployee(@NotNull HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(Constant.PATH_OPEN_ADD_EMPLOYEE).forward(req, resp);
    }

    private void employeeList(@NotNull HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String keyword = req.getParameter("search");
        keyword = keyword != null ? keyword : "";

        String page = req.getParameter("page");
        int pageNumber = page == null ? Constant.PAGE_NUMBER : Integer.parseInt(page);

        super.getAllEmployee(req, keyword, pageNumber);
        super.countAllEmployee(req, keyword);


        req.setAttribute("search", keyword);
        req.setAttribute("page", pageNumber);
        req.getRequestDispatcher(Constant.PATH_DASH_BOARD).forward(req, resp);

    }

    private void updateEmployee(@NotNull HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        LOGGER.info("Error req and resp : " + req + resp);

        String idEmployee = req.getParameter("employee-id");
        String idAccount = req.getParameter("account-id");
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


        Employee employee = Employee.builder()
                .id(Integer.parseInt(idEmployee))
                .firstName(firstName)
                .lastName(lastName)
                .phone(phone)
                .address(address)
                .department(department)
                .date(LocalDate.parse(date))
                .gender(Integer.parseInt(gender))
                .remark(remark)
                .build();

        Account.builder()
                .account(account1)
                .email(email)
                .id(Integer.parseInt(idAccount))
                .password(password)
                .status(Integer.parseInt(status))
                .employee(employee)
                .build();

        String errorMsg;

        try {
            errorMsg = employeeService.saveEmployee(employee) ? "Successfully!" : "Failed!";
        } catch (DuplicateRecordException e) {
            LOGGER.error(e.getMessage());
            errorMsg = e.getMessage();
        }

        if (!errorMsg.isEmpty()) {
            super.getAllEmployee(req, "",Constant.PAGE_NUMBER);
            HttpSession session = req.getSession(true);
            session.setAttribute("updateMsg", errorMsg);
            resp.sendRedirect(req.getContextPath() + Constant.PATH_HOME);
        } else {
            HttpSession session = req.getSession(false);
            session.setAttribute("error_message", "Error: The employee could not be updated!");
            req.getRequestDispatcher(Constant.PATH_DASH_BOARD).forward(req, resp);
        }

    }


    private void deleteEmployee(HttpServletResponse resp, @NotNull HttpServletRequest req) throws IOException {

        String idEmployee = req.getParameter("employee-id");
        String idAccount = req.getParameter("account-id");

        String msg = "Please do not delete this account! Thank you!";

        /*
         * Check not to delete the admin account at id 1.
         * In the remaining cases, the dog is allowed.
         */
        if ("1".equals(idEmployee) && "1".equals(idAccount)) {
            HttpSession session = req.getSession(false);
            super.getAllEmployee(req, "",Constant.PAGE_NUMBER);
            session.setAttribute("error_message", msg);
            resp.sendRedirect(req.getContextPath() + Constant.PATH_HOME);
        }else {

            Employee deleteById = new Employee();
            deleteById.setId(Integer.parseInt(idEmployee));

            msg = employeeService.deleteEmployee(deleteById) ? "Delete successfully!" : "Delete failed!" ;
            HttpSession session = req.getSession(true);
            super.getAllEmployee(req,"" ,Constant.PAGE_NUMBER);
            session.setAttribute("deleteSuccess", msg);
            resp.sendRedirect(req.getContextPath() + Constant.PATH_HOME);
        }

    }


}
