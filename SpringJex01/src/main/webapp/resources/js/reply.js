/*
 * reply.js는 Ajax호출을 담당함
 */
console.log("Reply Module....");

//javascript의 모듈 패턴은 쉽게 설명하면 java의 클래스처럼 Javascript를 이용해서 메서드를 가지는 객체를 구성한다.
//모듈 패턴은 Javascript의 즉시 실행함수와 {}를 이용해서 객체를 구성한다.
var replyService = (function(){
	
	//댓글 추가 함수(객체,콜백)
	//외부에서는 replyService.add(객체,콜백)를 전달하는 형태로 호출할 수 있는데, Ajax호출은 감춰져있기 때문에(=add함수안에 있기 때문에) 코드를 봄 더 깔끔하게 작설 할 수 있다.
	function add(reply, callback){
		console.log("reply......");
		
		//Ajax호출
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply), //The JSON.stringify() method converts a JavaScript object or value to a JSON string
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	
	//댓글 리스트 가져오는 함수(JSON목록을 호출)
	function getList(param, callback, error){
		
		var bno = param.bno;
		
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			}
		);
	}
	
	function remove(rno, callback, error){
		$.ajax({
			type : 'delete',
			url : "/replies/" + rno,
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	function update(reply, callback, error){
		$.ajax({
			type : "put",
			url : "/replies/" + reply.rno,
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(reply),
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return {
		add:add,
		getList:getList,
		remove : remove,
		update : update
	};
	
	
})();



































