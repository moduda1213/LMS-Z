<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- 위의 사이트 아이콘 -->
    <link rel="icon" type="image/png" sizes="16x16" href="${path}/assets/images/favicon.png">
    <title>modiftyTextbook</title>
    <!-- css -->
    <link href="${path}/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
    <link href="${path}/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <link href="${path}/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
    <link href="${path}/dist/css/style.min.css" rel="stylesheet">
    <link href="${path}/dist/css/lmsStyle.css" rel="stylesheet">
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
        data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        
        <jsp:include page="/WEB-INF/view/manager/inc/logoMenu.jsp" flush="false"></jsp:include>
        <jsp:include page="/WEB-INF/view/manager/inc/navbarMenu.jsp" flush="false"></jsp:include>
	
		<!-- 소제목 -->
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1"><a style="color: black;" href="">Textbook</a></h3>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
				<!-- 1번째 라인 카드 -->
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="card" id="cardStyle">
                            <div class="card-body">
                               <h4 class="card-title">교재 수정</h4>
	                            <div>
	                            	<form method="post" action="${path }/manager/modifyTextbookOneAction">
		                            	<table id="lmsTable" class="table table" style="margin-top: 20px; text-align: center;">
		                            		<tr>
												<th style="width:15%;">도서 번호 :</th>
												<td><input type="text" class="form-control"name="textbookIsbn" value="${textbookOne.textbookIsbn }" readonly="readonly"></td>
											</tr>
											<tr>
												<th>제목 :</th>
												<td><input type="text" class="form-control"name="textbookTitle" value="${textbookOne.textbookTitle }"></td>
											</tr>
											<tr>
												<th>글쓴이 :</th>
												<td><input type="text" class="form-control"name="textbookWriter" value="${textbookOne.textbookWriter }"></td>
											</tr>
											<tr>
												<th>출판사 :</th>
												<td><input type="text" class="form-control"name="textbookPublisher" value="${textbookOne.textbookPublisher }"></td>
											</tr>
											<tr>
												<th>책 소개 :</th>
												<td><input type="text" class="form-control"name="textbookInfo" value="${textbookOne.textbookInfo }"></td>
											</tr>
											<tr>
												<th>가격 :</th>
												<td>
													<input type="text" class="form-control" id="textbookPrice" name="textbookPrice" value="${textbookOne.textbookPrice }">
													<div id="price"></div>
												</td>
											</tr>
											<tr>
												<th>출판사 :</th>
												<td><input type="text" class="form-control"name="textbookPublishdate" value="${textbookOne.textbookPublishdate }" readonly="readonly"></td>
											</tr>
										</table>
										<a class="btn btn-outline-secondary" style="border-radius: 4px;" href="${path }/manager/textbookOne/${textbookOne.textbookIsbn }">돌아가기</a>
										<button  class="btn btn-success" style="border-radius: 4px; float:right;" type="submit">수정 완료</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="${path}/assets/libs/jquery/dist/jquery.min.js"></script>
    <script src="${path}/assets/libs/popper.js/dist/umd/popper.min.js"></script>
    <script src="${path}/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${path}/dist/js/app-style-switcher.js"></script>
    <script src="${path}/dist/js/feather.min.js"></script>
    <script src="${path}/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
    <script src="${path}/dist/js/sidebarmenu.js"></script>
    <script src="${path}/dist/js/custom.min.js"></script>
    <script src="${path}/assets/extra-libs/c3/d3.min.js"></script>
    <script src="${path}/assets/extra-libs/c3/c3.min.js"></script>
    <script src="${path}/assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="${path}/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="${path}/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="${path}/assets/extra-libs/jvector/jquery-jvectormap-world-mill-en.js"></script>
    <script src="${path}/dist/js/pages/dashboards/dashboard1.min.js"></script>
    <script>
    var price = 'success';
	var checkPrice = /^[0-9]{4,7}$/;
	$('#btn').click(function(){
		if(num== 'success' && price== 'success'){
			$('#textbook').submit();
			} else{
				alert('형식을 확인하세요');
			}
	})
    $('#textbookPrice').on('propertychange change keyup paste input', function(){
		if(checkPrice.test($('#textbookPrice').val())){				
			$('#price').text('');
			price='success';		
		}else{
			$('#price').text('4~7자리 숫자를 입력해주세요');
			price = '';	
		}
	});
    </script>
</body>
</html>