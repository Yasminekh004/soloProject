<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Your Profile</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link rel="stylesheet" type="text/css" href="/css/profile.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

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
			<div class="row gutters-sm">
				<div class="col-md-4 mb-3">
	              <div class="card">
	                <div class="card-body"> 
	                  <div class="d-flex flex-column align-items-center text-center">
		                  <c:if test="${currentUser.imgName == null}">
		                  	<form:form action="/addImg/${currentUser.id}" method="post" modelAttribute="imgUser" enctype="multipart/form-data">
		                  		<input type="hidden" name="_method" value="put">
							  	<div class="profile-picture">								   
								    <input type="file" id="fileUpload" name="filename" accept="image/*" class="file-uploader">
						  		</div>
							  	<input type="submit" value="Upload">
							</form:form>
		                  </c:if>
		                  <c:if test="${currentUser.imgName != null}">
		                  	<img src="/img/${currentUser.imgName}" alt="Img of ${currentUser.firstName}" class="rounded-circle" width="150">		                  	
		                  </c:if>
	                    <div class="mt-3">
	                      <h4>${currentUser.firstName} ${currentUser.lastName}</h4>
	                    </div>
	                  </div>
	                </div>
	              </div>
				</div>
				<div class="col-md-8">
	              <div class="card mb-3">
	                <div class="card-body">
	                  <div class="row">
	                    <div class="col-sm-3">
	                      <h6 class="mb-0">First Name</h6>
	                    </div>
	                    <div class="col-sm-9 text-secondary" id="firstName">                      	
							${currentUser.firstName}						    
	                    </div>
	                  </div>
	                  <hr>
	                  <div class="row">
	                    <div class="col-sm-3">
	                      <h6 class="mb-0">Last Name</h6>
	                    </div>
	                    <div class="col-sm-9 text-secondary">
	                      ${currentUser.lastName}
	                    </div>
	                  </div>
	                  <hr>
	                  <div class="row">
	                    <div class="col-sm-3">
	                      <h6 class="mb-0">Email</h6>
	                    </div>
	                    <div class="col-sm-9 text-secondary">
	                      ${currentUser.email}
	                    </div>
	                  </div>
	                  <hr>                  
	                  <div class="row">
	                    <div class="col-sm-3">
	                      <h6 class="mb-0">Points</h6>
	                    </div>
	                    <div class="col-sm-9 text-secondary">
	                      ${currentUser.totalPoints}
	                    </div>
	                  </div>
	                </div>
	              </div>
				</div>
			</div>
		</div>
	</div>
		<script src="/js/script.js"></script>
</body>
</html>