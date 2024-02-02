<%@ page import="entities.Employee" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 != null) {
        String errorMsg = (String) session1.getAttribute("errorMsg");
        if (errorMsg != null) {
%>
<c:set var="accountError" value=""/>
<c:set var="emailError" value=""/>

<c:forEach var="error" items="${fn:split(errorMsg, '!')}">
    <c:if test="${fn:contains(error, 'Account')}">
        <c:set var="accountError" value="${error}"/>
    </c:if>

    <c:if test="${fn:contains(error, 'Email')}">
        <c:set var="emailError" value="${error}"/>
    </c:if>

</c:forEach>
<%
        }
        session1.removeAttribute("errorMsg");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CMS Page</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/assets/img/user-solid.svg" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/cms.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/employee_list.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/employee.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/responsive.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@100;200;300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body>
<div class="container-fluid">

    <header class="border-bottom pd-mb-s">
        <div class="d-flex justify-content-between align-items-center w-100">
            <div class="nav-title">
                <p class="nav-title_text m-0 mobile-size"><i class="fa-solid fa-users icon-header"></i>Employee</p>
            </div>
            <div class="nav-title nav-title--login d-flex align-items-center">
                <p class="m-0 font-size mobile-size">Welcome
                    ${empty Username ? '' : Username}
                </p>
                <div class="logout">
                    <a href="logout"
                       class="nav-title_login-log_out shadow-none border-0 rounded-end-0 rounded-start-0 ps-5">
                        <i class="fa-solid fa-right-from-bracket icon-logout mobile-size"></i>
                        <span class="padding_left mobile-size">Logout</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main>
        <div class="main_container">
            <div class="main_navbar_table w-m-auto">
                <div class="main_navbar_table_search border-bottom w-100">
                    <div class="main_navbar_table_search-form">
                        <button type="button" class="rounded-0 bg-transparent w-100 p-mb-0"><i
                                class="fa-solid fa-gauge font-size pe-4 size-mobile"></i><span class="font-size mobile-text">Dashboard</span>
                        </button>
                    </div>
                </div>
                <div class="main_navbar_table_table  fix-height w-100">
                    <div class="main_navbar_table_table-item w-100  border-bottom  drop-down">
                        <div class="main_navbar_table-menu d-flex  flex-column-reverse w-100 mobile-position">
                            <ul class="drop-menu w-100 drop-menu-mb" id="drop-menu">
                                <li class="item-menu w-100" id="active"><a href="home"
                                                                           class="text-decoration-none p-lg-xl pd-mb-sm w-100 d-block"><i
                                        class="category__heading-icon fa-solid fa-list"></i> Employee list</a></li>
                                <li class="item-menu w-100 bg-light-success" id="active-add"><a href="add-employee"
                                                                                                class="text-decoration-none p-lg-xl w-100 d-block"><i
                                        class="fa-solid fa-plus mobile-text"></i>Add Employee</a></li>
                            </ul>
                            <button type="submit"
                                    class="fix-btn shadow-none pd-xl p-mb-lr d-flex justify-content-between w-100 border-0"
                                    id="open-drop-menu">
                                <div class="manager">
                                    <i class="fa-solid fa-chart-column size-mobile"></i>
                                    <span class="padding_left w-100 mobile-text">Employee manager</span>
                                </div>
                                <div class="container-icon">
                                    <i class="fa-solid fa-chevron-down"></i>
                                    <i class="fa-solid fa-chevron-up"></i>
                                </div>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="content" class="main_table_content">
                <div class="main_table_content-edit">
                    <h2 class="border-bottom text-size-mb">Add Employee</h2>
                    <div class="form_container-edit ">
                        <div class="form_container_input ">
                            <form action="insert" method="post" id="form-add">
                                <div class="form-group">
                                    <label for="first_name" class="form-label">First Name<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="text" pattern="^[a-zA-Z\s]+$" required name="first_name" placeholder="Enter the first name"
                                           id="first_name" class="form-control" minlength="3" maxlength="30">
                                    <div class="error-message"></div>
                                </div>
                                <div class="form-group">
                                    <label for="last_name" class="form-label">Last Name<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="text" name="last_name" pattern="^[a-zA-Z\s]+$" required placeholder="Enter the last name"
                                           id="last_name" class="form-control">
                                    <span class="error-message"></span>
                                </div>
                                <div class="form-group">
                                    <label for="phone" class="form-label">Phone number<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="text" name="phone" id="phone" maxlength="50" required
                                           placeholder="Enter your phone number"
                                           class="form-control">
                                  <span class="error-message"></span>
                                </div>
                                <div class="form-group">
                                    <label for="birth" class="form-label">Date of birth<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="date" name="date" id="birth" class="form-control" required>
                                    <span class="error-message"></span>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Gender<span class="sup-req">(<sup>*</sup>)</span></label>
                                    <div class="d-flex align-items-center m-1">
                                        <input type="radio" class="margin-right gender-check" id="female" name="gender"
                                               value="1">
                                        <label for="female">Female</label>
                                        <input type="radio" class="gender-check margin-right d-block" id="male"
                                               name="gender" value="0">
                                        <label for="male">Male</label>
                                    </div>
                                    <div class="error-message" id="gender-error"></div>
                                </div>
                                <div class="form-group">
                                    <label for="account" class="form-label">Account<span class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="text" name="account"  required maxlength="50" id="account"
                                           placeholder="Account"
                                           class="form-control ${not empty accountError ? 'error-border' : ''}">
                                    <span class="error-message">
                                       <c:if test="${not empty accountError}">
                                           <c:out value="${accountError}"/>
                                       </c:if>
                                   </span>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="form-label">Email<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="text" required name="email" id="email" placeholder="Email" maxlength="50"
                                           class="form-control ${not empty emailError ? 'error-border' : ''}">
                                  <span class="error-message">
                                      <c:if test="${not empty emailError}">
                                          <c:out value="${emailError}"/>
                                      </c:if>
                                  </span>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="form-label">Password<span class="sup-req">(<sup>*</sup>)</span></label>
                                    <input type="password" name="password" minlength="6" maxlength="100" class="form-control"
                                           id="password" placeholder="Password" required>
                                    <span class="error-message"></span>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea name="address" id="address" maxlength="50" maxlength="50" class="form-control" cols="30"
                                              rows="10"></textarea>
                                    <span class="error-message" id="error-address"></span>
                                </div>
                                <div class="form-group">
                                    <label for="status" class="form-label d-block">Status</label>
                                    <input type="checkbox" class="margin-right gender-check" id="status" name="status"
                                           value="1"  readonly disabled checked>
                                    <label for="status">Active</label>
                                </div>
                                <div class="form-group">
                                    <label for="department" class="form-label  d-block mt-2" >Department<span
                                            class="sup-req">(<sup>*</sup>)</span></label>
                                        <select name="department" id="department"
                                                class="department form-control form-select form-select-lg" required>
                                            <option value="">-------------- Select --------------</option>
                                            <option value="Fsoft Academy">Fsoft Academy</option>
                                            <option value="Fresher">Fresher</option>
                                            <option value="Leader">Leader</option>
                                            <option value="Employee">Employee</option>
                                            <option value="Service">Service</option>
                                            <option value="Packing">Packing</option>
                                            <option value="Manger">Manger</option>
                                        </select>
                                    <div class="error-message"></div>
                                </div>
                                <div class="form-group">
                                    <label for="remark" class="form-label">Remark</label>
                                    <textarea name="remark"  id="remark" class="form-control" cols="30"
                                              rows="10"></textarea>
                                    <span class="error-message"></span>
                                </div>
                                <div class="mt-4 mb-5 d-flex align-items-center">
                                    <button type="button" class="btn btn-primary bg-info" onclick="history.back()"><i
                                            class="fa-solid fa-backward"></i> Back
                                    </button>
                                    <button type="button" class="btn btn-secondary bg-warning m-lg-3" id="reset-value">
                                        <i class="fa-solid fa-rotate-left icon-button"></i>Reset
                                    </button>
                                    <button type="button" class="btn btn-secondary" id="btn-add-employee"><i
                                            class="fa-solid fa-plus"></i>Add
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer></footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/assets/js/cms.js"></script>
<script src="${pageContext.request.contextPath}/resource/assets/js/add_employee.js"></script>

</body>
</html>
