<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">Board Modify Page</div>
			
			<div class="panel-body">
				<form role="form" action="/board/modify" method="POST">			
				
					<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>"/>
					<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>"/>
					<input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
					
					<div class="form-group">
						<label>Bno</label> 
						<input class="form-control" name="bno" value="<c:out value='${board.bno}'/>" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>Title</label> 
						<input class="form-control" name="title" value="<c:out value='${board.title}'/>"/>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="content" ><c:out value='${board.content}'/>
						</textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name="writer" value="<c:out value='${board.writer}'/>" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label>RegDate</label>
						<input class="form-control" name="regdate" 
							value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.regdate}'/>" readonly="readonly">
					</div>
					<div class="form-group">
						<label>Update Date</label>
						<input class="form-control" name="updatedate" 
							value="<fmt:formatDate pattern='yyyy/MM/dd' value='${board.updatedate}'/>" readonly="readonly"> 
					</div>
					<button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
					<button type="submit" data-oper="list" class="btn btn-info">List</button>
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
	$(document).ready(function() {
		
		var formObj = $("form");
		
		$("button").on("click", function(e){
			
			e.preventDefault(); //submit작동을 일단 못하게 막음
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			//remove버튼을 눌렀을 때 폼의 action을 변경
			if(operation === "remove"){
				formObj.attr("action", "/board/remove");
			}else if(operation === "list"){
				formObj.attr("action", "/board/list").attr("method", "GET");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				
				formObj.empty(); //리스트로의 이동은 아무런 파라미터가 없기 때문에 <form>태그의 모든 내용은 삭제한 상태로 submit()을 진행한다.
				
				//목록페이지의 번호와 갯수를 추가함(위에서 empty()시켰기 때문에)
				formObj.append(pageNumTag); 
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
			}
			formObj.submit();
		});
	});
</script>




















