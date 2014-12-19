<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
		<title>60周岁以上农村籍退役士兵信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptcountretiredsoldierList.js"></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
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
			  var struId = '<%=BspUtil.getStruId()%>';
              var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
	</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" pageSize="20" method="queryCountretiredSoldier" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
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
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
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
						   <tr>
				                <td class="FieldLabel" nowrap>属地行政区划：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" readonly="readonly"/>
								<input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"/></td>
				                <td class="FieldLabel" nowrap>姓名：</td>
				                <td class="FieldInput"><input type="text" id="name" class="TextEditor" title="姓名" /></td>
				                <td class="FieldLabel" nowrap>身份证件号码：</td>
				                <td class="FieldInput"><input type="text" id="idCard" class="TextEditor" title="身份证件号码" /></td>
				
				                <td class="FieldLabel" nowrap>户籍类别：</td>
				                <td class="FieldInput">
				                    <select name="domicileType" field="domicileType" title="户籍类别">
					                        <option dataset="DomicileDataset"></option>
				                    </select>
				                </td>
			               </tr>
						   <tr >
								<td class="FieldLabel" nowrap>是否享受低保待遇:</td>
								<td class="FieldInput">
								    <select name="isGuarant" field="isGuarant" title="是否享受低保待遇">
					                        <option dataset="dsGuarant"></option>
				                    </select>
								</td>	
								<td class="FieldLabel" nowrap>是否享受五保待遇:</td>
								<td class="FieldInput">
								    <select name="isFiveGuarant" field="isFiveGuarant" title="是否享受五保待遇">
					                        <option dataset="dsFiveGuarant"></option>
				                    </select>
								   
								</td>	
								<td class="FieldLabel" nowrap>优抚对象状态：</td>
							    <td class="FieldInput"><select name="soldierStateCode"  title="优抚对象状态">
					                        <option dataset="ObjectStateDataset"></option>
				                    </select></td>
								<td align="center" colspan="2">
								    <button id="queryButton" onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								    <button onclick="reset()">重 置</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptcountretiredsoldierGrid" width="100%" stripeRows="true" height="99%"  autoScroll="true" dataset="BaseinfoPeopleDataSet" title="农村籍退役士兵信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<%-- <next:ToolBarItem text="Excel导入" iconCls="detail" handler="ett"/> --%>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="50"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    
	    <next:Column id="familyId" header="familyId" field="FAMILY_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="peopleId" header="peopleId" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="属地行政区划" field="DOMICILE_NAME" width="220">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="sex" header="性别" field="SEX" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="domicileType" header="户籍类别" field="DOMICILE_TYPE" width="60" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
	    <next:Column id="familyNum" header="家庭人口" field="FAMILY_NUM" width="55" >
			<next:NumberField  />
		</next:Column>
	    <next:Column id="isGuarant" header="是否享受低保" field="IS_GUARANT" width="80" dataset="dsGuarant">
			<next:TextField  />
		</next:Column>
	    <next:Column id="isFiveGuarant" header="是否享受五保" field="IS_FIVE_GUARANT" width="80" dataset="dsFiveGuarant">
			<next:TextField  />
		</next:Column>
		<next:Column id="RETIRED_STATE_CODE" header="优抚对象状态" field="RETIRED_STATE_CODE" width="90" dataset="ObjectStateDataset">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
