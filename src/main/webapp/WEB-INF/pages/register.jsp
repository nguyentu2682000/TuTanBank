<%-- 
    Document   : register
    Created on : Oct 3, 2022, 10:38:03 PM
    Author     : henry
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta name="description" content="Responsive Admin Template" />
        <meta name="author" content="SmartUniversity" />
        <title>Register</title>
        <jsp:include page="../pages/include/login_css.jsp" />
    </head>

    <body>
        <div class="limiter">
            <div class="container-login100 page-background">
                <div class="wrap-login100">
                    <c:if test="${displayCheckAccountBySendMail == false}">
                        <c:url var="home" value="/" scope="request" />
                        <form class="login100-form validate-form" action="${pageContext.request.contextPath}/register" method="post">
                            <span class="login100-form-logo">
                                <img src="${pageContext.request.contextPath}/resources-management/images/banking.webp" alt="">
                            </span>
                            <span class="login100-form-title p-b-34 p-t-27">
                                Đăng ký
                            </span>
                            <c:if test="${message != null && message != ''}">
                                <div class="alert alert-danger" style="text-align: center">${message}</div>
                            </c:if>
                            <div class="row">
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập tên người dùng">
                                        <input class="input100" type="text" value="${customerName}" name="customerName" placeholder="Tên người dùng">
                                        <span class="focus-input100" data-placeholder="&#xf207;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhaapj số điển thoại">
                                        <input class="input100" type="number" value="${customerPhone}" name="customerPhone" placeholder="Số điện thoại">
                                        <span class="focus-input100" data-placeholder="&#xf207;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập tên đăng nhập">
                                        <input class="input100" type="text" value="${userName}" name="userName" placeholder="Tên đăng nhập">
                                        <span class="focus-input100" data-placeholder="&#xf207;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập email VD: email@domain.com">
                                        <input class="input100" type="email" value="${customerEmail}" name="customerEmail" placeholder="Email">
                                        <span class="focus-input100" data-placeholder="&#xf207;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập Mật khẩu VD:Abcd123@">
                                        <input class="input100" type="password"  name="password" placeholder="Mật khẩu">
                                        <span class="focus-input100" data-placeholder="&#xf191;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập xác minh mật khẩu">
                                        <input class="input100" type="password" name="passwordAgain" placeholder="Xác minh mật khẩu">
                                        <span class="focus-input100" data-placeholder="&#xf191;"></span>
                                    </div>
                                </div>
                                 <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập số CCCD ">
                                        <input class="input100" type="text" value="${CINumber}" name="CINumber" placeholder="Nhập số CCCD">
                                        <span class="focus-input100" data-placeholder="&#xf191;"></span>
                                    </div>
                                </div>
                                 <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập ngày đăng ký CCCD">
                                        <input class="input100" type="date" value="${issueDate}" name="issueDate" placeholder="Ngày đăng ký CCCD">
                                        <span class="focus-input100" data-placeholder="&#xf191;"></span>
                                    </div>
                                </div>
                                 <div class="col-lg-12 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập nói đăng ký CCCD">
                                        <input class="input100" type="text" name="issuePlace" value="${issuePlace}" placeholder="Nơi đăng ký CCCD">
                                        <span class="focus-input100" data-placeholder="&#xf191;"></span>
                                    </div>
                                </div>
                                <div class="col-lg-6 p-t-20">
                                    <div class="wrap-input100 validate-input" data-validate="Nhập captcha">
                                        <input class="input100" type="text" name="captcha" placeholder="captcha">
                                        <small class="form-text text-muted">${messageCaptcha}</small>
                                    </div>
                                </div>
                                <div class="col-lg-4 p-t-20">
                                    <div class="wrap"  data-validate="Nhập captcha">
                                        <span class="captchaform" id="displayCaptcha">${sessionScope.captcha}</span>
                                    </div>

                                </div>
                                <script>

                                    function change() {
                                        $.ajax({
                                            type: 'GET',
                                            contentType: "application/json",
                                            dataType: 'json',
                                            url: '${home}changeCaptRegister',
                                            success: function (e) {
                                            },
                                            error: function (e) {
                                                $("#displayCaptcha").load("${home}changeCaptRegister");
                                            }

                                        });
                                    }
                                </script>
                                <div class="col-lg-2 p-t-20 icon-holder">
                                    <a onclick="change()" class="nav-link nav-toggle">
                                        <i class="fa fa-refresh"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="container-login100-form-btn">
                                <button class="login100-form-btn">
                                    Tiếp tục
                                </button>
                            </div>
                            <div class="text-center p-t-90">
                                <a class="txt1" href="${pageContext.request.contextPath}/login">
                                    Bạn đã có tài khoản?
                                </a>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${displayCheckAccountBySendMail == true}">
                        <form class="login100-form validate-form" action="${pageContext.request.contextPath}/checkAccountBySendEmail" method="post" >
                            <span class="login100-form-logo">
                                <img src="${pageContext.request.contextPath}/resources-management/images/banking.webp" alt="">
                            </span>
                            <span class="login100-form-title p-b-34 p-t-27">
                                Xác thực
                            </span>
                            <c:if test="${message != null && message != ''}">
                                <div class="alert alert-danger" style="text-align: center">${message}</div>
                            </c:if>
                            <div></div>
                            <span style="color: #426BB5">Mã xác thực đã được gửi đến email: <spam class="alert-link">${Email}</spam></span>
                            <script>
                                function startTimer(duration, display) {
                                    var timer = duration,
                                            seconds;
                                    setInterval(function () {
                                        seconds = parseInt(timer % 60, 10);

                                        seconds = seconds < 10 ? "0" + seconds : seconds;

                                        display.textContent = seconds;

                                        if (--timer < 0) {
                                            timer = duration;
                                        }
                                        if (timer == 0) {
                                            window.location.href = 'view_register';
                                        }
                                    }, 1000);
                                }

                                window.onload = function () {
                                    var fifteenMinutes = 60 * 1,
                                            display = document.querySelector('#time');
                                    startTimer(fifteenMinutes, display);
                                };
                            </script>
                            <div class="form-group mt-3">
                                <input type="text" style="color: black;border: 1px solid gray;"  class="form-control form-control-lg" autocomplete="off"  name="codeRandomCheck" maxlength="6"placeholder="Codes" required>
                            </div>
                            <div class="container-login100-form-btn">
                                <span class="" style="color: #426BB5">Thời gian nhập mã còn:     <span class="" style="color: red" id="time"></span></span>
                            </div>
                            <div class="container-login100-form-btn mt-3">
                                <button class="login100-form-btn" type="submit">
                                    xác nhận 
                                </button>
                            </div>
                        </form>
                    </c:if>     
                </div>
            </div>
        </div>
        <jsp:include page="../pages/include/login_js.jsp" />
    </body>

</html>
