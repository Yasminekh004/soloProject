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
		<div class="actions  navbar navbar-expand-lg">	
			<h1 class="title">
				<c:out value='${chore.title}'></c:out>
			</h1>
			<div class="nav-actions">
				<a href="/" class="btn button_sub">Back</a> 
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!" class="btn button_sub"  />
				</form>
			</div>
		</div>
		<div class="details">
			<div>
				<div>
					<p>description: <c:out value='${chore.description}'></c:out></p>
					<p>Posted by:
						<c:if test="${user.id == chore.choreCreater.id}">
							You
						</c:if>
						<c:if test="${user.id != chore.choreCreater.id}">
							<c:out	value='${chore.choreCreater.firstName} ${chore.choreCreater.lastName}'></c:out>
						</c:if>
					</p>
					<p>Posted on: <fmt:formatDate pattern="MMMM dd, y" value="${chore.createdAt}" /></p>
					<p>Due Date: <c:out value="${chore.dueDate}" /></p>
				</div>
				<c:if test="${subChoreListSize > 0 && chore.userChores.id == user.id}">
					<div>
						Progress : <span id="progress">${doneSubChoreListSize}</span>/${subChoreListSize}
					</div>
				</c:if>
				
				<div class="Stretch">
					<c:if test="${subChoreListSize > 0}">
						<h3>Sub-Chores:</h3>
						<c:if test="${chore.userChores.id == user.id}">
							<c:forEach var="subChoreOne" items="${subChoreList}">
								<div class="form-check">
									<form:form method="get" action="/chore/${chore.id}/markAsDone/${subChoreOne.id}">
									<c:if test="${subChoreOne.doneSub}">
										<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" checked="checked" disabled="disabled">
									</c:if>
									<c:if test="${!subChoreOne.doneSub}">
										<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" 
										 onchange="this.form.submit()">
									</c:if>
									</form:form>
									<c:out value='${subChoreOne.title}'></c:out>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${chore.userChores.id != user.id}">
							<ul>
								<c:forEach var="subChoreOne" items="${subChoreList}">
									<li><c:out value='${subChoreOne.title}'></c:out></li>
								</c:forEach>
							</ul>
						</c:if>
					</c:if>
				</div>
			</div>
			<div>
				<c:choose>
					<c:when test="${chore.difficulty == 'Easy'}">
						<img alt="Eazy" src="/img/Easy.png">
					</c:when>
					<c:when test="${chore.difficulty == 'Medium'}">
						<img alt="Medium" src="/img/Medium.png">
					</c:when>
					<c:when test="${chore.difficulty == 'Hard'}">
						<img alt="Hard" src="/img/Hard.png">
					</c:when>
				</c:choose>
			</div>
		</div>
		<div class="actions btn_action">
			<c:if test="${isAddedToUser == 0}">
				<c:if test="${!user.roles.get(0).name.contains('ROLE_ADMIN')}">
					<a href="/chores/addToUser/${chore.id}/add" class="btn button_sub" >add</a>
				</c:if>
				<c:if test="${user.id == chore.choreCreater.id}">
					<a href="/chores/edit/${chore.id}" class="btn button_sub" >edit</a>					
					<a href="/delete/${chore.id}" class="btn btn-outline-danger"> cancel </a>
				</c:if>
			</c:if>	
		</div>
	</div>
</body>
</html>