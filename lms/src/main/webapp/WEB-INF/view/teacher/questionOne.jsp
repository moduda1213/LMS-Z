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
<title>questionOne</title>
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
                        <h3 class="page-title text-truncate text-dark font-weight-medium mb-1">질문 상세보기</h3>
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
                    <div class="col-lg-12 col-md-12">
                        <div class="card" id="cardStyle">
                            <div class="card-body">
				<table id="lmsNoticeTable" class="table table">
					<tr>
						<th style="width:10%;">번호 :</th>
						<td>${question.questionNo}</td>
					</tr>
					<tr>
						<th>글쓴이 :</th>
						<td>${question.questionWriter}</td>
					</tr>
					<tr>
						<th>제목 :</th>
						<td>${question.questionTitle}</td>
					</tr>
					<tr>
						<th>내용 :</th>
						<td>${question.questionContent}</td>
					</tr>
				</table>
				<h3>질문게시판 첨부파일</h3>
				<table id="lmsNoticeTable" class="table table">
					<c:forEach var="qf" items="${question.questionfile}">
						<tr>
						<c:if test="${qf.questionFileUuid == null}">
							<td>첨부파일이 없습니다</td>
						</c:if>
						<c:if test="${qf.questionFileUuid != null}">
							<th>question_file</th>
							<td><a href="${path}/teacher/questionFileDownload/${qf.questionFileUuid}">${qf.questionFileOriginal}</a></td>
						</c:if>
						</tr>
					</c:forEach>
				</table>
				
				
				<h3>질문댓글게시판</h3>
				<table id="lmsNoticeTable" class="table table">
					<thead>
						<tr>
							<th>댓글 번호</th>
							<th>글쓴이</th>
							<th>내용</th>
							<th>최근 작성 날짜</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="qc" items="${question.questionCommentList}">
						<tr>
							<c:if test="${qc.questionCommentNo != 0}">
								<td>${qc.questionCommentNo}</td>
								<td>${qc.questionCommentWriter}</td>
								<td>${qc.questionCommentContent}</td>
								<td>${qc.questionCommentUpdatedate}</td>
								<c:if test="${qc.accountId == teacherId}">
								<td><a class="btn btn-info" style="border-radius: 4px;" href="${path}/teacher/modifyQuestionComment/${qc.questionCommentNo}/${currentPage}">수정</a></td>
								<td><a onclick="btn('${qc.questionNo}', '${qc.questionCommentNo}')" class="btn btn-outline-danger" style="border-radius: 4px;" href="javascript:click()">삭제</a></td>
								</c:if>
								<c:if test="${qc.accountId != teacherId}">
								<td></td>
								<td></td>
								</c:if>
							</c:if>
							
							<c:if test="${qc.questionCommentNo == 0}">
								<td colspan="6">댓글이 없습니다.</td>
							</c:if>
						</tr>
						</c:forEach>
		
					</tbody>
				</table>
				
				<!-- 숫자로 페이징 -->
                <div id="paging" style="text-align: center; padding: 7px;">
						   		<!-- 첫페이지이고 전체 페이지가 '1'이 아닌 경우 이전버튼 표시 -->
						   		<c:if test="${startPage!=1 && lastPage!=1}">
						    		<span>
						    			<a href="${path}/teacher/questionOne/${questionNo}/${startPage-10}">이전</a>
						    		</span>
						   		</c:if>
						   		<!-- lastPage가 10개를 채울수 없을 때 -->
						   		<c:if test="${startPage+9 > lastPage }">
						     	<c:forEach var="i" begin="${startPage }" end="${lastPage}">
						     		<!-- 현재 페이지일 경우 -->
						     		<c:if test="${currentPage == i }">
							      		<span>
							      			<a id="pagingStyle" class="bg-secondary font-18">${i}</a>
							      		</span>
						     		</c:if>
						     		<!-- 현재 페이지가 아닐 경우 -->
						     		<c:if test="${currentPage != i }">
							      		<span>
							      			<a class="font-18" href="${path}/teacher/questionOne/${questionNo}/${i}">${i}</a>
							      		</span>
						     		</c:if>
						     	</c:forEach>
						    	</c:if>
						    	<c:if test="${startPage+9<lastPage }">
						    		<c:forEach var="i" begin="${startPage }" end="${startPage+9}">
							     		<!-- 현재 페이지일 경우 -->
							     		<c:if test="${currentPage == i }">
								      		<span>
								      			<a id="pagingStyle" class="bg-secondary font-18">${i}</a>
								      		</span>
							     		</c:if>
							     		<!-- 현재 페이지가 아닐 경우 -->
							     		<c:if test="${currentPage != i }">
								      		<span>
								      			<a class="font-18" href="${path}/teacher/questionOne/${questionNo}/${i}">${i}</a>
								      		</span>
							     		</c:if>
						     		</c:forEach>
						    	</c:if>
						    	<!-- 한페이지에서 보여지는 10개의 페이지보다 마지막 페이지가 크고 / 마지막페이지가 시작페이지와 같이 않다면-->
						    	<c:if test="${startPage+9<lastPage && lastPage != startPage}">
							     	<span>
							     		<a href="${path}/teacher/questionOne/${questionNo}/${startPage+10}">다음</a>
							     	</span>
						    	</c:if>
						   	</div>
		
		
		<c:forEach var="qc" items="${question.questionCommentList}">
			
		</c:forEach>
		<!-- 댓글 추가 -->
		<form method="post" action="${path}/teacher/addQuestionComment">
			<input type="hidden" name="questionNo" value="${question.questionNo}">
			<input type="hidden" name="accountId" value="${teacherId}">
			작성자<br><input class="form-control" style="width:100%;" type="text" name="questionCommentWriter"><br>
			댓글<br><textarea class="form-control" style="width:100%;" name="questionCommentContent" rows="3" cols="50"></textarea>
			<br>
			<button class="btn btn-success" style="border-radius: 4px; float:right;"  type="submit">댓글입력</button>
			<a class="btn btn-outline-secondary"style="border-radius: 4px;" href="${path}/teacher/questionList/${question.lectureNo}/1">뒤로가기</a>
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

    function btn(questionNo, questionCommentNo){
	    	if (confirm("정말 삭제하시겠습니까?") == true){ // 확인
				location.href = '${path}/teacher/removeQuestionComment/' + questionNo + '/' + questionCommentNo + '/${currentPage}';
			}else{   //취소
			    return;
			}
        }

    </script>
</body>
</html>