
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_YEAR_COST_SHEET编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("id")%>';
			var method='<%=request.getParameter("method")%>';
			
		</script>
		<script type="text/javascript" src="disyearcostsheet_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisYearCostSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisYearCostSheet">
		<model:field name="disYear"  type="string" />
		<model:field name="yearCostSheet" type="string" />
		<model:field name="assistanceForSelf" type="string" />
		<model:field name="donationForSelf" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="年度资金预算">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
		
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>		
				<td  class="FieldLabel" >年度</td>
				<td class="FieldInput"><input type="text" name="disYear" field="disYear" maxlength="4" /><font color="red">*</font> </td>
				
				<td  class="FieldLabel" >本级募集救灾捐赠资金</td>
				<td class="FieldInput"><input type="text" id="donationForSelf" name="donationForSelf" field="donationForSelf" onblur="test1()" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >本级救灾资金年度预算</td>
				<td class="FieldInput"><input type="text" name="yearCostSheet" field="yearCostSheet" onblur="test2()" /> </td>
			
				<td  class="FieldLabel" >本级配套灾害救助资金</td>
				<td class="FieldInput"><input type="text" name="assistanceForSelf" field="assistanceForSelf" onblur="test3()" /> </td>
			</tr>
	   					
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
