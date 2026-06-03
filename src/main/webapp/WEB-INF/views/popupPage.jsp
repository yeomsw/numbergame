<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>popupPage</title>

<style>
    html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        background: #ffffff;
        font-family: "MS PGothic", "MS Gothic", sans-serif;
        font-size: 12px;
        color: #000;
    }

    body {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .popup-wrap {
        width: 211px;
        height: 181px;
        box-sizing: border-box;
    }

    .title-bar {
        width: 211px;
        height: 23px;
        line-height: 23px;
        background-color: #5b9bd5;
        color: #ffffff;
        text-align: center;
        font-size: 12px;
        box-sizing: border-box;
    }

    .popup-body {
        width: 211px;
        height: 158px;
        border: 1px solid #000;
        border-top: none;
        box-sizing: border-box;

        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        text-align: center;
    }

    .message-box {
        width: 164px;
        height: 51px;
        border: 1px solid #000;
        box-sizing: border-box;
        background-color: #ffffff;

        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        line-height: 17px;
    }

    .point-area {
        margin-top: 11px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 7px;
        height: 20px;
    }

    .point-input {
        width: 57px;
        height: 16px;
        border: 1px solid #000;
        box-sizing: border-box;
        text-align: center;
        font-family: "MS PGothic", "MS Gothic", sans-serif;
        font-size: 12px;
        color: #0000ff;
        background-color: #ffffff;
        padding: 0;
    }

    .ok-btn {
        margin-top: 18px;
        width: 54px;
        height: 22px;
        border: 1px solid #000;
        background-color: #eeeeee;
        font-family: "MS PGothic", "MS Gothic", sans-serif;
        font-size: 12px;
        cursor: pointer;
        padding: 0;
    }

    .ok-btn:hover {
        background-color: #e0e0e0;
    }
</style>
</head>

<body>

<div class="popup-wrap">

    <div class="title-bar">タイトルバー</div>

    <div class="popup-body">

        <div class="message-box">
            <div>${gameDTO.message}</div>
            <div>獲得ポイント：${gameDTO.addPoint}ポイント</div>
        </div>

        <div class="point-area">
            <span>現在</span>
            <input type="text" class="point-input" value="${gameDTO.point}" readonly>
            <span>ポイント</span>
        </div>

        <button type="button" class="ok-btn" onclick="window.close()">OK</button>

    </div>

</div>

</body>
</html>