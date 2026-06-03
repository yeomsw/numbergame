<%@page import="java.util.ArrayList"%>
<%@page import="com.ksinformation.numbergame.GameDTO"%>
<%@page contentType="text/html; charset=UTF-8" %>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>数当てゲーム</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
body {
	margin: 0;
	padding: 0;
	background: #ffffff;
	font-family: "MS PGothic", "ＭＳ Ｐゴシック", "MS Gothic", "ＭＳ ゴシック", sans-serif;
	font-size: 12px;
	color: #000;
}

.game-wrap {
	width: 365px;
	margin: 8px auto;
	border: 1px solid #555;
	background: #ffffff;
	min-height: 458px;
	box-sizing: border-box;
}

.top-bar {
	display: flex;
	height: 24px;
	border-bottom: 1px solid #555;
	box-sizing: border-box;
}

.title-area {
	flex: 1;
	background: #ead791;
	text-align: center;
	line-height: 24px;
	font-size: 12px;
	font-weight: bold;
}

.logout-area {
	width: 100px;
	border-left: 1px solid #555;
	background: #dce9f7;
}

.logout-btn {
	width: 100%;
	height: 24px;
	border: none;
	background: transparent;
	
	cursor: pointer;
	font-size: 12px;
	font-weight: bold;
	font-family: inherit;
	padding: 0;
}

.logout-area {
    position: relative;
    z-index: 9999;
}

.logout-confirm-box {
    position: absolute;
    top: 35px;
    right: 0;
    z-index: 10000;

    width: 120px;
    padding: 8px;
    background-color: #fff;
    border: 1px solid #333;
    text-align: center;

    pointer-events: auto;
}

#logoutYesBtn,
#logoutNoBtn {
    position: relative;
    z-index: 10001;
    width: 50px;
    height: 25px;
    cursor: pointer;
    font-size: 12px;
	font-weight: bold;
	font-family: inherit;
}

.content-area {
	position: relative;
	padding: 8px 0 0 0;
	min-height: 430px;
}


.point-row {
	margin-top: 7px;
	margin-left: 194px;
	font-size: 12px;
	font-weight: bold;
	white-space: nowrap;
}

.point-label {
	display: inline-block;
}

.point-value {
	display: inline-block;
	width: 20px;
	text-align: left;
	margin-left: 6px;
}

.hidden-row {
	margin-top: 26px;
	margin-left: 26px;
	font-size: 12px;
	font-weight: bold;
	white-space: nowrap;
}

.input-row {
	display: flex;
	align-items: center;
	margin-top: 2px;
	margin-left: 30px;
}
.number-box-group {
	display: flex;
	gap: 0px;
}
.digit-input {
	width: 28px;
	height: 28px;
	text-align: center;
	font-size: 16px;
	border: 1px solid #000;
	box-sizing: border-box;
	padding: 0;
}

.input-label {
	font-size: 12px;
	font-weight: bold;
	margin-right: 10px;
	line-height: 20px;
}

.number-input {
	width: 55px;
	height: 20px;
	border: 1px solid #555;
	box-sizing: border-box;
	background: #fff;
	font-size: 12px;
	font-family: inherit;
	text-align: center;
	padding: 0;
	line-height: 20px;
}

.check-btn {
	width: 42px;
	height: 22px;
	margin-left: 72px;
	border: 1px solid #555;
	background: #f3f3f3;
	font-size: 12px;
	font-family: inherit;
	cursor: pointer;
	padding: 0;
}

.message-area {
	width: 100%;
	height: 18px;
	line-height: 18px;
	text-align: center;
	color: red;
	font-size: 12px;
	font-weight: bold;
	margin-top: 8px;
	margin-bottom: 20px;
}

.table-wrap {
	margin-left: 24px;
	margin-top: 6px;
	margin-bottom:30px;
}

.history-table {
	width: 288px;
	border-collapse: collapse;
	background: #fff;
	table-layout: fixed;
}

.history-table th,
.history-table td {
	border: 1px solid #555;
	height: 24px;
	text-align: center;
	font-size: 12px;
	padding: 0;
}

.history-table th {
	background: #ffffff;
	font-weight: normal;
	padding : 0;
}

.col-turn {
	width: 95px;
}

.col-input {
	width: 92px;
}

.col-result {
	width: 101px;
}
</style>
</head>

<body>

<div class="game-wrap">
	<div class="top-bar">
		<div class="title-area">数当てゲーム</div>
		<div class="logout-area">
			<form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="post">
				<button type="button" id="logoutBtn" class="logout-btn">ログアウト</button>
			</form>
			<div id="logoutConfirmBox" class="logout-confirm-box" style="display:none;">
				<button type="button" class="logout-yes-btn" id="logoutYesBtn">YES</button>
				<button type="button" class="logout-no-btn" id="logoutNoBtn">NO</button>
			</div>
		</div>
		
	</div>

	<div class="content-area">


		<div class="point-row">
			<span class="point-label">現在のポイント</span>
			<span id="currentPoint" class="point-value"> ${gameDTO.point} </span>
		</div>

		<div class="hidden-row">
			隠れ数字: <span id="hiddenNumber">***</span>
		</div>
		<form id="gamePage" action="${pageContext.request.contextPath}/play-game" method="post">
			<div class="input-row">
				<span class="input-label">入力</span>
				<div class="number-box-group">
					<input type="text" id="num1" class="digit-input" maxlength="1">
					<input type="text" id="num2" class="digit-input" maxlength="1">
					<input type="text" id="num3" class="digit-input" maxlength="1">
					
					<input type="hidden" id="inputNum" name="inputNum">
				</div>
				<button type="submit" id="checkBtn" class="check-btn">確認</button>
			</div>
		</form>
			<div id="messageArea" class="message-area">エラーメッセージがここに表示されます</div>
		
		<div class="table-wrap">
			<table id="historyTable" class="history-table">
				<thead>
					<tr>
						<th class="col-turn">入力回数</th>
						<th class="col-input">入力数字</th>
						<th class="col-result">判定結果</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			
		</div>

	</div>
