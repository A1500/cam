<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
		<title>老烈子女信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="cbptMartyroffList.js"></script>
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
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringQueryCommand" pageSize="20"
	  method="queryMartyrOffspring" global="true">
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
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel" nowrap>身份类别:</td>
								<td class="FieldInput">
								    <select name="statusType" field="statusType" title="身份类别">
					                        <option dataset="StatusTypeEnum"></option>
				                    </select>
								</td>	
								<td class="FieldLabel" nowrap>牺牲时间:</td>
								<td class="FieldInput">
								    <input type="text" id="sacrificeDate" style= "width:100px;"  format="Y-m-d"  title="牺牲时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)">
								   
								</td>	
								<td class="FieldLabel" nowrap>批准平反时间：</td>
							    <td class="FieldInput"><input type="text" id="lezswApproveDate" style= "width:100px;"  format="Y-m-d"  title="批准烈士（平反）时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)"></td>
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

<next:GridPanel id="editGridPanel" name="bptmartyGrid" width="100%" stripeRows="true" height="99%"  autoScroll="true" dataset="BaseinfoPeopleDataSet" title="部分烈士(错杀被平反)子女信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<%-- <next:ToolBarItem text="Excel导入" iconCls="detail" handler="ett"/> --%>
	</next:TopBar>
	<next:Columns>
	    
	    <next:Column id="familyId" header="familyId" field="FAMILY_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="peopleId" header="peopleId" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:RowNumberColumn header="序号" width="45"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="fullName" header="属地行政区划" field="FULL_NAME" width="180">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sex" header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="nation" header="民族" field="NATION" width="60"  dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="statusType" header="身份类别" field="STATUS_TYPE" width="180" align="center" dataset="StatusTypeEnum">
			<next:TextField/>
		</next:Column>
		<next:Column id="sacrificeDate" header="牺牲时间" field="SACRIFICE_DATE" width="120" align="center">
			<next:TextField/>
		</next:Column>
		<next:Column id="lezswAppr" header="批准烈士（平反）时间" field="LEZSW_APPROVE_DATE" width="160" align="right">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
