<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- 위의 사이트 아이콘 -->
<link rel="icon" type="image/png" sizes="16x16"
	href="${path}/assets/images/favicon.png">
<title>faq</title>
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


	<div id="main-wrapper" data-theme="light" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed"
		data-boxed-layout="full">

		<jsp:include page="/WEB-INF/view/manager/inc/logoMenu.jsp"
			flush="false"></jsp:include>
		<jsp:include page="/WEB-INF/view/manager/inc/navbarMenu.jsp"
			flush="false"></jsp:include>

		<!-- 소제목 -->
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<div class="row">
					<div class="col-7 align-self-center">
						<h3 class="page-title text-truncate text-dark font-weight-medium mb-1">FAQ</h3>
						<br>
						<div class="d-flex align-items-center">
							<div>
								<!-- 카테로리 선택 -->
								<c:forEach var="c" items="${categoryList }">
									<!-- 현재 카테고리 페이지이면 a링크 삭제 -->
									<c:if test="${c.faqCategory == currentFaqCategory }">
										<span>${c.faqCategory }</span>
										&emsp;
									</c:if>
									<c:if test="${c.faqCategory != currentFaqCategory }">
										<span><a href="${path }/manager/faqList/${c.faqCategory}/1">${c.faqCategory }</a></span>
										&emsp;
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid">
				<!-- 테이블 -->
				<div class="row">
					<div class="col-mb-12 col-12">
						<div class="card" id="cardStyle">
							<div class="card-body">
								<div class="row">
									<div class="col-lg-5 col-md-5"></div>
									<!-- 검색기능 (현재 카테고리에서 검색하면 그 카테고리에 속한 FAQ가 출력됩니다.) -->
									<div class="col-lg-5 col-md-5">
										<input type="text" id="faqTitle" value="${faqTitle}" class="form-control-plaintext form-control border-black form-sm">
									</div>
									<div class="col-lg-2 col-md-2">
										<a class="btn btn btn-outline-secondary" style="border-radius: 4px;" id="searchBtn" href="">검색</a>
									</div>
								</div>
								<div class="table-responsive">
									<table id="lmsTable" class="table table" style="margin-top: 20px; text-align: center;">
										<thead>
											<tr>
												<th style="width:15%;">NO</th>
												<th style="width:25%;">카테고리</th>
												<th style="width:20%;">작성자</th>
												<th>제목</th>
												<th style="width:25%;">게시일</th>
												<th style="width:20%;">조회수</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="f" items="${faqList}" varStatus="status">
												<tr>
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5>
																<span>${ruleNo-(status.index)}</span> 
																<span hidden="hidden">${f.faqNo}</span>
															</h5>
														</div>
													</td>
	
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5>${f.faqCategory}</h5>
														</div>
													</td>
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5>${f.faqWriter }</h5>
														</div>
													</td>
	
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5>
																<a class="btn btn-outline-light bg-light text-secondary btn-block" href="${path }/manager/faqCountUp/${f.faqNo }/${currentPage}">${f.faqTitle}</a>
															</h5>
														</div>
													</td>
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5 class="text-dark mb-0 font-16 font-weight-medium">${f.faqCreatedate}</h5>
														</div>
													</td>
													<td>
														<div>
															<!-- 굵은 글씨 -->
															<h5 class="text-dark mb-0 font-16 font-weight-medium">${f.faqCount }</h5>
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- 페이징 -->
									<br>
									<!-- 페이징 처리 - 검색하지 않았을 때-->
									<div id="paging" style="text-align: center; padding: 7px;">
										<c:if test="${faqTitle == '' }">
											<div class="list-inline text-center mt-4 mb-0">
												<!-- 첫페이지이고 전체 페이지가 '1'이 아닌 경우 이전버튼 표시 -->
												<c:if test="${startPage!=1 && lastPage!=1}">
													<span> <a
														href="${path}/manager/faqList/${currentFaqCategory }/${startPage-10}">이전</a>
													</span>
												</c:if>
												<!-- lastPage가 10개를 채울수 없을 때 -->
												<c:if test="${startPage+9 > lastPage }">
													<c:forEach var="i" begin="${startPage }" end="${lastPage}">
														<!-- 현재 페이지일 경우 -->
														<c:if test="${currentPage == i }">
															<span> <a id="pagingStyle" class="bg-secondary font-18">${i}</a>
															</span>
														</c:if>
														<!-- 현재 페이지가 아닐 경우 -->
														<c:if test="${currentPage != i }">
															<span> <a class="font-18"
																href="${path}/manager/faqList/${currentFaqCategory }/${i}"></a>
															</span>
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${startPage+9<lastPage }">
													<c:forEach var="i" begin="${startPage }" end="${startPage+9}">
														<!-- 현재 페이지일 경우 -->
														<c:if test="${currentPage == i }">
															<span> <a id="pagingStyle" class="bg-secondary font-18">${i}</a>
															</span>
														</c:if>
														<!-- 현재 페이지가 아닐 경우 -->
														<c:if test="${currentPage != i }">
															<span> <a class="font-18"
																href="${path}/manager/faqList/${currentFaqCategory }/${i}">${i}</a>
															</span>
														</c:if>
													</c:forEach>
												</c:if>
												<!-- 한페이지에서 보여지는 10개의 페이지보다 마지막 페이지가 크고 / 마지막페이지가 시작페이지와 같이 않다면-->
												<c:if test="${startPage+9<lastPage && lastPage != startPage}">
													<span> <a
														href="${path}/manager/faqList/${currentFaqCategory }/${startPage+10}">다음</a>
													</span>
												</c:if>
											</div>
										</c:if>
									</div>
										<div id="paging" style="text-align: center; padding: 7px;">
										<!-- 페이징 처리 - 검색했을 때  -->
										<c:if test="${faqTitle != '' }">
											<div>
												<!-- 첫페이지이고 전체 페이지가 '1'이 아닌 경우 이전버튼 표시 -->
												<c:if test="${startPage!=1 && lastPage!=1}">
													<span> <a
														href="${path}/manager/faqList/${faqTitle }/${currentFaqCategory }/${startPage-10}">이전</a>
													</span>
												</c:if>
												<!-- lastPage가 10개를 채울수 없을 때 -->
												<c:if test="${startPage+9 > lastPage }">
													<c:forEach var="i" begin="${startPage }" end="${lastPage}">
														<!-- 현재 페이지일 경우 -->
														<c:if test="${currentPage == i }">
															<span> <a id="pagingStyle" class="bg-secondary font-18">${i}</a>
															</span>
														</c:if>
														<!-- 현재 페이지가 아닐 경우 -->
														<c:if test="${currentPage != i }">
															<span> <a class="font-18"
																href="${path}/manager/faqList/${faqTitle }/${currentFaqCategory }/${i}">${i}</a>
															</span>
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${startPage+9<lastPage }">
													<c:forEach var="i" begin="${startPage }" end="${startPage+9}">
														<!-- 현재 페이지일 경우 -->
														<c:if test="${currentPage == i }">
															<span> <a id="pagingStyle" class="bg-secondary font-18">${i}</a>
															</span>
														</c:if>
														<!-- 현재 페이지가 아닐 경우 -->
														<c:if test="${currentPage != i }">
															<span> <a class="font-18"
																href="${path}/manager/faqList/${faqTitle }/${currentFaqCategory }/${i}">${i}</a>
															</span>
														</c:if>
													</c:forEach>
												</c:if>
												<!-- 한페이지에서 보여지는 10개의 페이지보다 마지막 페이지가 크고 / 마지막페이지가 시작페이지와 같이 않다면-->
												<c:if test="${startPage+9<lastPage && lastPage != startPage}">
													<span> <a
														href="${path}/manager/faqList/${faqTitle }/${currentFaqCategory }/${startPage+10}">다음</a>
													</span>
												</c:if>
											</div>
										</c:if>
									</div>
									<span><a class="btn btn-success" style="border-radius: 4px; float:right;" href="${path }/manager/addFaqList/${managerId }/${currentPage}">FAQ작성</a></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- script 코드 -->
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
		// 검색창에 입력한 값을 바로 사용하기 위해서 jquery사용
		$(document).ready(function(){
			$('#searchBtn').on('click',function(){
				$('#searchBtn').prop('href',"${path}/manager/faqList/"+$('#faqTitle').val()+"/${currentFaqCategory}/1");
				})
			})
	</script>
</body>

</html>