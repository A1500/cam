
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
		<title>保障标准列表</title>
		<next:ScriptManager/>
		<script type="text/javascript">
          var struId='<%=BspUtil.getStruId()%>';
          var organCode='<%=BspUtil.getOrganCode()%>';
          var organName='<%=BspUtil.getOrganName()%>';
		  var nowTime= '<%=DateUtil.getMonth()%>';

        </script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
        <script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js") %>" ></script>
		<script type="text/javascript" src="lowStandardsList.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.esurey.cmd.SamLowStandardsQueryCmd" global="true" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamLowStandards"></model:record>
		<model:params>
		    <model:param name="DOMICILE_CODE" value="<%=BspUtil.getOrganCode()%>" />
		</model:params>
	</model:dataset>
	<model:dataset id="editDs" cmd="com.inspur.cams.drel.esurey.cmd.SamLowStandardsQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamLowStandards">
			<model:field name="assitanceType" type="string" rule="require" />
			<model:field name="validBeginDate" type="string" rule="require" />
			<model:field name="lowStandards" type="string" rule="require|regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
		</model:record>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.drel.esurey.cmd.SamLowStandardsQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamLowStandards"></model:record>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<!-- 救助对象类别 -->
	<model:dataset id="assitanceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value="01,02,03"></model:param>
		</model:params>
	</model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0"  autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >								
								<td class="FieldLabel">救助对象类别</td>
								<td class="FieldInput">
								<select id="assitanceTypeQuery" name="救助对象类别"><option dataset="assitanceTypeDataset"></option></select>
								</td>	
								<td class="FieldLabel">起始年月</td>
								<td class="FieldInput">
								<input type="text"  id="validYear" class="TextEditor" format="Y-m" onclick="LoushangDate(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
								</td>	
								<td class="FieldLabel">使用状态</td>
								<td class="FieldInput">
								<select id="inUseQuery"><option value="">请选择……</option><option value="1">启用</option><option value="0">停用</option></select>
								</td>
							    <td class="FieldButton">
								    <button onclick="query()">查 询</button>
								    &nbsp;&nbsp;
								    <button type="reset">重 置</button>
							    </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="samlowstandardsGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="保障标准列表" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="停用" iconCls="remove" handler="unUse"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     <next:Column header="内码" field="standardsId" width="9" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="救助对象属地" field="apanageName" width="180" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column header="救助对象类别" field="assitanceType" dataset="assitanceTypeDataset" width="100" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column header="供养方式" field="supportWay" width="100" align="center" dataset="supportWayDataset"><next:NumberField  /></next:Column>
	    <next:Column header="保障标准" field="lowStandards" width="100" align="right" renderer="formatTime">
			<next:NumberField  />
		</next:Column>
		<next:Column header="起始年月" field="validBeginDate" width="100" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="终止年月" field="validEndDate" width="100" align="center" renderer="formateValidEndDate">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="使用状态" field="inUse" renderer='getInUse' width="100" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 添加 -->
<next:Window id="addWin" closeAction="hide" title="保障标准编辑" width="740">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="editDs">
			<input type='hidden' field='standardsId' />
			<table border="1"  width="100%" >		
	   		<tr>
				<td class="FieldLabel" style='width:20%'>救助对象属地</td>
				<td class="FieldInput" style='width:30%'>
				<input type="text"  field="apanageName"  readonly="readonly" style='width:80%' disabled/>
				<input type="hidden" id="domicileCode" field="domicileCode" />
				</td>	
				<td  class="FieldLabel" style='width:20%'>救助对象类别</td>
				<td class="FieldInput" style='width:30%'>
				<select id='assitanceType' field="assitanceType" name="救助对象类别" style='width:80%' onblur='loadSupportWay();checkLowStandards()'><option dataset="assitanceTypeDataset"></option></select>
				<font color="red">*</font> 
				</td>
				
			</tr>
			<tr>
	   		    <td class="FieldLabel">供养方式</td>
				<td class="FieldInput">
					<select id='supportWay' field='supportWay' name='供养方式' style="width:80%" onblur='checkLowStandards()'>
						<option dataset='supportWayDataset'></option>
					</select><font color="red">*</font>
				</td>
	   		    <td  class="FieldLabel" >起始年月</td>
				<td class="FieldInput">
				<input type="text" name="起始年月" field="validBeginDate" format="Y-m" onclick="LoushangDate(this)" readonly="readonly" style='width:80%'/><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >保障标准（元）</td>
				<td class="FieldInput">
					<input type="text" name="保障标准（元）" field="lowStandards"  maxlength="14" style='width:80%'/>
					<font color="red">*</font>
				</td>
	   		    <td class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>
	   		<tr>
	   		 <td  class="FieldLabel" colspan="4" style="color:red;text-align:left">
	   		   说明：城市低保标准单位为（元/月），农村低保、农村五保标准单位为（元/年）。
	   		 </td>
	   		</tr>
	   		
						
		</table>
		</form>
	</next:Html>
</next:Window>


</body>
</html>
