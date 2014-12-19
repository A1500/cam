<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
  <title>注销备案表</title>
       <next:ScriptManager></next:ScriptManager>
       <script type="text/javascript" src="../js/float1.js"></script>
		        <style type='text/css'>
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}
.fontsize1 {
	 font-size: 36px;
}
table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 14px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 20px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
	font-size: 16px;
}

.unnamed6 {
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
	font-size: 16px;
}
</STYLE>
</head>
<body>
	<div id="float" >
		<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;" />
	</div>
	 <div align="center">
      <form method="post" onsubmit="return false" >
    <TABLE height=0 cellSpacing=0 cellPadding=0 width=800 align=center border=0>
		        <TR>
			       <TD class=title1 align=middle height=67>&nbsp;</TD>
		        </TR>
		        <TR>
			       <TD align="middle" height=40 class="title3" style="font-size: 25px">
			       	<strong><div align="center">假肢和矫形器生产装配企业<br />注销备案表</div></strong>
			     </TD>
		        </TR>
		    </TABLE>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=800 border=0 >
					<!-- 假肢和矫形器生产装配企业事项变更备案表 -->
					 <tr>
  						<td colspan="3" class=unnamed2 height="30"><div align="center">企业名称</div></td>
  						<td colspan="3" class=unnamed2>
  							<input type="text" name="企业名称" id="企业名称" size=50/>
  		
  						</td>
  						<td  class=unnamed2 colspan="2" height="30"><div align="center">编&nbsp;号</div></td>
  						<td  class=unnamed3 colspan="3">
  							<input type="text" name="编号" id="编号"/>
  						</td>
  					</tr>	
  					<tr>
  						<td  class=unnamed2 colspan="3" height="30"><div align="center">联&nbsp;系&nbsp;人</div></td>
  						<td  colspan="3" class=unnamed2>
  							<input type="text" name="联系人" id="联系人"/>
  		
  						</td>
  						<td class=unnamed2 colspan="2"><div align="center">联系电话</div></td>
  						<td class=unnamed3 colspan="3">
  							<input type="text" name="联系电话" id="联系电话"/>
  						</td>
  					</tr>
  					<tr>
  						<td height="30" colspan="3" class=unnamed2>
  							<div align="center" >注销时间</div>
  						</td>
  						<td colspan="8" height="30" class=unnamed3>
  						<input type="text" name="year" id="year" size=30 format="Y年m月d日" onclick="LoushangDate(this)" readonly="readonly" style="text-align: center"/>
  						</td>
  					</tr>
  					<tr>
  						<td colspan="2" class="unnamed2">
  							<div align="center">注<br/>销<br/>原<br/>因</div>
  						</td>
  						<td colspan="9" class="unnamed3">
  							<textarea rows="20" cols="109"></textarea>
  						</td>
  					</tr>
  					 <tr>
				  	<td class=unnamed2  colspan="5">
				  		<div align="left" >
				  			<br></br>
				  			&nbsp;法定代表人<br />
				  			<br></br>
				  			&nbsp;&nbsp;签&nbsp;章:<input type="text" name="签章" id="签章" /><br />
				  			<br></br>
				  			<div align="right"><input type="text" name="年" id="年" size=4/>年
				  			<input type="text" name="月" id="月" size=4/>月<input type="text" name="日" id="日" size=4/>日
				  			</div>
				  		</div>
				  	</td>
				  	<td class=unnamed3  colspan="5">
				  		<div align="left" >
				  			<br></br>
				  			&nbsp;企业盖章<br />
				  			<br></br>
				  			<br></br>
				  			<br></br>
				  			<div align="right" ><input type="text" name="年" id="年" size=4/>年
				  			<input type="text" name="月" id="月" size=4/>月<input type="text" name="日" id="日" size=4/>日
				  			</div>
				  		</div>
				  	</td>
				  </tr>						
		</TABLE>
	</form>
</div>									
</body>
</html>