<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Job</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="/js/script.js"></script>
</head>
<body>
	<div class="container info">
		<div class="actions navbar-expand navbar-dark bg-dark">		
			<img alt="Chore Tracker" src="/img/choreTracker.png" width="200px" height="60px">
			
			<div class="nav-actions">			
				<a href="/" class="btn btn-outline-light">Back</a>			
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					<input type="submit" value="Logout!" class="btn btn-outline-light"/>
				</form>
			</div>
		</div>

		<div class="main">
					<h1>Edit Your Job Posting</h1>
		
			<div class="froms">
				<table class="table table-bordered border-dark">
					<tbody>
						<form:form action="/chores/${chore.id}" method="post"
							modelAttribute="chore">
							<input type="hidden" name="_method" value="put">
							<tr>
								<td><form:label path="title" class="col-form-label">Title:</form:label></td>
								<td><form:input path="title" class="form-control " /> <form:errors
										path="title" class="text-danger" /></td>
							</tr>
							<tr>
								<td><form:label path="description" class="col-form-label">Description:</form:label></td>
								<td><form:textarea path="description" class="form-control" />
									<form:errors path="description" class="text-danger" /></td>
							</tr>
							<tr>
								<td><form:label path="difficulty" class="col-form-label">Difficulty:</form:label></td>
								<td>	
									<div class="btn-group difficulty-selector" role="group" aria-label="Difficulty levels">
										<form:radiobutton path="difficulty" id="easy" value="Easy" cssClass="btn-check"  onclick="getDiff()"/>
										<label class="btn btn-outline-success rounded-pill px-4" for="easy">Easy</label>
										
										<form:radiobutton path="difficulty" id="medium" value="Medium" cssClass="btn-check"  onclick="getDiff()"/>
										<label class="btn btn-outline-warning rounded-pill px-4" for="medium">Medium</label>
										
										<form:radiobutton path="difficulty" id="hard" value="Hard" cssClass="btn-check"  onclick="getDiff()"/>
										<label class="btn btn-outline-danger rounded-pill px-4" for="hard">Hard</label>
										
									</div>  
									<form:errors path="difficulty" class="text-danger" />
								</td>
							</tr>
							<tr>
								<td><form:label path="dueDate" class="col-form-label">Due Date:</form:label></td>
								<td><form:input path="dueDate" type="date"
										class="form-control " /> <form:errors path="dueDate"
										class="text-danger" /></td>
							</tr>
							<tr>
								<td><form:label path="points" class="col-form-label">Points:</form:label></td>
								<td><form:input path="points" type="number"
										class="form-control " id="chorePoint" /> <form:errors path="points"
										class="text-danger" /></td>
							</tr>
							<tr>
								<td colspan="2" class="text-end"><input type="submit"
									class="button_sub btn" value="Submit"></td>
							</tr>
	
						</form:form>
					</tbody>
				</table>
			</div>
		</div>
		<div class="main">
			<h3>Add Sub-Chores:</h3>
	
			<div class="froms">
				<table class="table table-bordered Stretch-table">
					<tbody>
						<form:form action="/chores/${chore.id}/subChore/new" method="post"
							modelAttribute="subChore">
							<tr>
								<td><form:label path="title" class="col-form-label Stretch">Sub-Chore Title:</form:label></td>
								<td><form:input path="title" class="form-control" /> <form:errors
										path="title" class="text-danger" /></td>
							</tr>
							<tr>
								<td colspan="2" class="text-end">
									<button class="button_sub_Stretch btn">Add Sub-Chore</button>
								</td>
							</tr>
						</form:form>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>