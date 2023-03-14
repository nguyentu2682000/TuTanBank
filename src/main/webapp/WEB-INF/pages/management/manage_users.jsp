<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <div class="page-content" style="min-height: 1639px;">
                        <div class="page-bar">
                            <div class="page-title-breadcrumb">
                                <div class="pull-left">
                                    <div class="page-title">Quản lý khách hàng</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li>
                                        <i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="index.html">Home</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li class="active">Quản lý người dùng</li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>Quản lý người dùng</header>
                                        <div class="tools">
                                            <a class="fa fa-repeat btn-color box-refresh" href="javascript:;"></a>

                                        </div>
                                    </div>
                                    <div class="card-body ">
                                        <div class="row p-b-20">
                                            <div class="col-md-6 col-sm-6 col-6">
                                                <div class="btn-group">
                                                    <a href="<c:url value="/addManageUser"/>" id="addRow" class="btn btn-info">
                                                        Thêm người dùng <i class="fa fa-plus"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-sm-6 col-6">
                                                <div class="btn-group pull-right">
                                                    <a href="" class="btn deepPink-bgcolor  btn-outline"><i class="fa fa-print"></i> Print </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
                                            <div class="row ">
                                                <div class="col-sm-12 col-md-6 ">
                                                    <div class="dataTables_length">
                                                        <form action="">
                                                            <label>
                                                                Hiển thị
                                                                <input type="hidden" name="searchValue" value="${searchValue}">
                                                                <select name="size" class="form-control form-control-sm"
                                                                        aria-controls="order-listing" onchange="this.form.submit()">
                                                                    <option value="10"  <c:if test="${pageSize == 10}">selected</c:if> >10</option>
                                                                    <option value="25"  <c:if test="${pageSize == 25}">selected</c:if> >25</option>
                                                                    <option value="50"  <c:if test="${pageSize == 50}">selected</c:if> >50</option>
                                                                    <option value="100" <c:if test="${pageSize == 100}">selected</c:if> >100</option>
                                                                    </select>
                                                                    mục
                                                                </label>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-12 col-md-6">
                                                        <div class="dataTables_filter">
                                                            <form action="${pageContext.request.contextPath}/management/search_user" method="GET">
                                                            <label>
                                                                Tiềm kiếm: 
                                                                <input type="text" class="form-control form-control-sm" name="searchValue" value="${searchValue}" placeholder> 
                                                                <input type="submit" class="btn btn-instagram" value="Tìm">
                                                            </label>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-hover table-checkable order-column full-width" id="example4">
                                                        <thead>
                                                            <tr>
                                                                <th class="center">Tên Người dùng </th>
                                                                <th class="center">Trạng thái </th>
                                                                <th class="center">Ngày tạo  </th>
                                                                <th class="center">Cấp quền</th>
                                                                <th class="center"> Action </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="u" items="${users.content}">
                                                                <tr class="odd gradeX">
                                                                    <td class="center">${u.userName}</td>

                                                                    <td class="center">
                                                                        <span class="
                                                                              <c:if test="${u.userStatus =='ACTIVE'}">label label-sm label-success</c:if>
                                                                              <c:if test="${u.userStatus =='UNACTIVE'}">label label-sm label-warning</c:if>
                                                                              <c:if test="${u.userStatus =='LOCK'}">label label-sm label-danger</c:if>
                                                                                  ">
                                                                              ${u.userStatus}
                                                                        </span>
                                                                    </td>
                                                                    <td class="center">
                                                                        <c:if test="${u.createDate == null}"> Không có thông tin</c:if>
                                                                        <c:if test="${u.createDate != null}">${u.createDate}</c:if>
                                                                        </td>
                                                                        <td class="center">
                                                                        <c:forEach var="ur" items="${u.userRoles}">
                                                                            <c:if test="${ur.role.roleName == 'ROLE_ADMIN'}"> Quản trị viên</c:if>
                                                                            <c:if test="${ur.role.roleName == 'ROLE_CUSTOMER'}"> Khách hàng</c:if>
                                                                            <c:if test="${ur.role.roleName == 'ROLE_STAFF'}">Giao dịch viên</c:if>,
                                                                        </c:forEach>
                                                                    </td>

                                                                    <td class="center">
                                                                        <a href="${pageContext.request.contextPath}/viewUserEdit/${u.id}" class="btn btn-tbl-edit btn-xs">
                                                                            <i class="fa fa-pencil"></i>
                                                                        </a>

                                                                        <c:if test="${u.userStatus == 'ACTIVE'}">
                                                                            <a href="<c:url value="/changeUserLock/${u.id}" />" class="btn btn-tbl-delete btn-xs">
                                                                                <i class="fa fa-lock"></i>
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${u.userStatus == 'UNACTIVE'}">
                                                                            <a href="<c:url value="/changeUserActive/${u.id}" />" class="btn btn-tbl-delete btn-xs">
                                                                                <i class="fa fa-unlock-alt"></i>
                                                                            </a>
                                                                        </c:if>
                                                                        <c:if test="${u.userStatus == 'LOCK'}">
                                                                            <a o href="<c:url value="/changeUserActive/${u.id}" />" class="btn btn-tbl-delete btn-xs">
                                                                                <i class="fa fa-unlock"></i>
                                                                            </a>
                                                                        </c:if>  

                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <c:if test="${users == null}">
                                                        <div class="card-head text-center">
                                                            <header>Không tìm thấy</header>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <c:if test="${users != null}">
                                                <div class="row">
                                                    <div class="col-sm-12 col-md-5">
                                                        
                                                    </div>
                                                    <div class="col-sm-12 col-md-7">
                                                        <div class="paging_simple_numbers">
                                                            <ul class="pagination justify-content-end">
                                                                <li class="paginate_button page-item previous <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                    <a href="${pageContext.request.contextPath}/management/<c:if test="${action == 'user'}">viewManageUser?</c:if><c:if test="${action == 'search_user'}">search_user?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}"
                                                                       class="page-link">Trước</a>
                                                                    </li>
                                                                <c:forEach var="page" begin="1"  end="${totalPages}">
                                                                    <li class="paginate_button page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                        <a href="${pageContext.request.contextPath}/management/<c:if test="${action == 'user'}">viewManageUser?</c:if><c:if test="${action == 'search_user'}">search_user?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}" class="page-link">${page}</a>
                                                                        </li>
                                                                </c:forEach>
                                                                <li class="paginate_button page-item next border- <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                    <a href="${pageContext.request.contextPath}/management/<c:if test="${action == 'user'}">viewManageUser?</c:if><c:if test="${action == 'search_user'}">search_user?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" class="page-link"
                                                                       >Tiếp theo</a>
                                                                    </li>
                                                                </ul>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                        </c:if>
                                    </div>
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