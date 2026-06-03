<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8" />
<title>会員認証</title>

<style>
body {
	margin: 0;
	padding: 0;
	background: #fff;
	font-family: "MS Gothic", "ＭＳ ゴシック", "MS PGothic", "ＭＳ Ｐゴシック", Arial,
		sans-serif;
	font-size: 12px;
	color: #000;
}

.login-box {
	width: 360px;
	margin: 60px auto;
	border: 2px solid #000;
	background: #fff;
}

.login-title {
	background: #f2d98c;
	text-align: center;
	font-weight: bold;
	padding: 5px 0 4px;
	border-bottom: 2px solid #000;
	letter-spacing: 1px;
}

.login-content {
	padding: 22px 28px 16px;
}

.form-row {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.form-row label {
	width: 90px;
}

.form-row input {
	width: 150px;
	height: 20px;
	padding: 1px 6px;
	border: 1px solid #000;
	box-sizing: border-box;
}

.btn-row {
	text-align: center;
	margin-top: 14px;
}

.btn-login {
	width: 190px;
	height: 26px;
	border: 1px solid #000;
	background: #dbe8f7;
	cursor: pointer;
	font-family: inherit;
	font-size: 12px;
	line-height: 18px;
	padding-top: 4px;
	padding-bottom: 0px;
	box-sizing: border-box;
}

.error-area {
	text-align: center;
	margin-top: 14px;
	min-height: 18px;
	color: #000;
	font-family: inherit;
	font-size: 12px;
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body>
	<form action="login" method="post">
		<div class="login-box">
			<div class="login-title">会員認証</div>

			<div class="login-content">
				<div class="form-row">
					<label for="memberId">会員ID</label> <input type="text" id="memberId"
						name="memberId" maxlength="6" />
				</div>

				<div class="form-row">
					<label for="password">パスワード</label> <input type="password"
						name="password" id="password" maxlength="12" />
				</div>

				<div class="btn-row">
					<button type="submit" class="btn-login" id="submit">ログイン</button>
				</div>

				<div class="error-area" id="errmsg">
				${empty errmsg ? 'ここにエーラが表示されます' : errmsg}</div>
			</div>
		</div>

		<script>
			const error = $("#errmsg");

			function setError(msg) {
				error.text(msg);
			}
			
			$(function(){
				$("#memberId","#password").on("keydown",function(e){
					if(e.key==="Enter"){
						e.preventDefault();
						$("#loginPage").submit();
					}
				});
			});


			$("form").on("submit", function(e) {
				console.log("submit 실행됨")
				

				const memberId = $("#memberId").val().trim();
				const password = $("#password").val().trim();
				const regex = /^[a-zA-Z0-9]+$/;

				if (!memberId) {
					setError("会員IDを入力してください。")
					$("#memberId").focus();
					e.preventDefault();
					return;
				}
				if (memberId.length != 6) {
					setError("会員IDは6桁で入力してください。");
					$("#memberId").focus();
					e.preventDefault();
					return;
				}
				if (!regex.test(memberId)) {
					setError("会員IDは半角英数字以外は入力できません");
					$("#memberId").focus();
					e.preventDefault();
					return;
				}
				if (!password) {
					setError("パスワードを入力してください");
					$("#password").focus();
					e.preventDefault();
					return;
				}
				if (password.length != 8) {
					setError("パスワードは8文字でで入力してください");
					$("#password").focus();
					e.preventDefault();
					return;
				}
				if (!regex.test(password)) {
					setError("パスワードは半角英数字以外は入力できません");
					$("#password").focus();
					e.preventDefault();
					return;
				}

			});
		</script>
	</form>
</body>
</html>










