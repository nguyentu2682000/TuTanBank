<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý thông tin</title>
        <!-- Required meta tags -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/icon/banking.webp" />
        <!-- Bootstrap CSS -->
        <link
            rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
            crossorigin="anonymous"
            />
        <link rel="stylesheet" href="<c:url value="/resources/style/fontawesome-free-6.2.0-web/css/all.min.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/fragment/header.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/fragment/header_responsive.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/fragment/footer.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/fragment/footer_responsive.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/css/external_transfer.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/external_transfer_responsive.css" />" />
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js"/>"></script>
    </head>
    <body>
        <jsp:include page="fragment/header.jsp" />
        <c:url var="home" value="/" scope="request" />
        <div class="container-fluid content">
            <div class="row">
                <div class="col-2">
                    &nbsp;
                </div>
                <div class="col-6 mt-3">
                    <h5 class="text-center">Quản lý thông tin</h5>
                </div>
                <div class="col-4">
                    <nav aria-label="breadcrumb" >
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house-chimney"></i> Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <i class="fa-solid fa-user"></i> Quản lý thông tin
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="container contentForm">
                <div class="row transactionContent justify-content-center">
                    <div class="col-2 mr-4 text-left" >
                        <div class="row">
                            <div class="col">
                                <h6>Cá nhân</h6>
                                 <a class="btn mt-1" href="${pageContext.request.contextPath}/profileManager">Thông tin tài khoản &nbsp; &nbsp;</a>
                                <a class="btn mt-1" href="${pageContext.request.contextPath}/transactionHistory">Lịch sử giao dịch &nbsp; &nbsp; &nbsp;</a>
                                <a class="btn mt-1" href="${pageContext.request.contextPath}/viewInternalTransfer">Chuyển tiền nội ngân hàng</a>
                                <a class="btn mt-1" href="${pageContext.request.contextPath}/viewExternalTransfer">Chuyển tiền liên ngân hàng</a>
                                <a class="btn mt-1" href="#">Mở tài khoản ngân hàng</a>
                            </div>
                        </div>
                        <hr style="border: 2px solid gray;">
                        <div class="row mb-5">
                            <div class="col">
                                <h6>Công cụ</h6>
                                <a class="btn mt-1" href="${pageContext.request.contextPath}/loanCalculation">Tính khoản vay &nbsp; &nbsp; &nbsp;</a> <br>
                                <a class="btn mt-1" href="${pageContext.request.contextPath}/home">Tính tỷ giá &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-9" style="margin-top: 44px">

                        <div class="row enterInfo justify-content-center">
                            <div class="col-12" style="background: #ffffff">
                                
                                <div class="form-group mt-3">
                                    <h4>Thông tin tài khoản</h4>
                                </div>
                                <div class="form-group">
                                    <label for="bankId">Tên tài khoản: </label>
                                    <input type="text" class="form-control" va id="receiveAccount"
                                           value="${user.userName}"  disabled>
                                </div>
                                <div class="form-group mt-3">
                                    <form action="${pageContext.request.contextPath}/chagePasswordUser" method="POST">
                                        <label >Đỗi mật khẩu:  </label>
                                        <input type="password" class="form-control" name="oldPassword" 
                                               placeholder="Mật khẩu hiện tại" >
                                        <span class="form-text text-danger">${messOldPass}</span>

                                        <input type="password" class="form-control" name="password" id="receiveAccount"
                                               placeholder="Mật khẩu mới" >
                                        <span class="form-text text-danger">${messPass}</span>

                                        <input type="password" class="form-control" name="resetPassword" id="receiveAccount"
                                               placeholder="Xác nhận mật khẩu"  >
                                        <span class="form-text text-danger">${messResetPass}</span>
                                        <div class="row nextButton mb-3 text-center">
                                            <c:if test="${successfulMess != null}">
                                            <div class="col-12">
                                                <span class="text-success">${successfulMess}<i class="fa-solid fa-check"></i></span>
                                            </div>
                                            </c:if>
                                            <div class="col mt-1    "> 
                                                <button class="btn">
                                                    Lưu thay đổi</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="form-group mt-3">
                                    <h4>Thông tin cá nhân</h4>
                                </div>
                                <div class="form-group mt-3 p-t-20">
                                    <form action="${pageContext.request.contextPath}/emailAuthentication" method="POST">
                                        <label>Email: </label>
                                        <input type="email" class="form-control" value="${user.customer.customerEmail}" name="email" autocomplete="off">
                                        <div class="col-12 p-t-20  text-center">
                                            <span class="text-danger">${messageCeError}</span>
                                            <span class="text-success">${messageSus}</span>
                                        </div>
                                        <c:if test="${check != true}">
                                            <div class="row nextButton mb-3 text-center mt-3">
                                                <div class="col">
                                                    <button class="btn">Lưu và xác thực</button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </form>
                                </div>
                                <c:if test="${check == true}">
                                    <form action="${pageContext.request.contextPath}/checkEmailAndUpdate" method="POST">
                                        <div class="form-group">
                                            <label for="confirmCode">Nhập mã xác nhận (Hiệu lực mã xác nhận có giá trị 1 phút ): <span
                                                    id="time">01:00</span> minutes!</label>
                                            <input type="text" class="form-control" name="confirmCode" id="confirmCode"
                                                   placeholder="Mã xác nhận đã được gửi tới email của bạn!">
                                            <script>
                                                function startTimer(duration, display) {
                                                    var timer = duration,
                                                            minutes, seconds;
                                                    setInterval(function () {
                                                        minutes = parseInt(timer / 60, 10);
                                                        seconds = parseInt(timer % 60, 10);

                                                        minutes = minutes < 10 ? "0" + minutes : minutes;
                                                        seconds = seconds < 10 ? "0" + seconds : seconds;

                                                        display.textContent = minutes + ":" + seconds;

                                                        if (--timer < 0) {
                                                            timer = duration;
                                                            location.href = '${home}profileManager'
                                                        }
                                                    }, 1000);
                                                }

                                                window.onload = function () {
                                                    var oneMinutes = 60,
                                                            display = document.querySelector('#time');
                                                    startTimer(oneMinutes, display);
                                                };
                                            </script>
                                        </div> 
                                        <div class="row nextButton mb-3 text-center mt-3">
                                            <div class="col">
                                                <button class="btn">Kiểm tra</button>
                                            </div>
                                        </div>
                                    </form>
                                </c:if>    
                                <mvc:form action="${pageContext.request.contextPath}/customerSave" method="POST"
                                          modelAttribute="customer" >
                                    <div class="form-group">
                                        <label for="balanceTransfer">Tên: </label>
                                        <input type="text" class="form-control" 
                                               name="customerName" id="balanceTransfer"
                                               placeholder="Số tiền cần chuyển là bao nhiêu?" 
                                               value="${user.customer.customerName}">
                                        <small class="form-text text-muted">${customerName}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="contentTransfer">Ngày sinh: </label>
                                        <input class="form-control" type="date"  name="birthDate"   value="${user.customer.birthDate}"/>
                                        <small class="form-text text-muted">${messageContentTransfer}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="contentTransfer">Số điện thoại  : </label>
                                        <input class="form-control" type="number"  name="customerPhone"  value="${user.customer.customerPhone}"/>
                                        <small class="form-text text-muted">${messageContentTransfer}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="contentTransfer">Số CCCD : </label>
                                        <input class="form-control" type="number"  name="CINumber" disabled value="${user.customer.CINumber}"/>
                                        <small class="form-text text-muted">${messageContentTransfer}</small>
                                    </div>
                                    <div class="form-group">
                                        <label >Quốc tịch </label>
                                        <select class="form-control" name="nation"  >
                                            <c:forEach var="n" items="${nation}">
                                                <option value="${n}" <c:if test="${n == user.customer.nation}">selected</c:if>>${n}</option>
                                            </c:forEach>
                                        </select>
                                        <small class="form-text text-muted">${messageBank}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="bankId">Giới tính </label>
                                        <select class="form-control" name="gender" >
                                            <c:forEach var="g" items="${gender}">
                                                <option value="${g}" <c:if test="${g == user.customer.gender}">selected</c:if> >
                                                    <c:if test="${g == 'MALE'}">Nam</c:if>
                                                    <c:if test="${g == 'FEMALE'}">Nữ</c:if>
                                                    <c:if test="${g == 'OTHER'}">Giới tính khác</c:if>
                                                    </option>
                                            </c:forEach>
                                        </select>
                                        <small class="form-text text-muted">${messageBank}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="contentTransfer">Địa chỉ : </label>
                                        <input class="form-control" type="text"  name="customerAddress"  value="${user.customer.customerAddress}"/>
                                        <small class="form-text text-muted">${customerAddress}</small>
                                    </div>
                                    <div class="row nextButton mb-3 text-center">
                                        <div class="col">
                                            <button class="btn">Lưu </button>
                                        </div>
                                    </div>
                                </mvc:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="fragment/footer.jsp" />
        <jsp:include page="fragment/go_to_top.jsp" />
        <script
            src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"
        ></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    </body>
</html>
