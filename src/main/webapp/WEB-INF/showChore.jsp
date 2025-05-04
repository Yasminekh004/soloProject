<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Listing</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script src="/js/script.js"></script>	
</head>
<body>
	<div class="container info">
		<h1 class="title">
			<c:out value='${chore.title}'></c:out>
		</h1>
		<div class="title">
			<a href="/">Back</a> 
			<form id="logoutForm" method="POST" action="/logout">
				<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="submit" value="Logout!" />
			</form>
		</div>
		<div>
			<p><c:out value='${chore.description}'></c:out></p>
			<p>Location:<c:out value='${chore.location}'></c:out></p>
			<p>Posted by:<c:out	value='${chore.choreCreater.firstName} ${chore.choreCreater.lastName}'></c:out></p>
			<p> Posted on: <fmt:formatDate pattern="MMMM dd, y" value="${chore.createdAt}" /></p>
		</div>
		<c:if test="${subChoreListSize > 0 && chore.userChores.id == idUser}">
			<div>
				Progress : <span id="progress">0</span>/${subChoreListSize}
			</div>
		</c:if>
		
		<div class="Stretch">
			<c:if test="${subChoreListSize > 0}">
				<h3>Sub-Chores:</h3>
				<c:if test="${chore.userChores.id == idUser}">
					<c:forEach var="subChoreOne" items="${subChoreList}">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault"  onclick="disableIfChecked(this)">
							<c:out value='${subChoreOne.title}'></c:out>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${chore.userChores.id != idUser}">
					<ul>
						<c:forEach var="subChoreOne" items="${subChoreList}">
							<li><c:out value='${subChoreOne.title}'></c:out></li>
						</c:forEach>
					</ul>
				</c:if>
			</c:if>
		</div>
	</div>
</body>
</html>