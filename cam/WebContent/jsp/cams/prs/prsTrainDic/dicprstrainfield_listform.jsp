<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>培训专业列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dicprstrainfield_listform.js"></script>
		<script language="javascript">
			var orgCode  ='<%=BspUtil.getOrganCode()%>';
		 	 
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
	<model:dataset id="ds" cmd="com.inspur.cams.prs.prsTrainDic.cmd.DicPrsTrainFieldQueryCommand" sortField="effective" sortDirection="desc" global="true">
		<model:record fromBean="com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainField"></model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="YesNo" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
				<table  border="1" width="100%" >
					<tr >
						<td class="FieldLabel">专业名称:</td>
						<td class="FieldInput"><input type="text"  id="q_name" class="TextEditor" title="专业名称"  /></td>	
						<td class="FieldLabel">使用状态:</td>
								<td class="FieldInput"><select id="effective" class="TextEditor" title="使用状态" ><option dataset = "YesNo"></option> </select> </td>	
						<td class="FieldLabel"><button onclick="query()">查 询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button onclick="reset()">重 置</button> </td>
					</tr>
				</table>
				</form>
				</div>
	   </fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="dicprstrainfieldGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="培训专业列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="保存"  iconCls="save" handler="save"/>
		<next:ToolBarItem text="取消"  iconCls="undo" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="name" header="专业名称" field="name" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="effective" header="使用状态" field="effective"  width="90" >
			<next:ComboBox dataset = "YesNo" id="effectiveComboBox" />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
