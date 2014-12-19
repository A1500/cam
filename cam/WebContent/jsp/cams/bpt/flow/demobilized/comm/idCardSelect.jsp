<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>在乡复员军人信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="idCardSelect.js"></script>
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
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" method="queryDemobilizedPeople" global="true">
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
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否抗美援朝 -->
	<model:dataset id="dsIskoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel">所属机关：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="所属机关" onclick="forHelp()" readonly="readonly"/>
								<input type="hidden"  id="domicileCode" class="TextEditor" title="所属机关"/></td>
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
		
							   
							    <td>
                             <button onclick="query()">查 询</button>
                              
                            </td>	
							</tr>
							<tr>
							 <td class="FieldLabel" nowrap="nowrap">户籍类别：</td>
							    <td class="FieldInput">
							        <select id="domicileType" name="domicileType" field="domicileType" title="户籍类别"> 
											<option dataset="DomicileDataset"></option>
									</select></td>	
							<td class="FieldLabel" nowrap="nowrap">属于时期:</td>
							<td class="FieldInput">
									<select id="belongDate" name="belongDate" field="belongDate" title="属于时期"> 
											<option dataset="warDs"></option>
									</select>
							</td>
							<td class="FieldLabel" nowrap="nowrap">是否抗美援朝:</td>
							<td class="FieldInput">
									<select id="isKoreanwar" name="isKoreanwar" field="isKoreanwar" title="是否抗美援朝"> 
											<option dataset="dsIskoeanwar"></option>
									</select></td>
							  <td >
                            <button onclick="reset()">重 置</button> 
                            </td>	
						 </tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="98%" dataset="BaseinfoPeopleDataSet" title="在乡复员军人信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="编号" width="50"/>
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
		
		<next:Column id="telMobile" header="属于时期" field="BELONGDATE" width="60" dataset="warDs">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="是否参加抗美援朝" field="IS_KOREANWAR" width="103" dataset="dsIskoeanwar">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="入伍时间" field="CONSCRIPT_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="退伍时间" field="DECRUITMENT_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="手机" field="TEL_MOBILE" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column id="NOTE" header="备注" field="NOTE" width="90">
						<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
