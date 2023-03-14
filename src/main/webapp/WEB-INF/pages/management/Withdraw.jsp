<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                    <div class="page-title">Rút tiền</div>
                                </div>
                                <ol class="breadcrumb page-breadcrumb pull-right">
                                    <li><i class="fa fa-home"></i>&nbsp;<a class="parent-item" href="#">Home</a>&nbsp;<i class="fa fa-angle-right"></i>
                                    </li>
                                    <li class="active">Rút tiền</li>

                                </ol>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-body row">
                                    <div class="col-lg-12 p-t-20">
                                        <c:if test="${print != true}">
                                            <div class="card-box ">
                                                <c:if test="${action == 'search'}">
                                                    <div class="col-lg-12">
                                                        <div class="card-head">
                                                            <div class="col-lg-12 p-t-20 "> 
                                                                <header>Tiềm thông tin khách hàng</header>
                                                            </div>
                                                        </div>

                                                        <form action="${pageContext.request.contextPath}/search_BankAccount" method="POST">
                                                            <div class="ard-body p-t-20 row">
                                                                <div class="col-lg-4 p-t-20"></div>
                                                                <div class="col-lg-4 p-t-20 text-center">
                                                                    <input type="text"  class="form-control form-control-sm" placeholder="Nhập số tài khoản hoặc căn cước công dân" 
                                                                           name="searchValue" value="${valueSearch}" autocomplete="off" placeholder> 
                                                                    <span class="required text-danger ">${error}</span>
                                                                </div>
                                                                <div class="col-lg-1 p-t-20 ">
                                                                    <input type="submit" class="btn btn-instagram" value="Truy vấn">
                                                                </div>
                                                                <div class="col-lg-3 p-t-20"></div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </c:if>
                                                <c:if test="${print != true}">
                                                    <div class="col-lg-12 " >
                                                        <div class="row center" style="border: 1px; border-color: #000">
                                                            <div class="col-lg-4 p-t-20">
                                                                <div class="card-body ">
                                                                    <div class="col-lg-12 p-t-20 border">
                                                                        <table> <h4 style="color: #426BB5">Chủ tài khoản: </h4> 
                                                                            <p>${bankAccount.accountName}</p>
                                                                        </table>
                                                                    </div>
                                                                    <div class="col-lg-12 p-t-20 border">
                                                                        <table>
                                                                            <h4 style="color: #426BB5">Số tài khoản:</h4> 
                                                                            <p> ${bankAccount.accountNumber}</p>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4 p-t-20">
                                                                <div class="card-body">
                                                                    <div class="col-lg-12 p-t-20 border">
                                                                        <table>
                                                                            <h4 style="color: #426BB5">Loại tài khoản:</h4> 
                                                                            <p> <c:if test="${bankAccount.accountType == 'PAYMENT_ACCOUNT'}">Thanh toán</c:if>
                                                                            <p> <c:if test="${bankAccount.accountType == 'SAVING_ACCOUNT'}">Tiết kiệm</c:if>
                                                                                </p>
                                                                            </table>
                                                                        </div>
                                                                        <div class="col-lg-12 p-t-20 border">
                                                                            <table>
                                                                                <h4 style="color: #426BB5">Trạng thái:</h4> 
                                                                                <p>
                                                                                    <span class="
                                                                                    <c:if test="${bankAccount.bankAccountStatus =='ACTIVE'}">label label-sm label-success</c:if>
                                                                                    <c:if test="${bankAccount.bankAccountStatus =='UNACTIVE'}">label label-sm label-warning</c:if>
                                                                                    <c:if test="${bankAccount.bankAccountStatus =='LOCK'}">label label-sm label-danger</c:if>
                                                                                        ">
                                                                                    ${bankAccount.bankAccountStatus}
                                                                                </span>
                                                                            </p>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-4 p-t-20">
                                                                <div class="card-body">
                                                                    <div class="col-lg-12 p-t-20 border">
                                                                        <table>
                                                                            <h4 style="color: #426BB5">Số căn cước:</h4> 
                                                                            <p> ${bankAccount.customer.CINumber}</p>
                                                                        </table>
                                                                    </div>
                                                                    <div class="col-lg-12 p-t-20 border">
                                                                        <table>
                                                                            <h4 style="color: #426BB5">Số dư tài khoản:</h4> 
                                                                            <c:if test="${bankAccount.balance > 0}">
                                                                                <p> <fmt:formatNumber  type="number" value="${bankAccount.balance}"/> VND</p> 
                                                                            </c:if>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>   
                                                    </div>
                                                </c:if>
                                                <div class="col-lg-12 p-t-20">
                                                    <c:if test="${search == true}">
                                                        <div class="col-lg-12 p-t-20 "> 
                                                            <h3>Nhập số tiền cần rút</h3>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/withdraw" method="POST">
                                                            <div class="ard-body  row">
                                                                <div class="col-lg-6 center">
                                                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                                        <input type="text" id="text5" class="mdl-textfield__input" placeholder="Nhập số tiền" 
                                                                               name="amount" value="" autocomplete="off" placeholder> 
                                                                        <label class = "mdl-textfield__label" for = "text5">Số điện thoại</label>
                                                                    </div>
                                                                     <span class="required text-danger">${ErrorMessage}</span>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select getmdl-select__fix-height txt-full-width">
                                                                        <label for="sample4" class="mdl-textfield__label">Chi nhánh ngân hàng</label>
                                                                        <select class="mdl-textfield__input" id="sample4" name="tantuBankAddress" readonly tabIndex="-1">
                                                                            <c:forEach var="tantuBankAddress" items="${tantuBankAddress}">
                                                                                <option class="mdl-menu__item" value="${tantuBankAddress.address}" >
                                                                                    ${tantuBankAddress.address}</option>
                                                                                </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 p-t-20  center">
                                                                <a href="${pageContext.request.contextPath}/management/viewManageUsers" type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 btn-default">Thoát</a>
                                                                <button  type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect m-b-10 m-r-20 btn-facebook"> Tiếp theo </button>
                                                            </div>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <c:if test="${print == true}">
                                    <div class="col-lg-12   ">
                                        <div class="card-box ">
                                            <div class="row">
                                                <div class="col-md-12" id="printableArea">
                                                    <div class="white-box">
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-md-12 row">
                                                                <div class="pull-left col-lg-4">
                                                                    <address>
                                                                        <img src="${pageContext.request.contextPath}/resources-management/images/banking.webp" alt="logo" class="logo-default" style="width: 20%" />
                                                                    </address>
                                                                </div>
                                                                <div class="pull text-center col-lg-4 p-t-20">
                                                                    <address>
                                                                        <p class=" addr-font-h3"><b>GIẤY RÚT TIỀN MẶT</b></p> 
                                                                        <p>CASH WITHDRAWAL SLIP </p>
                                                                    </address>
                                                                </div>
                                                                <div class="pull col-lg-4">
                                                                    <div class="m-t-30 text-right">
                                                                        <p class="">Số(Seq No):   #${code2}</p>
                                                                        <p class="">Ngày(Day):   ${Date}</p> 
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <hr>
                                                            <div class="col-md-12 p-t-20">
                                                                <div class="row border" >
                                                                    <div class="pull-left m-t-30 ">
                                                                        <p class="addr-font-h4"><b>Tên Tài khoản:</b>   ${bankAccount.accountName}</p>
                                                                        <p class="addr-font-h4"><b>Số tài khoản:</b>   ${bankAccount.accountNumber}</p>
                                                                    </div>
                                                                </div>
                                                                <div class="row border p-t-20 ">
                                                                    <div class="pull-left m-t-30 col-lg-6">
                                                                        <p class="addr-font-h4"><b>Số Tiền bằng số :</b> <fmt:formatNumber type="number" value="${moneyNumber}" />. Đ</p>
                                                                    </div>
                                                                    <div class="pull-right m-t-30  col-lg-6">
                                                                        <p class="addr-font-h4"><b>Số Tiền bằng Chữ :</b>  ${moneyText}</p>
                                                                    </div>
                                                                </div>
                                                                <div class="row border ">
                                                                    <div class="pull-left m-t-30 col-lg-9 p-t-20 ">
                                                                        <p class="addr-font-h4"><b>Đề nghị NH quy đỗi ra loại tiền:</b></p>
                                                                        <p class="addr-font-h4"><b>Tỷ giá:</b></p>
                                                                    </div>
                                                                    <div class="pull-right m-t-30 border col-lg-3">
                                                                        <p class="addr-font-h4"><b>Phí ngân hàng :</b></p>
                                                                        <p class="addr-font-h4"><input type="checkbox" /> <b>Phí Trong </b></p>
                                                                        <p class="addr-font-h4"><input type="checkbox" /> <b>Phí Ngoài </b></p>
                                                                    </div>
                                                                </div>
                                                                <div class="row border ">
                                                                    <div class="pull-left m-t-30 col-lg-12 p-t-20 ">
                                                                        <p class="addr-font-h4"><b>Họ tên người lỉnh tiền:</b>   ${bankAccount.customer.customerName}</p>
                                                                    </div>
                                                                    <div class="col-lg-12 p-t-20 ">
                                                                        <div class="pull-left m-t-30 col-lg-6 ">
                                                                            <p class="addr-font-h4"><b>Số CCCD:</b>    ${bankAccount.customer.CINumber}</p>
                                                                        </div>
                                                                        <div class="pull-left m-t-30 col-lg-3">
                                                                            <p class="addr-font-h4"><b>Số ngày cấp:</b>   ${bankAccount.customer.issueDate}</p>
                                                                        </div>
                                                                        <div class="pull-left m-t-30 col-lg-3">
                                                                            <p class="addr-font-h4"><b>Số nơi cấp:</b>    ${bankAccount.customer.issuePlace}</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-12 p-t-20 ">
                                                                        <div class="pull-left m-t-30 col-lg-3">
                                                                            <p class="addr-font-h4"><b>Số Số điện thoại:</b>    ${bankAccount.customer.customerPhone}</p>
                                                                        </div>
                                                                        <div class="pull-left m-t-30 col-lg-9">
                                                                            <p class="addr-font-h4"><b>Địa chỉ:</b>     ${bankAccount.customer.customerAddress}</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row border text-center" style="padding-bottom: 178px">
                                                                    <div class="col-4 p-t-20 "> 
                                                                        <div class=" m-t-30 ">
                                                                            <p class="addr-font-h4"><b>Người lĩnh tiền</b></p>
                                                                            <p>(Ký và ghi rõ họ tên)</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-4 p-t-20 ">
                                                                        <div class=" m-t-30 ">
                                                                            <p class="addr-font-h4"><b>Giao dịch viên</b></p>
                                                                            <p>(Ký và ghi rõ họ tên)</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-4 p-t-20 ">
                                                                        <div class="  m-t-30 ">
                                                                            <p class="addr-font-h4"><b>Chủ tài khoản</b></p>
                                                                            <p>(Ký và ghi rõ họ tên)</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 p-t-20 p-b-20">
                                                    <div class="col-lg-12">
                                                        <div class="text-right">
                                                            <a class="btn btn-danger" type="button" href="${pageContext.request.contextPath}/management/Withdraw" >Hoàn thành</a>
                                                            <button onclick="printDiv('printableArea')" class="btn btn-default btn-outline" type="button"> <span> Print</span> </button>
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
    <script>
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
    <!-- end js include path -->
</body>

</html>