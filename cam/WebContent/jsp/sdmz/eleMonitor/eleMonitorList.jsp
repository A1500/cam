<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%
String organArea = BspUtil.getCorpOrgan().getOrganCode().substring(0,6);
String organArea1 = BspUtil.getCorpOrgan().getOrganCode();
String organCode = BspUtil.getCorpOrgan().getOrganCode();
String sign=null;
if(organArea1.substring(4,12).equals("00000000"))
{
	organArea1=organArea1.substring(0,4);
	sign="1";
}
 
%>
<script>
	        var organArea = "<%=organArea%>";
			var organArea1 = "<%=organArea1%>";
			var organCode = "<%=organCode%>";
			var organArea2 = "<%=organArea%>"+"000000";
			var sign = "<%=sign%>";
</script>
<html>
<head>
<title>家庭成员信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="eleMonitorList.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/ISPrint.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>

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
	<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetQu" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="DmHzgxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 患病种类-->
	<model:dataset id="DmHbzlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 事故种类-->
	<model:dataset id="DmSgzlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ACCIDENT_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 教育状况 -->
	<model:dataset id="DmJyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类型 -->
	<model:dataset id="DmCjlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 抚恤对象类型-->
	<model:dataset id="DmFxdxlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PENSIONO_OBJ'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="DmJzlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" 	autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗状况-->
	<model:dataset id="DmYlzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="DmXbDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	 <model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="domicileDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DOMICILE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" method="getJtcy1"  autoLoad="false" pageSize="15">
	</model:dataset>
	
   <model:dataset id="dsImport" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" method="getJtcy"  autoLoad="false" pageSize="15" >
	</model:dataset>
	<model:dataset id="printDataset" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" method="getJtcy">
	</model:dataset>
   <model:dataset id="jtcyNumDs" cmd="com.inspur.sdmz.jtxx.cmd.JtxxQueryCommand" global="true" autoLoad="false" method="getJtcyNum">
    </model:dataset>
</model:datasets>

