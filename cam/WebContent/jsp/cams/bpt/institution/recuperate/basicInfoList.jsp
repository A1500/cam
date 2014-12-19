<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var struId='<%=BspUtil.getStruId()%>';
	var idField='<%=request.getParameter("batchId")%>';
</script>
<html>
	<head>
		<title>优抚对象基本信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="basicInfoList.js"></script>
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
	<model:dataset id="dsBptObject" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryBPTObjectInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 伤残人员信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryDisabilityBptPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record> 
	</model:dataset>
	<!--三属人员信息 -->
		<model:dataset id="DependantDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDepePeo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 在乡人员信息 -->
	<model:dataset id="demobilizedDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" method="queryDemobilizedPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 带病回乡人员信息 -->
	<model:dataset id="dsDemobilizeInelld" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand" method="queryDemobilizedIllnessPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!--参战人员信息 -->
	<model:dataset id="dataSetWar" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand" method="queryPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 参试人员信息 -->
	<model:dataset id="dataSetTested" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand" method="queryPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 60周岁以上农村籍退役军人 -->
	<model:dataset id="countretiredSoldierDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" method="queryCountretiredSoldier" global="true">
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
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectType" enumName="BIGOBJECT.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否抗美援朝 -->
	<model:dataset id="dsIskoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="dsIsWar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="dsIsInnuclear" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!--参战类别代码-->
	<model:dataset id="warTypeCodeDataset" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel">优抚证书编号：</td>
								<td class="FieldInput">
								    <input type="text" id="bptNo" class="TextEditor">
									<input type="hidden"  id="ageBegin" class="TextEditor" title="最小年龄" style="width:60px"  />
									<input type="hidden"  id="ageEnd" class="TextEditor" title="最大年龄" style="width:60px"  />
								</td>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="objectState" name="objectState" field="objectState"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
								<!-- 	<select id="objectType" name="objectType"> 
											<option dataset="ObjectType"></option>
									</select> -->
									<input type="text"  id="objectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="objectType"  id="objectType" class="TextEditor"/>
								</td>
								<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>	
							</tr>
						</table>
					</form>
					<!-- 此隐藏域仅用于存放优抚对象的节点ID -->
					<input type="hidden" name="bptObjectType" id="bptObjectType" />
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<!-- 伤残查询条件 -->
<next:Panel name="disabilityform" id="disabilityform" hidden="true"
	width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
				<td class="FieldInput"><input type="text" id="disabilityDomicileName"
					class="TextEditor" title="属地行政区划" onclick="forHelp()" /> <input
					type="hidden" id="disabilityDomicileCode" class="TextEditor" title="属地行政区划" /></td>

				<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" /></td>

				<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="idCard"
					class="TextEditor" title="身份证件号码" /></td>

				<td class="FieldLabel">户籍类别：</td>
				<td class="FieldInput"><select id="domicileType">
					<option dataset="DomicileDataset"></option>
				</select></td>

			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
				<td class="FieldInput"><select id="disabilityStateCode" disabled="disabled">
					<option dataset="ObjectStateDataset" value="2" ></option>
				</select></td>
		<!-- 		<td class="FieldLabel" nowrap="nowrap">伤残类别：</td>
				<td class="FieldInput"><select id="disabilityTypeCode">
					<option dataset="DisabilityTypeCodeEnum"></option>
				</select></td> -->
				<td class="FieldLabel" nowrap="nowrap">伤残等级：</td>
				<td class="FieldInput">
					<input type="text" name="disabilityLevelCodeName" id="disabilityLevelCodeName"
					onclick="forDisability()" readonly="readonly"/>
					<input type="hidden" name="disabilityLevelCode" id="disabilityLevelCode" />
				</td>
				<td class="FieldLabel" nowrap="nowrap">伤残性质：</td>
				<td class="FieldInput"><select id="disabilityCaseCode">
					<option dataset="DisabilityCaseDataset"></option>
				</select></td>
			
				<td class="FieldLabel" nowrap="nowrap">伤残属别：</td>
				<td class="FieldInput"><select id="disabilityGenusCode">
					<option dataset="DisabilityGenusDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">伤残时期：</td>
				<td class="FieldInput"><select id="disabilityWarCode">
					<option dataset="BptWarDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">证书编号：</td>
				<td class="FieldInput"><input type="text" id="disabilityNo"
					class="TextEditor" title="证书编号" /></td>
				<!-- 		<td class="FieldLabel" nowrap="nowrap">备注：</td>
								<td class="FieldInput"><input type="text"  id="note" class="TextEditor" title="备注"/></td> -->

				<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td class="FieldInput"><input type="text" id="disabilityObjectTypeName"
					class="TextEditor" title="优抚对象类别" readonly="readonly"
					onclick="forHelpOT()" /> <input type="hidden" name="disabilityObjectType"
					id="disabilityObjectType" class="TextEditor" /></td>
				<td class="FieldInput" colspan="2" align="center">
				<button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<!-- 三属查询条件 -->
