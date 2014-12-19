<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="../../../../comm/dicm/autoComplete.js"></script>
<link href="../../../../comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function borgNameFill(value,cellmeta,record,rowindex,colindex,dataset){
		var borgName = record.get('borgName');
		var nowBorgName = getBorgName(borgName);
		return nowBorgName;
}
function query(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	if(_$("ifHis")=="1"){
		//历史
		somOrganDataset.setParameter("BORG_NAME",_$("borgName"));
		doQuery(somOrganDataset);
	}else if(_$("ifHis")=="0"){
		var borgCode=_$("borgName");
		var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
		command.setParameter("borgCode", borgCode);

		command.afterExecute=function(){
			var changeCount=command.getReturn('changeCount');
			if(changeCount<1){
				//没有变更
				somOrganDataset.setParameter("BORG_NAME",borgCode);
				doQuery(somOrganDataset);
			}else{
				var somBorgChangeHis=L5.DatasetMgr.lookup('somBorgChangeHis');
				somBorgChangeHis.setParameter("borgCode", borgCode);
				somBorgChangeHis.on("load",loadSomBorgChangeHis);
				somBorgChangeHis.load();
			}
		};
		command.execute("queryCount");

	}else{
		doQuery(somOrganDataset);
	}
}
function loadSomBorgChangeHis(somBorgChangeHis){
	somBorgChangeHis.un("load",loadSomBorgChangeHis);
	var count=somBorgChangeHis.getCount();
	var borgCodes=somBorgChangeHis.getAt(count-1).get("changeAfterId");
	for(var i=0;i<count;i++){
		var record=somBorgChangeHis.getAt(i);
		if(borgCodes){
			borgCodes+=",";
		}
		borgCodes+=record.get("changeBeforeId");
	}
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("BORG_NAME@IN",borgCodes);
	doQuery(somOrganDataset);
}
function doQuery(somOrganDataset){
	somOrganDataset.setParameter("CN_NAME@like",_$("sorgName"));
	somOrganDataset.setParameter("SORG_CODE",_$("sorgCode"));
	somOrganDataset.setParameter("SORG_TYPE",_$("sorgType"));
	somOrganDataset.setParameter("IF_BRANCH",_$("ifBranch"));
	somOrganDataset.setParameter("BUS_SCOPE",_$("busScope"));
	somOrganDataset.setParameter("ORGAN_CODE",_$("organCode"));
	somOrganDataset.setParameter("LEGAL_PEOPLE@like",_$("legalPeople"));
	somOrganDataset.setParameter("to_number(REG_MON)@>",_$("regMon"));
	somOrganDataset.setParameter("MORG_AREA@IN",_$("morgNameCode"));
	somOrganDataset.setParameter("BORG_NAME",_$("borgName"));
	somOrganDataset.load();
}
function loadSomOrganDataset(somOrganDataset){
	somOrganDataset.un("load",loadSomOrganDataset);
	somOrganDataset.each(function(rec,idx){
		var borgName = rec.get('borgName');
		var nowBorgName = getBorgName(borgName);
		rec.set('nowBorgName', nowBorgName);
	});
	somOrganDataset.commitChanges();
}
function forDetail(value,cellmeta,record,rowindex,colindex,dataset){
	var sorgId=record.get('sorgId');
	var url='jsp/cams/sorg/query/som/baseQuery/somBaseQueryDetail.jsp?sorgId='+sorgId;
	return '<a href="javascript:L5.forward(\'' + url + '\')">' + value + '</a>';
}
// 选择管辖单位-无Ds赋值,查询使用
function selectOrganNoDs() {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath
			+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&radioType=checkbox&organCode="
			+ cantCode + "&organName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
	var revalue  = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		//是否本级
		var isSelf = list[5];
		//上级代码，本级的上级代码为实际代码
		var ups = list[3];
		//行政区划名称
		var name = list[1];
		//区划代码
		var code = list[0];
		document.getElementById("morgName").value = name;
		//为1的说明只选择了一个，并且为本级的将查询代码替换为ups。不为1的可能有两种情况，一是0，此时按原代码查询，二是多选此时ups为类似0，1，0格式，这种的程序暂不处理，按原code进行in处理
		if(isSelf=="1"){
			document.getElementById("morgNameCode").value = ups;
		}else{
			document.getElementById("morgNameCode").value = code;
		}
	}

}
function clearBorg(obj){
	if(obj.value == ""){
		$("borgName").value = "";
	}
}
/** *查询信息* **/
function getBorgName(borgCode){
	var publicCmd = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	publicCmd.setParameter("borgCode", borgCode);
	publicCmd.execute("nowBorgName");
	var getReturns = publicCmd.getReturn("borgName");
	if (getReturns == null || getReturns == "" || getReturns == undefined){
		return "";
	}else {
		return getReturns;
	}
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganWithAreaCodeSearchCondition" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 变更历史 -->
	<model:dataset id="somBorgChangeHis"  cmd="com.inspur.cams.sorg.base.cmd.SomBorgChangeQueryCmd" method="showChange">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorgChange"></model:record>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事）业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelectDic" cmd="com.inspur.cams.sorg.base.cmd.SomBorgQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorg"></model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel >
	<next:Panel >
		<next:Html>
			<form class="L5form">
			<fieldset><legend>查询条件</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:17%"><label>社会组织名称：</label></td>
					<td class="FieldInput" style="width:17%"><input style='width:90%'  type="text" id="sorgName"/></td>
					<td class="FieldLabel" style="width:17%"><label>登记证号：</label></td>
					<td class="FieldInput" style="width:17%"><input style='width:90%'  type="text" id="sorgCode" /></td>
					<td class="FieldLabel" style="width:17%"><label>社会组织种类：</label></td>
					<td class="FieldInput" style="width:17%"><select style='width:90%' id="sorgType"><option dataset="sorgTypeSelect"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>业务主管单位：</label></td>
					<td class="FieldInput">
					<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:75%" onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','-15')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
					<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        			<ul></ul>
     				</div>
     				<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
     				<input type="hidden" id="ifHis" /></td>
					</td>
					<td class="FieldLabel"><label>是否为分支：</label></td>
					<td class="FieldInput"><select style='width:90%' id="ifBranch"><option dataset="comm_yesorno"></option></select></td>
					<td class="FieldLabel"><label>所属行（事）业：</label></td>
					<td class="FieldInput"><select style='width:90%' id="busScope"><option dataset="busScopeSelect"></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>组织机构代码：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="organCode" /></td>
					<td class="FieldLabel"><label>法定代表人：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="legalPeople" /></td>
					<td class="FieldInput" colspan='2' align='center'>
						<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>资金数额大于：</label></td>
					<td class="FieldInput"><input style='width:90%'  type="text" id="regMon" /></td>
					<td class="FieldLabel"><label>登记管理机关行政区划：</label></td>
					<td class="FieldInput">
					<input style='width:90%'  type="text" id="morgName" onclick="selectOrganNoDs()"/>
					<input style='width:90%'  type="hidden" id="morgNameCode"/>
					</td>
					<td class="FieldInput" colspan='2' align='center'>
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel title="社会组织列表" id="organGrid" dataset="somOrganDataset" height="500"  >
		<next:Columns>
			<next:RowNumberColumn/>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column header="社会组织种类" field="sorgType" sortable="true" dataset="sorgTypeSelect" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否为分支" field="ifBranch" sortable="true" dataset="comm_yesorno" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会组织名称"  field="cnName" sortable="true" editable="false"width="20%" renderer="forDetail"><next:TextField></next:TextField></next:Column>
			<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
			<next:Column header="社会组织状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
			<next:Column header="所属行(事)业" field="busScope" sortable="true" editable="false" width="12%" dataset="busScopeSelect"><next:TextField /></next:Column>
			<next:Column header="业务主管单位" field="nowBorgName" sortable="false" editable="false"  width="20%" renderer="borgNameFill"><next:TextField /></next:Column>
			<next:Column header="登记管理机关" field="morgName" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="住所" field="residence" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="活动地域" field="actArea" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="法定代表人" field="legalPeople" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
			<next:Column header="社会组织电话" field="sorgPhone" sortable="true" editable="false" width="15%"><next:TextField />	</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somOrganDataset" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>