</div>

<%@ page import="java.util.List" %>
<%@ page import="com.ksinformation.numbergame.GameDTO" %>
<%@ page import="com.ksinformation.numbergame.ResultDTO" %>

<script>

$(function(){
	
	const gameResultList = [
		<%
			GameDTO gameDTO = (GameDTO)request.getAttribute("gameDTO");
			java.util.List<ResultDTO> resultList = gameDTO.getResultList();
			if(resultList==null){
				resultList = new ArrayList<ResultDTO>();
			}
			for(int i=0;i<resultList.size();i++){
				ResultDTO tmp = resultList.get(i);
			
			
		%>
		{
			inputNum: "<%=tmp.getInputNum()%>",
			result : "<%=tmp.getResult()%>"
		}
		<%= (i<resultList.size()-1)?",":"" %>
		<%	
		}
		%>
	];
	
	let html="";
	for(let i =0;i<10;i++){
		const row = gameResultList[i];
		
		html+="<tr>";
		html+="<td>"+(i+1)+"回目</td>";
		html+="<td>"+(row?row.inputNum : "")+ "</td>";
		html+="<td>"+(row?row.result : "")+ "</td>";
		html+="</tr>";
	}
	$("#historyTable tbody").html(html);
	
	const gameActFlg = "${gameDTO.gameActFlg}";
	const message = "${gameDTO.message}";
	
	console.log("message:","${gameDTO.message}");
	
	if(message && message.trim()!=="" && gameActFlg==1){
		showMessage(message);	
		
		const popupWidth = 400;
		const popupHeight = 300;

		const left = Math.round(window.screenLeft + (window.outerWidth - popupWidth) / 2);
		const top = Math.round(window.screenTop + (window.outerHeight - popupHeight) / 2);

		const popup = window.open(
		    "${pageContext.request.contextPath}/popup",
		    "popupPage",
		    "width=" + popupWidth +
		    ",height=" + popupHeight +
		    ",left=" + left +
		    ",top=" + top
		);

		if (popup) {
		    popup.moveTo(left, top);
		    popup.resizeTo(popupWidth, popupHeight);
		    popup.focus();
		}
		
		console.log("popup",popup);
		
		if(gameActFlg==="1"){
			$(".digit-input").prop("disabled",true);
			$("#checkBtn").prop("disabled",true);	
		}
		
	} else if(gameActFlg==="1"){
		$(".digit-input").prop("disabled",true);
		$("#checkBtn").prop("disabled",true);
		$("#messageArea").text("今日のゲームは終了しました。");
	} else if(message && message.trim()!==""){
		showMessage(message);
	} else{
		clearMessage();
	}
	
	
	function showMessage(message){
		$("#messageArea").text(message);
	}
	
	function clearMessage(){
		$("#messageArea").text("エラーメッセージがここに表示されます");
	}
	
	$("#logoutBtn").on("click",function(){
		showMessage("ログアウトしますか。");
		$("#logoutConfirmBox").show();
	});
	$("#logoutYesBtn").on("click",function(){
		$("#logoutForm").submit();
	});
	
    $("#logoutNoBtn").on("click", function () {
    	clearMessage();
        $("#logoutConfirmBox").hide();
    });
	
	$("#gamePage").on("submit",function(e){
		const num1 = $("#num1").val();
		const num2 = $("#num2").val();
		const num3 = $("#num3").val();
		
		if(num1===""||num2===""||num3===""){
			$("#messageArea").text("3桁の数字を入力してください。");
			e.preventDefault();
			return;
		}
		
		if(num1===num2||num1===num3||num2===num3){
			$("#messageArea").text("それぞれ違う数字を入力してください。");
			$("#num1").val("");
			$("#num2").val("");
			$("#num3").val("");
			e.preventDefault();
			return;
		}
		const inputNum = num1+num2+num3;
		$("#inputNum").val(inputNum);
	});
	
	
	
	$(".digit-input").on("input",function(){
		const rawValue = $(this).val();
		const numberOnly = rawValue.replace(/[^0-9]/g,"");
		
		if(rawValue!==numberOnly){
			showMessage("数字のみ入力してください");
		} else {
			clearMessage();
		}
		
		$(this).val(numberOnly);
		
		if(numberOnly.length===1){
			$(this).next(".digit-input").focus();
		}		
	});
	$(".digit-input").on("keydown",function(e){
		if(e.key==="Backspace" && $(this).val()===""){
			$(this).prev(".digit-input").focus();
		}
	});
	
})

</script>

</body>
</html>






