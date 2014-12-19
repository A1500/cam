
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>优抚医院信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bpthospital_list.js"></script>
		<script>
		var organName = '<%=BspUtil.getOrganName()%>';
		var organCode = '<%=BspUtil.getOrganCode()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalQueryCommand"  global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptinstitution.data.BptHospital">
			<model:field name="domicileName" type="string" />	
		</model:record>
	</model:dataset>
		<!-- 优抚医院种类 -->
	<model:dataset id="bptHospitalType" enumName="BPT.HOSPITAL.TYPE" autoLoad="true" global="true"></model:dataset>
		<!-- 优抚医院等级代码 -->
	<model:dataset id="bptHospitalLevel" enumName="BPT.HOSPITAL.LEVEL" autoLoad="true" global="true"></model:dataset>
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
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr>
								<td class="FieldLabel" nowrap style="width:15%">行政区划:</td>
								<td class="FieldInput" style="width:15%">
								<input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:80%" onclick="func_ForDomicileSelect1()" readonly="readonly"/>
								<input type="hidden"  id="domicileCode"  title="行政区划"  /></td>	
								<td class="FieldLabel" nowrap style="width:15%">单位全称:</td>
								<td class="FieldInput" style="width:15%"><input type="text"  id="unitFullname" class="TextEditor" title="单位全称" style="width:80%" /></td>	
								<td class="FieldButton" style="width:15%"><button id="queryButton" onclick="query()">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap style="width:15%">主管部门:</td>
								<td class="FieldInput" style="width:15%"><input type="text"  id="personSection" class="TextEditor" title="主管部门" style="width:80%" /></td>	
								<td class="FieldLabel" style="width:15%"></td>	
								<td class="FieldInput" style="width:15%"></td>	
								<td class="FieldButton" style="width:15%"><button onclick="reset()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bpthospitalGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" height="100%" dataset="ds" title="优抚医院信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="删除" iconCls="delete" handler="del" />
		<next:ToolBarItem text="查看" iconCls="edit" handler="getDeatil"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="hospitalId" header="ID" field="hospitalId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="domicileCode" header="行政区划" field="domicileName"  width="120"  >
			<next:TextField allowBlank="false"/>
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
	
		<next:Column id="registerProperty" header="注册资本(万元)" field="registerProperty" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="immobilisations" header="固定资产原值(万元)" field="immobilisations" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="floorArea" header="占地面积(平方米)" field="floorArea" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="businessArea" header="业务用房面积(平方米)" field="businessArea" width="130" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="telContact" header="联系电话" field="telContact" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="postcode" header="邮政编码" field="postcode" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="mailingAddress" header="通信地址" field="mailingAddress" width="150" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="unitIntroduce" header="单位介绍" field="unitIntroduce" width="150" hidden="true" >
			<next:TextField  />
		</next:Column>
	
	 	<next:Column id="prepareNum" header="编制人数" field="prepareNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="yearWorkerNum" header="年末职工人数" field="yearWorkerNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="threewNum" header="三无人数" field="threewNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="primaryTitleNum" header="初级职称人数" field="primaryTitleNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="intermediateTitleNum" header="中级职称人数" field="intermediateTitleNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="seniorTitleNum" header="高级职称人数" field="seniorTitleNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="centralFunds" header="中央划拨维修改造经费" field="centralFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="placeFunds" header="地方下拨的维修改造经费" field="placeFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="bptMedicalFunds" header="优抚对象医疗经费" field="bptMedicalFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="bptLiveFunds" header="优抚对象的生活经费" field="bptLiveFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="officialFunds" header="办公经费" field="officialFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="personnelFunds" header="人员工资" field="personnelFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="otherFunds" header="其他经费" field="otherFunds" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="bptHospitalSort" header="优抚医院种类" field="bptHospitalSort" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="bptHospitalBusintype" header="优抚医院业务类型" field="bptHospitalBusintype" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="bptHospitalGrade" header="优抚医院等级" field="bptHospitalGrade" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="tenbelowDevice" header="1-10万元设备数(件)" field="tenbelowDevice" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="tenaboveDevice" header="10万元以上设备数(件)" field="tenaboveDevice" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="formationBed" header="编制床位(张)" field="formationBed" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="yearActualBed" header="年末实有床位(张)" field="yearActualBed" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="allyearInhospital" header="全年收住院人次" field="allyearInhospital" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="allyearOutpatients" header="全年门诊人次" field="allyearOutpatients" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="yearBptNum" header="年末优抚对象人数" field="yearBptNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="maimNum" header="1-4级残疾军人数" field="maimNum" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="psychosisHometown" header="带精神病回乡复员退伍军人数" field="psychosisHometown" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="otherillHometown" header="带其他严重疾病回乡复员退伍军人数" field="otherillHometown" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="societyNum" header="社会病员人数" field="societyNum" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="newArtBusiness" header="新技术新业务项目" field="newArtBusiness" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regId" header="录入人ID" field="regId" width="90" hidden="true" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regTime" header="录入时间" field="regTime" width="90" hidden="true"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="modId" header="修改人ID" field="modId" width="90" hidden="true" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="modTime" header="修改时间" field="modTime" width="90" hidden="true"  hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="note" header="备注" field="note" width="90"  hidden="true">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
