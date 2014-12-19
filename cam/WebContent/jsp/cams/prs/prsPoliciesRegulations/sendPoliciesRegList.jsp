<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sendPoliciesRegList.js"></script>
		<script type="text/javascript" src="../prsComm.js"></script>
		<script language="javascript">
			var organId='<%=BspUtil.getCorpOrganId()%>';
		    var organArea='<%=BspUtil.getOrganCode()%>';
		</script>
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
	</head>
<body>
<model:datasets>
	<model:dataset id="policRegDS" cmd="com.inspur.cams.prs.prspoliciesregulations.cmd.PrsPoliciesRegulationsQueryCmd">
		<model:record fromBean="com.inspur.cams.prs.prspoliciesregulations.dao.PrsPoliciesRegulations"></model:record>
	</model:dataset>
	<model:dataset id="effectFlagDS" enumName="PRS.EFFECT_FLAG" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="typeDS" enumName="PRS.POLICREG_TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" width="10%">文号：</td>
				<td class="FieldInput" width="30%"><input type="text" id="fileNum"
					 name="文号" /></td>
				<td class="FieldLabel" width="10%">年度：</td>
				<td class="FieldInput" width="30%"><input type="text" id="yearly"
					 name="年度" /></td>
				<td class="FieldInput">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">标题：</td>
				<td class="FieldInput" width="30%"><input type="text" id="titlequery"
					 name="标题" /></td>
				<td class="FieldLabel" width="10%">下发时间：</td>
				<td class="FieldInput" width="30%"><input
					type="text" id="sendDateBegin" title="下发时间起" format="Y-m-d"
					maxlength="10" onpropertychange="changeDateStyle(this)" /><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);">&nbsp;--&nbsp;<input
					type="text" id="sendDateEnd" format="Y-m-d" maxlength="10"
					onpropertychange="changeDateStyle(this)" /><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"></td>
				<td class="FieldInput">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="gridPanel" clickToSelectedForChkSM="true"  notSelectFirstRow="true"  title="发件箱列表" name="informGrid"  width="100%" height="99.9%" dataset="policRegDS" frame="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新建" handler="click_add"/>
		<next:ToolBarItem iconCls="detail"  text="查看" handler="click_view"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="click_delete"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="文号" field="FILE_NUM"   width="160" >
			<next:TextField />
		</next:Column>
		<next:Column header="标题" field="REGULATIONS_TITLE"   width="160" >
			<next:TextField />
		</next:Column>
		<next:Column header="接收单位" field="ACCEPTING_COMPANY"  width="100" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="类别" field="TYPE"   width="80"  sortable="true">
			<next:ComboBox dataset="typeDS" />
		</next:Column>
		<next:Column header="下发日期" field="RELEASE_DATE"  align="center" width="140" sortable="true">
			<next:DateField />
		</next:Column>
		<next:Column header="下发单位" field="RELEASE_COMPANY_NAME"  width="100" sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="policRegDS"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

