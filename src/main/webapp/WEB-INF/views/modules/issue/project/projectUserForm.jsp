<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			
			$('#group').bind('click',function(){
				var projectId = $('#group').val();
				$('#hiddenOfficeId').val(projectId);
				$('#searchForm').submit();
			});
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<ul class="nav nav-tabs">
			<li ><a href="${ctx}/issue/info/list">缺陷列表</a></li>
			<li class="active"><a href="${ctx}/issue/info/form">缺陷添加</a></li>
		</ul>
	</ul><br/>
	
	<form:form id="searchForm" method="post" action="${ctx }/issue/project/user">
		<input type="hidden" name="officeId" id="hiddenOfficeId" value=""/>
		<input type="hidden" name="id"  value="${issueProject.id}"/>
	</form:form>
	
	<form:form id="inputForm" modelAttribute="issueProject" action="${ctx}/issue/project/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label">分配组:</label>
			<div class="controls">
				<form:select path="search.id" id="group">
					<form:options items="${offices}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分配人员:</label>
			<div class="controls">
				<form:checkboxes path="userIdList" items="${users}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
			</div>
			</div>
		
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保    存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>