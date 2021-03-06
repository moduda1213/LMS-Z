<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="icon" type="image/png" sizes="16x16" href="${path}/assets/images/favicon.png">
<title>reportOne</title>
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
    
		<jsp:include page="/WEB-INF/view/teacher/inc/logoMenu.jsp" flush="false"></jsp:include>
		<jsp:include page="/WEB-INF/view/teacher/inc/navbarMenu.jsp" flush="false"></jsp:include>



		<!-- 소제목 -->
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">과제 상세보기</h3>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                	<!-- 소제목 밑 글씨 -->
                                    <li class="breadcrumb-item"><a href=""></a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

		<div class="container-fluid">
		<!-- 1번째 라인 카드 -->
                <div class="row">
                    <div class="col-lg-9 col-md-9">
                        <div class="card" id="cardStyle">
                            <div class="card-body">

		<table class="table table" id="tableOneStyle">
				<tr>
					<th>과제 제목</th>
					<td>${reportOne.reportTitle}</td>
				</tr>
				<tr>
					<th>과제 내용</th>
					<td>${reportOne.reportContent}</td>
				</tr>
				<tr>
					<th>과제 출제일</th>
					<td>${reportOne.reportStartdate}</td>
				</tr>
				<tr>
					<th>과제 마감일</th>
					<td>${reportOne.reportEnddate}</td>
				</tr>
		</table>
		<div class="text-right">
			<a class="btn btn-info" style="border-radius: 4px;" href="${path}/teacher/modifyReport/${reportOne.reportNo}">수정하기</a>
		</div>
		<h3 style="border-top: 1px solid #444444; padding: 24px; margin-top: 30px">과제제출</h3>
		<table id="lmsNoticeTable" class="table table">
			<thead>
				<tr>
					<th>제출자</th>
					<th>과제제출 제목</th>
					<th>과제 점수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="rs" items="${reportOne.reportSubmitList}">
					<tr>
					<c:if test="${rs.reportSubmitNo == 0}">
						<td colspan="3">과제제출 인원이 없습니다.</td>
					</c:if>
					<c:if test="${rs.reportSubmitNo != 0}">
						<td>${rs.reportSubmitWriter}</td>
						<td><a class="btn btn-outline-light text-secondary btn-block" href="${path}/teacher/reportSubmitOne/${rs.reportSubmitNo}">${rs.reportSubmitTitle}</a></td>
						<td>${rs.reportSubmitPoint}점</td>
					</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div style="float:left;">
			<a class="btn btn-outline-secondary text-dark" href="${path}/teacher/reportList/${reportOne.lectureNo}/1">뒤로가기</a>		
		</div>
		<div class="text-right">
			<a onclick="btn('${reportOne.lectureNo}', '${reportOne.reportNo}')" class="btn btn-outline-danger" style="border-radius: 4px;" href="javascript:click()">삭제</a>
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
    
    function btn(lectureNo, reportNo){
    	if (confirm("정말 삭제하시겠습니까?") == true){ // 확인
			location.href = '${path}/teacher/removeReport/'+ lectureNo + '/' + reportNo;
		}else{   //취소
		    return;
		}
    }
    
    </script>
		
</body>
</html>