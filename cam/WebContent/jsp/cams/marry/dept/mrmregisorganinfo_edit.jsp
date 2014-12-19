<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.net.URLEncoder" %>
<html>
	<head>
		<title>登记机关信息表</title>
		<next:ScriptManager/>
		<script>
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var organName = '<%=BspUtil.getOrganName()%>';
			
			var idField='<%=request.getParameter("organId")%>';
			var regionName='<%=request.getParameter("regionName")%>';
			regionName=decodeURIComponent(regionName);
			var regionCode='<%=request.getParameter("regionCode")%>';
			var method='<%=request.getParameter("method")%>';
			var name = '<%=request.getParameter("name")%>';

			var dept_code = '<%=request.getParameter("dept_code")%>';
			//alert(idField+"--"+regionName+"---"+regionCode+"--"+method);
			var deptId="";
		</script>
		<%
			String name = null;
			if(request.getParameter("name") != null && !"".equals(request.getParameter("name"))){
				name = URLEncoder.encode(request.getParameter("name"), "UTF-8");
			}
			
		%>
		<script type="text/javascript" src="mrmregisorganinfo_edit.js"></script>
	</head>
<body>
<model:datasets>
 	 <model:dataset id="bztypesDs" enumName="MRM.FORMATION.NATURE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="sslevelDs" enumName="MRM.LEVEL.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="monitorDs" enumName="MRM.MONITOR.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <!--	资源	-->
	<model:dataset id="resourceNameDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HY_RESOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--	区域		-->
	<model:dataset id="areaNameDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HY_AREA'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	 <model:dataset id="validDs" enumName="MRM.VALIDFLAG" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="wsyydjDs" enumName="MRM.WSYYDJ.TYPE" autoLoad="true" pageSize="-1"></model:dataset>
	 <model:dataset id="foreignDataSet" enumName="MRM.ORGAN.FOREIGN" global="true" autoLoad="true"/>
	 	<!-- 等级 -->
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true"></model:dataset>
	 
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo">
			  <model:field name="deptNumRy" type="string" rule="number|length{8}"/>
			  <model:field name="deptNumRdbz" type="string" rule="number|length{8}"/>
			  <model:field name="deptNumSj" type="string" rule="number|length{8}"/>
		</model:record>
	</model:dataset>
	
	 <model:dataset id="resourceDs" cmd="com.inspur.cams.marry.base.cmd.MrmResourcesInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmResourcesInfo"></model:record>
	</model:dataset>
	
    <model:dataset id="areaDs" cmd="com.inspur.cams.marry.base.cmd.MrmRegisAreaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisArea"></model:record>
	</model:dataset>
	
</model:datasets>
<next:Panel>

<next:TabPanel id="allPanel">
	<next:Tabs>
