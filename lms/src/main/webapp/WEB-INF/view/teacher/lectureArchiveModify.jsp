<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
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
    <title>lectureArchiveAModify</title>
    <!-- css -->
    <link href="${path}/assets/extra-libs/c3/c3.min.css" rel="stylesheet">
    <link href="${path}/assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <link href="${path}/assets/extra-libs/jvector/jquery-jvectormap-2.0.2.css" rel="stylesheet" />
    <link href="${path}/dist/css/style.min.css" rel="stylesheet">
    <link href="${path}/dist/css/lmsStyle.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">Lecture Archive</h3>
                    </div>
                </div>
            </div>
            <!-- 내용 -->
            <div class="container-fluid">
            	<div class="row">
            		<div class="col-lg-12 col-md-12">
            			<div class="card" id="cardStyle">
            				<div class="card-body">
            					<h4 class="card-title">자료 수정</h4>
            					
            					
								<form method="post" id="lectureArchiveModify" action="${path}/teacher/lectureArchiveModify/${teacherId}/${lectureArchive.lectureNo}/${lectureArchive.lectureArchiveNo}" enctype="multipart/form-data">
									<table id="lmsTable" class="table text-center" style="margin-top:20px; text-align:center;">
										<tr>
											<td style="width:10%;">강의</td>
											<td>
												<select class="custom-select" name="lectureNo">
													<c:forEach var="l" items="${lectureList}">
														<option value="${l.lectureNo}">${l.lectureNo}: ${l.lectureName}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<td>자료 번호</td>
											<td>${lectureArchive.lectureArchiveNo}</td>
										</tr>
										<tr>
											<td>작성자</td>
											<td>
												<input class="form-control" type="text" name="lectureArchiveWriter" readonly="readonly" value="${lectureArchive.lectureArchiveWriter}">
												<input type="hidden" name="accountId" readonly="readonly" value="${teacherId}">
											</td>
										</tr>
										
										<tr>
											<td>제목</td>
											<td><input class="form-control" type="text" name="lectureArchiveTitle" id="lectureArchiveTitle"  value="${lectureArchive.lectureArchiveTitle}"></td>
										</tr>
										<tr>
											<td>내용</td>
											<td>
												<textarea class="form-control" name="lectureArchiveContent" id="lectureArchiveContent" rows="13">${lectureArchive.lectureArchiveContent }</textarea>
											</td>
										</tr>
									</table>
									
									<table id="lmsTable" class="table" style="margin-top:20px; text-align:center;">
										<tr>
											<td style="width:20%;">첨부파일</td>
											<td>
												<c:forEach var="laf" items="${lectureArchive.lectureArchiveFileList}">
													<c:if test="${laf.lectureArchiveFileOriginal != null}">
													<div>
														<span id="${laf.lectureArchiveFileOriginal}">${laf.lectureArchiveFileOriginal}
															<a class="btn btn-sm btn-outline-danger" style="border-radius:4px; margin-left:10px;" href="${path}/teacher/lectureArchiveOneFileRemove/${laf.lectureArchiveFileUuid}/${lectureArchiveNo}/${teacherId}/${lectureNo}" onclick="return confirm('파일을 삭제하시겠습니까?');">삭제</a>
														</span>
													</div>
													</c:if>
												</c:forEach>
												<div id="fileinput"></div>
											</td>
											<td>
												<div>
													<button class="btn btn-outline-success" style="border-radius:4px;" type="button" id="addBtn">파일추가</button>
													<button class="btn btn-outline-danger" style="border-radius:4px;" type="button" id="delBtn">파일삭제</button>
												</div>
											</td>
										</tr>
									</table>
									<a class="btn btn-outline-secondary text-dark" style="border-radius:4px; float:left;" href="${path}/teacher/lectureArchiveOne/${teacherId}/${lectureNo}/${lectureArchiveNo}">뒤로가기</a>
									<button class="btn btn-outline-secondary" style="border-radius:4px; float:right;" type="button" id="submitBtn">작성완료</button>
								</form>
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
</body>
<script>
	$(document).ready(function() {
		// SmartEditor2 스크립트 추가
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : 'lectureArchiveContent',
			sSkinURI : '${path}/smarteditor2/SmartEditor2Skin.html',
			fCreator : 'createSEditor2'
	})
	$('#addBtn').click(function(){
		let html= '<div><input type="file" class="form-control" name="lectureArchiveFile" class="lectureArchiveFile"></div>';	
		$('#fileinput').append(html);
	});
	
	$('#delBtn').click(function(){
		$('#fileinput').children().last().remove();
	});
	$('#submitBtn').click(function(){
			let ck = true;
			oEditors.getById["lectureArchiveContent"].exec("UPDATE_CONTENTS_FIELD", []);
			$('.lectureArchiveFile').each(function(index, item){
				if($(item).val()==''){
					ck = false;	
				}
			})
			if(ck == false){
				alert('파일을 선택해 주세요');
			}
			else if($('#lectureArchiveTitle').val() ==""){
				alert('제목을 입력해주세요.');
				}
			else if($('#lectureArchiveContent').val() == '<p>&nbsp;</p>' ||$('#lectureArchiveContent').val() == ''){
				alert('내용을 입력해주세요.');
				}
			else{
				$('#lectureArchiveModify').submit();
			}
		})
	})
</script>
</html>