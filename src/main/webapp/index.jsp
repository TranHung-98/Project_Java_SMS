<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CMS Page Login</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/assets/img/user-solid.svg" type="image/x-icon">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/responsive.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,400;0,500;1,400&display=swap" rel="stylesheet">
</head>

<body>
<div id="myModal" class="modal">
    <div class="modal__overlay"></div>
    <div class="modal__body">
        <div class="authen-form">
            <span><i class="fa-solid fa-xmark icon-close"></i></span>
            <div class="authen-form_title">
                <h2>Member Login</h2>
            </div>
            <div class="authen-form__container">
                <c:choose>
                    <c:when test="${empty loginError}">
                        <form action="login"  method="post"  id="login-form">
                            <div class="form-group-1"  id="user-name" >
                                <i class="fa-solid fa-user form-group-icon"></i>
                                <label for="username"></label>
                                <input class="form-input"
                                       type="text" name="username" id="username" placeholder="Username" value="" minlength="5" maxlength="50" >
                            </div>
                            <div class="error-message" data-target="username"></div>
                            <div class="form-group-1" id="pass">
                                <i class="fa-solid fa-lock form-group-icon"></i>
                                <label for="password"></label>
                                <input class="form-input ${empty msgError ? '' :  'error--border'}"
                                       type="password" name="password" id="password" placeholder="Password" value="" minlength="8" maxlength="50">
                            </div>
                            <div class="error-message" data-target="password"></div>

                            <button  class="button-bgr" id="login-user" type="button">Login</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="login"  method="post"  id="login-form">
                            <div class="form-group-1"  id="user-name" >
                                <i class="fa-solid fa-user form-group-icon"></i>
                                <label for="username"></label>
                                <input class="form-input ${empty loginError? '': 'error--border'}"
                                       type="text" name="username" id="username" placeholder="Username" value="" minlength="5" maxlength="50" >
                            </div>
                            <div class="error-message" data-target="username">
                                    ${empty userError ? '' :  'Username is incorrect!' }
                            </div>
                            <div class="form-group-1" id="pass">
                                <i class="fa-solid fa-lock form-group-icon"></i>
                                <label for="password"></label>
                                <input class="form-input ${empty loginError ? '' :  'error--border'}"
                                       type="password" name="password" id="password" placeholder="Password" value="" minlength="8" maxlength="50">
                            </div>
                            <div class="error-message" data-target="password">${empty passError ? '' :  'Password is incorrect!'}</div>

                            <button  class="button-bgr" id="login-user" type="button">Login</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="authen-form_click">
                <a href="#" target="_parent">Forgot Password?</a>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/assets/js/login.js"></script>
</body>

</html>



