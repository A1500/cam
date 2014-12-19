<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新建通知</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="fisMattersAttention.js"></script>
<script type="text/javascript">
		var attentionId='<%=request.getParameter("attentionId")%>';
		var method='<%=request.getParameter("method")%>'; 
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="informType" enumName="Inform.Type" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="availableDate" enumName="Available.Date" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="attentionType" enumName="FIS.MATTERS.ATTENTION.TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="fisMattersAttention" cmd="com.inspur.cams.fis.base.cmd.FisMattersAttentionQueryCmd" global="true" autoLoad="true">
	    <model:record fromBean="com.inspur.cams.fis.base.data.FisMattersAttention"></model:record>
	</model:dataset>
</model:datasets>
<next:TabPanel name="tabpanel-div" deferredRender="false" height="590" activeTab="0"  title="发件箱">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="发布" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>

	</next:TopBar>
	<next:Tabs>
		<next:Panel title="基本信息" collapsible="false">
			<next:Html>
			<form id="form_content" method="post" dataset="fisMattersAttention" onsubmit="return false" class="L5form">
				<table id="table1" border=1 width="100%">
				    <tr>
						<td class="FieldLabel">标题：</td>
						<td ><input type="text" id="title" size="1000" maxlength="10000" value="" width="100000" style="width: 300px">
						</td>
					</tr>
					
					<tr>
					   <td class="FieldLabel">通知类型</td>
					       <td> <select id="attentionType" name="attentionType">
					           <option dataset="attentionType"></option>
					        </select></td>
					     </input>
					</tr>
					
					<tr>
					   <td class="FieldLabel">紧急程度</td>
					        <td><select id="emergencyDegree" name="emergencyDegree">
					          <option dataset="informType"></option>
					        </select></td>
					</tr>
					
					<tr>
						<td class="FieldLabel">面向单位：</td>
						<td>
                           <input type="checkbox" name="toOrganFis" id="funeralHome" value="B">&nbsp;殡仪馆</input>
                           &nbsp;&nbsp;&nbsp;&nbsp;
                           <input type="checkbox" name="toOrganFis" id="cemetery" value="G">&nbsp;公墓</input>
                           &nbsp;&nbsp;&nbsp;&nbsp;
                           <input type="checkbox" name="toOrganFis" id="funeralHomeCemetery" value="Y">&nbsp;馆墓一体</input>
						</td>
<!-- 						
						
						<textarea id="NAME" name="receivemanview"	rows="5" cols="92" readonly="readonly">
				  		 </textarea>

						<input type="button" name="selectdept" value="选择部门" onclick="selectUser()" style="CURSOR: hand">
						<input type="hidden"  id="CODE" class="TextEditor"/> -->
						
					</tr>
					
					<tr style="display:none">
						<td class="FieldLabel">有效时限：</td>
						<td><select name="validdaynum"  id="validdaynum" >
							<option dataset="availableDate" ></option>
						</select></td>
					</tr>
					<tr style="display:none"><td class="FieldLabel">附件</td>
					<td>
					<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
         		    &nbsp;<span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
				</table>

				</form>
			</next:Html>
		</next:Panel>
		<next:Panel id="content" title="正文" closable="false">
				<next:Html>	
					<div id="htmledit" />
				</next:Html>
		</next:Panel>
	</next:Tabs>

</next:TabPanel>
</body>
</html>