<next:Panel name="form" width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form id="queryForm"   style="width: 100%; height: 100%;" class="L5form">
		<table border="1" style="width:100%;table-layout:fixed;">
			<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">姓名:</td>
				<td class="FieldInput"  width="15%" nowrap="nowrap"><input type="text" style="width:140" id="xmquery" name="xmquery" maxlength="25" class="TextEditor" title="成员姓名" style="width:90%"/></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">身份证号:</td>
				<td class="FieldInput" width="16%" nowrap="nowrap"><input type="text"  style="width:140" id="sfzhquery" name="sfzhquery" maxlength="18"  class="TextEditor" title="成员身份证号" /></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">户主姓名:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><input type="text" style="width:140"  id="hzxmquery" name="hzxmquery" maxlength="25" class="TextEditor" title="成员姓名" style="width:90%"/></td>
		  </tr>
		   <tr>
				<td class="FieldLabel" nowrap="nowrap" width="10%">区:</td>
			    <td class="FieldInput" width="15%"> <select id="quQuery"   style="width:140"  onchange="getDzStreet()"> <option  dataset="DmXzqhDataSetQu"></option> </select> </td>	
				<td class="FieldLabel" nowrap="nowrap" width="10%">街镇:</td>
				<td class="FieldInput" width="15%"> <select id="dzZhenquery"  style="width:140"  onchange="getDzCun()"> <option dataset="DmXzqhDataSetStreet"></option> </select></td>	
				<td class="FieldLabel" nowrap="nowrap" width="10%">村居:</td>
				<td class="FieldInput" width="15%"> <select id="dzCunquery"  style="width:140" > <option dataset="DmXzqhDataSetVillage"></option> </select>	</td>
	     	</tr>
		   	<tr>
		   	    <td class="FieldLabel" width="10%" nowrap="nowrap">与户主关系:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><select id="relationshipType" style="width:140"  name="relationshipType" > <option dataset="DmHzgxDataSet"></option> </select></td>
			
		     	<td class="FieldLabel" width="10%" nowrap="nowrap">家庭人口数:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><input type="text" id="peopleNum"   name="peopleNum"  style="width:70" title="请输入阿拉伯数字" /> </td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">性别:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"> <select id="sex" name="sex"  style="width:140"> <option dataset="DmXbDataSet"></option> </select></td>
			</tr>
		   	<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">出生日期:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><input type="text" id="birthday" format="Ymd" name="birthday"  style="width:140" onclick="LoushangDate(this)" readonly="readonly"/></td>
		  		<td class="FieldLabel" width="10%" nowrap="nowrap">年龄段:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><input type="text" id="ageStageS"   name="ageStageS"  style="width:40" title="请输入阿拉伯数字"  /> -----
				<input type="text" id="ageStageT"  name="ageStageT"  style="width:40" title="请输入阿拉伯数字" /></td>
		  		<td class="FieldLabel" width="10%" nowrap="nowrap">户籍性质:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><select id="domicileType" name="domicileType" style="width:140" > <option dataset="domicileDataset"></option> </select></td>
		   </tr>
		   <tr>
			    <td class="FieldLabel" width="10%" nowrap="nowrap">民族:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><select id="nation" name="nation" style="width:140" > <option dataset="DmMzDataSet"></option> </select></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">婚姻状况:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><select id="marriageCode" name="marriageCode" style="width:140" > <option dataset="DmHyzkDataSet"></option></select></td>
	            <td class="FieldLabel" width="10%" nowrap="nowrap">政治面貌:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><select id="politicalCode" name="politicalCode" style="width:140" > <option dataset="DmZzmmDataSet"></option></select></td>
			 </tr>
		 	<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">医疗状况:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><select id="safeguardType" name="safeguardType" style="width:140" > <option dataset="DmYlzkDataSet"></option></select></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">职业状况:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><select id="employmentCode" name="employmentCode" style="width:140" > <option dataset="DmZyDataSet"></option></select></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">救助类型:</td>
				<td class="FieldInput"  width="16%" nowrap="nowrap"><input type="text" id="jzlxDisplay" style="width:110" readOnly="true" ondblclick="displayDbClick('jzlxDisplay','jzlxquery')" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="mutiHelp('DmJzlxDataSet','jzlxDisplay','jzlxquery')"/>
								    <input type="hidden" id="jzlxquery" name="jzlxquery"></td>
		    </tr>
		 	<tr>
				<td class="FieldLabel" width="10%" nowrap="nowrap">登记时间:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><input type="text" id="regTimeS" format="Ymd" name="regTimeS"  style="width:70"  onclick="LoushangDate(this)" readonly="readonly"/> -----
				<input type="text" id="regTimeT" format="Ymd" name="regTimeT"  style="width:70"  onclick="LoushangDate(this)" readonly="readonly"/></td>
				 <td class="FieldLabel" width="10%" nowrap="nowrap">导出条数:</td>
				<td class="FieldInput" width="17%" nowrap="nowrap"><input type="text" id="impS"   name="impS"  style="width:70"  title="请输入阿拉伯数字,导出的条数小于1000" /> -----
				<input type="text" id="impT"  name="impT"  style="width:70" title="请输入阿拉伯数字,导出的条数小于1000" /></td>
				
				<td colspan="2" align="center"  nowrap="nowrap">
			   	<button onclick="query()">查 询</button>&nbsp;&nbsp;
			    <button onclick="reset()">重 置</button></td>
			</tr>
		  </table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="ygjzjtxxGrid" width="99%" deferRowRender="false" columnLines="true" bodyBorder="true" notSelectFirstRow="true" height="300" dataset="ds" title="阳光救助家庭信息">

    <next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="add" handler="forExcel1" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" hidden="true" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
				<next:Column id="PEOPLE_ID" header="人员ID" field="PEOPLE_ID" hidden="true" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="NAME" header="姓名" field="NAME"  width="6%" align="center"/>
		<next:Column id="ID_CARD" header="身份证号" field="ID_CARD"  width="12%"  align="center"/>
		<next:Column id="FAMILY_NAME" header="户主姓名" field="FAMILY_NAME" width="6%"  align="center"/>
		<next:Column id="JTCY" header="家庭成员" field="JTCY"  width="10%"   align="left"/>
		<next:Column id="RELATIONSHIP_TYPE" header="与户主关系" width="8%"  field="RELATIONSHIP_TYPE" dataset="DmHzgxDataSet" align="center"/>
		<next:Column id="SEX" header="性别" field="SEX"    dataset="DmXbDataSet" width="5%"  align="center"/>
		<next:Column id="BIRTHDAY" header="出生日期" field="BIRTHDAY"   width="7%"  align="center"/>
		<next:Column id="DOMICILE_TYPE" header="户籍性质" field="DOMICILE_TYPE" width="7%" align="center"  dataset="domicileDataset" />
		<next:Column id="NATION"  header="民族" align="center" width="220" field="NATION" width="5%" dataset="DmMzDataSet"  />
	    <next:Column id="MARRIAGE_CODE" header="婚姻状况" field="MARRIAGE_CODE" width="7%" align="center" dataset="DmHyzkDataSet"  />
	   <next:Column id="SAFEGUARD_TYPE" header="医疗状况" field="SAFEGUARD_TYPE" width="7%" align="center"  dataset="DmYlzkDataSet"  />
		<next:Column id="EMPLOYMENT_CODE" header="职业状况" field="EMPLOYMENT_CODE" width="7%" align="center"  dataset="DmZyDataSet"    />
		<next:Column id="ASSISTANCE_TYPE" header="救助类型" field="ASSISTANCE_TYPE" width="7%" align="center"  renderer="szlxRef"/>
	    <next:Column id="POLITICAL_CODE" header="政治面貌" field="POLITICAL_CODE" width="7%" align="center"  dataset="DmZzmmDataSet"/>
	    <next:Column id="REG_TIME" header="登记时间" field="REG_TIME" width="12%" align="center" />
	    <next:Column id="REG_ORG_NAME" header="登记单位" field="REG_ORG_NAME"  width="8%"  align="center"  />
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
 <next:Panel autoWidth="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="jtcyNumDs">
							<table border="0" width="70%">
								<tr>
									<td class="FieldLabel" width="20%">家庭户数:</td>
									<td class="FieldInput" width="25%"><label id="hsnum" name="hsnum" field="HSNUM" /></td>
									<td class="FieldLabel" width="20%">家庭成员人数:</td>
									<td class="FieldInput" width="25%" ><label  id="rsnum" name="rsnum" field="RSNUM" /></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
 </next:Panel>
<next:Window id="socialWin" closeAction="hide" title="导出条数设置" height="230" width="580">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="save" handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="undo" handler="Evt_butreturn_onclick"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" >
			<table>
				<tr>
					<td class="FieldLabel" width="10%">导出条数从：</td>
					<td class="FieldInput" width="20%"><input  type="text" id="importNumS"  name="importNumS"/>-----<input  type="text" id="importNumT"  name="importNumT"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