<next:Panel  name="dependantform"  hidden="true" id="dependantform" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
						<tr >
								<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
								<td class="FieldInput"><input type="text"  id="dependantDomicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
													   <input type="hidden"  id="dependantDomicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="dependantName" class="TextEditor" title="姓名"  /></td>	
								
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="dependantIdCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" nowrap="nowrap">户籍类别：</td>
								<td class="FieldInput">
									<select id="dependantDomicileType" title="户籍类别"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>	
						</tr>
							
						<tr>		
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="dependantDisabilityStateCode" title="优抚对象状态"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>
							 	<td class="FieldLabel" nowrap="nowrap">定期抚恤证编号：</td>
								<td class="FieldInput"><input type="text"  id="dependantNo" class="TextEditor" title="备注"/></td> 
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<input type="text"  id="dependantObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="dependantObjectType"  id="dependantObjectType" class="TextEditor"/>
								</td>
								<td colspan="2" align="center"><button onclick="query()">查 询</button>
								&nbsp;<button onclick="reset()">重 置</button></td>
						</tr>		

						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<!-- 在乡查询条件 -->
<next:Panel  name="demobilizeform" id="demobilizeform" hidden="true" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldInput"><input type="text"  id="demobilizeDomicileName" class="TextEditor" title="所属机关" onclick="forHelp()" readonly="readonly"/>
								<input type="hidden"  id="demobilizeDomicileCode" class="TextEditor" title="所属机关"/></td>
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="bilizedName" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="bilizedIdCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
							    <td class="FieldInput">
									<select id="bilizedObjectState" field="objectState"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
							    </td>
							    <td>
                             <button onclick="query()">查 询</button>
                              
                            </td>	
							</tr>
							<tr>
							 <td class="FieldLabel" nowrap="nowrap">户籍类别：</td>
							    <td class="FieldInput">
							        <select id="bilizedDomicileType" field="domicileType" title="户籍类别"> 
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
						<!-- 	<td class="FieldLabel" nowrap="nowrap">备注：</td>
							<td class="FieldInput"><input type="text"  id="note" class="TextEditor" title="备注" /></td> -->
							<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<input type="text"  id="bilizedObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="bilizedObjectType"  id="bilizedObjectType" class="TextEditor"/>
								</td>
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
<!-- 带病回乡查询条件 -->
<next:Panel  name="demobilizedIllnessform" id="demobilizedIllnessform" hidden="true" width="100%" autoScroll="true"  border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldInput"><input type="text"  id="illnessDomicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" readonly="readonly"/>
								<input type="hidden"  id="illnessDomicileCode" class="TextEditor" title="属地行政区划"  /></td>
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="illnessName" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="illnessIdCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="illnessObjectState" name="illnessObjectState" field="objectState" title="优抚对象状态"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>
								<td><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
							<td class="FieldLabel" nowrap="nowrap">户籍类别：</td>
							    <td class="FieldInput">
							        <select id="illnessDomicileType" name="illnessDomicileType" field="domicileType" title="户籍类别"> 
											<option dataset="DomicileDataset"></option>
									</select></td>	
							<td class="FieldLabel" nowrap="nowrap">是否参战：</td>
							<td class="FieldInput">
							        <select id="isWar" name="isWar" field="isWar" title="是否参战"> 
											<option dataset="dsIsWar"></option>
									</select></td>
							<td class="FieldLabel" nowrap="nowrap">是否参试：</td>
							<td class="FieldInput">
							        <select id="isInnuclear" name="isInnuclear" field="isInnuclear" title="是否参试"> 
											<option dataset="dsIsInnuclear"></option>
									</select></td>
						<!--     <td class="FieldLabel" nowrap="nowrap">备注：</td>
							<td class="FieldInput"><input type="text"  id="note" class="TextEditor" title="备注"  /></td> -->
							<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
							<td class="FieldInput">
									<input type="text"  id="illnessObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
									<input type="hidden" name="illnessObjectType"  id="illnessObjectType" class="TextEditor"/>
							</td>
							<td><button onclick="reset()">重 置</button> </td>
						 </tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<!-- 参战查询条件 -->
