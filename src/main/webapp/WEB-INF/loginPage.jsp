<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
</head>
<body>
	<div class="container info">
	<h1 id="title">Welcome to Chore Tracker</h1>
		
		<c:if test="${logoutMessage != null}">
			<div class="text-success"><c:out value="${logoutMessage}"></c:out></div>
		</c:if>
		<c:if test="${errorMessage != null}">
			<div class="text-danger"><c:out value="${errorMessage}"></c:out></div>
		</c:if>
		
		<div class="main">
			<form:form action="/login" method="post" modelAttribute="user">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<table class="table table-bordered border-dark">
					<thead>
						<tr>
							<td colspan="2" class="text-center"><h3>Log In</h3></td>
						</tr>
					</thead>
					<thead>
						<tr>
							<td>Email:</td>
							<td><form:errors path="email" class="text-danger" /> <form:input
									class="form-control" type="email" path="email" /></td>
						</tr>
						<tr>
							<td>Password:</td>
							<td><form:errors path="password" class="text-danger" /> <form:input
									class="form-control" type="password" path="password" /></td>
						</tr>
						<tr>
							<td colspan=2><input class="button_sub btn"
								type="submit" value="Submit" /></td>
						</tr>
					</thead>
				</table>
			</form:form>
			
			
	
			<form:form action="/register" method="post" modelAttribute="user">
				<table class="table table-bordered border-dark">
					<thead>
						<tr>
							<td colspan="2" class="text-center"><h3>Register</h3></td>
						</tr>
					</thead>
					<thead>
						<tr>
							<td>First Name:</td>
							<td><form:errors path="firstName" class="text-danger" /> <form:input
									class="form-control" path="firstName" /></td>
						</tr>
						<tr>
							<td>Last Name:</td>
							<td><form:errors path="lastName" class="text-danger" /> <form:input
									class="form-control" path="lastName" /></td>
						</tr>
						<tr>
							<td>Email:</td>
							<td><form:errors path="email" class="text-danger" /> <form:input
									class="form-control" type ="email" path="email" /></td>
						</tr>
						<tr>
							<td>Password:</td>
							<td><form:errors path="password" class="text-danger" /> <form:input
									class="form-control" type="password" path="password" /></td>
						</tr>
						<tr>
							<td>Confirm PW:</td>
							<td><form:errors path="confirm" class="text-danger" /> <form:input
									class="form-control" type="password" path="confirm" /></td>
						</tr>
						<tr>
							<td colspan=2><input class="button_sub btn" 
								type="submit" value="Submit" /></td>
						</tr>
					</thead>
				</table>
			</form:form>	
		</div>	
	</div>

</body>
</html>