<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>行政区划新增编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
	String reqTime=DateUtil.getDay();
	String organCode=BspUtil.getCorpOrgan().getOrganCode();
	String organName=BspUtil.getCorpOrgan().getOrganName();
	String userName=GetBspInfo.getBspInfo().getUserName();
	String changeId = request.getParameter("changeId");
	String areaCode=BspUtil.getCorpOrgan().getOrganCode();
	if(areaCode.endsWith("0000000000")){//省370000000000
		areaCode= areaCode.substring(0,2);
	} else if (areaCode.endsWith("00000000")){//市370100000000
		areaCode=  areaCode.substring(0,4);
	} else if (areaCode.endsWith("000000")){//县370104000000
		areaCode=  areaCode.substring(0,6);
	} else if (areaCode.endsWith("000")){//乡370104003000
		areaCode=  areaCode.substring(0,9);
	}
	if(changeId==null){
		changeId = IdHelp.getUUID32();
	}
	%>
</script>
<script type="text/javascript">
	var organCode='<%=organCode%>';
	var userName='<%=userName%>';
	var organName='<%=organName%>';
	var method='<%=request.getParameter("method")%>';
	var changeId='<%=changeId%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var reqTime='<%=reqTime%>';
	var areaCode='<%=areaCode%>';
	var radioType = "radiobox";// 按钮类型（默认为单选按钮）
