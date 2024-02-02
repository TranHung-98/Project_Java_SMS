package controller;



import constants.Constant;
import org.jetbrains.annotations.NotNull;
import service.EmployeeServiceDaoImpl;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;


public class BaseController extends HttpServlet {

    private final EmployeeServiceDaoImpl employeeService;

    public BaseController() {
        employeeService = new EmployeeServiceDaoImpl();
    }


    protected void  getAllEmployee(@NotNull HttpServletRequest req, String keyword, int pageNumber)  {
        req.setAttribute("employees",employeeService.getAllEmployee(keyword, pageNumber, Constant.PAGE_SIZE));
        req.setAttribute("prevPage", pageNumber - 1);
        req.setAttribute("nextPage", pageNumber + 1);
    }

    protected void  countAllEmployee(@NotNull HttpServletRequest req, String keyword)  {
        long totalResult = employeeService.countResultByNameEmployee(keyword);
        int totalPage = (int) Math.ceil((double) totalResult / Constant.PAGE_SIZE);
        req.setAttribute("totalResult", totalResult);
        req.setAttribute("totalPage", totalPage);
    }

}
