<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lịch sử giao dich</title>
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
                </div>
                <div class="col-4">
                    <nav aria-label="breadcrumb" >
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/home"><i class="fa-solid fa-house-chimney"></i> Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <i class="fa-solid fa-user"></i> Lịch sử giao dịch
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
                                    <h4>Lịch sử giao dich</h4>
                                </div>
                                <div class="row">
                                    <div class="col-6 ">
                                        <form>
                                            <div class="form-inline">
                                                <label for="size">Hiển thị: </label>
                                                <select class="form-control ml-2 mr-2" name="size" id="size" onchange="this.form.submit();">
                                                    <option value="5" <c:if test="${pageSize == 5}">selected</c:if>>5</option>
                                                    <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
                                                    <option value="15" <c:if test="${pageSize == 15}">selected</c:if>>15</option>
                                                    </select>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-2 "></div>
                                        <div class="col-4 ">
                                        <mvc:form action="${pageContext.request.contextPath}/search_transactionHistory" method="get">
                                            <div class="form-check-inline">
                                                <input type="text"
                                                       class="form-control" name="searchValue" id="searchValue" 
                                                       placeholder="Tìm kiếm tài khoản" value="${searchValue}">
                                                <button class="btn btn-dark"><i class="fas fa-search"></i></button>
                                            </div>
                                        </mvc:form>
                                    </div>          
                                </div>             
                                <table class="table table-bordered mt-3">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th scope="col">Ngày</th>
                                            <th scope="col">Nội dung</th>
                                            <th scope="col">Số tiền giao dịch</th>
                                            <th scope="col">Nhân viên</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${transactions != null}">
                                            <c:forEach var="t" items="${transactions.content}">
                                                <tr>
                                                    <td>${t.transactionDate}</td>
                                                    <td>${t.transactionContent}</td>
                                                    <td>
                                                        <p class="text-success" >
                                                            <c:if test="${t.transactionType == 'DEPOSIT_PAYMENT_ACCOUNT'}">  +<fmt:formatNumber  type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            <c:if test="${t.transactionType == 'DEPOSIT_SAVING_ACCOUNT'}"> +<fmt:formatNumber type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            </p>
                                                            <p class="text-danger" >
                                                            <c:if test="${t.transactionType == 'WITHDRAW_PAYMENT_ACCOUNT'}">  -<fmt:formatNumber type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            <c:if test="${t.transactionType == 'INTERNAL_TRANSFER_PAYMENT_ACCOUNT'}">  -<fmt:formatNumber type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            <c:if test="${t.transactionType == 'EXTERNAL_TRANSFER_PAYMENT_ACCOUNT'}">  -<fmt:formatNumber type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            <c:if test="${t.transactionType == 'WITHDRAW_SAVING_ACCOUNT'}"> -<fmt:formatNumber type="number" value="${t.transactionAmount}"/>.đ</c:if>
                                                            </p>
                                                        </td>
                                                        <td>${t.staff.staffName}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                                <c:if test="${transactions == null}">
                                    <h3 class="text-center">Không có lịch sử giao dịch nào</h3>
                                </c:if>
                                <c:if test="${transactions != null}">
                                    <div class="row paginate">
                                        <div class="col">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination">
                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                            <a class="page-link" 
                                                               href="${pageContext.request.contextPath}/<c:if test="${action == 'transactionHistory'}">transactionHistory?</c:if><c:if test="${action == 'search_transactionHistory'}">search_transactionHistory?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}"
                                                               aria-label="First">
                                                                <span aria-hidden="true">Trang đầu</span>
                                                            </a>
                                                        </li>
                                                    <c:forEach var="page" begin="1"  end="${totalPages}">
                                                        <li class="paginate_button page-item <c:if test="${currentPage == page}">active</c:if>">
                                                            <a href="${pageContext.request.contextPath}/<c:if test="${action == 'transactionHistory'}">transactionHistory?</c:if><c:if test="${action == 'search_transactionHistory'}">search_transactionHistory?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}" class="page-link">${page}</a>
                                                            </li>
                                                    </c:forEach>  
                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                            <a class="page-link" 
                                                               href="${pageContext.request.contextPath}/<c:if test="${action == 'transactionHistory'}">transactionHistory?</c:if><c:if test="${action == 'search_transactionHistory'}">search_transactionHistory?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}"
                                                               aria-label="Finally">
                                                                <span aria-hidden="true">Trang cuối</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                </c:if>
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
