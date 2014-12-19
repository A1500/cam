<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>特殊困难户列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="specialpoorFamilyList.js"></script>
<script type="text/javascript">
    <%
	    String organArea = BspUtil.getCorpOrgan().getOrganCode();
    	String queryCode = "";
    	if(organArea.endsWith("0000000000")){//省370000000000
    		queryCode = organArea.substring(0,2);
 		} else if (organArea.endsWith("00000000")){//市370100000000
 			queryCode = organArea.substring(0,4);
 		} else if (organArea.endsWith("000000")){//县370104000000
 			queryCode = organArea.substring(0,6);
 		} else if (organArea.endsWith("000")){//乡370104003000
 			queryCode = organArea.substring(0,9);
 		}else{
 			queryCode = organArea;
 		}
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
    var queryCode='<%=queryCode%>';
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>

<model:datasets>

	<!-- 家庭信息 -->
	<model:dataset id="speFamilyDataset" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorFamilyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorFamily">
		</model:record>
	</model:dataset>
	
	<model:dataset id="SpecialpoorSupportRefDataset" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportRef">
		</model:record>
	</model:dataset>
	
	<model:dataset id="povertyCauseType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SPECIAL_POVERTY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="supportName" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SUPPORT_UNIT_TYPE_CODE" pageSize="300">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='specialpoor_support_unit'></model:param>
			<model:param name="value" value='SUPPORT_UNIT_CODE'></model:param>
			<model:param name="text" value='SUPPORT_UNIT_NAME'></model:param>
			<model:param name="sort" value='SUPPORT_UNIT_TYPE_CODE'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="assitanceDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_assitance_type'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
			<next:Panel width="100%" height="100%">
				<next:Panel title="查询条件" width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html>			
							<form class="L5form">
								<table  border="1" width="100%">
									<tr>
									 	<td class="FieldLabel" style="width:10%">地区</td>
						                <td class="FieldInput" style="width:20%">
						                 <input type="text" id="lrdwmcquery" readonly name="lrdwmc" id="lrdwmc" value="<%=organName%>" style='width:80%'/>
									  <input type="text" style="display: none;"  name="lrdwId" id="lrdwId" value="<%=organArea%>"/>
									  <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						               </td>
						                
						                <td class="FieldButton" style="width:10%"><button style="width:100" id="queryId" onclick="query();">查询</button></td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width:10%">户主姓名</td>
						                <td class="FieldInput" style="width:10%"><input type="text"  id="familyName" style='width:80%'/></td>
						                 <td class="FieldButton" style="width:10%"> </td>
									</tr>
									<tr>
									 	<td class="FieldLabel" style="width:10%">省直单位名称</td>
						                <td class="FieldInput" style="width:10%">
						               <select  id="supportNameID" style='width:80%'><option  dataset="supportName"></option></select>
						                </td>
						                 <td class="FieldButton" style="width:10%"><button type="reset" style="width:100">重置</button></td>
									</tr>
									
								</table>
							</form>
					</next:Html>
				</next:Panel>
				 <next:GridPanel  clickToSelectedForChkSM="true"id="daiBanGridPanel" title="特殊困难户列表" dataset="speFamilyDataset" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add"  text="新增" handler="insert"/>
						<next:ToolBarItem iconCls="detail"  text="修改" handler="update"/>
						<next:ToolBarItem iconCls="remove"  text="删除" handler="deleteFamily"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column  header="地区" field="domicileFullName"  width="200"  ></next:Column>							
				        <next:Column header="户主姓名" field="familyName" width="100" align="center" ></next:Column>
			        	<next:Column header="身份证号码" field="familyCardNo" width="150"align="center" ></next:Column>
						<next:Column header="帮包村名称" field="helpVillageName"   width="220" ></next:Column>
						<next:Column header="是否低保或五保" field="assistanceFlag" align="center" dataset="comm_yesorno"  width="100" ></next:Column>
						<next:Column header="救助类型" field="assistanceType"align="center" dataset="assitanceDataset"  width="100" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="speFamilyDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
</body>

</html>