<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User Info</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script src="/js/script.js"></script>
</head>
<body>
	<div class="container info">
		
		
		<div class="actions navbar navbar-expand-lg">	
			<h1 style="margin-bottom: 10px;">
				<c:out value="${userInfo.firstName}"></c:out>'s info list
			</h1>		
			
			<div class="nav-actions">
				<a href="/">Back</a>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="submit" value="Logout!" />
				</form>				
			</div>
		</div>
		
		

		<div class="userInfoPage">
			<div class="tableWrapper">
				<table class="table table-striped table-bordered border-dark">
					<thead>
						<tr>
							<th>${userInfo.firstName} Jobs</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="userChore" items="${userChores}">
							<tr>
								<td><span class="dueDateTitle"><c:out
											value='${userChore.title}'></c:out></span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="tableWrapper">
				<div>Page ${currentPage + 1} of ${totalPages}</div>

				<div>
					<c:if test="${currentPage > 0}">
						<a href="?page=${currentPage - 1}&size=4" >Previous</a>
					</c:if>

					<c:if test="${currentPage + 1 < totalPages}">
						<a href="?page=${currentPage + 1}&size=4">Next</a>
					</c:if>
				</div>
				<table class="table table-striped table-bordered border-dark">
					<thead>
						<tr>
							<th>Job</th>
							<th>Due date</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="allChore" items="${allChores.content}">
							<tr>
								<td><c:out value='${allChore.title}'></c:out></td>
								<td>${allChore.dueDate}</td>
								<td><a href="/chores/${allChore.id}">View</a> <a
									href="/chores/addToUser/${userInfo.id}/chore/${allChore.id}/add">add</a>
									<a href="/chores/edit/${allChore.id}">edit</a>
									<a href="/delete/${chore.id}" class="btn btn-outline-danger"> cancel </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<button class="btn btn-primary" onclick="commentButton()">Add Comment</button>
			<div id="myComment" style="display: none; margin-top: 10px;">
				<form:form action="/comment/${userInfo.id}/add" method="post" modelAttribute="comment">
					<form:label path="commentText" class="col-form-label">Comment:</form:label>
					<form:textarea path="commentText" class="form-control" rows="3" placeholder="Write your comment..." style="width: 100%;"/>  
					<form:errors path="commentText" class="text-danger" />
					<button class="button_sub btn">Submit</button>
				</form:form>
			</div>
	</div>
</body>
</html>