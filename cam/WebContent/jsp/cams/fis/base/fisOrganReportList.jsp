<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>殡仪馆上报情况查询</title>
<next:ScriptManager />
</head>
<script language="javascript">
 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
<script type="text/javascript" src="fisOrganReportList.js"></script>
<body>
   <model:datasets>
      <model:dataset id="fisOrganReportDs" cmd="com.inspur.cams.fis.base.cmd.FisImportDataQueryCmd" method="queryForOrganImport">
         <model:record fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganManage"></model:record>
      </model:dataset>
   </model:datasets>
   
   <next:Panel name="form" width="99.9%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件 
				<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" />
			</legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">殡仪馆:</td>
				<td class="FieldInput"><input type="text" id="queryUnitName" /></td>
				<td class="FieldLabel">主管单位:</td>
				<td class="FieldInput"><input type="text" id="qParentOrganName" readOnly=true/>
				<input type="text" id="qParentOrganCode"  style="display: none">
				<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="4">
					<button onclick="query()">查 询</button>
					&nbsp;
					<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
  </next:Panel>
   <next:GridPanel id="editGridPanel" name="fiscemeGrid" width="99.9%" stripeRows="true" height="100%" dataset="fisOrganReportDs" clickToSelectedForChkSM="true">
       <next:TopBar>
          <next:ToolBarItem symbol="->"></next:ToolBarItem>
          <next:ToolBarItem iconCls="export" text="导出Excel" handler="exportExcel"></next:ToolBarItem>
       </next:TopBar>
       <next:Columns>
           <next:RowNumberColumn></next:RowNumberColumn>
           <next:RadioBoxColumn></next:RadioBoxColumn>
           <next:Column field="UNIT_NAME" header="殡仪馆名称" width="15%"></next:Column>
           <next:Column field="END_TIME" header="最后上报时间"></next:Column>
           <next:Column field="DAY_DIFF" header="间隔天数"></next:Column>
       </next:Columns>
       <next:BottomBar>
          <next:PagingToolBar dataset="fisOrganReportDs"></next:PagingToolBar>
       </next:BottomBar>
   </next:GridPanel>
</body>