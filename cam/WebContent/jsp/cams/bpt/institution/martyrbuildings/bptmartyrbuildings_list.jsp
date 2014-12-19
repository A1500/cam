<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>烈士纪念建筑物保护单位信息列表</title>
		<next:ScriptManager/>	<script>
		var organName = '<%=BspUtil.getOrganName()%>';
		var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptmartyrbuildings_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings">
			<model:field name="domicileName" type="string" />	
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%">
							<tr >
								<td class="FieldLabel" nowrap style="width:15%">行政区划:</td>
								<td class="FieldInput" style="width:15%">
									<input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:80%" onclick="func_ForDomicileSelect1()" readonly="readonly"/>
									<input type="hidden"  id="domicileCode"  title="行政区划"  />
								</td>	
								<td class="FieldLabel" nowrap style="width:15%">单位全称:</td>
								<td class="FieldInput" style="width:15%"><input type="text"  id="unitFullname" class="TextEditor" title="单位全称" style="width:80%" /></td>	
								<td class="FieldButton" style="width:15%"><button  id="queryButton"  onclick="query()">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap style="width:15%">主管部门:</td>
								<td class="FieldInput" style="width:15%"><input type="text"  id="personSection" class="TextEditor" title="主管部门" style="width:80%" /></td>	
								<td class="FieldLabel" nowrap>重点保护单位批准级别:</td>
								<td class="FieldInput" style="width:15%"><input type="text"  id="protectionUnit" class="TextEditor" title="重点保护单位批准级别" style="width:80%" /></td>	
								<td class="FieldButton" style="width:15%"><button onclick="reset()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="bptmartyrbuildingsGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" height="100%" dataset="ds" title="烈士纪念建筑物保护单位信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem iconCls="detail"  text="明细" handler="Evt_butdetail_click"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="mbuildingId" header="ID" field="mbuildingId" width="90" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="domicileName" header="行政区划" field="domicileName" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="unitFullname" header="单位全称" field="unitFullname" width="140" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="personSection" header="主管部门" field="personSection" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="creationDate" header="建立日期" field="creationDate" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="registerProperty" header="注册资产" field="registerProperty" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="immobilisations" header="固定资产原值(万元)" field="immobilisations" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="floorArea" header="占地面积(平方米)" field="floorArea" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="businessArea" header="业务用房面积(平方米)" field="businessArea" width="140" >
			<next:TextField  />
		</next:Column>
		<next:Column id="telContact" header="联系电话" field="telContact" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="postcode" header="邮政编码" field="postcode" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="mailingAddress" header="通信地址" field="mailingAddress" width="90" hidden="true" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="unitIntroduce" header="单位介绍" field="unitIntroduce" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="prepareNum" header="编制人数" field="prepareNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="yearWorkerNum" header="年末职工人数" field="yearWorkerNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="primaryTitleNum" header="初级职称人数" field="primaryTitleNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="intermediateTitleNum" header="中级职称人数" field="intermediateTitleNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		<next:Column id="seniorTitleNum" header="高级职称人数" field="seniorTitleNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="centralFunds" header="中央划拨维修改造经费" field="centralFunds" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="placeFunds" header="地方下拨的维修改造经费" field="placeFunds" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="officialFunds" header="办公经费" field="officialFunds" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="personnelFunds" header="人员工资" field="personnelFunds" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="otherFunds" header="其他经费" field="otherFunds" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="protectionUnit" header="重点保护单位批准级别" field="protectionUnit" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="noticeDate" header="批准时间" field="noticeDate" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="burialMartyrsNum" header="安葬烈士人数" field="burialMartyrsNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="showMartyrsNum" header="陈展烈士人数" field="showMartyrsNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="receptionLookedNum" header="接待瞻仰人次" field="receptionLookedNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="americanaNum" header="革命文物数量" field="americanaNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="martyrFacilityNum" header="烈士纪念设施数量" field="martyrFacilityNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="patrioticEducationBase" header="是否爱国主义教育基地" field="patrioticEducationBase" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="redScenicSpots" header="是否红色旅游精品景点" field="redScenicSpots" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regId" header="录入人ID" field="regId" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regTime" header="录入时间" field="regTime" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="modId" header="修改人ID" field="modId" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="modTime" header="修改时间" field="modTime" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="note" header="备注" field="note" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