<next:Panel name="warform" id="warform" hidden="true" width="100%" border="0" autoScroll="true"
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
				<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
				<td class="FieldInput"><input type="hidden" id="warDomicileCode" />
				<input type="text" id="warDomicileName" class="TextEditor" title="所属机构"
					onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap>姓名：</td>
				<td class="FieldInput"><input type="text" id="warName"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap>身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="warIdCard"
					class="TextEditor" title="身份证件号码" /></td>
				
				<td class="FieldLabel" nowrap>户籍类别：</td>
				<td class="FieldInput"><select id="warDomicileType"
					field="domicileType" title="户籍类别">
					<option dataset="DomicileDataset"></option>
				</select></td>
			</tr>
			<tr>
				
				
				<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
				<td class="FieldInput"><select id="warObjectState"
					name="warObjectState" field="objectState" title="优抚对象状态">
					<option dataset="ObjectStateDataset"></option>
				</select></td>
				
				<td class="FieldLabel" nowrap="nowrap">参战类别代码：</td>
				<td class="FieldInput"><select id="warTypeCode"
					name="warTypeCode" field="warTypeCode" title="参战类别代码">
					<option dataset="warTypeCodeDataset"></option>
				</select></td>
                <td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td class="FieldInput">
						<input type="text"  id="warObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
						<input type="hidden" name="warObjectType"  id="warObjectType" class="TextEditor"/>
				</td>
				<td colspan="2" align="center"><button onclick="query()">查 询</button>&nbsp;<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
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
				<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
				<td class="FieldInput"><input type="hidden" id="testDomicileCode" />
				<input type="text" id="testDomicileName" class="TextEditor" title="所属机构"
					onclick="forHelp()" /></td>
				<td class="FieldLabel" nowrap>姓名：</td>
				<td class="FieldInput"><input type="text" id="testName"
					class="TextEditor" title="姓名" /></td>
				<td class="FieldLabel" nowrap>身份证件号码：</td>
				<td class="FieldInput"><input type="text" id="testIdCard"
					class="TextEditor" title="身份证件号码" /></td>
				
				<td class="FieldLabel" nowrap>户籍类别：</td>
				<td class="FieldInput"><select name="testDomicileType"
					field="domicileType" title="户籍类别">
					<option dataset="DomicileDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
				<td class="FieldInput"><select id="warStateCode"
					 field="warStateCode" title="优抚对象状态">
					<option dataset="ObjectStateDataset"></option>
				</select></td>

				<td class="FieldLabel" nowrap>残疾等级：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="disabilityLevelCode" field="disabilityLevelCode" title="残疾等级">
					<option dataset="DisabilityLevelDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
				<td class="FieldInput">
						<input type="text"  id="testObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
						<input type="hidden" name="testObjectType"  id="testObjectType" class="TextEditor"/>
				</td>
				<td colspan="2" align="center"><button onclick="query()">查 询</button>&nbsp;
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<!-- 60周岁以上农村籍退役军人 -->
<next:Panel  name="countretiredsoldierform" id="countretiredsoldierform" hidden="true" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
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
				                <td class="FieldLabel" nowrap="nowrap">所属机关：</td>
								<td class="FieldInput"><input type="text"  id="soldierDomicileName" class="TextEditor" title="所属机关" onclick="forHelp()" readonly="readonly"/>
								<input type="hidden"  id="soldierDomicileCode" class="TextEditor" title="所属机关"/></td>
				                <td class="FieldLabel" nowrap>姓名：</td>
				                <td class="FieldInput"><input type="text" id="soldierName" class="TextEditor" title="姓名" /></td>
				                <td class="FieldLabel" nowrap>身份证件号码：</td>
				                <td class="FieldInput"><input type="text" id="soldierIdCard" class="TextEditor" title="身份证件号码" /></td>
				
				                <td class="FieldLabel" nowrap>户籍类别：</td>
				                <td class="FieldInput">
				                    <select name="soldierDomicileType" field="domicileType" title="户籍类别">
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
							<!-- 	<td class="FieldLabel" nowrap>备注：</td>
							    <td class="FieldInput"><input type="text"  id="note" class="TextEditor" title="备注" /></td> -->
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
										<input type="text"  id="soldierObjectTypeName" class="TextEditor" title="优抚对象类别"  readonly="readonly" onclick="forHelpOT()"/>
										<input type="hidden" name="soldierObjectType"  id="soldierObjectType" class="TextEditor"/>
								</td>
								<td align="center" colspan="2">
								    <button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DOMICILE_NAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="OBJECT_STATE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="OBJECT_TYPE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsBptObject"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 伤残 -->
