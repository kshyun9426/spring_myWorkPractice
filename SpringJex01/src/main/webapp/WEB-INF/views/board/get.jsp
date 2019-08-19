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

<div class="bigPictureWrapper">
	<div class="bigPicture">
	
	</div>
</div>

<style>
.uploadResult{
	width: 100%;
	background-color: gray;	
}

.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img{
	width: 100px;
}

.uploadResult ul li span{
	color: white;
}

.bigPictureWrapper {
	position: absoluite;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img{
	width: 600px;
}
</style>

<!-- 첨부파일 관련 div -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel panel-heading">Files</div>
			<div class="panel-body">
				<div class="uploadResult">
					<ul>
					<!-- 첨부파일 보열 줄 곳 -->
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<!-- 댓글 공간 -->
				</ul>
			</div>
			<div class="panel-footer">
				<!-- 댓글 페이지 번호출력 -->
			</div>
		</div>
		<!-- /.panel panel-default -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- Reply Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="replyModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="modal-group">
					<label>Reply</label>
					<input class="form-control" name="reply" value="New Reply!!!"/>
				</div>
				<div class="modal-group">
					<label>Replyer</label>
					<input class="form-control" name="replyer" value="replyer"/>
				</div>
				<div class="modal-group">
					<label>Reply Date</label>
					<input class="form-control" name="replyDate" value=""/>
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div> 
<!-- /.modal -->

<%@include file="../includes/footer.jsp"%>

<!-- 댓글처리하는 javascript모듈 -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<!-- //TEST CODE
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
	
	console.log("=====================");
	console.log("REPLY GET TEST");
	replyService.get(10, function(data){
		console.log(data);
		}
	);
</script>
 -->
 
<script>
//첨부파일 관련 로딩 함수
$(document).ready(function(){(function(){
		
		var bno = "<c:out value='${board.bno}'/>";
	
		$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
			console.log(arr);
			var str="";
			$(arr).each(function(i, attach){
				if(attach.fileType){ //이미지라면 썸네일 가져오기
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName
						+"' data-type='"+attach.fileType+"'>";
					str += "<div><img src='/display?fileName=" + fileCallPath + "'/></div></li>";	
				}else{
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
						+attach.fileName+"' data-type='"+attach.fileType+"'>";
					str += "<div><span>" + attach.fileName + "</span><br/>";
					str += "<img src='/resources/img/attach.jpg'/></div></li>";
				}
			});
			$(".uploadResult ul").html(str);
		});
	})();
});
</script>
 
<script type="text/javascript">

	

	//댓글 관련 로딩 함수
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
		
		/*댓글 리스트 작업*/
		var bnoValue = "<c:out value='${board.bno}'/>";
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			replyService.getList({bno:bnoValue,page:page||1}, function(replyCnt, list){
				
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum); //마지막 페이지로 이동
					return;
				}
				
				var str="";
				if(list == null || list.length==0){
					return;
				}
				
				for(var i=0, len=list.length || 0; i<len; i++){
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "<div><div class='header'>";
					str += "<strong class='primary-font'>" + list[i].replyer + "</strong>";
					str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "<p>" + list[i].reply + "</p></div></li>";
				}
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
		}
		
		/*모달창 관련 변수*/
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		//댓글 추가 버튼 클릭시 모달창
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id!='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			$(".modal").modal("show");
			
		});
		
		//댓글모달에서 등록버튼 클릭시 
		modalRegisterBtn.on("click", function(e){
			
			var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			};
			
			replyService.add(reply, function(result){
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(-1); //댓글을 등록했으니 리스트를 다시 호출하여 등록된것을 확인시켜줌
			});
		});
		
		//각 댓글 클릭시 모달로 댓글 내용 보이게하고 수정/삭제 버튼 생성
		//<ul>태그의 클래스 'chat'을 이용해서 이벤트를 걸고 실제 이벤트의 대상은 <li>태그가 되도록 한다.(=이벤트 위임 처리)
		$(".chat").on("click", "li", function(e){
			
			var rno = $(this).data("rno");
			
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id!='modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		modalModBtn.on("click", function(e){
			
			var reply = {rno:modal.data("rno"), reply:modalInputReply.val()};
			
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		modalRemoveBtn.on("click", function(e){
			
			var rno = modal.data("rno");
			
			replyService.remove(rno, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			});
		});
		
		/* 댓글 페이지처리 */
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){ //replyCnt는 댓글의 총 갯수
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='" + (startNum-1) + "'>Previous</a></li>";
			}
			
			for(var i=startNum; i<=endNum; i++){
				var active = pageNum == i ? 'active' : '';
				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum+1) + "'>Next</a></li>";
			}
			
			str += "</ul>";
			replyPageFooter.html(str);
		}
		
		//댓글 페이지 클릭 시
		replyPageFooter.on("click", "li a", function(e){
			
			e.preventDefault();
			
			targetPageNum = $(this).attr("href");
							
			console.log("targetPageNum: " + targetPageNum);
			pageNum = targetPageNum
			showList(pageNum);
			
		});
	});
</script>








