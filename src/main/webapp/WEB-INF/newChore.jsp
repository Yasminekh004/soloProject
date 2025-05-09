<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>

<meta charset="UTF-8">
	<title>Add A Job</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
	<div class="container info">
		<div class="actions navbar-expand navbar-dark bg-dark">		
			<img alt="Chore Tracker" src="/img/choreTracker.png" width="200px" height="60px">
			<div class="nav-actions">
				<a href="/" class="btn btn-outline-light">Back</a>
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!"  class="btn btn-outline-light" />
				</form>
				
			</div>			
		</div>

		<div class="main">
					<h1 class="title">Add A Job</h1>
		
			<table class="table table-bordered border-dark">				
				<tbody>
					<form:form action="/chores/new" method="post" modelAttribute="chore">
						<tr>
							<td><form:label path="title" class="col-form-label">Title:</form:label></td>
							<td>
								<form:input path="title" class="form-control " /> 
								<form:errors path="title" class="text-danger" />
							</td>
						</tr>
						<tr>
							<td><form:label path="description" class="col-form-label">Description:</form:label></td>
							<td>	
								<form:textarea path="description" class="form-control"/>  
								<form:errors path="description" class="text-danger" />
							</td>
						</tr>	
						<tr>
							<td><form:label path="difficulty" class="col-form-label">Difficulty:</form:label></td>
							<td>	
								<div class="btn-group difficulty-selector" role="group" aria-label="Difficulty levels">
									<form:radiobutton path="difficulty" id="easy" value="Easy" cssClass="btn-check"/>
									<label class="btn btn-outline-success rounded-pill px-4" for="easy">Easy</label>
									
									<form:radiobutton path="difficulty" id="medium" value="Medium" cssClass="btn-check"/>
									<label class="btn btn-outline-warning rounded-pill px-4" for="medium">Medium</label>
									
									<form:radiobutton path="difficulty" id="hard" value="Hard" cssClass="btn-check"/>
									<label class="btn btn-outline-danger rounded-pill px-4" for="hard">Hard</label>
									
								</div>  
								<form:errors path="difficulty" class="text-danger" />
							</td>
						</tr>
						<tr>
							<td><form:label path="dueDate" class="col-form-label">Due Date:</form:label></td>
							<td>	
								<form:input path="dueDate" type="date" class="form-control " /> 
								<form:errors path="dueDate" class="text-danger" />
							</td>
						</tr>
						<tr>
							<td><form:label path="points" class="col-form-label">Points:</form:label></td>
							<td>	
								<form:input path="points" type="number" class="form-control " /> 
								<form:errors path="points" class="text-danger" />
							</td>
						</tr>
						<div class="form-row">
							<form:errors path="choreCreater" class="error"/>
							<form:input type="hidden" path="choreCreater" value="${user.id}" class="form-control"/>
						</div>					
						<tr>
							<td colspan="2" class="text-end">
								<button class="button_sub btn">Submit</button>
							</td>
						</tr>
					</form:form>
				</tbody>
			</table>
		</div>
	
	</div>
</body>
</html>