<next:GridPanel id="disbilityGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true"  dataset="BptPeopleDisabilityDataSet" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	   <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DICNAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="DISABILITY_TYPE_CODE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="disabilityLevelCode" header="伤残等级" field="DISABILITY_LEVEL_CODE" width="60" dataset="DisabilityLevelDataset">
			<next:TextField  />
		</next:Column>
		<next:Column id="disabilityCaseCode" header="伤残性质" field="DISABILITY_CASE_CODE" width="90" dataset="DisabilityCaseDataset">
			<next:TextField  />
		</next:Column>
		<next:Column id="disabilityGenusCode" header="伤残属别" field="DISABILITY_GENUS_CODE" width="60" dataset="DisabilityGenusDataset">
			<next:TextField  />
		</next:Column>
		<next:Column id="disabilityWarCode" header="伤残时期" field="DISABILITY_WAR_CODE" width="90" dataset="BptWarDataset">
			<next:TextField  />
		</next:Column>		
		<next:Column id="disabilityNo" header="证书编号" field="DISABILITY_NO" width="90">
			<next:TextField  />
		</next:Column>	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BptPeopleDisabilityDataSet"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 三属 -->
<next:GridPanel id="depentGridPanel" name="basicInfoGridPanel" width="100%" autoScroll="false" height="100%" stripeRows="true" dataset="DependantDataset" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DICNAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="DEPENDANT_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="DEPENDANT_TYPE_CODE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="lezswName" header="烈士姓名" field="LEZSW_NAME" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="lezswApproveDate" header="烈士批准时间" field="LEZSW_APPROVE_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="dependantNo" header="定期抚恤证编号" field="DEPENDANT_NO" width="120">
			<next:TextField  />
		</next:Column>		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="DependantDataset"/>
	</next:BottomBar>
</next:GridPanel>

<!-- 在乡(在乡复员军人)-->
<next:GridPanel id="demobilizedGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true"  dataset="demobilizedDataSet" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DOMICILE_NAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="DEMOBILIZED_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="telMobile" header="属于时期" field="BELONGDATE" width="90" dataset="warDs">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="是否参加抗美援朝" field="IS_KOREANWAR" width="103" dataset="dsIskoeanwar">
			<next:TextField  />
		</next:Column>
		
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="demobilizedDataSet"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 在乡(带病回乡)-->
<next:GridPanel id="demobilizeInelldGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true"  dataset="dsDemobilizeInelld" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DOMICILE_NAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="DEMOBILIZED_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="telMobile" header="是否参战" field="IS_WAR" width="60" dataset="dsIsWar">
			<next:TextField  />
		</next:Column>
		<next:Column id="telMobile" header="是否涉核" field="IS_INNUCLEAR" width="60" dataset="dsIsInnuclear">
			<next:TextField  />
		</next:Column>		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dsDemobilizeInelld"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 参战-->
<next:GridPanel id="warGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true" dataset="dataSetWar" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_NAME" header="所属行政区划" field="DICNAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="WAR_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="asdpNo" header="退伍证号" field="ASDP_NO" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="forcesNo" header="原部队代号" field="FORCES_NO"
			width="140">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="warTypeCode" header="参战类别代码" field="WAR_TYPE_CODE" width="150" dataset="warTypeCodeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dataSetWar"/>
	</next:BottomBar>
</next:GridPanel>
<!--参试-->
<next:GridPanel id="testedGridPanel" name="basicInfoGridPanel" width="100%" height="100%" autoScroll="false" stripeRows="true" dataset="dataSetTested" title="优抚对象基本信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="DOMICILE_NAME" header="所属行政区划" field="DICNAME" width="140">
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
		<next:Column id="objectState" header="优抚对象状态" field="WAR_STATE_CODE" width="115" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="forcesNo" header="原部队代号" field="FORCES_NO" width="150">
			<next:TextField />
		</next:Column>
        <next:Column id="testedType" header="参试类别" field="TESTED_TYPE" width="150" dataset="dsTest">
			<next:TextField />
		</next:Column>
        <next:Column id="disabilityLevelCode" header="残疾等级" field="DISABILITY_LEVEL_CODE" width="90" dataset="DisabilityLevelDataset">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dataSetTested"/>
	</next:BottomBar>
</next:GridPanel>
<!-- 60周岁以上农村籍退役军人 -->
<next:GridPanel id="countretiredsoldierGridPanel" name="basicInfoGridPanel" width="100%" autoScroll="false" stripeRows="true" height="100%"  autoScroll="true" dataset="countretiredSoldierDataSet" notSelectFirstRow="true" title="优抚对象基本信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="commit"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="no" handler="cancel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    
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
		<next:Column id="NOTE" header="备注" field="NOTE" width="90">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="countretiredSoldierDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>
