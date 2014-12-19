
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>等级评定信息表列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmlevelevalutioninfo_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo"></model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true"></model:dataset>
<!-- 是否首次评定 -->
	<model:dataset id="FirstEvaluDataset" enumName="MRM.IF.FIRSTEVALU" autoLoad="true" global="true"></model:dataset>
	
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
							
								<td class="FieldLabel">登记机关:</td>
								<td class="FieldInput"><input type="text"  id="deptName" class="TextEditor" title="登记机关"  onclick="getDeptName()" style="width: 200px"/></td>	
								<td class="FieldLabel">等级:</td>
								<td class="FieldInput">
									<select name="evaluLevel" id="evaluLevel" field=evaluLevel>
										<option dataset="EvaluLevelDataset"/>
									</select>
							  </td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="mrmlevelevalutioninfoGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="等级评定信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column  header="登记机关" field="deptName" width="200" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="evaluLevel" header="等级" field="evaluLevel" width="90" dataset="EvaluLevelDataset">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="evaluTime" header="评定时间" field="evaluTime" width="90" >
			<next:TextField />
		</next:Column>
	
		<next:Column id="reviewTime" header="复核时间" field="reviewTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="rectificPassTime" header="整改合格时间" field="rectificPassTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="revokeTime" header="不合格撤销等级时间" field="revokeTime" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="cancelLevelTime" header="主动申请取消等级时间" field="cancelLevelTime" width="150" >
			<next:TextField />
		</next:Column>
	
		<next:Column id="firstEvalu" header="是否首次评定" field="firstEvalu" width="120" dataset="FirstEvaluDataset">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="nhgjjTime" header="不合格降级时间" field="nhgjjTime" width="120" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="nhgjjBlevel" header="不合格降级原等级" field="nhgjjBlevel" width="120" dataset="EvaluLevelDataset">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="nhgjjNlevel" header="不合格降级现等级" field="nhgjjNlevel" width="120"dataset="EvaluLevelDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="zdsqjjTime" header="主动申请降级时间" field="zdsqjjTime" width="120" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="zdsqjjBlevel" header="主动申请降级原等级" field="zdsqjjBlevel" width="150" dataset="EvaluLevelDataset">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="zdsqjjNlevel" header="主动申请降级现等级&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" field="zdsqjjNlevel" width="200" dataset="EvaluLevelDataset">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
