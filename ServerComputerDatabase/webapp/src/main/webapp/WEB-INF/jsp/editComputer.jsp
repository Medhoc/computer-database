<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<%@include file='../template/head.jsp'%>
<body>
	<%@include file='../template/header.jsp'%>

	<section id="main">
		<div class="container">
			<div class="row">
				<div class="col-xs-8 col-xs-offset-2 box">
					<div class="label label-default pull-right">id:
						${computer.id}</div>
					<h1>
						<spring:message code="form.EditComputer" />
					</h1>

					<form id="editComputer" action="editComputer" method="POST">
						<!-- We include the CSRF token in the request, because of Spring Security -->
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							
						<input type="hidden" id="id" name="id" value="${computer.id}" />

						<fieldset>
							<div class="form-group">
								<label for="computerName"><spring:message
										code="form.ComputerName" /></label> <input type="text"
									class="form-control" id="name" name="name" required="required"
									minlength="3" value="${computer.name}">
							</div>
							<div class="form-group">
								<label for="introduced"><spring:message
										code="form.IntroducedDate" /></label> <input type="text"
									class="form-control" id="introduced" name="introduced"
									value="${computer.introduced}">
							</div>
							<div class="form-group">
								<label for="discontinued"><spring:message
										code="form.DiscontinuedDate" /></label> <input type="text"
									class="form-control" id="discontinued" name="discontinued"
									value="${computer.discontinued}">
							</div>
							<div class="form-group">
								<label for="companyId"><spring:message
										code="form.Company" /></label> <select class="form-control"
									id="companyId" name="companyId">
									<c:forEach var="company" items="${companyList}">
										<option value="${company.id}"
											<c:if test="${company.id == computer.companyId}">selected</c:if>>${company.name}</option>
									</c:forEach>
								</select>
							</div>
						</fieldset>
						<div class="actions pull-right">
							<input type="submit" value="<spring:message code="form.Edit" />"
								class="btn btn-primary"> or <a href="dashboard"
								class="btn btn-default"><spring:message code="form.Cancel" /></a>
						</div>
					</form>

					<!-- Form validation -->
					<!-- JQuery -->
					<script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
					<!-- JQuery form validator -->
					<script src="<c:url value="/resources/js/jquery.validate.js"/>"></script>

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