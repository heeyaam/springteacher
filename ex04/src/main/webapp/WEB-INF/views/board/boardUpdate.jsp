<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<form name="updateForm">
		<table>
			<tr>
				<th>번호</th>
				<td><input type="text" name="bno" value="${boardInfo.bno}" readonly></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="${boardInfo.title}"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="writer" value="${boardInfo.writer}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="contents">${boardInfo.contents}</textarea></td>
			</tr>
			<tr>
				<th>첨부이미지</th>
				<td><input type="text" name="image" value="${boardInfo.image}"></td>
			</tr>
			<tr>
				<th>수정일자</th>
				<td><input type="date" name="updatedate" 
					value='<fmt:formatDate value="${boardInfo.updatedate}" pattern="yyyy-MM-dd" />'></td>
			</tr>
		</table>
		<button type="submit">수정</button>
		<button type="button" onclick="location.href='boardInfo?bno=${boardInfo.bno}'">취소</button>
	</form>
	<script>
		$('form').on('submit', function(e){
			
			let objData = serializeObject();
			
			$.ajax({
				url : 'boardUpdate',
				method : 'post',
				data : objData
			})
			.done(data => {
				console.log(data);
			})
			.fail(reject => console.log(reject));
			
			
			return false;
		});
	
		function serializeObject(){
			let formData = $('form').serializeArray();
			// [ { name : 'title', value : 'Hello'}, {name : 'writer', value :'여행자'}, ..]
			
			let formObject = {};
			$.each(formData, function(idx, obj){
				let field = obj.name;
				let val = obj.value;
				
				formObject[field] = val;
			});
			
			return formObject;
		}
	</script>
</body>
</html>