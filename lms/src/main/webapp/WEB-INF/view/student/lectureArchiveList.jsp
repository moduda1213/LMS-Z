<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<!-- 위의 사이트 아이콘 -->
<link rel="icon" type="image/png" sizes="16x16"
	href="${path}/assets/images/favicon.png">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

		<jsp:include page="/WEB-INF/view/student/inc/logoMenu.jsp" flush="false"></jsp:include>
		<jsp:include page="/WEB-INF/view/student/inc/navbarMenu.jsp" flush="false"></jsp:include>
			
		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<div class="row">
					<div class="col-7 align-self-center">
						<h2 class="page-title text-truncate text-dark font-weight-medium mb-1">자료실</h2>
					</div>
				</div>
			</div>	
			<br>
			<div class="container-fluid">
				&emsp;<span><a type="button" class="btn btn-outline-secondary mb-2" href="${path}/student/lectureArchiveList/${studentId}/1">전체</a></span>
			<c:if test="${!empty lectureList}">
				<c:forEach var="l" items="${lectureList}">
					&emsp;<span><a type="button" class="btn btn-outline-secondary mb-2" href="${path}/student/lectureSearchArchive/${studentId}/${l.lectureNo}/1">${l.lectureName}</a></span>
				</c:forEach>
			</c:if>
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card" id="cardStyle">
							<div class="card-body">
								<div class="table-responsive">
									<div class="border border-0 d-flex justify-content-end">	
										<div class="border  border-0">
											<input type="text" id="title" style="width: 400px" class="form-control-plaintext form-control border-black form-sm" placeholder="제목으로 검색됩니다"> 
										</div>		
										<div class="border  border-0">	
											&nbsp;<a type="button" style="border-radius: 4px;" class="btn btn-outline-secondary btn-default btn-sm" id="btn" href="">검색</a>
										</div>	
									</div>
									<table id="lectureTable" class="table table" style="margin-top: 20px; text-align: center;">
										<thead>
											<c:if test="${!empty lectureArchive}">
											<tr class="border-0">
												<th class="border-0 font-14 font-weight-medium text-muted px-2">강의</th>
												<th class="border-0 font-14 font-weight-medium text-muted px-2">작성자</th>
												<th class="border-0 font-14 font-weight-medium text-muted px-2">제목</th>
												<th class="border-0 font-14 font-weight-medium text-muted px-2">작성일</th>
												<th class="border-0 font-14 font-weight-medium text-muted px-2">조회수</th>
											</tr>
											</c:if>
											<c:if test="${empty lectureArchive}">
													<tr>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
															
																등록된 게시물이 없습니다.
														
														</td>
													</tr>
											</c:if>
										</thead>	
										<tbody>
											
												<c:forEach var="la" items="${lectureArchive}">
													<tr>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
																${la.lecture.lectureName}
															
														</td>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
																${la.lectureArchiveWriter}
															
														</td>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
																<h5 class="text-dark mb-0 font-16 font-weight-medium"><a class="btn btn-outline-light text-secondary btn-block" href="${path}/student/lectureArchiveCountUp/${la.lectureArchiveNo}">${la.lectureArchiveTitle}</a></h5>
															
														</td>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
																${la.lectureArchiveCreatedate}
															
														</td>
														<td class="font-weight-medium text-dark border-top-0 px-2 py-4 align-self-center">
																${la.lectureArchiveCount}
															
														</td>
													</tr>
												</c:forEach>
									
											
										</tbody>
									</table>
									<div id="paging" style="text-align: center; padding: 7px;">							
										<div>
											<c:if test="${listCurrentPage%10==1 && listCurrentPage>10}">
												
												<a href="${path}/student/lectureArchiveList/${studentId}/${listCurrentPage-1}">이전</a>
											</c:if>
											
											<c:forEach var="i" begin="${listUnderFirstPage}" end="${listUnderLastPage}">
												<c:if test="${i<=lastPage && listCurrentPage == i}">
													<a id="pagingStyle" class="bg-secondary font-18" href="${path}/student/lectureArchiveList/${studentId}/${i}">${i}</a>
												</c:if>
												<c:if test="${i<=lastPage && listCurrentPage != i}">
													<a class="font-18" href="${path}/student/lectureArchiveList/${studentId}/${i}">${i}</a>
												</c:if>
											</c:forEach>
											
											<c:if test="${listCurrentPage%10==0 && listCurrentPage<lastPage}">
												<a href="${path}/student/lectureArchiveList/${studentId}/${listCurrentPage+1}">다음</a>
												
											</c:if>
										</div>
										
										<!-- 강의 검색 -->
										<c:if test="${!empty lectureNo}">
										<div>
											<c:if test="${searchLectureCurrentPage%10==1 && searchLectureCurrentPage>10}">
												
												<a href="${path}/student/lectureSearchArchive/${studentId}/${lectureNo}/${searchLectureCurrentPage-1}">이전</a>
											</c:if>
											
											<c:forEach var="i" begin="${searchLectureUnderFirstPage}" end="${searchLectureUnderLastPage}">
												<c:if test="${i<=searchLectureLastPage && searchLectureCurrentPage == i}">
													<a id="pagingStyle" class="bg-secondary font-18" href="${path}/student/lectureSearchArchive/${studentId}/${lectureNo}/${i}">${i}</a>
												</c:if>
												<c:if test="${i<=searchLectureLastPage && searchLectureCurrentPage != i}">
													<a class="font-18" href="${path}/student/lectureSearchArchive/${studentId}/${lectureNo}/${i}">${i}</a>
												</c:if>
											</c:forEach>
											
											<c:if test="${searchLectureCurrentPage%10==0 && searchLectureCurrentPage<searchLectureLastPage}">
												<a href="${path}/student/lectureSearchArchive/${studentId}/${lectureNo}/${searchLectureCurrentPage+1}">다음</a>
												
											</c:if>
										</div>
										</c:if>
										<!-- 검색 페이징 -->
										<c:if test="${lectureArchiveTitle != null}">
											<div>
												<c:if test="${searchCurrentPage>1}">
													
													<a href="${path}/student/lectureArchiveSearch/${studentId}/${lectureArchiveTitle}/${searchCurrentPage-1}">이전</a>
												</c:if>
												
												<c:forEach var="s" begin="${searchUnderFirstPage}" end="${searchUnderLastPage}">
													<c:if test="${s<=searchLastPage && searchCurrentPage == s}">
														<a href="${path}/student/lectureArchiveSearch/${studentId}/${lectureArchiveTitle}/${s}">${s}</a>
													</c:if>
													<c:if test="${s<=searchLastPage && searchCurrentPage != s}">
														<a href="${path}/student/lectureArchiveSearch/${studentId}/${lectureArchiveTitle}/${s}">${s}</a>
													</c:if>
												</c:forEach>
												
												<c:if test="${searchCurrentPage<searchLastPage}">
													<a href="${path}/student/lectureArchiveSearch/${studentId}/${lectureArchiveTitle}/${searchCurrentPage+1}">다음</a>
													
												</c:if>
											</div>
										</c:if>
									</div>		
									<input type="hidden" id="studentId" value="${studentId}">
	
								</div>
							</div>			
						</div>			
					</div>			
				</div>			
			</div>			
		</div>			
	</div>									
</body>
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
	$('#btn').on('click',function(){
		if($('#title').val()!=''){
			$('#btn').prop('href',"${path}/student/lectureArchiveSearch/"+$('#studentId').val()+"/"+$('#title').val()+"/1");
		} 
		if($('#title').val()==''){
		$('#btn').prop('href',"${path}/student/lectureArchiveList/"+$('#studentId').val()+"/1");
		}
	});		
</script>
</html>