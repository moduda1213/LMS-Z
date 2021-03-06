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
<title>modifyReport</title>
    <link href="${path}/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
    <link href="${path}/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <link href="${path}/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
    <link href="${path}/dist/css/style.min.css" rel="stylesheet">
    <link href="${path}/dist/css/lmsStyle.css" rel="stylesheet">
<!-- SmartEditor 텍스트편집기 -->
<script src="${path }/smarteditor2/js/HuskyEZCreator.js"></script>
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
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">과제수정</h3>
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
		<form method="post" action="${path}/teacher/modifyReport/${reportOne.reportNo}">
					<div>
						<input type="hidden" name="reportNo" value="${reportOne.reportNo}" readonly="readonly">
						<input type="hidden" name="lectureNo" value="${reportOne.lectureNo}" readonly="readonly">
					</div>
			<table id="lmsNoticeTable" class="table table">
				<tr>
					<th>과제 제목</th>
					<td><input class="form-control" style="width:100%" type="text" name="reportTitle" id="reportTitle" value="${reportOne.reportTitle}" style="width:560px"></td>
				</tr>
				<tr>
					<th>과제 내용</th>
					<td><textarea class="form-control" style="width:100%" rows="3" cols="50" name="reportContent" id="reportContent">${reportOne.reportContent}</textarea></td>
				</tr>
				<tr>
					<th>과제 출제일</th>
					<td><input class="form-control" type="datetime-local" name="reportStartdate" id="reportStartdate" value="${reportOne.reportStartdate}"></td>
				</tr>
				<tr>
					<th>과제 마감일</th>
					<td><input class="form-control" type="datetime-local" name="reportEnddate" id="reportEnddate" value="${reportOne.reportEnddate}"></td>
				</tr>
			</table>
			<button class="btn btn-success" style="border-radius: 4px; float:right;" type="button" id="updateBtn">수정하기</button>
			<a class="btn btn-outline-secondary text-dark" href="${path}/teacher/reportOne/${reportOne.reportNo}">뒤로가기</a>
		</form>
		
		
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
		$(document).ready(function() {
			// SmartEditor2 스크립트 추가
			var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : 'reportContent',
				sSkinURI : '${path}/smarteditor2/SmartEditor2Skin.html',
				fCreator : 'createSEditor2'
			})
			$('#updateBtn').click(function(){
				oEditors.getById["reportContent"].exec("UPDATE_CONTENTS_FIELD", []);
				if($('#reportTitle').val() ==""){
					alert('제목을 입력해주세요.');
					}
				else if($('#reportContent').val() == '<p>&nbsp;</p>' ||$('#reportContent').val() == ''){
					alert('내용을 입력해주세요.');
					}
				else if($('#reportStartdate').val() == ""){
					alert('시작날짜는 입력해주세요.');
					}
				else if($('#reportEnddate').val() == ""){
					alert('마감날짜는 입력해주세요.');
					}
				else{
					$('#updateBtn').removeAttr("type");
					$('#updateBtn').attr("type","submit");
					}
				});
			
		})
	</script>
</body>
</html>