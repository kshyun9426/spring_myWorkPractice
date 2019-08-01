<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body">
				
				<div class="form-group">
					<label>Bno</label> 
					<input class="form-control" name="bno" value="<c:out value='${board.bno}'/>" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label>Title</label> 
					<input class="form-control" name="title" value="<c:out value='${board.title}'/>" readonly="readonly"/>
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value='${board.content}'/>
					</textarea>
				</div>
				<div class="form-group">
					<label>Writer</label>
					<input class="form-control" name="writer" value="<c:out value='${board.writer}'/>" readonly="readonly"/>
				</div>
				<button class="btn btn-default" data-oper="modify">Modify</button>
				<button class="btn btn-info" data-oper="list">List</button>
				<form id="operForm" action="/board/modify" method="GET">
					<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>"/>
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel panel-default -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- ./row -->

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		var operForm = $("#operForm");
		
		//$("button[data-oper='modify']")문법 설명
		//https://api.jquery.com/attribute-equals-selector/
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove(); //id="bno" 가 속한 태그를 지움
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
</script>











