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
                                    <li class="active">Quản lý khách hàng</li>
                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-box">
                                    <div class="card-head">
                                        <header>Quản lý khách hàng</header>
                                        <div class="tools">
                                            <a class="fa fa-repeat btn-color box-refresh" href="javascript:;"></a>

                                        </div>
                                    </div>
                                    <div class="card-body ">

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
                                                            <form action="${pageContext.request.contextPath}/search_customer" method="GET">
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
                                                                <th class=""> #</th>
                                                                <th class="center"> Quất tịch </th>
                                                                <th class="center"> Tên tài khoản </th>
                                                                <th class="center"> Tên khách hàng </th>
                                                                <th class="center"> Ngày sinh </th>
                                                                <th class="center"> Gơi tính </th>
                                                                <th class="center"> Số điện thoại </th>
                                                                <th class="center"> Email </th>
                                                                <th class="center"> Dịa chỉ </th>
                                                                <th class="center"> Số căn CCCD</th>
                                                                <th class="center"> Ngày cấp CCCD</th><!-- comment -->
                                                                <th class="center"> Nơi cấp CCCD</th>
                                                                <th class="center"> Action </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="c" items="${customers.content}">
                                                                <tr class="odd gradeX">
                                                                    <td></td>
                                                                    <td class="">
                                                                        <c:if test="${c.nation != null}">${c.nation}</c:if>
                                                                        <c:if test="${c.nation == null}"> Không có thông tin</c:if>
                                                                        </td>
                                                                        <td class="">
                                                                        ${c.user.userName}
                                                                    </td>
                                                                    <td class="">${c.customerName}</td>
                                                                    <td class="center">
                                                                        <c:if test="${c.birthDate == null}"> Không có thông tin</c:if>
                                                                        <c:if test="${c.birthDate != null}">${c.birthDate}</c:if>
                                                                        </td>
                                                                        <td class="">
                                                                        <c:if test="${c.gender == 'MALE'}"> Nam</c:if>
                                                                        <c:if test="${c.gender == 'FEMALE'}">Nữ</c:if>
                                                                        <c:if test="${c.gender == null}"> Không có thông tin</c:if>
                                                                        <c:if test="${c.gender == 'OTHER'}">Khác</c:if>
                                                                        </td>
                                                                        <td class="center">
                                                                            <a href="tel:${c.customerPhone}">${c.customerPhone}</a>
                                                                    </td>
                                                                    <td class=""><a href="mailto:${c.customerEmail}">${c.customerEmail}</a></td>

                                                                    <td class="">
                                                                        <c:if test="${c.customerAddress != null}">${c.customerAddress}</c:if>
                                                                        <c:if test="${c.customerAddress == null}"> Không có thông tin</c:if>
                                                                        </td>
                                                                        <td class="center">
                                                                        <c:if test="${c.CINumber != null}">${c.CINumber}</c:if>
                                                                        <c:if test="${c.CINumber == null}"> Không có thông tin</c:if>
                                                                        </td>
                                                                        <td class="center">
                                                                        <c:if test="${c.issueDate != null}">${c.issueDate}</c:if>
                                                                        <c:if test="${c.issueDate == null}"> Không có thông tin</c:if>
                                                                        </td>
                                                                        <td class="">
                                                                        <c:if test="${c.issuePlace != null}">${c.issuePlace}</c:if>
                                                                        <c:if test="${c.issuePlace == null}"> Không có thông tin</c:if>  
                                                                        </td>
                                                                        <td class="center">
                                                                            <a href="${pageContext.request.contextPath}/editManageCustomer/${c.id}" class="btn btn-tbl-edit btn-xs">
                                                                            <i class="fa fa-pencil"></i>
                                                                        </a>

                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <c:if test="${customers == null}">
                                                        <div class="card-head text-center">
                                                            <header>Không tìm thấy</header>
                                                        </div>
                                                    </c:if> 
                                                </div>
                                            </div>
                                            <c:if test="${customers != null}">
                                                <div class="row">
                                                    <div class="col-sm-12 col-md-5">

                                                    </div>
                                                    <div class="col-sm-12 col-md-7">
                                                        <div class="paging_simple_numbers">
                                                            <ul class="pagination justify-content-end">
                                                                <li class="paginate_button page-item previous <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                    <a href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customer'}">viewManageCustomer?</c:if><c:if test="${action == 'search_customer'}">search_customer?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}"
                                                                       class="page-link">Trước</a>
                                                                    </li>
                                                                <c:forEach var="page" begin="1"  end="${totalPages}">
                                                                    <li class="paginate_button page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                        <a href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customer'}">viewManageCustomer?</c:if><c:if test="${action == 'search_customer'}">search_customer?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}" class="page-link">${page}</a>
                                                                        </li>
                                                                </c:forEach>
                                                                <li class="paginate_button page-item next border- <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                    <a href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customer'}">viewManageCustomer?</c:if><c:if test="${action == 'search_customer'}">search_customer?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" class="page-link"
                                                                       >Tiếp theo</a>
                                                                    </li>
                                                                </ul>
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