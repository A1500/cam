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
		<style type="text/css">  
	 	 	
	 	 	  .selectBorder { 
				display: block;
				width: 100px;
				height: 240px; /*此高度不可更改*/
				margin: 0;
				overflow: hidden ;
				border: 1px solid #009ac5;
				background: #fff;
				float: left;
				}
				.selectBorder select { 
				width: 100px;
				height: 250px;
				margin: -1px;
				border: 0;
				}
				p {font-size: 70%}
			</style> 
		<script type="text/javascript" src="bptdata.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="doubselect.js"></script>
		
		<script type="text/javascript" src="basicInfoListNew.js"></script>
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
		<style type="text/css">  
	 	 	
	 	 	  .selectBorder { 
display: block;
width: 150px;
height: 240px; 
margin: 0;
overflow: hidden ;
border: 1px solid #009ac5;
background: #fff;
float: left;
}
.selectBorder select { 
width: 150px;
height: 250px;
margin: -1px;
border: 0;
}
			</style>  
	</head>
<body>
<model:datasets>
	<!-- 全部人员信息 -->
	<model:dataset id="dsBptObject" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryBPTPeopleInfo" global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 全部人员信息用于导出Excel -->
	<model:dataset id="dsBptObject1" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryBPTPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	
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
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
    <!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectType" enumName="BIGOBJECT.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE"  autoLoad="true" global="true"></model:dataset>
	<!-- 是否抗美援朝 -->
	<model:dataset id="dsIskoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="dsIsWar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="dsIsInnuclear" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!--参战类别代码-->
	<model:dataset id="warTypeCodeDataset" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否为省内迁移人员-->
	<model:dataset id="isprovinceMigrateds" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否-->
	<model:dataset id="yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 与牺牲病故军人关系 -->
	<model:dataset id="RelationTypeEnum" enumName="RELATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE"
		autoLoad="true" global="true"></model:dataset>
		<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE"
		autoLoad="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!--参战类别代码-->
	<model:dataset id="dsWarData" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
    <model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE"  autoLoad="true" global="true"></model:dataset>
    <!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" id="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
					
						<table  border="1" width="100%" id="queryTable">
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput">
								<input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp()"/>
								<input type="hidden"  id="domicileCode" class="TextEditor"/></td>
								<td class="FieldLabel" >姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput" ><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								
							</tr>
							
							<tr>
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput" >
								<!-- 	<select id="objectType" name="objectType"> 
											<option dataset="ObjectType"></option>
									</select> -->
									<input type="text"  id="objectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="objectType"  id="objectType" class="TextEditor"/>
								</td>
								<td class="FieldLabel" align="center" >年龄：</td>
								<td class="FieldInput" align="center" >
									<input type="text"  id="ageBegin" style="width:60px"  />~<input type="text"  id="ageEnd" style="width:60px"  />
								</td>
							
								<td class="FieldLabel">批准日期：</td>
								<td class="FieldInput" align="left" nowrap="nowrap" ><select id ="timeType" onchange="showTime('')">
								<option value="0">--请选择--</option>
								<option value="2">截止日期</option>
								<option value="1">起止日期</option>
								</select> 
								<span  id ="times" style="display: none;" ><input type="text" id="startTime"
									format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
									type="text" id="endTime" format="Y-m-d"
									style="width: 80px;" maxlength="10"  onpropertychange="changeDateStyle(this)"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
								</span>
								<span    id = "time" ><input type="text" id="toTime"
									format="Y-m-d" style="width: 80px;" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
								</span>
								
							</tr>
						</table>
						<table border="1" width="100%" id="queryTable1">
							<tr>
								<td class="FieldButton" style="text-align: center;">
								<button onclick="query()" id="queryButton">查 询</button>
								&nbsp;&nbsp;&nbsp;
								<button onclick="selectCondition('conditionSelect')">自定义查询条件</button>
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
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="打印" iconCls="edit" handler="print"/>
		<next:ToolBarItem text="导出人员档案" iconCls="detail" handler="dossiers"/>
		<next:ToolBarItem text="导出EXCEL" iconCls="detail" handler="excel_click"/>
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
		
		<next:Column id="PEOPLE_AGE" header="年龄（周岁）" field="PEOPLE_AGE" width="80" >
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
		<next:Column id="objectType" header="优抚对象类别" field="OBJECT_TYPE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsBptObject" />
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
<next:Window id="conditionSelect" title='选择查询条件' resizable="false"
	width="360" height="330" lazyRender="false" closable="false">
	<next:FitLayout>
		<next:Panel id="extend" border="false">
			<next:Html>
				<div id="conditions"></div>
			</next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="确定" handler="win_sure"></next:ToolButton>
		<next:ToolButton text="关闭" handler="cwin_close()"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="fieldSelect" title='选择需要导出的信息' resizable="false"
	width="360" height="330" lazyRender="false" closable="false">
	<next:FitLayout>
		<next:Panel id="fextend" border="false">
			<next:Html>
				<div id="fields"></div>
			</next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="导出" handler="excel_imp" id="excelButton"></next:ToolButton>
		<next:ToolButton text="关闭" handler="fwin_close()"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
<input type="hidden" id="printYear" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="printMonth" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="changeContent" name="printMark" printMark="printMark" value="" />
<input type="hidden" id="docPath" printMark="printMark" value="" />
<input type="hidden" id="bptQueryPathServiceType" value=""/>
</html>