</script>
<script type="text/javascript" src="dicCityInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCityInsertDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChange">
			<model:field name="codeLeve" type="string" rule="require" />
			<model:field name="preChangeName" type="string" rule="require" />
			<model:field name="preChangeCode" type="string" rule="require" />
			<model:field name="serialNum" type="string" rule="require" />
			<model:field name="remark" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 变更类型 -->
	<model:dataset id="changeTypeDataset" enumName="COMM.CHANGE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 (区县)-->
	<model:dataset id="codeLeveDatasetQU" enumName="COMM.CODE.LEVE.QU" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 (市)-->
	<model:dataset id="codeLeveDatasetCity" enumName="COMM.CODE.LEVE.CITY" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 (街道)-->
	<model:dataset id="codeLeveDatasetXIANG" enumName="COMM.CODE.LEVE.XIANG" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 -->
	<model:dataset id="codeLeveDataset" enumName="COMM.CODE.ADD" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 -->
	<model:dataset id="codeAddDataset" enumName="COMM.CODE.LEVE.CITY" autoLoad="true" global="true"></model:dataset>
	<!-- 区划代码 -->
	<model:dataset id="dicCityExportDataSet" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
		<next:Panel title="当前区划代码列表" collapsible="true" autoScroll="true" width="20%" anchor="100% 100%">
			<next:Html>
				<next:Tree name="dicCitytree" id="dicCitytree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
				<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
						<next:treeRecord name="dicCityRecord" idField="id">
		   					<model:field name="id" type="string"/>	
		   					<model:field name="name" type="string"/>	
		   					<model:field name="leve" type="string"/>	
		   					<model:field name="ups" type="string"/>
		   					<model:field name="fullName" type="string"/>		
		   					<model:field name="flag" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="UPS@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicCityRecord">
					<next:TreeNodeAttribute name="text"  handler="getUserInfo"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicCitydisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:RightmouseMenu menuId="cityMenu">
						<next:MenuItem text="导出成Excel" handler="exportExcel"></next:MenuItem>
					</next:RightmouseMenu>
				</next:TreeNodemodel>
			</next:Tree>
			</next:Html>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true">
		<next:Panel width="98%" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"/>
			<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
			<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
		</next:TopBar>
		<next:Html>
		<form id="form1" method="post" dataset="dicCityInsertDataSet" onsubmit="return false" class="L5form">
		<fieldset>
			<%if(organCode.endsWith("00000000")){ %>
				<legend>县及以上行政区划新增</legend>	
			<%}else{ %>
				<legend>县以下行政区划新增</legend>
			<%} %>
			<table width="100%">
				<tr >
					<td class="FieldLabel" style="width:18%">上级区划代码：</td>
					<td class="FieldInput" style="width:36%"><input type="text" name="变更前上级区划代码" id="preUpsCode" field="preUpsCode"  maxlength="12" style="width:90%"/>
						<img id="img" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:18%">上级区划名称：</td>
					<td class="FieldInput" style="width:36%"><input type="text"  name="上级区划名称" id="preUpsName" field="preUpsName" maxlength="100" style="width:90%"/></td>
				</tr>
				<tr id="dmjb1">
					<td class="FieldLabel" style="width:18%">类别：</td>
					<td class="FieldInput" style="width:36%">
					<select id="codeLeve1" field="codeLeve" name="类别" style="width:90%">
		                 <option dataset="codeLeveDatasetXIANG"></option>
		            </select><font color="red">*</font></td>
				</tr>
				<tr id="dmjb2">
					<td class="FieldLabel" style="width:18%">类别：</td>
					<td class="FieldInput" style="width:36%">
					<select id="codeLeve2" field="codeLeve" name="类别" style="width:90%">
		                 <option dataset="codeLeveDatasetQU"></option>
		            </select><font color="red">*</font></td>
				</tr>
				<tr id="dmjb3">
					<td class="FieldLabel" style="width:18%">类别：</td>
					<td class="FieldInput" style="width:36%">
					<select id="codeLeve3" field="codeLeve" name="类别" style="width:90%">
		                 <option dataset="codeLeveDatasetCity"></option>
		            </select><font color="red">*</font></td>
				</tr>
				<tr >
					<td class="FieldLabel" style="width:18%">区划名称：</td>
					<td class="FieldInput" style="width:36%"><input type="text" name="变更前区划名称" id="preChangeName" field="preChangeName" maxlength="50" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:18%">区划代码：</td>
					<td class="FieldInput" style="width:36%"><input type="text"  name="变更前区划代码" id="preChangeCode" field="preChangeCode" maxlength="12" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:18%">序号：</td>
					<td class="FieldInput" style="width:36%"><input type="text" onblur="_isNum(this.value)" name="序号" id="serialNum" field="serialNum" maxlength="4" /><font color="red">序号为1~9999(序号大小决定调整执行的先后顺序!!!)</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:18%">变更说明：</td>
					<td class="FieldInput" style="width:36%"><textarea onpropertychange="if(value.length>100) value=value.substr(0,100)" name="变更说明" id="remark" field="remark"  style="width:90%"></textarea></td>
				</tr>
				<%if(organCode.endsWith("00000000")){ %>
					<tr>
						<td class="FieldInput" colspan="6"><label style="height:200px"><font size="3" >县及以上行政区划代码编码规则<br>
						县及县以上行政区划数字代码（简称数字码）共有12位数字，其中后六位均为0，前六位采用三层次码结构(<font color="red">XX</font>-<font color="green">XX</font>-<font color="blue">XX</font>)，按层次分别表示我国各省（自治区、直辖市、特别行政区）、市（地区、自治州、盟）、县（自治县、县级市、旗、自治旗、市辖区、林区、特区）。<br>
						<font color="red">1.第一层即前两位代码表示省。</font><br>
						<font color="green">2.第二层即中间两位代码表示市。</font><br>
						<font color="blue">3.第三层即后两位表示县、市辖区，其中01~20表示市辖区，21~80表示县，81~89表示县级市，90~99表示开发区。(凡是未经批准，不是国家标准的行政区划单列区县级单位，代码的第三层即后两位必须设置为以91开始按顺序往下编制。)</font>
						</font></label>
						</td>
					</tr>
				<%}else{ %>
					<tr>
						<td class="FieldInput" colspan="6"><label style="height:200px"><font size="3"  >县以下行政区划代码编码规则:<br>
						县以下行政区划代码共有12位数字，分为三段(<font color="red">XXXXXX</font>-<font color="green">XXX</font>-<font color="blue">XXX</font>)。代码的第一段为6位数字，表示县及县以上的行政区划；第二段为3位数字，表示街道、镇和乡；第三段为3位数字，表示社区和村庄<br>
						<font color="red">1.第一段的6位代码统一标准不能修改</font><br>
						<font color="green">2.第二段的3位代码,其中的第一位数字为类别标识，以“0”表示街道，“1”表示镇，“2和3”表示乡，“4和5”表示政企合一的单位，“6”表示开发区等非法定单位，“999”表示本级代码；其中的第二、三位数字为该代码段中各行政区划的顺序号</font><br>
						<font color="blue">3.第三段的3位代码为社区和村的代码，其中的第一位数字为类别标识，以“0和1”表示社区，“2和3”表示村，“4和5”表示非法定的村，“8”表示本级所属单位，“999”表示乡镇本级单位，其中的第二、三位数字为该代码段中各行政区划的顺序号</font></font></label></td>
					</tr>
				<%} %>
			</table>
		</fieldset>
		</form>
		</next:Html>
		</next:Panel>
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>