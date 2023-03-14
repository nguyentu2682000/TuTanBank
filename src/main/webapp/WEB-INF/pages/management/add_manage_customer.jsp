<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html >
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta name="description" content="Responsive Admin Template" />
        <meta name="author" content="SmartUniversity" />
        <title></title>
        <!-- google font -->
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css" />
        <jsp:include page="../include/css.jsp" />
    </head>
    <!-- END HEAD -->

    <body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-sidebar-color logo-dark">
        <div class="page-wrapper">
            <!-- start header -->
            <jsp:include page="../include/header.jsp" />
            <!-- end header -->
            <!-- start page container -->
            <div class="page-container">
                <!-- start sidebar menu -->
                <jsp:include page="../include/menu.jsp" />
                <!-- end sidebar menu -->
                <!-- start page content -->
                <div class="page-content-wrapper">
                    <div class="page-content">
                        <div class="page-bar">
                            <div class="page-title-breadcrumb">
                                <div class=" pull-left">
                                    <div class="page-title">Khách hàng</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li><i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="index.html">Home</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li><a class="parent-item" href="">Quảng lý khách hàng</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li class="active">Sủa thông tin khách hàng</li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-box">
                                    <mvc:form action="${pageContext.request.contextPath}/updateCustomer" method="post"
                                              modelAttribute="customer" >
                                        <div class="card-head">
                                            <header>Sửa thông tin khách hàng</header>
                                        </div>
                                        <input type="text" name="id" value="${customer.id}" hidden="">
                                        <input type="text" name="user.id" value="${customer.user.id}" hidden="">   

                                        <div class="card-body row">
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" name="customerName" value="${customer.customerName}"  type="text" id="txtFullName">
                                                    <label class = "mdl-textfield__label">Tên </label>
                                                    <span class="required"><mvc:errors path="customerName"/></span>
                                                </div>
                                            </div>

                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" name="customerEmail" value="${customer.customerEmail}" type="email" id = "txtemail">
                                                    <label class = "mdl-textfield__label" >Email</label>
                                                    <span class = "mdl-textfield__error">Enter Valid Email Address!</span>
                                                    <span class="required"><mvc:errors path="customerEmail"/></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" value="${customer.birthDate}" name="birthDate"  type="text" id="date" >
                                                    <label class = "mdl-textfield__label" >Ngày sinh</label>
                                                    <span class="required"><mvc:errors path="birthDate"/></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" 
                                                           value="${customer.customerPhone}" name="customerPhone"
                                                           type = "number"  pattern = "-?[0-9]*(\.[0-9]+)?" id = "text5" >
                                                    <label class = "mdl-textfield__label" for = "text5">Số điện thoại</label>
                                                    <span class = "mdl-textfield__error">Number required!</span>
                                                    <span class="required"><mvc:errors path="customerPhone" /></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                    <label for="sample2" class="mdl-textfield__label">Giới tính</label>
                                                    <select class="mdl-textfield__input" name="gender" >
                                                        <c:forEach var="g" items="${gender}">
                                                            <option value="${g}" <c:if test="${g == customer.gender}">selected</c:if> >
                                                                <c:if test="${g == 'MALE'}">Nam</c:if>
                                                                <c:if test="${g == 'FEMALE'}">Nữ</c:if>
                                                                <c:if test="${g == 'OTHER'}">khác</c:if>
                                                                </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                    <label for="sample4" class="mdl-textfield__label">Quốc tịch</label>
                                                    <select class="mdl-textfield__input" id="sample4" name="nation" readonly tabIndex="-1">
                                                        <c:forEach var="nation" items="${nation}">
                                                            <option class="mdl-menu__item" value="${nation}" <c:if test="${nation == customer.nation}">selected</c:if>>
                                                                ${nation}</option>
                                                            </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" name="customerAddress" value="${customer.customerAddress}" name="customerAddress" type="text" id="txtaddress" >
                                                    <label class = "mdl-textfield__label">Địa chỉ </label>
                                                    <span class="required"><mvc:errors path="customerAddress"/></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 p-t-20"> 
                                                <header>Thông tin căn cước công dân</header>
                                            </div>
                                            <div class="col-lg-6 p-t-20">
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" 
                                                           value="${customer.CINumber}" name="CINumber"
                                                           type = "text"  id = "text6" readonly>
                                                    <label class = "mdl-textfield__label" >Số căn cước công dân </label>
                                                    <span class="required"><mvc:errors path="CINumber" /></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" value="${customer.issueDate}" name="issueDate"  type="text" id="date2" readonly>   
                                                    <label class = "mdl-textfield__label" >Ngày cấp</label> 
                                                    <span class="required"><mvc:errors path="issueDate"/></span>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 p-t-20"> 
                                                <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width">
                                                    <input class = "mdl-textfield__input" name="issuePlace" value="${customer.issuePlace}"  type="text" >
                                                    <label class = "mdl-textfield__label">Nơi cấp</label>
                                                    <span class="required"><mvc:errors path="issuePlace"/></span>
                                                </div>
                                            </div>

                                            <div class="col-lg-12 p-t-20 text-center"> 
                                                <button onclick="location.href = '${pageContext.request.contextPath}/updateCustomer'" type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-instagram">Lưu</button>
                                                <a href="${pageContext.request.contextPath}/viewManageCustomer" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                            </div>
                                        </div>
                                    </mvc:form>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <!-- end page content -->
                <!-- start chat sidebar -->

                <!-- end chat sidebar -->
            </div>
            <!-- end page container -->
            <!-- start footer -->
            <jsp:include page="../include/footer.jsp" />
            <!-- end footer -->
        </div>
        <!-- start js include path -->
        <jsp:include page="../include/js.jsp" />
        <!-- end js include path -->
    </body>

</html>