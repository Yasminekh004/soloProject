<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User Info</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
	<div class="container info">
		<h2><c:out value="${userInfo.firstName}"></c:out>'s info list</h2>
		<form id="logoutForm" method="POST" action="/logout">
			<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" /> <input type="submit" value="Logout!" />
		</form>
		<a href="/">Back</a>
		
		<div class="userInfoPage">
			<table class="table table-striped table-bordered border-dark">
				<thead>
					<tr>
						<th>${userInfo.firstName} Jobs</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="userChore" items="${userChores}">
						<tr>
							<td><span class="dueDateTitle"><c:out value='${userChore.title}'></c:out></span></td>							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
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
								<form action="/chores/${allChore.id}" method="post">
									<input type="hidden" name="_method" value="delete"> <input
										type="submit" value="cancel" class="text-start deleteBtn">
								</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		
		
	</div>
</body>
</html>