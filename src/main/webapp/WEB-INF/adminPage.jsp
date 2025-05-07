<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<title>Admin Dashboard</title>
</head>
<body>
	<div class="container">
		<div class="actions">
			<h1>Welcome, ${currentUser.firstName}</h1>
			
			<div class="nav-actions">			
				<a href="/chores/new" class="btn button_sub">Add A Job</a>
			
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="submit" value="Logout!"  class="btn button_sub"/>
				</form>
			</div>
		</div>


		<table class="table table-bordered border-dark">
			<thead>
				<tr>
					<th>Name</th>
					<th>Total Points</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${users}">
					<c:if test="${!user.roles.get(0).name.contains('ROLE_ADMIN')}">
						<tr>
							<td><a href="/user/${user.id}">${user.firstName}
									${user.lastName}</a></td>
							<td>${user.totalPoints}</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>