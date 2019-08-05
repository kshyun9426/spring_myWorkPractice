<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board List Page
				<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Button</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
						<c:forEach items="${list}" var="board">
						<tr>
							<td><c:out value="${board.bno}"/></td>
							<td>
								<a class="move" href='<c:out value="${board.bno}"/>'>
									<c:out value="${board.title}"/>
								</a>
							</td>
							<td><c:out value="${board.writer}"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}"/></td>
						</tr>
						</c:forEach>
					</thead>
				</table>
				<!-- table태그의 끝 -->
				
				<div class="row">
					<div class="col-lg-12">
						<form id="searchForm" action="/board/list" method="GET">
							<select name="type">
								<option value=""
									<c:out value="${pageMaker.cri.type==null ? 'selected' : ''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}"/>>제목 or 작성자 or 내용</option>
							</select>
							<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
							<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
							<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
							<button class="btn btn-default">Search</button>
						</form>
					</div>
				</div>
				
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage-1}">Previous</a>
							</li>
						</c:if>
						
						<c:forEach begin="${pageMaker.startPage}" var="num" end="${pageMaker.endPage}">
							<li class="pagination_button ${pageMaker.cri.pageNum == num ? "active" : ""}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage+1}">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
				<!-- end Pagination -->
				
				<form id="actionForm" action="/board/list" method="GET">
					<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>
					<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
					<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>"/>
					<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
				</form>
				
				<!-- Modal 추가 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- end panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<%@include file="../includes/footer.jsp" %>


<script type="text/javascript">
	$(document).ready(function(){
		
		var result = '<c:out value="${result}"/>';
		
		checkModal(result); //먼저 모달을 띄우는데(result가 존재한다면)
		
		history.replaceState({},null,null); //뒤로가기를 하면 다시 모달을 띄워질 수가 있기 때문에 
		
		function checkModal(result) {
			
			if(result === '' || history.state){
				return;
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show"); //화면에 모달창이 보임
		}
		
		//Register New Button 버튼 눌렀을 때 호출하는 이벤트함수 구현
		$("#regBtn").on("click", function(){
			self.location="/board/register"; //GET방식
		});
		
		//페이지 번호 클릭 이벤트 처리
		var actionForm = $("#actionForm");
		$(".pagination_button a").on("click", function(e){
			
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		//각 게시글의 제목클릭시 게시글조회페이지로 이동하기 위한 클릭이벤트처리
		$(".move").on("click", function(e){
			
			e.preventDefault();
			
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
		//검색버튼을 클릭하면 검색은 1페이지를 하도록 수정하고, 화면에 검색 조건과 키워드가 보이게 처리하는 작업
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요!");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요!");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1"); //1페이지로 
			e.preventDefault();
			searchForm.submit();
		});
	});
</script>




















