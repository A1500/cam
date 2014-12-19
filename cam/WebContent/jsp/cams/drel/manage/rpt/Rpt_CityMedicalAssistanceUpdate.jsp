<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<%
	//String reportCorpOrganId = BspUtil.getCorpOrgan().getOrganId();//填报单位organId
	//String reportCorpOrganName = BspUtil.getCorpOrgan().getOrganName();//填报单位名称
	String reportOrganCode = BspUtil.getCorpOrgan().getOrganCode();//填报单位的organCode
	String provinceFlag = reportOrganCode.substring(reportOrganCode.length()-3);//省标志
	String cityFlag = reportOrganCode.substring(reportOrganCode.length()-2);//市标志
	
%>

<html>
	<head>
		<title>城市医疗救助工作情况修改</title>
		<next:ScriptManager/>
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
<next:Panel  name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form name="frm" style="width: 95%; height: 100%;" class="L5form" action="../../../../../ReportServer" target="Rpt_CityMedicalAssistanceQuery">
						<table  border="1" width="100%" >
							<input type="hidden" id="reportlet" name="reportlet">
							<input type="hidden" id="reportOrganCode" name="reportOrganCode">
							
							<input type="hidden" id="op" name="op">
							<input type="hidden"  id="reportcorp" name="reportcorp" />
							<input type="hidden"  id="id" name="id" />
							<tr>
								<td class="FieldLabel">年份:</td>
								<td class="FieldInput"><input type="text" id="reportyear" name="reportyear" format="Y"  class="TextEditor" title="年份"  /></td>	
								<td class="FieldLabel">季度:</td>
								<td class="FieldInput">
									<select id="reportquarter" name="reportquarter">
										<option value="1">第一季度</option>
										<option value="2">第二季度</option>
										<option value="3">第三季度</option>
										<option value="4">第四季度</option>
									</select>
								</td>
								<td  class="FieldLabel">所属单位：</td>
								<td class="FieldInput"><input type="text" id="reportCorpOrganName"  disabled="disabled"/>
								<input type="text" id="reportCorpOrganId" class="TextEditor" style="display:none"/>
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectDept(this)" />
								</td>
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<iframe id="Rpt_CityMedicalAssistanceQuery" name="Rpt_CityMedicalAssistanceQuery" width="100%" height="100%">
	
</iframe>
</body>
<script type="text/javascript">
var struId = '<%=BspUtil.getStruId()%>';
	var now = L5.server.getSysDate();//获取服务器的时间
	var provinceFlag = '<%=provinceFlag%>';
	var cityFlag = '<%=cityFlag %>';
	var reportOrganCode = '<%=reportOrganCode%>';
	//设置默认值
	function check() {
		var year = document.getElementById("reportyear").value;
		var reportcorp = document.getElementById("reportCorpOrganName").value;
		var nowYear = now.getYear();
		if(year == ""){
			L5.Msg.alert("提示", "请选择年份！");
			return;
		}		
		if(reportcorp == ""){
			L5.Msg.alert("提示", "请选择所属单位！");
			return;
		}
		return true;
	}
	function getParam(ElementId) {
		var value=document.getElementById(ElementId).value;
		if(value=="") value=undefined;
		return value;
	}
	//城市医疗救助工作情况查询
	function query() {
		if(!check()) {
			return;
		}
		var year = document.getElementById("reportyear").value+'';
		//校验年份格式
		if(_isNum(year)){
			if(year.length!=4){
				L5.Msg.alert("提示", "请输入正确的年份！");return;
			}
		}else{
			L5.Msg.alert("提示", "请输入正确的年份！");return;
		}
		var command = new L5.Command("com.inspur.cams.drel.rpt.cmd.RptCitymedicalassistanceCommand");
		command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTYEAR@=", getParam("reportyear"));
		command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTQUARTER@=", getParam("reportquarter"));
		command.setParameter("RPT_CITYMEDICALASSISTANCE.REPORTCORP@=", getParam("reportCorpOrganName"));
		//必须使用异步方式，然后转向必须在afterExecute回调函数中。
   		command.afterExecute = function(){
   			var msg = command.getReturn("message", false);
	   		if (msg==null || msg=="") {//
	   			if(provinceFlag == "000" && reportOrganCode!='371000') {//省级用户
					document.forms[0].reportlet.value = "/Rpt_CityMedicalAssistanceProvinceUpdate.cpt";
					document.forms[0].id.value = command.getReturn("id", false);
				}else if(cityFlag == "00") {//市级用户修改
					document.forms[0].reportlet.value = "/Rpt_CityMedicalAssistanceCityUpdate.cpt";
					document.forms[0].id.value = command.getReturn("id", false);
				}else {//其他
					L5.Msg.alert("提示", "市级以下没有修改业务！");
				}
				document.forms[0].op.value = "write";
				document.forms[0].submit();
	   			
	   		}else {
	   			L5.Msg.alert("提示", msg);
	   			return;
	   		}
			
		}
		command.execute("queryCitymedicalassistanceForupdate");
	}
	//选择单位
	function selectDept(){
	var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("reportCorpOrganId").value = list[0];
		document.getElementById("reportCorpOrganName").value = list[1];
		}
	}
	//校验是否数字
function _isNum(s){
	return /^[0-9]+$/.test(s);
}
</script>
</html>