<next:Panel  title="登记机关信息" id="baseTabPanel">
		<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="returnBack"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form">
		<table width="100%">
		
	   		<tr>
				<td  class="FieldLabel" nowrap="nowrap" >登记机关代码</td>
				<td class="FieldInput"><input id="deptCode" type="text" name="登记机关代码" field="deptCode" onclick="func_Ingoing()" onblur="showOrhide(this.value)"/> <font color="red">*</font> </td>
				<td  class="FieldLabel" >名称</td>
				<td class="FieldInput"  colspan="1"><input id="name" type="text" name="名称" field="name"  style="width: 300px"/>  <font color="red">*</font></td>
				<td  class="FieldLabel" >简称</td>
				<td class="FieldInput"  colspan="1"><input id="sname" type="text" name="简称" field="shortName"  style="width: 300px" disabled/>  <font color="red">*</font></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >地址</td>
				<td class="FieldInput" colspan="5"><input type="text" name="地址" field="deptAddress"  style="width: 670px"/>  <font color="red">*</font></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >邮编</td>
				<td class="FieldInput"><input type="text" name="邮编" field="deptPost"  />  <font color="red">*</font></td>
				<td  class="FieldLabel" >服务电话</td>
				<td class="FieldInput"><input type="text" name="服务电话" field="deptTel" /> <font color="red">*</font> </td>
				<td  class="FieldLabel" >传真电话</td>
				<td class="FieldInput"><input type="text" name="传真电话" field="deptFax" /> </td>
			</tr>
			<tr>	
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><input type="text" name="负责人" field="modifyId"  /> <font color="red">*</font></td>
				<td  class="FieldLabel" >手机</td>
				<td class="FieldInput"><input type="text" name="手机" field="complainTel"  /> <font color="red">*</font></td>
				<td  class="FieldLabel" >电子邮箱</td>
				<td class="FieldInput"><input type="text" name="电子邮箱" field="officeEmail"  /> <font color="red">*</font> </td>
			</tr>
			<tr>	
				<td  class="FieldLabel" >编制性质</td>
				<td class="FieldInput">
				 	<select  name="编制性质" field="types" >
						<option dataset="bztypesDs"></option>
					</select>
				  <font color="red">*</font> </td>
				   <td  class="FieldLabel" >上年度工作经费</td>
				<td class="FieldInput"><input type="text" name="上年度工作经费" field="lastYearBudget"   /> 万元 <font color="red">*</font></td>
				   <td  class="FieldLabel" >本年度工作经费</td>
				<td class="FieldInput"><input type="text" name="本年度工作经费" field="thisYearBudget"  /> 万元 <font color="red">*</font></td>
				  </tr>
				  <tr>
				<td  class="FieldLabel" >级别</td>
				<td class="FieldInput">
					<select  name="级别" field="sslevel" >
						<option dataset="sslevelDs"></option>
					</select>
				 <font color="red">*</font></td>
				<td  class="FieldLabel" >成立日期</td>
				<td class="FieldInput">
				 <input type="text" id="creatDate" name="creatDate" readonly="readonly" field="creatDate" title="成立日期" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				 </td>
				<td class="FieldLabel">涉外标志</td>
				<td class="FieldInput">					
					<select id="foreign" name="涉外标志" field="foreign">
						<option dataset="foreignDataSet"></option>
					</select>
				</td>
			</tr>
			
				<tr>
			    <td  class="FieldLabel" >辖区人口(人)</td>
				<td class="FieldInput"><input type="text" name="辖区人口" field="deptNumRy"  /> <font color="red">*</font></td>
				
				<td  class="FieldLabel" >编委核定编制人数</td>
				<td class="FieldInput"><input type="text" name="编委核定编制人数" field="deptNumRdbz"  /> 人 <font color="red">*</font></td>
				
				<td  class="FieldLabel" >实有人数</td>
				<td class="FieldInput"><input type="text" name="实有人数" field="deptNumSj"  /> 人 <font color="red">*</font></td>
			
			</tr>
			
			<tr>
				<td  class="FieldLabel" >机构状态</td>
				<td class="FieldInput">
					<select id="validFlag" name="机构状态" field="validFlag" >
						<option dataset="validDs"></option>
					</select> <font color="red">*</font>
				 </td>
				<td  class="FieldLabel" >所属行政区</td>
				<td class="FieldInput">
				<label id="regionName" field="regionName" ></label> 
				<input type="hidden" name="regionCode" id="regionCode" field="regionCode"/> </td>
				
				<td  class="FieldLabel" >所属民政部门</td>
				<td class="FieldInput"><label id="deptOrgan" field="deptOrgan" ></label></td>
			</tr>
			<tbody id="showInfo">
			<tr>
			    <td  class="FieldLabel" >分管局长姓名</td>
				<td class="FieldInput"><input type="text" name="分管局长姓名" field="jzname"  /> <font color="red">*</font></td>
				
				<td  class="FieldLabel" >分管局长电话</td>
				<td class="FieldInput"><input type="text" name="分管局长电话" field="jzdh"  /> <font color="red">*</font></td>
				
				<td  class="FieldLabel" >分管局长手机</td>
				<td class="FieldInput"><input type="text" name="分管局长手机" field="jzsj"  /> <font color="red">*</font></td>
			
			</tr>
			<tr>
				
	            <td  class="FieldLabel" >在线登记时间</td>
				<td class="FieldInput">
				 <input type="text" id="zxDate" name="zxDate" readonly="readonly" field="zxDate" title="在线登记时间" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				 </td>
				<td  class="FieldLabel" >联网时间</td>
				<td class="FieldInput" >
				<input type="text" id="lwDate" name="lwDate" readonly="readonly" field="lwDate" title="联网时间" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				</td>
				<td  class="FieldLabel" >网上预约登记</td>
				<td class="FieldInput" >
					<select name="wsyytype" field="wsyytype" >
						<option dataset="wsyydjDs"></option>
					</select>
				</td>
			</tr>
			<tr>
			    <td  class="FieldLabel" >网络预约系统启用时间</td>
				<td class="FieldInput">
				<input type="text" id="begintime" name="begintime"  readonly="readonly" field="begintime" title="成立日期" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				</td>
				
				<td  class="FieldLabel" >网络预约量</td>
				<td class="FieldInput"><input type="text" name="网络预约量" field="wlyul"  /></td>
				
				<td  class="FieldLabel" >上年度预约量</td>
				<td class="FieldInput"><input type="text" name="上年度预约量" field="sjyyl"  /></td>
			
			</tr>
			<tr>
				<td  class="FieldLabel" >登记机关等级</td>
				<td class="FieldInput" >
					<select name="skinValue" field="skinValue" >
						<option dataset="EvaluLevelDataset"></option>
					</select>
				</td>
	            <td  class="FieldLabel" >登记机关被撤销时间</td>
				<td class="FieldInput">
				 <input type="text" id="abolishDate"  readonly="readonly" name="abolishDate" field="abolishDate" title="成立日期" format="Y-m-d"  /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
				 </td>
				<td  class="FieldLabel" >撤消后业务归属</td>
				<td class="FieldInput" ><input type="text" name="abolishYwgs" field="abolishYwgs"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >撤销原因</td>
				<td class="FieldInput" colspan="5">
				<input type="text" name="abolishReason" field="abolishReason" style="width: 671px"/> 
			</tr>
	   		<tr>
				<td  class="FieldLabel" >部门外网网址</td>
				<td class="FieldInput" colspan="5"><input type="text" name="homeUrl" field="homeUrl"  style="width: 670px"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注</td>
				<td class="FieldInput" colspan="5"><textarea rows="4" cols="130" name="remark" field="remark" ></textarea> </td>
			</tr>
			</tbody>
			<tr id="people_dhInfo" style="display:none">
				<td  class="FieldLabel" nowrap="nowrap">工作人员及联系电话</td>
				<td class="FieldInput" colspan="5"><input type="text" name="peopleDh" field="peopleDh"  style="width:300px;"/></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:GridPanel id="areaGridPanel" name="mrmregisareaGrid" stripeRows="true" height="100%" dataset="areaDs" title="登记机关场所"
 enableHdMenu="true" enableColumnHide="true"   hasSum="true">
	<next:Columns>
	    <next:RowNumberColumn width="50"/>
	    
		<next:Column header="机关场所" field="functionName" width="120" sortable="true" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRender
			</next:ExtendConfig>
			<next:ComboBox dataset="areaNameDs"></next:ComboBox>
		</next:Column>
		
		<next:Column header="面积(平方米)" field="functionArea" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : arRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="窗口(个)" field="windowNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : wiRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="座椅(个)" field="chairNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : chRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="计算机(台)" field="computerNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : coRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="打印机(台)" field="printerNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : prRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="读卡器(个)" field="cardreaderNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : caRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="areaDs"/>
	</next:BottomBar>
