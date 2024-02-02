<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>


<%!

%><c:set var="accountError" value=""/>
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
    HttpSession session2 = request.getSession(false);
    HttpSession session1 = request.getSession(true);

    String error_message = (session2 != null) ? (String) session2.getAttribute("error_message") : null;
    String updateMsg = (String) session1.getAttribute("updateMsg");
    String deleteSuccess = (String) session1.getAttribute("deleteSuccess");
    String createMsg = (String) session1.getAttribute("createMsg");
    String loginMsg = (String) session1.getAttribute("loginMsg");

    boolean shouldDisplayNotify = error_message != null || updateMsg != null || deleteSuccess != null || createMsg != null || loginMsg != null;
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CMS Page</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/assets/img/users-solid.svg" type="image/x-icon">
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

<div class="container-fluid  position-relative">
    <% if (shouldDisplayNotify) { %>
    <div class="notify" id="notify">
        <span class="close-notify" id="close-notify">&times;</span>
        <div>
            <span class="icon-notify"  style="${empty error_message? '': 'color: red;'}"><i class="fa-solid fa-bell"></i></span>
            <div class="message-timeout" id="error-msg">
                ${error_message}
            </div>
            <div class="message-timeout" id="msgSuccess">
                ${updateMsg}
                ${deleteSuccess}
                ${createMsg}
                ${loginMsg}
            </div>
        </div>
        <div class="signal" id="signal" style="${empty error_message? '': 'background-color: red;'}"></div>
    </div>
    <%
        assert session2 != null;
        session1.removeAttribute("updateMsg");
        session1.removeAttribute("deleteSuccess");
        session1.removeAttribute("createMsg");
        session1.removeAttribute("loginMsg");
        session2.removeAttribute("error_message");
    %>
    <% } %>

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
                <div class="main_navbar_table_search border-bottom w-100 mobile-center">
                    <div class="main_navbar_table_search-form">
                        <button type="button" class="rounded-0 bg-transparent p-mb-0 w-100"><i
                                class="fa-solid fa-gauge font-size pe-4 size-mobile"></i><span class="font-size mobile-text ">Dashboard</span>
                        </button>
                    </div>
                </div>
                <div class="main_navbar_table_table  fix-height w-100">
                    <div class="main_navbar_table_table-item w-100  border-bottom  drop-down ">
                        <div class="main_navbar_table-menu d-flex  flex-column-reverse w-100 mobile-position">
                            <ul class="drop-menu w-100 mobile-d-none drop-menu-mb" id="drop-menu">
                                <li class="item-menu w-100 bg-light-success" id="active"><a href="home"
                                                                                            class="text-decoration-none p-lg-xl pd-mb-sm w-100 d-block"><i
                                        class="category__heading-icon fa-solid fa-list"></i> Employee list</a></li>
                                <li class="item-menu w-100"><a href="add-employee"
                                                               class="text-decoration-none p-lg-xl w-100 d-block"><i
                                        class="fa-solid fa-plus"></i>Add Employee</a></li>
                            </ul>
                            <button type="submit" class="fix-btn shadow-none pd-xl p-mb-lr d-flex justify-content-between w-100 border-0"
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
                <div class="main_table_content-view">
                    <div class="border-bottom">
                        <h2 class="text-pd text-size-mb">Employee list</h2>
                    </div>
                    <div class="main_add_content ">
                        <div class="main_add_content_table">
                            <div class="w-100">
                                <form method="post" id="form-search" class="d-flex search-container " action="home">
                                    <div class="form-group-1 d-flex size">
                                        <i class="fa-solid fa-magnifying-glass icon-search" id="click-submit"></i>
                                        <label for="search"></label>
                                        <input type="search" name="search" id="search"
                                                                           class="search-user" placeholder="User Search" value="${search}">
                                    </div>
                                    <ul class="list-filter d-flex">
                                        <li class="item-filter bg-head"><i class="fa-solid fa-filter icon"></i>Filter By
                                        </li>
                                        <li class="item-filter pd-right">
                                            <label for="filter-by"></label><select name="filter" id="filter-by"
                                                                                   class="department form-control">
                                            <option value="Name">Name</option>
                                            <option value="Date of birth">Date of birth</option>
                                            <option value="Address">Address</option>
                                            <option value="Phone">Phone</option>
                                            <option value="Department">Department</option>
                                        </select>
                                            <i class="fa-solid fa-caret-down icon pd-right"></i>
                                        </li>
                                    </ul>
                                    <button type="button" id="btn-search" class="btn-sl">Search</button>
                                </form>
                            </div>
                            <div class="main_add_content_table_content">
                                <table class="">
                                    <thead class="bg-head">
                                    <tr>
                                        <th class="text-center ">ID</th>
                                        <th class="">Name</th>
                                        <th class="">Date of birth</th>
                                        <th class="">Address</th>
                                        <th class="">Phone number</th>
                                        <th class="">Department</th>
                                        <th class="">Action</th>
                                    </tr>
                                    </thead>
                                    <tbody class="show-data-search">
                                        <c:choose>
                                            <c:when test="${empty employees}">
                                                <tr class="bg-light">
                                                    <td colspan="7" class="search-msg">No match.</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${employees}" var="item" varStatus="count">
                                                    <tr class="bg-light hide-success">
                                                        <td class="index">${count.index + 1}</td>
                                                        <td class="full-name">${item.firstName} ${item.lastName}</td>
                                                        <td class="date-of-birth">${item.date}</td>
                                                        <td class="address">${item.address}</td>
                                                        <td class="phone-number">${item.phone}</td>
                                                        <td class="department-table">${item.department}</td>
                                                        <td class="gender">${item.gender}</td>
                                                        <td class="remark">${item.remark}</td>
                                                        <td class="account">${item.account.account}</td>
                                                        <td class="email">${item.account.email}</td>
                                                        <td class="password">${item.account.password}</td>
                                                        <td class="status">${item.account.status}</td>
                                                        <td class="number-count">${item.account.id}</td>
                                                        <td class="number">${item.id}</td>
                                                        <td>
                                                            <div class="view d-flex">
                                                                <p class="update-emp"><i class="fa-regular fa-eye icon-eye"></i>
                                                                    View</p>
                                                                <button type="submit" class="btn icon-btn delete-emp"><i
                                                                        class="fa-solid fa-trash icon-eye"></i></button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <ul class="list-next-page d-flex ${empty employees ? 'd-none': ''}">
                                <li class="item-next-page ${prevPage + 1 eq 1 ? 'disable' : 'actived'}" id="prev"><a
                                        href="${pageContext.request.contextPath}/home?page=${prevPage}"
                                 class="number-page text-color">Previous</a>
                                </li>
                                <c:forEach begin="1" end="${totalPage}" var="i">
                                    <li class="item-next-page bg-head width-num ${i eq page ? 'active' : ''}">
                                        <a href="${pageContext.request.contextPath}/home?page=${i}" class="number-page ${i eq page ? 'active' : ''}">
                                                ${i}
                                        </a>
                                    </li>
                                </c:forEach>
                                <li class="item-next-page pd-right width-next ${nextPage - 1 eq totalPage ? 'disable' : 'actived'}" id="next"><a
                                        href="${pageContext.request.contextPath}/home?page=${nextPage}" class="number-page text-color ${i eq page ? 'active' : ''}">Next</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <div class="modal modal--none" id="modal">
        <div class="modal__overlay bgr-color"></div>
        <div class="modal__body width-size" id="show-update">
            <form id="form-update" action="update" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Edit</h5>
                    <button type="button" id="close" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span
                            class="sr-only">Close</span></button>
                </div>
                <div class="modal-body max-height">
                    <div class="form-group pd-r-0" style="display: none">
                        <label for="number"></label>
                        <input class="form-control" name="employee-id" id="number" type="text" value=""/>
                    </div>
                    <div class="form-group pd-r-0" style="display: none">
                        <label for="number-account"></label>
                        <input class="form-control" name="account-id" id="number-account" type="text" value=""/>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group form-group-w-100">
                                <label for="first_name-up" class="form-label">First Name</label>
                                <input class="form-control" name="first_name" id="first_name-up" type="text" value=""
                                       placeholder="First Name"/>
                                <span class="error-message"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group form-group-w-100">
                                <label for="last_name-up" class="form-label">Last Name</label>
                                <input class="form-control" name="last_name" id="last_name-up" type="text" value=""
                                       placeholder="Last Name"/>
                                <span class="error-message"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="birth-up" class="form-label">Date of birth</label>
                        <input class="form-control" name="date" id="birth-up" type="date" value=""/>
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="phone-up" class="form-label">Phone number</label>
                        <input class="form-control" name="phone" id="phone-up" type="text" value=""
                               placeholder="Phone number"/>
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account-up" class="form-label">Account</label>
                        <input type="text" name="account" required maxlength="50" id="account-up"
                               placeholder="Account"
                               class="form-control ${not empty accountError ? 'error-border' : ''}">
                        <span class="error-message">
                            <c:if test="${not empty accountError}">
                                <c:out value="${accountError}"/>
                            </c:if>
                        </span>
                    </div>
                    <div class="form-group">
                        <label for="email-up" class="form-label">Email</label>
                        <input type="text" required name="email" id="email-up"
                               placeholder="Email" maxlength="50"
                               class="form-control ${not empty emailError ? 'error-border' : ''}">
                        <span class="error-message">
                             <c:if test="${not empty emailError}">
                                 <c:out value="${emailError}"/>
                             </c:if>
                        </span>
                    </div>
                    <div class="form-group">
                        <label for="password-up" class="form-label">Password</label>
                        <input type="password" name="password" maxlength="100" class="form-control"
                               id="password-up" placeholder="Password" value="" required>
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="d-flex align-items-center m-1">
                            <input type="radio" class="margin-right gender-check" id="female-up" name="gender"
                                   value="1">
                            <label for="female-up">Female</label>
                            <input type="radio" class="gender-check margin-right d-block" id="male-up"
                                   name="gender" value="0">
                            <label for="male-up">Male</label>
                        </div>
                        <div class="error-message" id="gender-error"></div>
                    </div>
                    <div class="form-group">
                        <label for="status-up" class="form-label d-block">Status</label>
                        <input type="checkbox" class="margin-right gender-check" id="status-up" name="status"
                               value="1" required>
                        <label for="status-up">Active</label>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="department-up" class="form-label">Department</label>
                        <select name="department" id="department-up"
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
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="address" class="form-label">Address</label>
                        <textarea name="address" id="address" maxlength="50" class="form-control" cols="30"
                                  rows="10"></textarea>
                        <span class="error-message" id="error-address"></span>
                    </div>
                    <div class="form-group">
                        <label for="remark" class="form-label">Remark</label>
                        <textarea name="remark" id="remark" class="form-control" cols="30"
                                  rows="10"></textarea>
                        <span class="error-message"></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btn-update" class="btn btn-lg btn-primary">Save</button>
                </div>
            </form>
        </div>
        <div class="modal__body width-size" id="show-delete">
            <form id="form-delete" action="delete" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">Delete</h5>
                    <button type="button" id="click-close" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                </div>
                <div class="modal-body max-height">
                    <div class="form-group pd-r-0" style="display: none">
                        <label for="epm-delete"></label>
                        <input class="form-control" name="employee-id" id="epm-delete" type="text" value=""/>
                    </div>
                    <div class="form-group pd-r-0" style="display: none">
                        <label for="ac-delete"></label>
                        <input class="form-control" name="account-id" id="ac-delete" type="text" value=""/>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group form-group-w-100">
                                <label for="firstname" class="form-label">First Name</label>
                                <input class="form-control" name="first_name" id="firstname" type="text" value=""
                                       placeholder="First Name"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group form-group-w-100">
                                <label for="lastname" class="form-label">Last Name</label>
                                <input class="form-control" name="last_name" id="lastname" type="text" value=""
                                       placeholder="Last Name"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="date" class="form-label">Date of birth</label>
                        <input class="form-control" name="date" id="date" type="date" value=""/>
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="phone-number" class="form-label">Phone number</label>
                        <input class="form-control" name="phone" id="phone-number" type="text" value=""
                               placeholder="Phone number"/>
                    </div>
                    <div class="form-group pd-r-0">
                        <label for="department-dle" class="form-label">Department</label>
                        <select name="department" id="department-dle"
                                class="department form-control form-select form-select-lg">
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status-dle" class="form-label d-block">Status</label>
                        <input type="checkbox" class="margin-right gender-check" id="status-dle" name="status"
                               value="1">
                        <label for="status-dle">Active</label>
                    </div>
                    <div class="form-group">
                        <label for="email-dle" class="form-label">Email</label>
                        <input type="text" required name="email" id="email-dle" placeholder="Email" maxlength="50"
                               class="form-control">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="d-flex align-items-center m-1">
                            <label for="female-dle"></label>
                            <input type="radio" class="margin-right gender-check" id="female-dle" name="gender"
                                                                   value="1">
                            <label for="male-dle">Female</label>
                            <input type="radio" class="gender-check margin-right d-block" id="male-dle"
                                                                 name="gender" value="0">
                            <label for="male-dle">Male</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password-dle" class="form-label">Password</label>
                        <input type="password" name="password" maxlength="100" class="form-control"
                                                                 id="password-dle" placeholder="Password" value="">
                        <span class="error-message"></span>
                    </div>
                    <div class="form-group">
                        <label for="account-dle" class="form-label">Account</label>
                        <label for="account-dle"></label>
                        <input type="text" name="account" maxlength="50" id="account-dle"
                                                                placeholder="Account" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="remark-delete" class="form-label">Remark</label>
                        <textarea name="remark" id="remark-delete" class="form-control" cols="30"
                                  rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="address-delete" class="form-label">Address</label>
                        <textarea name="address" id="address-delete" maxlength="50" class="form-control" cols="30"
                                  rows="10"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="btn-delete" class="btn btn-lg btn-primary">Delete</button>
                </div>

            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/assets/js/cms.js"></script>
<script src="${pageContext.request.contextPath}/resource/assets/js/add_employee.js"></script>

</body>
</html>
