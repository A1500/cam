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
		<script type="text/javascript" src="doubleIdRemindList.js"></script>
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
	<model:dataset id="dsBptObject" cmd="com.inspur.cams.bpt.manage.cmd.BptNotRemindQueryCommand" method="queryDoubPeopleRemind" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="APPLY_ID" type="string"/>
			<model:field name="ACTDEF_NAME" type="string"/>
			<model:field name="ACT" type="string"/>
			<model:field name="SERVICE_TYPE" type="string"/>
			<model:field name="ST" type="string"/>
		</model:record>
	</model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
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
							
								<td class="FieldInput" align="center" style="text-align: center"> 
					<button onclick="reset()">重 置</button> 
					</td>  
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="baseGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true" dataset="dsBptObject" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="认证人员状态" iconCls="detail" handler="sure" id="excelButton"/>
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
	
		<next:Column id="disability_flag" header="伤残人员" field="DISABILITY_FLAG" renderer="typeRender" width="70" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="dependant_flag" header="三属人员" field="DEPENDANT_FLAG" renderer="typeRender" width="115" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="demobilized_flag" header="在乡复员人员" field="DEMOBILIZED_FLAG" renderer="typeRender"  width="115" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="demobilizedill_flag" header="带病回乡人员" field="DEMOBILIZEDILL_FLAG"  renderer="typeRender" width="115" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="war_flag" header="参战人员" field="WAR_FLAG" renderer="typeRender" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="test_flag" header="参试人员" field="TEST_FLAG" renderer="typeRender" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="retired_flag" header="60周岁退役士兵" field="RETIRED_FLAG" renderer="typeRender" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="martyr_offspring_flag" header="老烈子女" field="MARTYR_OFFSPRING_FLAG" renderer="typeRender" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>	
		<next:PagingToolBar dataset="dsBptObject"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
