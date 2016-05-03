<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file='static/head.html'%>
<body>
	<%@include file='static/header.html'%>

	<section id="main">
		<div class="container">
			<div class="row">
				<div class="col-xs-8 col-xs-offset-2 box">
					<div class="label label-default pull-right">id:
						${computer.id}</div>
					<h1>Edit Computer</h1>

					<form id="editComputer" action="editComputer" method="POST">
						<input type="hidden" value="0" />
						<fieldset>
							<div class="form-group">
								<label for="computerName">Computer name</label> <input
									type="text" class="form-control" id="computerName" required="required" minlength="3"
									value="${computer.name}">
							</div>
							<div class="form-group">
								<label for="introduced">Introduced date (YYYY-MM-dd) :</label> <input
									type="text" class="form-control" id="introduced" name="introduced"
									value="${computer.introduced}">
							</div>
							<div class="form-group">
								<label for="discontinued">Discontinued date (YYYY-MM-dd) :</label> <input
									type="text" class="form-control" id="discontinued" name="discontinued"
									value="${computer.discontinued}">
							</div>
							<div class="form-group">
								<label for="companyId">Company</label> <select
									class="form-control" id="companyId" name="companyId">
									<c:forEach var="company" items="${companyList}">
										<option value="${company.id}" <c:if test="${company.id == computer.companyId}">selected</c:if> >${company.name}</option>
									</c:forEach>
								</select>
							</div>
						</fieldset>
						<div class="actions pull-right">
							<input type="submit" value="Edit" class="btn btn-primary">
							or <a href="dashboard.html" class="btn btn-default">Cancel</a>
						</div>
					</form>
					
					<!-- Form validation -->
					<!-- JQuery -->
					<script src="js/jquery.min.js"></script>
					<!-- JQuery form validator -->
					<script src="js/jquery.validate.js"></script>

					<!-- Form validator -->
					<script>
						$("#editComputer").validate({
							rules : {
								introduced : {
									dateISO : true
								},
								discontinued : {
									dateISO : true
								}
							}
						});
					</script>
				</div>
			</div>
		</div>
	</section>
</body>
</html>