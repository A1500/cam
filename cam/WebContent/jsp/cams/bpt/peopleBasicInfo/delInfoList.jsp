<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>优抚对象基本信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="delInfoList.js"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
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
	<!-- 全部人员信息 -->
	<model:dataset id="dsBptObject" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleService" global="true" pageSize="5">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="APPLY_ID" type="string"/>
			<model:field name="ACTDEF_NAME" type="string"/>
			<model:field name="ACT" type="string"/>
			<model:field name="SERVICE_TYPE" type="string"/>
			<model:field name="ST" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
    <!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectType" enumName="BIGOBJECT.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" id="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
					<input type="hidden" id="test" value="2"/>
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput">
								<input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp()"/>
								<input type="hidden"  id="domicileCode" class="TextEditor"/></td>
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldInput" align="center" style="text-align: center"><button id="queryButton" onclick="query()">查 询</button> 
					</td>
							</tr>
							<tr>
								<td class="FieldLabel">优抚对象类别：</td>
								<td class="FieldInput">
								    <select id="objectType" name="objectType" field="objectType"> 
											<option dataset="ObjectTypeDataset"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="objectState" name="objectState" field="objectState"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap">业务类型：</td>
								<td class="FieldInput">
									<select id="serviceType" name="serviceType"> 
											<option value="">非(未)审批人员</option>
											<option value="11">伤残人员评残</option>
											<option value="12">伤残人员调残</option>
											<option value="13">伤残人员换证补证</option>
											<option value="17">伤残人员配置伤残辅助器械</option>
											<option value="14">退役军人伤残抚恤关系迁入</option>
											<option value="15">外省伤残人员抚恤关系迁入</option>
											<option value="16">伤残人员省内迁移</option>
											<option value="19">伤残人员抚恤关系跨省迁出</option>
											<option value="21">三属定期抚恤申请审批</option>
											<option value="22">三属抚恤定补关系跨省迁入</option>
											<option value="23">三属抚恤定补关系省内迁移</option>
											<option value="25">三属抚恤定补关系跨省迁出</option>
											<option value="41">在乡复员军人身份认定及定期定量生活补助审批</option>
											<option value="42">在乡复员军人定补关系跨省迁入</option>
											<option value="43">在乡复员军人定补关系省内迁移</option>
											<option value="4A">在乡复员军人定补关系跨省迁出</option>
											<option value="45">带病回乡退伍军人身份认定及生活补助审批</option>
											<option value="46">带病回乡退伍军人定补关系跨省迁入</option>
											<option value="47">带病回乡退伍军人定补关系省内迁移</option>
											<option value="4B">带病回乡退伍军人定补关系跨省迁出</option>
											<option value="55">参战人员定补关系跨省迁出</option>
											<option value="51">参战人员身份认定及生活补助申请审批</option>
											<option value="52">参战人员定补关系跨省迁入</option>
											<option value="53">参战人员定补关系省内迁移</option>
											<option value="65">参试人员定补关系跨省迁出</option>
											<option value="61">参试人人员身份认定及生活补助申请审批</option>
											<option value="62">参试人员定补关系跨省迁入</option>
											<option value="63">参试人员定补关系省内迁移</option>
											<option value="81">年满60周岁农村籍退役士兵</option>
											<option value="82">年满60周岁农村籍退役士兵定补关系跨省迁入</option>
											<option value="83">年满60周岁农村籍退役士兵定补关系省内迁移</option>
											<option value="84">年满60周岁农村籍退役士兵定补关系跨省迁出</option>
											<option value="B2">部分烈士（错杀被平反人员）子女定补关系跨省迁入</option>
											<option value="B3">部分烈士（错杀被平反人员）子女定补关系省内迁移</option>
											<option value="B4">部分烈士（错杀被平反人员）子女定补关系跨省迁出</option>
											<option value="B1">部分烈士（错杀被平反人员）子女</option>
											<option value="A1">临时补助申请审批</option>
									</select> 
								</td>
								<td class="FieldInput" align="center" style="text-align: center"> 
					<button onclick="reset()">重 置</button> 
					</td>  
							</tr>
							
						</table>
					</form>
					<!-- 此隐藏域仅用于存放优抚对象的节点ID -->
					<input type="hidden" name="bptObjectType" id="bptObjectType" />
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="baseGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true" dataset="dsBptObject" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="删除" iconCls="delete" handler="delPeople"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DOMICILE_NAME" width="240">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="NAME" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="ID_CARD" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="SEX" header="性别" field="SEX" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="NATION" header="民族" field="NATION" width="70" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectState" header="优抚对象状态" field="OBJECT_STATE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectState" header="优抚对象类别" field="OBJECT_TYPE" width="115" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="objectType" header="业务类型" field="ST" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="已办环节" field="ACTDEF_NAME" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="审批时间" field="ACT" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsBptObject"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
