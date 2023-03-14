<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sidebar-container">
    <div class="sidemenu-container navbar-collapse collapse fixed-menu">
        <div id="remove-scroll">
            <ul class="sidemenu page-header-fixed p-t-20" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
                <li class="sidebar-toggler-wrapper hide">
                    <div class="sidebar-toggler">
                        <span></span>
                    </div>
                </li>
                <li class="sidebar-user-panel">
                    <div class="user-panel">
                        <div class="row">
                            <div class="sidebar-userpic">
                                <img src="${pageContext.request.contextPath}/resources-management/assets/img/anh-avatar-dep-doc-dao.jpg" class="img-responsive" alt=""> </div>
                        </div>
                        <div class="profile-usertitle">
                            <div class="sidebar-userpic-name">${usernamelg}</div>
                        </div>
                        <div class="sidebar-userpic-btn">
                            <a class="tooltips" href="<c:url value="/profileManager"/>" data-placement="top" data-original-title="Profile">
                                <i class="material-icons">person_outline</i>
                            </a>
                            <a class="tooltips" href="${pageContext.request.contextPath}/logout" data-placement="top" data-original-title="Logout">
                                <i class="material-icons">input</i>
                            </a>
                        </div>
                    </div>
                </li>
                <sec:authorize access="isAuthenticated()">
<!--                <li class="menu-heading">
                    <span>-- Main</span>
                </li>
                    <li class="nav-item ">
                        <a href="index.html" class="nav-toggle">
                            <i class="material-icons">dashboard</i>
                            <span class="title">Bảng điều khiển</span>

                        </a>

                    </li>-->
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li class="menu-heading m-t-20">
                            <span>--Quản trị viên</span>
                        </li>

                        <li class="nav-item">
                            <a href="<c:url value="/management/viewManageUsers"/>" class="nav-link nav-toggle">
                                <i class="material-icons">account_box</i>
                                <span class="title">Quản lý người dùng</span>
                                <span class="selected"></span>
                                <span class="arrow open"></span>
                            </a>
                            <ul class="sub-menu">
                                <li>
                                    <a href="<c:url value="/addManageUser"/>" class="nav-link ">
                                        <span class="title">Thêm Người dùng</span>

                                    </a>
                                </li>
                                <li>
                                    <a href="<c:url value="/management/viewManageUsers?active=user"/>"   class="nav-link <c:if test="${active == 'user'}">active</c:if>">
                                        <span class="title">Xem tất cả người dùng</span>
                                    </a>
                                </li>
                            </ul>

                        </li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_STAFF')">
                        <li class="menu-heading m-t-20">
                            <span>--Nhân viên</span>
                        </li>
                        <li class="nav-item <c:if test="${action == 'deposit_for_customer'}">active</c:if>">
                            <a href="${pageContext.request.contextPath}/management/depositForCustomer" class="nav-link nav-toggle">
                                <i class="material-icons">attach_money</i>
                                <span class="title">Nạp tiền cho khách hàng</span>
                            </a>
                        </li>
                        <li class="nav-item start <c:if test="${action == 'managePaymentBankAccount' || action == 'manageSavingBankAccount' || action == 'manageExternalBankAccount'}">active</c:if>">
                                <a class="nav-link nav-toggle">
                                    <i class="material-icons">account_balance</i>
                                    <span class="title">Tài khoản ngân hàng</span>
                                    <span class="selected"></span>
                                    <span class="arrow open"></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item <c:if test="${nav == 'managePaymentBankAccount'}">active</c:if>">
                                    <a href="${pageContext.request.contextPath}/management/viewManageBankAccount?action=viewBankAccounts&nav=managePaymentBankAccount" class="nav-link ">
                                        <span class="title"><i class="fa-solid fa-credit-card"></i> Thanh toán</span>
                                    </a>
                                </li>
                                <li class="nav-item <c:if test="${nav == 'manageSavingBankAccount'}">active</c:if>">
                                    <a href="${pageContext.request.contextPath}/management/viewManageBankAccount?action=viewBankAccounts&nav=manageSavingBankAccount" class="nav-link ">
                                        <span class="title"><i class="fas fa-piggy-bank"></i> Tiết kiệm</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                <li class="nav-item <c:if test="${nav == 'manageExternalBankAccount'}">active</c:if>">
                                    <a href="${pageContext.request.contextPath}/management/viewManageBankAccount?action=viewBankAccounts&nav=manageExternalBankAccount" class="nav-link ">
                                        <span class="title"><i class="fa-solid fa-earth-americas"></i> Liên ngân hàng</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                <li class="nav-item <c:if test="${nav == 'manageUnActiveBankAccount'}">active</c:if>">
                                    <a href="${pageContext.request.contextPath}/management/viewManageBankAccount?action=viewBankAccounts&nav=manageUnActiveBankAccount" class="nav-link ">
                                        <span class="title"><i class="fa-solid fa-toggle-off"></i> Chưa hoạt
                                            động</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                                <li class="nav-item <c:if test="${nav == 'openOrEditBankAccount'}">active</c:if>">
                                    <a href="${pageContext.request.contextPath}/management/viewOpenOrEditBankAccount" class="nav-link ">
                                        <span class="title"><i class="fa-solid fa-plus"></i> Mở tài khoản</span>
                                        <span class="selected"></span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/transactions"/>" class="nav-link nav-toggle">
                                <i class="material-icons">autorenew</i>
                                <span class="title">Quản lý giao dịch</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value="/viewManageCustomer"/>" class="nav-link nav-toggle">
                                <i class="material-icons"> person</i>
                                <span class="title">Quản lý Khách hàng</span>

                            </a>

                        </li>
                        <li class="nav-item <c:if test="${active == 'Withdraw'}">active</c:if>">
                            <a href="<c:url value="/management/Withdraw?action=Withdraw"/>"  class="nav-link nav-toggle ">
                                <i class="material-icons">assignment_returned</i>
                                <span class="title">Rút tiền</span>
                            </a>
                        </li>
                    </sec:authorize>
                </sec:authorize>
            </ul>
        </div>
    </div>
</div>