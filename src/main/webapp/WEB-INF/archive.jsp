<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Archive</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">	
	<script src="/js/script.js"></script>
</head>
<body>
	<div class="container info">

		<div class="actions navbar navbar-expand-lg">	
			<h1>Your Comments Archive</h1>
			<div class="nav-actions">
				<a href="/" class="btn button_sub">Back</a> 
				<form id="logoutForm" method="POST" action="/logout">
					<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="submit" value="Logout!" class="btn button_sub"  />
				</form>
			</div>
		</div>
		
		<div class="d-flex justify-content-between align-items-center my-3">
		  <div class="fs-5">
		    <span class="badge bg-info text-dark">
		      Page ${currentPageComments + 1} of ${totalPagesComments}
		    </span>
		  </div>
		
		  <nav>
		    <ul class="pagination mb-0">
		      <c:if test="${currentPageComments > 0}">
		        <li class="page-item">
		          <a class="page-link" href="?page=${currentPageComments - 1}&size=4" aria-label="Previous">
		            <span aria-hidden="true">&laquo; Previous</span>
		          </a>
		        </li>
		      </c:if>
		
		      <c:if test="${currentPageComments + 1 < totalPagesComments}">
		        <li class="page-item">
		          <a class="page-link" href="?page=${currentPageComments + 1}&size=4" aria-label="Next">
		            <span aria-hidden="true">Next &raquo;</span>
		          </a>
		        </li>
		      </c:if>
		    </ul>
		  </nav>
		</div>
		
		<table class="table">
			<tbody>
				<c:forEach var="comment" items="${allComments.content}">		    	
					<tr>
						<td><c:out value="${comment.commentText}"/></td>
						<td><a href="/addToFavorie/${comment.id}">						
								<c:if test="${!comment.favorie}">
								<i class="fa-solid fa-star" style="color: gray;" onclick="ChangeStyle(this)"></i>
								</c:if>
								<c:if test="${comment.favorie}">
								<i class="fa-solid fa-star" style="color: yellow;" onclick="ChangeStyle(this)"></i>
								</c:if>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>

</body>
</html>