<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> LmsNoticeList</title>
</head>
<body>
	<h1>Lms 공지사항</h1>
		<table border="1">
			<thead>
				<tr>
					<th>lms_notice_no</th>
					<th>lms_notice_writer</th>
					<th>lms_notice_title</th>
					<th>lms_notice_count</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="l" items="${lmsNoticeList}">
					<tr>
						<td>${l.lmsNoticeNo}</td>
						<td>${l.lmsNoticeWriter}</td>
						<td><a href="${path}/manager/lmsNoticeOne/${l.lmsNoticeNo}">${l.lmsNoticeTitle}</a></td>
						<td>${l.lmsNoticeCount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>