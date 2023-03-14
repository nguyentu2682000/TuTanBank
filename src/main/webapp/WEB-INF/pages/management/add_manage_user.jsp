<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
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

    <body class="page-header-fixed sidemenu-closed-hidelogo page-content-white page-md header-white dark-sidebar-color logo-dark none">
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
                                    <c:if test="${action == 'update_user'}" >
                                        <div class="page-title">Chỉnh sửa thông tin người dùng</div>
                                    </c:if> 
                                    <c:if test="${action == 'add_user' && 'add_user1' && 'add_user2'}" >
                                        <div class="page-title">Thêm người dùng</div>
                                    </c:if> 
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li><i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="index.html">Home</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li><a class="parent-item" href="${pageContext.request.contextPath}/management/viewManageUsers">Quảng lý người dùng</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <c:if test="${action == 'update_user'}" > 
                                        Chỉnh sửa người dùng
                                    </c:if>
                                    <c:if test="${action == 'add_user' && 'add_user1' && 'add_user2'}" > 
                                        <li class="active">Thêm người dùng</li>
                                        </c:if>

                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-box">
                                    <c:if test="${action == 'update_user'}" >
                                        <mvc:form Class="validate-form" action="${pageContext.request.contextPath}/updateUser" method="post">
                                            <div class="col-lg-6 p-t-20"> 
                                                <header>Sửa thông tin</header>
                                            </div>
                                            <div class="card-body ">
                                                <div class="row  center">
                                                    <div class="col-lg-12 p-t-20  "> 
                                                        <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                                                            <input class = "mdl-textfield__input" value="${userEdit.userName}"  
                                                                   type="text" name="userName" id="txtFullName" readonly>
                                                            <label class = "mdl-textfield__label">Tên người dùng</label>
                                                            <span class="required">${messageUser}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row ">
                                                    <div class="col-5 p-t-20 "></div>
                                                    <div class="col-3 p-t-20 "> 
                                                        <c:forEach items="${roles}" var="r">
                                                            <div class="checkbox checkbox-aqua">
                                                                <input id="${r.roleName}" name="roleUsers" type="checkbox" value="${r.id}"
                                                                       <c:if test="${r.existRoleUser == true}">checked</c:if>
                                                                       <c:if test="${r.roleName == 'ROLE_CUSTOMER'}" >disabled checked</c:if>  >
                                                                <label for="${r.roleName}">
                                                                    <c:if test="${r.roleName == 'ROLE_ADMIN'}" >Quản trị viên</c:if>
                                                                    <c:if test="${r.roleName == 'ROLE_CUSTOMER'}" >Khách hàng</c:if>
                                                                    <c:if test="${r.roleName == 'ROLE_STAFF'}" >Giao dịch viên</c:if>
                                                                    </label>
                                                                </div>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="col-4 p-t-20 "></div>
                                                    <div class="col-lg-12 p-t-20 text-center"> 
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/updateCustomer'" type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-pink">lưu</button>
                                                        <a href="${pageContext.request.contextPath}/management/viewManageUsers" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                                    </div>
                                                </mvc:form>
                                            </div>
                                        </c:if>
                                        <c:if test="${action == 'add_user'}" >
                                            <mvc:form class="form-horizontal"  action="${pageContext.request.contextPath}/addUser" method="POST" 
                                                      modelAttribute="user">
                                                <div class="card-head">
                                                    <header>+ Thêm người dùng</header>
                                                </div>
                                                <div class="card-body row">
                                                    <div class="col-lg-12 p-t-20"> 
                                                        <header>Thông tin khách hàng</header>
                                                    </div>
                                                    <div class="col-lg-6  p-t-20"> 
                                                        <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập tên người dùng">
                                                            <input class = "mdl-textfield__input" name="userName" value="${userName}"
                                                                   type="text" id="txtFullName" <c:if test="${action == 'add_user1'}">disabled</c:if>>
                                                                   <label class = "mdl-textfield__label">Tên người dùng</label>
                                                            </div>
                                                            <span class="required text-danger">${messageUser}</span>
                                                        <span class="required text-danger"><mvc:errors path="userName"/></span>
                                                    </div>

                                                    <div class="col-lg-6 p-t-20"> 
                                                        <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập mật khẩu">
                                                            <input class = "mdl-textfield__input" name="password" type="password" value="" id="password">
                                                            <label class = "mdl-textfield__label">Password</label>
                                                        </div>
                                                        <span class="required text-danger">${messagePass}</span>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 p-t-20 text-center"> 
                                                    <button  type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-facebook"> Tiếp theo </button>
                                                    <a href="${pageContext.request.contextPath}/admin/viewManageUsers" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                                </div>
                                            </mvc:form>
                                        </c:if>
                                        <c:if test="${action == 'add_user1'}">
                                            <form class="form-horizontal"  action="${pageContext.request.contextPath}/addUser1"
                                                  method="POST" >
                                                <div class=" col-lg-12 p-t-20 "> 
                                                    <div class="col-lg-12 p-t-20"> 
                                                        <header>Cấp quền :</header>
                                                    </div>
                                                    <div class=" col-lg-12 p-t-20 d-flex"> 
                                                        <div class=" col-lg-4 p-t-20"> 
                                                            <c:forEach items="${roles}" var="r">
                                                                <div class="checkbox checkbox-aqua">
                                                                    <input id="${r.roleName}" name="roleUsers" type="checkbox" value="${r.id}"
                                                                           <c:if test="${r.roleName == 'ROLE_CUSTOMER'}" >disabled checked</c:if>  >
                                                                    <label for="${r.roleName}">
                                                                        <c:if test="${r.roleName == 'ROLE_ADMIN'}" >Quản trị viên</c:if>
                                                                        <c:if test="${r.roleName == 'ROLE_CUSTOMER'}" >Khách hàng</c:if>
                                                                        <c:if test="${r.roleName == 'ROLE_STAFF'}" >Giao dịch viên</c:if>
                                                                        </label>
                                                                    </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-12 p-t-20 text-center"> 
                                                    <button  type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-facebook"> Tiếp theo </button>
                                                    <a href="${pageContext.request.contextPath}/management/viewManageUsers" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                                </div>
                                            </form>
                                        </c:if>
                                        <div class="card-body ">
                                            <c:if test="${action == 'add_user2'}" >
                                                <mvc:form class="form-horizontal"  action="${pageContext.request.contextPath}/addUser2" method="POST" 
                                                          modelAttribute="customer">
                                                    <div class="col-lg-12 p-t-20"> 
                                                        <header>Thông tin khách hàng</header>
                                                    </div>
                                                    <div class="card-body row">
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập tên khách hàng">
                                                                <input class="mdl-textfield__input " name="customerName" value="${customer.customerName}"  type="text" id="txtFullName">
                                                                <label class = "mdl-textfield__label">Tên </label>
                                                            </div>
                                                            <span class="required text-danger">${mesCtName}</span>
                                                            <span class="required text-danger"><mvc:errors path="customerName"/></span>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập email">
                                                                <input class = "mdl-textfield__input" name="customerEmail" value="${customer.customerEmail}"  type="email" id="txtemail" >
                                                                <label class = "mdl-textfield__label" >Email</label>
                                                                <span class = "mdl-textfield__error">Enter Valid Email Address!</span>
                                                            </div>
                                                            <span class="required text-danger">${messEmail}</span>
                                                            <span class="required text-danger"><mvc:errors path="customerEmail"/></span>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập ngày sinh">
                                                                <input class = "mdl-textfield__input" name="BirthDate" value="${customer.BirthDate}"  type="text" id="date" >
                                                                <label class = "mdl-textfield__label" >Ngày sinh</label>
                                                            </div>
                                                            <span class="required text-danger"></span>
                                                        </div>

                                                        <div class="col-lg-6 p-t-20">
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập số điện thoại">
                                                                <input class = "mdl-textfield__input" 
                                                                       name="customerPhone"
                                                                       type = "number"  pattern = "-?[0-9]*(\.[0-9]+)?" value="${customer.customerPhone}" id="text5">
                                                                <label class = "mdl-textfield__label" for = "text5">Số điện thoại</label>
                                                                <span class = "mdl-textfield__error">Number required!</span>
                                                            </div>
                                                            <span class="required text-danger">${messphone}</span>
                                                            <span class="required text-danger"><mvc:errors path="customerPhone"/></span>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                                <label for="sample4" class="mdl-textfield__label">Quốc tịch</label>
                                                                <select class="mdl-textfield__input" id="sample4" name="nation" readonly tabIndex="-1">
                                                                    <c:forEach var="nation" items="${nations}">
                                                                        <option class="mdl-menu__item" value="${nation}">
                                                                            ${nation}</option>
                                                                        </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                                <label for="sample2" class="mdl-textfield__label">Giới tính</label>
                                                                <select class="mdl-textfield__input" name="gender" >
                                                                    <c:forEach var="g" items="${genders}">
                                                                        <option value="${g}">
                                                                            <c:if test="${g == 'MALE'}">Nam</c:if>
                                                                            <c:if test="${g == 'FEMALE'}">Nữ</c:if>
                                                                            <c:if test="${g == 'OTHER'}">khác</c:if>
                                                                            </option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập địa chỉ của khách hàng">
                                                                <input class = "mdl-textfield__input" name="customerAddress" value="${customer.customerAddress}" name="customerAddress" type="text" id="txtaddress">
                                                                <label class = "mdl-textfield__label">Địa chỉ </label>
                                                                <span class="required text-danger"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12 p-t-20"> 
                                                            <header>Thông tin căn cước công dân</header>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20">
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập số căn cước công dân">
                                                                <input class = "mdl-textfield__input" 
                                                                       name="CINumber"
                                                                       type = "text"  id="text6" value="${customer.CINumber}">
                                                                <label class = "mdl-textfield__label" >Số căn cước công dân </label>
                                                            </div>
                                                            <span class="required text-danger">${messCINumber}</span>
                                                            <span class="required text-danger"><mvc:errors path="CINumber"/></span>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập nhập ngày cấp căn cươc công dân">
                                                                <input class = "mdl-textfield__input" name="issueDate"  value="${customer.issueDate}" type="text" id="date2">   
                                                                <label class = "mdl-textfield__label"> Ngày cấp </label> 
                                                                <span class="required text-danger"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6 p-t-20"> 
                                                            <div class = "mdl-textfield mdl-js-textfield mdl-textfield--floating-label txt-full-width validate-input" data-validate="Nhập nơi cấp căn cước công dân">
                                                                <input class = "mdl-textfield__input" name="issuePlace" value="${customer.issuePlace}"  type="text" >
                                                                <label class = "mdl-textfield__label">Nơi cấp</label>
                                                            </div>
                                                            <span class="required text-danger"><mvc:errors path="issuePlace"/></span>
                                                        </div>

                                                    </div>
                                                    <div class="col-lg-12 p-t-20 text-center"> 
                                                        <button  type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-facebook"> Thêm </button>
                                                        <a href="${pageContext.request.contextPath}/management/viewManageUsers" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                                    </div>
                                                </mvc:form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <!-- end page content -->
                    <!-- start chat sidebar -->
                    <div class="chat-sidebar-container" data-close-on-body-click="false">
                        <div class="chat-sidebar">
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a href="#quick_sidebar_tab_1" class="nav-link active tab-icon" data-toggle="tab">Theme
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="#quick_sidebar_tab_2" class="nav-link tab-icon" data-toggle="tab"> Chat
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="#quick_sidebar_tab_3" class="nav-link tab-icon" data-toggle="tab">  Settings
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane chat-sidebar-settings in show active animated shake" role="tabpanel" id="quick_sidebar_tab_1">
                                    <div class="slimscroll-style">
                                        <div class="theme-light-dark">
                                            <h6>Sidebar Theme</h6>
                                            <button type="button" data-theme="white" class="btn lightColor btn-outline btn-circle m-b-10 theme-button">Light Sidebar</button>
                                            <button type="button" data-theme="dark" class="btn dark btn-outline btn-circle m-b-10 theme-button">Dark Sidebar</button>
                                        </div>
                                        <div class="theme-light-dark">
                                            <h6>Sidebar Color</h6>
                                            <ul class="list-unstyled">
                                                <li class="complete">
                                                    <div class="theme-color sidebar-theme">
                                                        <a href="#" data-theme="white"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="dark"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="blue"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="indigo"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="cyan"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="green"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="red"><span class="head"></span><span class="cont"></span></a>
                                                    </div>
                                                </li>
                                            </ul>
                                            <h6>Header Brand color</h6>
                                            <ul class="list-unstyled">
                                                <li class="theme-option">
                                                    <div class="theme-color logo-theme">
                                                        <a href="#" data-theme="logo-white"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-dark"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-blue"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-indigo"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-cyan"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-green"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="logo-red"><span class="head"></span><span class="cont"></span></a>
                                                    </div>
                                                </li>
                                            </ul>
                                            <h6>Header color</h6>
                                            <ul class="list-unstyled">
                                                <li class="theme-option">
                                                    <div class="theme-color header-theme">
                                                        <a href="#" data-theme="header-white"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-dark"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-blue"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-indigo"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-cyan"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-green"><span class="head"></span><span class="cont"></span></a>
                                                        <a href="#" data-theme="header-red"><span class="head"></span><span class="cont"></span></a>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- Start Doctor Chat -->
                                <div class="tab-pane chat-sidebar-chat animated slideInRight" id="quick_sidebar_tab_2">
                                    <div class="chat-sidebar-list">
                                        <div class="chat-sidebar-chat-users slimscroll-style" data-rail-color="#ddd" data-wrapper-class="chat-sidebar-list">
                                            <div class="chat-header">
                                                <h5 class="list-heading">Online</h5>
                                            </div>
                                            <ul class="media-list list-items">
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user3.jpg" width="35" height="35" alt="...">
                                                    <i class="online dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">John Deo</h5>
                                                        <div class="media-heading-sub">Spine Surgeon</div>
                                                    </div>
                                                </li>
                                                <li class="media">
                                                    <div class="media-status">
                                                        <span class="badge badge-success">5</span>
                                                    </div> <img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user1.jpg" width="35" height="35" alt="...">
                                                    <i class="busy dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Rajesh</h5>
                                                        <div class="media-heading-sub">Director</div>
                                                    </div>
                                                </li>
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user5.jpg" width="35" height="35" alt="...">
                                                    <i class="away dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Jacob Ryan</h5>
                                                        <div class="media-heading-sub">Ortho Surgeon</div>
                                                    </div>
                                                </li>
                                                <li class="media">
                                                    <div class="media-status">
                                                        <span class="badge badge-danger">8</span>
                                                    </div> <img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user4.jpg" width="35" height="35" alt="...">
                                                    <i class="online dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Kehn Anderson</h5>
                                                        <div class="media-heading-sub">CEO</div>
                                                    </div>
                                                </li>
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user2.jpg" width="35" height="35" alt="...">
                                                    <i class="busy dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Sarah Smith</h5>
                                                        <div class="media-heading-sub">Anaesthetics</div>
                                                    </div>
                                                </li>
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user7.jpg" width="35" height="35" alt="...">
                                                    <i class="online dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Vlad Cardella</h5>
                                                        <div class="media-heading-sub">Cardiologist</div>
                                                    </div>
                                                </li>
                                            </ul>
                                            <div class="chat-header">
                                                <h5 class="list-heading">Offline</h5>
                                            </div>
                                            <ul class="media-list list-items">
                                                <li class="media">
                                                    <div class="media-status">
                                                        <span class="badge badge-warning">4</span>
                                                    </div> <img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user6.jpg" width="35" height="35" alt="...">
                                                    <i class="offline dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Jennifer Maklen</h5>
                                                        <div class="media-heading-sub">Nurse</div>
                                                        <div class="media-heading-small">Last seen 01:20 AM</div>
                                                    </div>
                                                </li>
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user8.jpg" width="35" height="35" alt="...">
                                                    <i class="offline dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Lina Smith</h5>
                                                        <div class="media-heading-sub">Ortho Surgeon</div>
                                                        <div class="media-heading-small">Last seen 11:14 PM</div>
                                                    </div>
                                                </li>
                                                <li class="media">
                                                    <div class="media-status">
                                                        <span class="badge badge-success">9</span>
                                                    </div> <img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user9.jpg" width="35" height="35" alt="...">
                                                    <i class="offline dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Jeff Adam</h5>
                                                        <div class="media-heading-sub">Compounder</div>
                                                        <div class="media-heading-small">Last seen 3:31 PM</div>
                                                    </div>
                                                </li>
                                                <li class="media"><img class="media-object" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user10.jpg" width="35" height="35" alt="...">
                                                    <i class="offline dot"></i>
                                                    <div class="media-body">
                                                        <h5 class="media-heading">Anjelina Cardella</h5>
                                                        <div class="media-heading-sub">Physiotherapist</div>
                                                        <div class="media-heading-small">Last seen 7:45 PM</div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="chat-sidebar-item">
                                        <div class="chat-sidebar-chat-user">
                                            <div class="page-quick-sidemenu">
                                                <a href="javascript:;" class="chat-sidebar-back-to-list">
                                                    <i class="fa fa-angle-double-left"></i>Back
                                                </a>
                                            </div>
                                            <div class="chat-sidebar-chat-user-messages">
                                                <div class="post out">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/dp.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Kiran Patel</a> <span class="datetime">9:10</span>
                                                        <span class="body-out"> could you send me menu icons ? </span>
                                                    </div>
                                                </div>
                                                <div class="post in">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user5.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Jacob Ryan</a> <span class="datetime">9:10</span>
                                                        <span class="body"> please give me 10 minutes. </span>
                                                    </div>
                                                </div>
                                                <div class="post out">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/dp.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Kiran Patel</a> <span class="datetime">9:11</span>
                                                        <span class="body-out"> ok fine :) </span>
                                                    </div>
                                                </div>
                                                <div class="post in">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user5.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Jacob Ryan</a> <span class="datetime">9:22</span>
                                                        <span class="body">Sorry for
                                                            the delay. i sent mail to you. let me know if it is ok or not.</span>
                                                    </div>
                                                </div>
                                                <div class="post out">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/dp.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Kiran Patel</a> <span class="datetime">9:26</span>
                                                        <span class="body-out"> it is perfect! :) </span>
                                                    </div>
                                                </div>
                                                <div class="post out">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/dp.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Kiran Patel</a> <span class="datetime">9:26</span>
                                                        <span class="body-out"> Great! Thanks. </span>
                                                    </div>
                                                </div>
                                                <div class="post in">
                                                    <img class="avatar" alt="" src="${pageContext.request.contextPath}/resources-management/assets/img/user/user5.jpg" />
                                                    <div class="message">
                                                        <span class="arrow"></span> <a href="javascript:;" class="name">Jacob Ryan</a> <span class="datetime">9:27</span>
                                                        <span class="body"> it is my pleasure :) </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat-sidebar-chat-user-form">
                                                <div class="input-group">
                                                    <input type="text" class="form-control" placeholder="Type a message here...">
                                                    <div class="input-group-btn">
                                                        <button type="button" class="btn deepPink-bgcolor">
                                                            <i class="fa fa-arrow-right"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- End Doctor Chat -->
                                <!-- Start Setting Panel -->
                                <div class="tab-pane chat-sidebar-settings animated slideInUp" id="quick_sidebar_tab_3">
                                    <div class="chat-sidebar-settings-list slimscroll-style">
                                        <div class="chat-header">
                                            <h5 class="list-heading">Layout Settings</h5>
                                        </div>
                                        <div class="chatpane inner-content ">
                                            <div class="settings-list">
                                                <div class="setting-item">
                                                    <div class="setting-text">Sidebar Position</div>
                                                    <div class="setting-set">
                                                        <select class="sidebar-pos-option form-control input-inline input-sm input-small ">
                                                            <option value="left" selected="selected">Left</option>
                                                            <option value="right">Right</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Header</div>
                                                    <div class="setting-set">
                                                        <select class="page-header-option form-control input-inline input-sm input-small ">
                                                            <option value="fixed" selected="selected">Fixed</option>
                                                            <option value="default">Default</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Sidebar Menu </div>
                                                    <div class="setting-set">
                                                        <select class="sidebar-menu-option form-control input-inline input-sm input-small ">
                                                            <option value="accordion" selected="selected">Accordion</option>
                                                            <option value="hover">Hover</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Footer</div>
                                                    <div class="setting-set">
                                                        <select class="page-footer-option form-control input-inline input-sm input-small ">
                                                            <option value="fixed">Fixed</option>
                                                            <option value="default" selected="selected">Default</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat-header">
                                                <h5 class="list-heading">Account Settings</h5>
                                            </div>
                                            <div class="settings-list">
                                                <div class="setting-item">
                                                    <div class="setting-text">Notifications</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-1">
                                                                <input type = "checkbox" id = "switch-1" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Show Online</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-7">
                                                                <input type = "checkbox" id = "switch-7" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Status</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-2">
                                                                <input type = "checkbox" id = "switch-2" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">2 Steps Verification</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-3">
                                                                <input type = "checkbox" id = "switch-3" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="chat-header">
                                                <h5 class="list-heading">General Settings</h5>
                                            </div>
                                            <div class="settings-list">
                                                <div class="setting-item">
                                                    <div class="setting-text">Location</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-4">
                                                                <input type = "checkbox" id = "switch-4" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Save Histry</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-5">
                                                                <input type = "checkbox" id = "switch-5" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="setting-item">
                                                    <div class="setting-text">Auto Updates</div>
                                                    <div class="setting-set">
                                                        <div class="switch">
                                                            <label class="mdl-switch mdl-js-switch mdl-js-ripple-effect" for="switch-6">
                                                                <input type = "checkbox" id = "switch-6" 
                                                                       class = "mdl-switch__input" checked>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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