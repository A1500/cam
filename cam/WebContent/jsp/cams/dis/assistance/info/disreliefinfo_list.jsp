
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>DIS_RELIEF_INFO列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disreliefinfo_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
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
								<td class="FieldLabel">编号:</td>
								<td class="FieldInput"><input type="text"  id="infoId" class="TextEditor" title="INFO_ID"  /></td>	
								<td class="FieldLabel">档案编号:</td>
								<td class="FieldInput"><input type="text"  id="recordId" class="TextEditor" title="RECORD_ID"  /></td>	
								<td class="FieldLabel">救助类型:</td>
								<td class="FieldInput"><input type="text"  id="reliefType" class="TextEditor" title="RELIEF_TYPE"  /></td>	
								<td class="FieldLabel">需口粮救助（公斤）:</td>
								<td class="FieldInput"><input type="text"  id="requiredForFood" class="TextEditor" title="REQUIRED_FOR_FOOD"  /></td>	
								<td class="FieldLabel">需衣被救助（件）:</td>
								<td class="FieldInput"><input type="text"  id="requiredForClothes" class="TextEditor" title="REQUIRED_FOR_CLOTHES"  /></td>	
								<td class="FieldLabel">需取暖救助（元）:</td>
								<td class="FieldInput"><input type="text"  id="requiredForHeat" class="TextEditor" title="REQUIRED_FOR_HEAT"  /></td>	
								<td class="FieldLabel">需伤病救助（元）:</td>
								<td class="FieldInput"><input type="text"  id="requiredForDisease" class="TextEditor" title="REQUIRED_FOR_DISEASE"  /></td>	
								<td class="FieldLabel">需其他救助（元）:</td>
								<td class="FieldInput"><input type="text"  id="requiredForOthers" class="TextEditor" title="REQUIRED_FOR_OTHERS"  /></td>	
								<td class="FieldLabel">受灾时间:</td>
								<td class="FieldInput"><input type="text"  id="damageTime" class="TextEditor" title="DAMAGE_TIME"  /></td>	
								<td class="FieldLabel">灾害种类:</td>
								<td class="FieldInput"><input type="text"  id="disasterType" class="TextEditor" title="DISASTER_TYPE"  /></td>	
								<td class="FieldLabel">倒塌房屋（间）:</td>
								<td class="FieldInput"><input type="text"  id="collapsedHouse" class="TextEditor" title="COLLAPSED_HOUSE"  /></td>	
								<td class="FieldLabel">严重损坏房屋（间）:</td>
								<td class="FieldInput"><input type="text"  id="seriousDamageHouse" class="TextEditor" title="SERIOUS_DAMAGE_HOUSE"  /></td>	
								<td class="FieldLabel">一般损坏房屋（间）:</td>
								<td class="FieldInput"><input type="text"  id="generalDamageHouse" class="TextEditor" title="GENERAL_DAMAGE_HOUSE"  /></td>	
								<td class="FieldLabel">需重建房屋（间）:</td>
								<td class="FieldInput"><input type="text"  id="rebuildHouse" class="TextEditor" title="REBUILD_HOUSE"  /></td>	
								<td class="FieldLabel">需修缮房屋（间）:</td>
								<td class="FieldInput"><input type="text"  id="repairedHouse" class="TextEditor" title="REPAIRED_HOUSE"  /></td>	
								<td class="FieldLabel">死者姓名:</td>
								<td class="FieldInput"><input type="text"  id="deadName" class="TextEditor" title="DEAD_NAME"  /></td>	
								<td class="FieldLabel">死者性别:</td>
								<td class="FieldInput"><input type="text"  id="deadSex" class="TextEditor" title="DEAD_SEX"  /></td>	
								<td class="FieldLabel">死者年龄:</td>
								<td class="FieldInput"><input type="text"  id="deadAge" class="TextEditor" title="DEAD_AGE"  /></td>	
								<td class="FieldLabel">死者民族:</td>
								<td class="FieldInput"><input type="text"  id="deadFolk" class="TextEditor" title="DEAD_FOLK"  /></td>	
								<td class="FieldLabel">死者户口所在地:</td>
								<td class="FieldInput"><input type="text"  id="deadPopulace" class="TextEditor" title="DEAD_POPULACE"  /></td>	
								<td class="FieldLabel">死亡（失踪）地点:</td>
								<td class="FieldInput"><input type="text"  id="deadMissingPlace" class="TextEditor" title="DEAD_MISSING_PLACE"  /></td>	
								<td class="FieldLabel">死亡（失踪）时间:</td>
								<td class="FieldInput"><input type="text"  id="deadMissingTime" class="TextEditor" title="DEAD_MISSING_TIME"  /></td>	
								<td class="FieldLabel">死亡（失踪）原因:</td>
								<td class="FieldInput"><input type="text"  id="deadMissingReason" class="TextEditor" title="DEAD_MISSING_REASON"  /></td>	
								<td class="FieldLabel">核准救助时段:</td>
								<td class="FieldInput"><input type="text"  id="approvalTimes" class="TextEditor" title="APPROVAL_TIMES"  /></td>	
								<td class="FieldLabel">核准救助粮食（公斤）:</td>
								<td class="FieldInput"><input type="text"  id="approvalFood" class="TextEditor" title="APPROVAL_FOOD"  /></td>	
								<td class="FieldLabel">核准救助衣被（件）:</td>
								<td class="FieldInput"><input type="text"  id="approvalClothes" class="TextEditor" title="APPROVAL_CLOTHES"  /></td>	
								<td class="FieldLabel">核准重建间数（间）:</td>
								<td class="FieldInput"><input type="text"  id="approvalRebuiledHouse" class="TextEditor" title="APPROVAL_REBUILED_HOUSE"  /></td>	
								<td class="FieldLabel">核准修缮间数（间）:</td>
								<td class="FieldInput"><input type="text"  id="approvalRepairedHouse" class="TextEditor" title="APPROVAL_REPAIRED_HOUSE"  /></td>	
								<td class="FieldLabel">核准救助资金（元）:</td>
								<td class="FieldInput"><input type="text"  id="approvalMonry" class="TextEditor" title="APPROVAL_MONRY"  /></td>	
								<td class="FieldLabel">村级填报人姓名:</td>
								<td class="FieldInput"><input type="text"  id="acceptPeopleName" class="TextEditor" title="ACCEPT_PEOPLE_NAME"  /></td>	
								<td class="FieldLabel">填报日期:</td>
								<td class="FieldInput"><input type="text"  id="acceptDate" class="TextEditor" title="ACCEPT_DATE"  /></td>	
								<td class="FieldLabel">乡镇（街道）审核人代码:</td>
								<td class="FieldInput"><input type="text"  id="checkPeopleOrganId" class="TextEditor" title="CHECK_PEOPLE_ORGAN_ID"  /></td>	
								<td class="FieldLabel">乡镇（街道）审核人名称:</td>
								<td class="FieldInput"><input type="text"  id="checkPeopleName" class="TextEditor" title="CHECK_PEOPLE_NAME"  /></td>	
								<td class="FieldLabel">审核日期:</td>
								<td class="FieldInput"><input type="text"  id="checkDate" class="TextEditor" title="CHECK_DATE"  /></td>	
								<td class="FieldLabel">县级批准人代码:</td>
								<td class="FieldInput"><input type="text"  id="auditPeopleOrganId" class="TextEditor" title="AUDIT_PEOPLE_ORGAN_ID"  /></td>	
								<td class="FieldLabel">县级批准人名称:</td>
								<td class="FieldInput"><input type="text"  id="auditPeopleName" class="TextEditor" title="AUDIT_PEOPLE_NAME"  /></td>	
								<td class="FieldLabel">批准日期:</td>
								<td class="FieldInput"><input type="text"  id="auditDate" class="TextEditor" title="AUDIT_DATE"  /></td>	
								<td class="FieldLabel">发放人代码:</td>
								<td class="FieldInput"><input type="text"  id="grantPeopleOrganId" class="TextEditor" title="GRANT_PEOPLE_ORGAN_ID"  /></td>	
								<td class="FieldLabel">发放人名称:</td>
								<td class="FieldInput"><input type="text"  id="grantPeopleName" class="TextEditor" title="GRANT_PEOPLE_NAME"  /></td>	
								<td class="FieldLabel">发放日期:</td>
								<td class="FieldInput"><input type="text"  id="grantTime" class="TextEditor" title="GRANT_TIME"  /></td>	
								<td class="FieldLabel">备注:</td>
								<td class="FieldInput"><input type="text"  id="comment" class="TextEditor" title="COMMENT"  /></td>	
								<td class="FieldLabel">填报单位代码:</td>
								<td class="FieldInput"><input type="text"  id="organCode" class="TextEditor" title="ORGAN_CODE"  /></td>	
								<td class="FieldLabel">填报单位名称:</td>
								<td class="FieldInput"><input type="text"  id="organName" class="TextEditor" title="ORGAN_NAME"  /></td>	
								<td class="FieldLabel">流程跳转状态:</td>
								<td class="FieldInput"><input type="text"  id="workflowStatus" class="TextEditor" title="WORKFLOW_STATUS"  /></td>	
								<td class="FieldLabel">流程接收单位:</td>
								<td class="FieldInput"><input type="text"  id="workflowReceiveOrgan" class="TextEditor" title="WORKFLOW_RECEIVE_ORGAN"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="DIS_RELIEF_INFO">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="infoId" header="编号" field="infoId" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="recordId" header="档案编号" field="recordId" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="reliefType" header="救助类型" field="reliefType" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="requiredForFood" header="需口粮救助（公斤）" field="requiredForFood" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="requiredForClothes" header="需衣被救助（件）" field="requiredForClothes" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="requiredForHeat" header="需取暖救助（元）" field="requiredForHeat" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="requiredForDisease" header="需伤病救助（元）" field="requiredForDisease" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="requiredForOthers" header="需其他救助（元）" field="requiredForOthers" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="damageTime" header="受灾时间" field="damageTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="disasterType" header="灾害种类" field="disasterType" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="collapsedHouse" header="倒塌房屋（间）" field="collapsedHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="seriousDamageHouse" header="严重损坏房屋（间）" field="seriousDamageHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="generalDamageHouse" header="一般损坏房屋（间）" field="generalDamageHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="rebuildHouse" header="需重建房屋（间）" field="rebuildHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="repairedHouse" header="需修缮房屋（间）" field="repairedHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadName" header="死者姓名" field="deadName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadSex" header="死者性别" field="deadSex" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadAge" header="死者年龄" field="deadAge" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadFolk" header="死者民族" field="deadFolk" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadPopulace" header="死者户口所在地" field="deadPopulace" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadMissingPlace" header="死亡（失踪）地点" field="deadMissingPlace" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadMissingTime" header="死亡（失踪）时间" field="deadMissingTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="deadMissingReason" header="死亡（失踪）原因" field="deadMissingReason" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalTimes" header="核准救助时段" field="approvalTimes" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalFood" header="核准救助粮食（公斤）" field="approvalFood" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalClothes" header="核准救助衣被（件）" field="approvalClothes" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalRebuiledHouse" header="核准重建间数（间）" field="approvalRebuiledHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalRepairedHouse" header="核准修缮间数（间）" field="approvalRepairedHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalMonry" header="核准救助资金（元）" field="approvalMonry" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="acceptPeopleName" header="村级填报人姓名" field="acceptPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="acceptDate" header="填报日期" field="acceptDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkPeopleOrganId" header="乡镇（街道）审核人代码" field="checkPeopleOrganId" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkPeopleName" header="乡镇（街道）审核人名称" field="checkPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkDate" header="审核日期" field="checkDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditPeopleOrganId" header="县级批准人代码" field="auditPeopleOrganId" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditPeopleName" header="县级批准人名称" field="auditPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditDate" header="批准日期" field="auditDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantPeopleOrganId" header="发放人代码" field="grantPeopleOrganId" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantPeopleName" header="发放人名称" field="grantPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantTime" header="发放日期" field="grantTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="note" header="备注" field="note" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organCode" header="填报单位代码" field="organCode" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="organName" header="填报单位名称" field="organName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="workflowStatus" header="流程跳转状态" field="workflowStatus" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="workflowReceiveOrgan" header="流程接收单位" field="workflowReceiveOrgan" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
