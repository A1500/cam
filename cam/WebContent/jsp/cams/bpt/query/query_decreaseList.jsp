<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String objectName = request.getParameter("objectName");
	if(objectName != null && !"".equals(objectName)) {
		objectName = java.net.URLDecoder.decode(objectName, "utf-8");
	}
	String type = request.getParameter("type");
	if(type != null && !"".equals(type)) {
		type = java.net.URLDecoder.decode(type, "utf-8");
	}
	String query_organCode = request.getParameter("organCode");
%>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
   
   var query_organCode = '<%=query_organCode%>';
   var autoQuery = '<%=request.getParameter("autoQuery")%>';
   var query_objectType = '<%=request.getParameter("objectType")%>';
   var query_objectName = '<%=objectName%>';
   var query_state = '<%=request.getParameter("state")%>';
   var query_startTime = '<%=request.getParameter("startTime") == null?"":request.getParameter("startTime")%>';
   var query_endTime = '<%=request.getParameter("endTime")%>';
   var query_timeType='<%=request.getParameter("timeType")%>';
   var query_type='<%=type%>';
</script>
<html>
	<head>
		<title>优抚对象基本信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script type="text/javascript" src="query_decreaseList.js"></script>
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
	<model:dataset id="dsBptObject" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryDecreaseBpt" global="true" pageSize="100">
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
    <!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	 
	 
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset> 
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
					<form style="width: 95%; height: 100%;" class="L5form">
					<input type="hidden" id="test" value="2"/>
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属行政区划：</td>
								<td class="FieldInput">
								<input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp()"/>
								<input type="hidden"  id="domicileCode" class="TextEditor"/></td>
								 <td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
								<!-- 	<select id="objectType" name="objectType"> 
											<option dataset="ObjectType"></option>
									</select> -->
									<input type="text"  id="objectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="objectType"  id="objectType" class="TextEditor"/>
								</td>
								<td class="FieldInput" align="center">
									<button onclick="reset()">重 置</button> 
								</td>
							</tr>
							<tr>	
								<tr>
								<td class="FieldLabel">批准日期：</td>
					<td  align="left" style="background-color: #f5fafa;text-align:left;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="timeType" onchange="showTime('')">
					<option value="2">截止日期</option>
					<option value="1">起止日期</option>
					</select> </td>
					<td colspan="2" class="FieldInput"   id ="times" style="display: none;" ><input type="text" id="cxsj_qs"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="cxsj_zs" format="Y-m-d"
						style="width: 80px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td colspan="2" class="FieldInput"  id = "time" ><input type="text" id="cxsj_z"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td class="FieldInput" align="center"><button onclick="query()">查 询</button> 
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
    
<!-- 参试查询条件 -->
<next:Panel name="testform" id="testform" hidden="true" width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap>所属机构：</td>
				
				<td class="FieldInput"><input type="hidden" id="testDomicileCode" />
				<input type="text" id="testDomicileName" class="TextEditor" title="所属机构"
					onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td class="FieldInput">
						<input type="text"  id="testObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
						<input type="hidden" name="testObjectType"  id="testObjectType" class="TextEditor"/>
				</td>
				<td class="FieldLabel" nowrap>参试类别：</td>
				<td class="FieldInput"><select style="width: 160px;"
					id="testType"  title="参试类别">
					<option dataset="dsTest"></option>
				</select></td>
			</tr>
			 
			<tr>
					<td class="FieldLabel">批准日期：</td>
					<td  style="background-color: #f5fafa;text-align: left;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="testtimeType" onchange="showTime('test')">
					<option value="2">截止日期</option>
					<option value="1">起止日期</option>
					</select>  
					<td  id ="testtimes" style="display: none;" ><input type="text" id="testcxsj_qs"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="testcxsj_zs" format="Y-m-d"
						style="width: 80px;" maxlength="10"   onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td  id = "testtime" ><input type="text" id="testcxsj_z"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td  colspan="3"  align="center"><button onclick="query()">查 询</button>
								&nbsp;<button onclick="reset()">重 置</button></td>
				</tr>	
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
   
<!-- 参试查询条件 -->
<next:Panel name="offspringform" id="offspringform" hidden="true" width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap>所属机构：</td>
				
				<td class="FieldInput"><input type="hidden" id="offspringDomicileCode" />
				<input type="text" id="offspringDomicileName" class="TextEditor" title="所属机构"
					onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td class="FieldInput">
						<input type="text"  id="offspringObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
						<input type="hidden" name="offspringObjectType"  id="offspringObjectType" class="TextEditor"/>
				</td>
				<td class="FieldLabel" nowrap>类别：</td>
				<td class="FieldInput"><select style="width: 160px;"
					id="offspringType"  title="类别">
					<option value="1">部分烈士子女</option>
					<option value="2">错杀被平反子女</option>
				</select></td>
			</tr>
			 
			<tr>
					<td class="FieldLabel">批准日期：</td>
					<td  style="background-color: #f5fafa;text-align: left;font: normal 12px tahoma, arial, helvetica, sans-serif;"><select id ="offspringtimeType" onchange="showTime('offspring')">
					<option value="2">截止日期</option>
					<option value="1">起止日期</option>
					</select>  
					<td  id ="offspringtimes" style="display: none;" ><input type="text" id="offspringcxsj_qs"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >--  --<input
						type="text" id="offspringcxsj_zs" format="Y-m-d"
						style="width: 80px;" maxlength="10"   onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td  id = "offspringtime" ><input type="text" id="offspringcxsj_z"
						format="Y-m-d" style="width: 80px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > 
					</td>
					<td  colspan="3"  align="center"><button onclick="query()">查 询</button>
								&nbsp;<button onclick="reset()">重 置</button></td>
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
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="导出" iconCls="chart" handler="excel_export"/>
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
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DICNAME" width="240">
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
	
		<next:Column id="NATION" header="名族" field="NATION" width="70" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectState" header="优抚对象状态" field="STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="SERVICE_TYPE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsBptObject"/>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="scaconfPath" value="reguIdentiApp/reguIdentiAppPrintDao"/>
<input type="hidden" id="objectType" name="printQuery" queryData="queryData" value="" />
</html>
