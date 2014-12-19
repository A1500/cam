<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<style type="text/css">
body,input,textarea,td{font-size: 9pt;color: black;}
A {text-decoration: none; color: snow;font-size: 9pt;}
A:hover {text-decoration: underline; color: #FF0000; font-size: 9pt;}
img.hand {cursor:hand;}
BODY {
	FONT-SIZE: 9pt; CURSOR: default; COLOR: #ccccff; SCROLLBAR-ARROW-COLOR: #ffffff; FONT-FAMILY: ??,MS Shell Dlg,Tahoma; SCROLLBAR-BASE-COLOR: #E1EFFF
}
</style>
<title>城市民主选举列表</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Top>
		<next:Panel  id="topPanel" collapsible="false"  title='选举信息汇总'  autoScroll="false" width="80%" border="false">
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem text="返回" handler="undo" iconCls="undo"></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件</legend>
						<form class="L5form">
						<table width="100%" border="1">
							<tr>
								<td class="FieldLabel" style="width:18%;">汇总单位：</td>
								<td class="FieldInput" style="width:27%"><input type="text" id="domicileName" onclick="func_ForDomicileSelect()" style="width: 99%" readonly="readonly"/>
								<input type="hidden" id="domicileCode"/><input type="hidden" id="leve"/></td>
								<td class="FieldLabel" style="width:13%">填报日期：</td>
								<td class="FieldInput" style="width:42%"><select id="reportDate" style="width: 50%" ><option dataset="reportWorkDataSet"/></select></td>
							</tr>
						</table>
					</form>
				</fieldset>
			</next:Html>
		</next:Panel>
		</next:Top>
		<next:Left  cmargins="5 0 0 0 0 " margins="5 0 0 0" split="true" floatable="true">
		<next:Panel  id="leftPanel" collapsible="true"  title='选举情况汇总'  autoScroll="true" width="20%" border="false">
		<next:Html>
			<TABLE border=0 cellspacing=0 cellpadding=0 width="190">
			<TR ><TD width="758">
		      <table border=0 cellspacing=0 cellpadding=0 width="190">
		        <tr id=Item0> 
		          <td colspan=3 width="190" align="middle" height="20"> 
		            <p align="center"></p>
		          </td>
		        </tr>
		        <tr id=Item0> 
		          <td colspan=3 width="190"> <IMG align=absMiddle border=0 src="../images/gzai.jpg" width="16" height="16"title="返回主页面">
		            <font color="#000000">城市社区民主选举汇总 </font></td>
		        </tr>
		         <tr id=Item2 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16>
				  <IMG  border=0 id=Pic1 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"   onclick="selectedNode('11')"><font id = "node11" color="#000000">选举准备信息</font></A></td>
		        </tr>
		
			  <tr id=Item4 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic4 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('1')"><font id = "node1" color="#000000">提名方式信息</font></A></td>
		        </tr>
		
			  <tr id=Item5 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic5 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('2')" ><font id = "node2" color="#000000">正式候选人信息</font></A></td>
		        </tr>
		
			  <tr id=Item6 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic6 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('3')" ><font id = "node3" color="#000000">投票方式信息</font></A></td>
		        </tr>
		
			  <tr id=Item7 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic7 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('4')" ><font id = "node4" color="#000000">选举程序信息</font></A></td>
		        </tr>
			<tr id=Item7 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic5 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="150"><A href="#"  onclick="selectedNode('5')" ><font id = "node5" color="#000000">完成选举情况</font></A></td>
		        </tr>
				<tr id=Item8 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic5 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="150"><A href="#"  onclick="selectedNode('6')" ><font id = "node6" color="#000000">选举完成情况</font></A></td>
		        <tr id=Item9 > 
		        <tr id=Item9 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic8 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('7')" ><font id = "node7" color="#000000">居委会组成党员比例统计</font></A></td>
		        </tr>
		        <tr id=Item10 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic8 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('8')" ><font id = "node8" color="#000000">居民代表、居民小组长统计</font></A></td>
		        </tr>
		        <tr id=Item11 > 
		          <td width="40"><IMG border=0 height=22 src="../images/midnodeline.jpg" width=16><IMG  border=0 id=Pic8 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('9')" ><font id = "node9" color="#000000">社区“两委”成员情况统计</font></A></td>
		        </tr>
		        <tr id=Item1 > 
		          <td width="40"><IMG border=0 height=22 src="../images/lastnodeline.jpg" width=16>
				  <IMG  border=0 id=Pic1 src="../images/clsfld.jpg" width="16" height="16"></td>
		          <td width="120"><A href="#"  onclick="selectedNode('10')"><font id = "node10" color="#000000">居委会成员罢免情况</font></A> 
		          </td>
		        </tr>
		      </table>
		</TD><TD width="50">
		</TD></TR>
		</TABLE>
		</next:Html>
      </next:Panel>
		</next:Left>
		<next:Center floatable="true" margins="5 0 0 0" cmargins="5 0 0 0 0 ">
	<next:Panel id="center" width="100%" height="100%">
		<next:Panel id="detail" hidden="ture" width="100%" height="100%" >
				<next:Html>
						<iframe id="nodeFrame" name="nodeFrame" height="100%" width="100%">
						</iframe>
				</next:Html>
		</next:Panel>
	</next:Panel>	
	</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>