<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Monitor._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>监控 | 多平台在线离线数量</title>
	<style type="text/css">
		#container{
			width: 80%;
			margin: 30px auto;
			font-size: 40px;
		}
		table{
			border-collapse: collapse;
			text-align: center;
			border-color: #000;
			width: 100%;
		}
		tr{
			height: 100px;
			line-height: 100px;
		}
		td{
			padding: 4px;
		}
		th{
			background-color: #4fc08d;
			color: #fff;
		}
		#info,#warn{
			color: #4fc08d;
			font-weight: bold;
		}
	</style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="container">
		<table border="2">
			<thead>
				<tr>
					<th>平台名称</th>
					<th>在线</th>
					<th>离线</th>
				</tr>
			</thead>
			<tbody>
				<tr id="qn" class="company-row">
					<td>金华青年</td>
					<td>-</td>
					<td>-</td>
				</tr>
				<tr id="cd" class="company-row">
					<td>成都客车</td>
					<td>-</td>
					<td>-</td>
				</tr>
				<tr id="gx" class="company-row">
					<td>广西源正</td>
					<td>-</td>
					<td>-</td>
				</tr>
				<tr id="qy" class="company-row">
					<td>汽研中心</td>
					<td>-</td>
					<td>-</td>
				</tr>
			</tbody>
		</table>
		<p id="info">新年快乐，狗年大吉！</p>
        <p id="warn"></p>
	</div>
    </form>
</body>
<script type="text/javascript" src="Scripts/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
    var count = 0;

    $(function () {
        getData();
    });

    function getData() {
        try{
            //青年
            $.post('./Data/HandlerQN.ashx', function (res) {
                console.log(res);
                hanldeRes(res, 'qn');
            });
            //成都
            $.post('./Data/HandlerCD.ashx', function (res) {
                console.log(res);
                hanldeRes(res, 'cd');
            });

            //广西
            $.post('./Data/HandlerGX.ashx', function (res) {
                console.log(res);
                hanldeRes(res, 'gx');
            });

            //汽研
            $.post('./Data/HandlerQY.ashx', function (res) {
                console.log(res);
                hanldeRes(res, 'qy');
            });

            count++;
            $("#warn").html("当前请求第 " + count + " 次");
        } catch (e) {
            $("#warn").html("请求异常，请前往网站查看！");
        }

        setTimeout(getData, 5000);
    }

    function hanldeRes(res, tid) {
        var data = JSON.parse(res)[0];
        var textColor = "#000";
        if (data["在线数量"] == 0) {
            textColor = '#f00';
            $("#warn").html("异常离线，请拨打电话152-2228-1210！");
        }
        $("#" + tid).find("td").eq(1).text(data["在线数量"]).css("color", textColor);
        $("#" + tid).find("td").eq(2).text(data["离线数量"]);
    }
</script>
</html>
