<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
	<form>
		<label> 부서번호 : <input type="number" name="departmentId" value="${deptInfo.departmentId }" readonly></label><br>
		<label> 부서이름 : <input type="text" name="departmentName" value="${deptInfo.departmentName }" ></label><br>
		<label> 팀장번호 : <input type="number" name="managerId" value="${deptInfo.managerId }" ></label><br>
		<label> 위치번호 : <input type="number" name="locationId" value="${deptInfo.locationId }" ></label><br>
		<button type="submit">수정</button>
		<button type="button" onclick="location.href='deptList'">목록</button>
	</form>
	<script>
		let msg = `${message}`;		
		if(msg != null && msg != '') alert(msg); 
		
		$('form').on('submit', ajaxDeptUpdate);
		
		function ajaxDeptUpdate(event){
			event.preventDefault();
			
			let obj = serializeObject();
			
			$.ajax({
				url : 'deptUpdate',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify(obj)
			})
			.done( data => {
				if(data != null && data['결과'] == 'Success'){
					let msg = '수정되었습니다.\n부서번호 : ' + data['부서번호'];					
					alert(msg);
				}else{
					alert('수정되지 않았습니다. 정보를 확인해주세요.');
				}
			})
			.fail( reject => console.log(reject));
		};
		
		function serializeObject(){
			let formData = $('form').serializeArray();
			
			let formObj = {};
			$.each(formData, function(idx, obj){
				formObj[obj.name] = obj.value;
			});
			
			return formObj;			
		}
		
		
	</script>
</body>
</html>