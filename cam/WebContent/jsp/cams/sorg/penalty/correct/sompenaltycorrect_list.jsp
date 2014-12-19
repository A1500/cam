
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>责令改正通知列表</title>
			<%
				String area = BspUtil.getOrganCode().substring(0,6);
			%>
		<next:ScriptManager/>
		<script type="text/javascript" src="sompenaltycorrect_list.js"></script>
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
			var area = '<%=area%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyCorrectQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenaltyCorrect"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
					<form class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" width='14%'>社会组织类型:</td>
								<td class="FieldInput" width='14%'><select id='sorgType' field="sorgType" name='社会组织类型' style='width:90%'><option  dataset="sorgTypeSelect"></option></select></td>	
								<td class="FieldLabel" width='14%'>登记证号:</td>
								<td class="FieldInput" width='14%'><input type="text"  id="sorgCode" class="TextEditor" title="登记证号"  style='width:90%'/></td>	
								<td class="FieldLabel" width='14%'>通知书编号:</td>
								<td class="FieldInput" width='14%'><input type="text"  id="correctNo" class="TextEditor" title="通知书编号"  style='width:90%'/></td>	
								<td class="FieldLabel" width='14%'><button onclick="query()">查 询</button>&nbsp;&nbsp;<button type="reset">重置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sompenaltycorrectGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="责令改正通知" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="90" >
			<next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="correctNo" header="通知书编号" field="correctNo" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="illegalBehavior" header="违规行为" field="illegalBehavior" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deregulation" header="违反规定" field="deregulation" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="correctDate" header="责改日期" field="correctDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="linkmanName" header="联系人" field="linkmanName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="linkmanPhone" header="联系电话" field="linkmanPhone" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regPeopleId" header="登记人ID" field="regPeopleId" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regPeopleName" header="登记人姓名" field="regPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regDate" header="登记日期" field="regDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regOrganId" header="登记部门ID" field="regOrganId" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regOrganName" header="登记部门名称" field="regOrganName" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regArea" header="行政区划" field="regArea" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
