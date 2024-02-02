package controller;

import constants.Constant;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(filterName = "filter",urlPatterns = {"/*"})
public class ServletFilter implements Filter {

    private List<String> excludedRequests;

    private static final Logger LOGGER = LogManager.getLogger(ServletFilter.class);


    @Override
    public void init(FilterConfig filterConfig)  {
        if (excludedRequests == null) {
            excludedRequests = new ArrayList<>();
            excludedRequests.add(Constant.PATH_LOGIN);
            excludedRequests.add(Constant.PATH_PAGE);
            excludedRequests.add(".js");
            excludedRequests.add(".css");
        }

    }



    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;

        HttpServletResponse response = (HttpServletResponse)  servletResponse;

        HttpSession session = request.getSession();

        boolean loggedId = session != null && session.getAttribute("Username") != null;

        String userRequest = request.getRequestURI();


        if (loggedId || isVaLidRequest(userRequest)) {

            filterChain.doFilter(request,response);
        }else {
            LOGGER.info("Invalid Request");
            response.sendRedirect(request.getContextPath() + Constant.PATH_LOGIN);
        }

    }

    private boolean isVaLidRequest(String req) {
        for (String excludedRequest : excludedRequests) {

            if (req.endsWith(excludedRequest)) {
                return true;
            }

        }
        return false;
    }


    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
