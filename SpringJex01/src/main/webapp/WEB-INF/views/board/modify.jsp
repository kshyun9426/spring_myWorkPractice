<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

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

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Files</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple"/>
				</div>
				<div class="uploadResult">
					<ul>
						
					</ul>
				</div>			
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>

<script>
	$(document).ready(function(){
		(function(){
			//첨부파일목록 보여주는 작업
			var bno = "<c:out value='${board.bno}'/>";
			$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
				console.log(arr);
				var str="";
				$(arr).each(function(i, attach){
					
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					
					if(attach.fileType){ //이미지라면
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='"  
							+ attach.fileName +"' data-type='" + attach.fileType +"'>";
						str += "<span>" + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times' aria-hidden='true'></i></button><br/>";
						str += "<div><img src='/display?fileName=" + fileCallPath +"'/></div>";
						str += "</li>";
					}else{ //일반파일이라면
						str += "<li data-path='" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='"  
							+ attach.fileName +"' data-type='" + attach.fileType +"'>";
						str += "<span>" + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' ";
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times' aria-hidden='true'></i></button><br/>";
						str += "<div><img src='/resources/img/attach.jpg'/></div>";
						str += "</li>";
					}
				});
				$(".uploadResult ul").html(str);
			});
		})();
		
		//x버튼 클릭시 화면에서 사라지는 작업
		$(".uploadResult").on("click", "button", function(e){
			if(confirm("Remove this file?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtensionAndSize(fileName, fileSize){
			
			if(fileName > maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		
		//서버에 업로드작업
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']"); 
			//console.log(inputFile); //input된 정보들을 가지고 있는데(0:input) 그 중에서 files라는 속성(?)에 업로드할 파일 정보들이 있음
			var files = inputFile[0].files; //fileList{0:File, 1:File, 2:File, length:3}로 반환(파일정보만 가지고있는 정보들을 가져옴)
			for(var i=0; i<files.length; i++){
				if(!checkExtensionAndSize(files[i])){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: "/uploadAjaxAction",
				processData: false,
				contentType: false,
				data: formData,
				type: "POST",
				dataType:"json",
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		
		//(업로드된 파일들을 클라이언트가 확인가능하도록)화면에 출력하는 함수
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0){
				return;
			}
			
			var uploadUL = $(".uploadResult ul");
			
			var str="";
			
			$(uploadResultArr).each(function(i,obj){
				if(obj.image){ //이미지라면 섬네일 이미지를 보여주고 
					var thumbnailFile = encodeURIComponent(obj.uploadPath + "/s_" +  obj.uuid + "_" + obj.fileName);
					str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid 
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image +"'><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' class='btn btn-warning btn-circle' data-file=\'" 
							+ thumbnailFile + "\' data-type='image'>";
					str += "<i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + thumbnailFile + "'/>";
					str += "</div></li>";
				}else{ //일반파일이라면
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName
							+"' data-type='"+obj.image+"'><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' class='btn btn-warning btn-circle' data-file=\'" 
							+ fileCallPath + "\' data-type='file'>";
					str += "<i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.jpg'/>";
					str += "</div></li>";
				}
			});
			uploadUL.append(str);
		}
		
		
	});
</script>

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




















