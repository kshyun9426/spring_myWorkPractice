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
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>"/>
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>"/>
					<input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
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

<!-- 댓글처리하는 javascript모듈 -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">

	var bnoValue = "<c:out value='${board.bno}'/>";

	console.log("=====================");
	console.log("REPLY ADD TEST");
	//replyService의 add()에 던져야 하는 파라미터는 JavaScript의 객체 타입으로 만들어서 전송해 주고, Ajax전송 결과를 처리하는 함수를 파라미터로 같이 전달
	replyService.add({reply:"JS TEST", replyer: "tester", bno: bnoValue}
		,function(result){
			alert("RESULT: " + result);	
		}
	);
	
	console.log("=====================");
	console.log("REPLY LIST TEST");
	replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i=0, len=list.length||0; i<len; i++){
			console.log(list[i]);
		}
	});
	
	
	console.log("=====================");
	console.log("REPLY REMOVE TEST");
	replyService.remove(1, function(count){
		console.log(count);
		if(count === "success"){
			alert("REMOVED");
		}}
		,function(error){
			alert("ERROR....");
		}
	);
	
	console.log("=====================");
	console.log("REPLY UPDATE TEST");
	replyService.update({rno:18, bno:bnoValue, reply:"modified reply..."},
			function(result){
				alert("수정 완료");
			}
	);
</script>

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











