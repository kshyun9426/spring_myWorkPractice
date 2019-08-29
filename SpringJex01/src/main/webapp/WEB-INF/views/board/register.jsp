<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>

<div class="bigPictureWrapper">
	<div class="bigPicture">
			
	</div>
</div>
<style>
	.uploadResult {
		width:100%;
		background-color:gray;
	}
	
	.uploadResult ul {
		display:flex;
		flex-flow:row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style:none;
		padding: 10px;
	}
	
	.uploadResult ul li img {
		width:100px;
	}
	
	.uploadResult ul li span {
		color: red;
	}
	
	.bigPictureWrapper {
		position: absoulte;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background:rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		widtH:600px;
	}
</style>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title" />
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea class="form-control" rows="3" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer" 
								value="<sec:authentication property='principal.username'/>" readonly="readonly"/>
					</div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">File Attach</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple />
				</div>
				<div class="uploadResult">
					<ul>
						<!-- 업로드된 파일들이 보여질 공간 -->
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(e){
		
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			var str="";
			$(".uploadResult ul li").each(function(i, obj){
				//<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid 
				//+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image +"'>
				var jObj = $(obj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jObj.data("filename") + "'/>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jObj.data("uuid") + "'/>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jObj.data("path") + "'/>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jObj.data("type") + "'/>";
			});
			formObj.append(str).submit();
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
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
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
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
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
		
		//업로드된 파일의 x버튼 클릭시 삭제처리하는 이벤트
		$(".uploadResult").on("click", "button", function(e){
			//console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url: "/deleteFile",
				data: {fileName:targetFile, type:type},
				type: "POST",
				dataType: "text",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				success: function(result){
					alert(result);
					targetLi.remove(); //li태그가 없어지면 input[type='file']이 change된 것이므로 다시 showUploadResult()함수를 실행시킴
				}
			});
		});
	});
</script>

<%@include file="../includes/footer.jsp"%>



































