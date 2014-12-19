<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
  <title>注销备案表</title>
       <next:ScriptManager></next:ScriptManager>
       <script type="text/javascript" src="../js/float1.js"></script>
       <script type="text/javascript">
       	var annex = 0;
 	 function addbg(obj){ 
 	  	 var otr1=tbg1.insertRow();
 		 var ocel1=otr1.insertCell(0);
 		 
 		 ocel1.innerHTML="<div align='center' ><input type='text' name='变更事项"+annex+"' id='变更事项"+annex+"' size=40/></div>";  
 		 var otr2=tbg2.insertRow();
 		 var ocel2=otr2.insertCell(0);
 		  
 		 ocel2.innerHTML="<div align='center' ><input type='text' name='变更前"+annex+"' id='变更前"+annex+"' size=50/></div>";
 		 var otr3=tbg3.insertRow();
 		 var ocel3=otr3.insertCell(0);
 		 
 		 ocel3.innerHTML="<div align='center' ><input type='text' name='变更后"+annex+"' id='变更后"+annex+"' size=50/></div>";
 		 annex++;
 	  
 	  }
 	  
       </script>
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
.unnamed8 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
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
			       	<strong><div align="center">假肢和矫形器生产装配企业<br />事项变更备案表</div></strong>
			     </TD>
		        </TR>
		    </TABLE>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width=800 border=0>
					<!-- 假肢和矫形器生产装配企业事项变更备案表 -->
					 <tr>
  						<td colspan="2" width=200 class=unnamed2><div align="center">企业名称</div></td>
  						<td width=250 colspan="3" class=unnamed2>
  							<input type="text" name="企业名称" id="企业名称" size=50/>
  		
  						</td>
  						<td width=150  class=unnamed2><div align="center">编&nbsp;号</div></td>
  						<td width=200 class=unnamed3 colspan="2">
  							<input type="text" name="编号" id="编号"/>
  						</td>
  					</tr>	
  					<tr>
  						<td width=200 class=unnamed2 colspan="2"><div align="center">联&nbsp;系&nbsp;人</div></td>
  						<td width=250 colspan="3" class=unnamed2>
  							<input type="text" name="联系人" id="联系人"/>
  		
  						</td>
  						<td width=150 class=unnamed2 ><div align="center">联系电话</div></td>
  						<td width=200 class=unnamed3 colspan="2">
  							<input type="text" name="联系电话" id="联系电话"/>
  						</td>
  					</tr>
				   <tr>
				    <td width=200 class=unnamed2 height="24px" colspan="2"><div align="center">变更事项</div></td>
				    <td width=300 class=unnamed2 colspan="3" height="24px"><div align="center">变&nbsp;更&nbsp;前</div></td>
				    <td width=300 class=unnamed3 colspan="3" height="24px">变&nbsp;更&nbsp;后&nbsp;&nbsp;
				    	<input type="button" id="添加" value="添加" onclick="addbg()"/>
				    </td>
				   
				  </tr>
				  <!--<tr>
				    <td  class=unnamed2 colspan="2"><div align="center">
				      <textarea name="变更事项" id="变更事项" cols=35 rows=10></textarea>
				    </div></td>
				    <td class=unnamed2 align="center" colspan="3"><textarea name="变更前" id="变更前" cols=40 rows=10></textarea></td>
				    <td  class=unnamed3 align="center" colspan="3"><textarea name="变更后" id="变更后" cols=40 rows=10></textarea></td>
				  </tr>
				  -->
				  <tr>
				    <td  class=unnamed2 colspan="2"><div align="center"><input type="text" id="变更事项" name="变更事项" size=40/> </div></td>
				    <td class=unnamed2 align="center" colspan="3"><div align="center"><input type="text" id="变更前" name="变更前" size=50/> </div></td>
				    <td  class=unnamed3 align="center" colspan="3"><div align="center"><input type="text" id="变更后" name="变更后" size=50/> </div></td>
				  </tr>
				 <!-- 添加按钮 -->
				  <tr>
				    <td  class=unnamed2 colspan="2"><div align="center"><table id="tbg1"></table> </div></td>
				    <td class=unnamed2 align="center" colspan="3"><div align="center"><table id="tbg2"></table></div></td>
				    <td  class=unnamed3 align="center" colspan="3"><div align="center"><table id="tbg3"></table></div></td>
				  </tr>
				  
				  <tr>
				  	<td  height=100 class=unnamed2><div align="center">变<br />更<br />理<br />由</div></td>
				  	<td class=unnamed3 width=400 height=100 colspan="7">
				  		<div align="left" >
				  			<textarea name="变更理由" id="变更理由" cols="60" rows="10"></textarea>
				  		</div>
				  	</td>
				  </tr>	
				  <tr>
				  	<td class=unnamed2 width=400 height=100 colspan="4">
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
				  	<td class=unnamed3 width=400 height=100 colspan="4">
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






