</next:GridPanel>

<next:GridPanel id="resourceGridPanel" name="mrmresourcesinfoGrid" stripeRows="true" height="100%" dataset="resourceDs" title="资源信息表" >
 
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	
		<next:Column id="resourceName" header="资源名称" field="resourceName" width="200" >			
			<next:ComboBox dataset="resourceNameDs"></next:ComboBox>
		</next:Column>
	
		<next:Column id="resourceNum" header="数量" field="resourceNum" width="150" align="right">			
			<next:NumberField allowBlank="false" />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="resourceDs"/>
	</next:BottomBar>
</next:GridPanel>

<next:Panel  title="机关场所信息" id="areaPanel"  height="100%" >
	<next:Html>
		<iframe  src="area/mrmregisarea_list.jsp"
			 frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	    </iframe>
	</next:Html>
</next:Panel>
<next:Panel  title="资源信息" id="resourcePanel"  height="100%" >
	<next:Html>
		<iframe  src="resource/mrmresourcesinfo_list.jsp"
			 frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	    </iframe>
	</next:Html>
</next:Panel>
<next:Panel  title="管理制度" id="regulation"  height="100%" >
	<next:Html>
		<iframe  src="regulation/mrmRegisOrganInfoShow.jsp?deptCode=<%=request.getParameter("dept_code")%>"
			 frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	    </iframe>
	</next:Html>
</next:Panel>	
<next:Panel  title="机关图片" id="photoPanel"  height="100%" >
	<next:Html>
		<iframe  src="photoInfo/mrmPhotoInfoShow.jsp?deptCode=<%=request.getParameter("dept_code")%>&deptName=<%=name%>"
			 frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	    </iframe>
	</next:Html>
</next:Panel>	
</next:Tabs>
</next:TabPanel>
</next:Panel>

</body>
</html>
