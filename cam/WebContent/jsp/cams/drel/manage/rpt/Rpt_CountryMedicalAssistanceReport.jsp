<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil" %>
<%@ page import="com.inspur.cams.comm.util.DateUtil" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<%
	String reportCorpOrganName = BspUtil.getCorpOrgan().getOrganName();//填报单位名称
	String reportOrganCode = BspUtil.getCorpOrgan().getOrganCode();//填报单位的organCode
	String cityFlag = reportOrganCode.substring(reportOrganCode.length()-2);//市标志
%>

<html>
	<head>
		<title>农村医疗救助工作情况填报</title>
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
					class="GroupBoxTitle">选择填报年份及季度 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form name="frm" style="width: 95%; height: 100%;" class="L5form" action="../../../../../ReportServer" target="Rpt_CountryMedicalAssistanceReport">
						<table  border="1" width="100%" >
							<input type="hidden" id="reportlet" name="reportlet">
							<input type="hidden" id="op" name="op">
							<input type="hidden" id="reportCorpOrganId" name="reportCorpOrganId">
							<input type="hidden" id="reporterOrganId" name="reporterOrganId">
							<input type="hidden" id="reportTime" name="reportTime">
							<input type="hidden" id="reportOrganCode" name="reportOrganCode">
							<input type="hidden"  id="reportcorp" name="reportcorp" />
							<tr>
								<td class="FieldLabel">年份:</td>
								<td class="FieldInput"><input type="text"  id="reportyear" format="Y"  class="TextEditor" title="年份"  /></td>	
								<td class="FieldLabel">季度:</td>
								<td class="FieldInput">
									<select id="reportquarter" name="reportquarter">
										<option value="1">第一季度</option>
										<option value="2">第二季度</option>
										<option value="3">第三季度</option>
										<option value="4">第四季度</option>
									</select>
								</td>
								<td class="FieldLabel"><button onclick="query()">开始填报</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<iframe id="Rpt_CountryMedicalAssistanceReport" name="Rpt_CountryMedicalAssistanceReport" width="100%" height="100%">
	
</iframe>
</body>
<script type="text/javascript">
	var now = L5.server.getSysDate();//获取服务器的时间
	var cityFlag = '<%=cityFlag %>';

	//设置默认值
	function setDefault() {
		var year = document.getElementById("reportyear").value;
		var quarterO = document.getElementById("reportquarter");
		var quarter = quarterO.options[quarterO.selectedIndex].value;
		var reportcorp = document.getElementById("reportcorp").value;
		var nowYear = now.getYear();
		if(year == ""){
			document.getElementById("reportyear").value = nowYear;
		}
		if(quarter == ""){
			document.getElementById("reportquarter").value = "1";
		}
		if(reportcorp == ""){
			document.getElementById("reportcorp").value = '<%=reportCorpOrganName%>';
		}
	}
	function getParam(ElementId) {
		var value=document.getElementById(ElementId).value;
		if(value=="") value=undefined;
		return value;
	}
	
	//农村医疗救助工作情况查询
	function query() {
		setDefault();
		var year = document.getElementById("reportyear").value+'';
		//校验年份格式
		if(_isNum(year)){
			if(year.length!=4){
				L5.Msg.alert("提示", "请输入正确的年份！");return;
			}
		}else{
			L5.Msg.alert("提示", "请输入正确的年份！");return;
		}
		var quarterO = document.getElementById("reportquarter");
		var quarter = quarterO.options[quarterO.selectedIndex].value;
		var command = new L5.Command("com.inspur.cams.drel.rpt.cmd.RptCountrymedicalassistanceCommand");
		command.setParameter("RPT_COUNTRYMEDICALASSISTANCE.REPORTYEAR@=", getParam("reportyear"));
		command.setParameter("RPT_COUNTRYMEDICALASSISTANCE.REPORTQUARTER@=", getParam("reportquarter"));
		command.setParameter("RPT_COUNTRYMEDICALASSISTANCE.REPORTCORP@=", getParam("reportcorp"));
   		command.afterExecute = function(){
   			var msg = command.getReturn("message", false);
	   		if (msg==null || msg=="") {
	   			//增加
				var data = new L5.Map();
				data.put("year", document.getElementById("reportyear").value);
				data.put("quarter", quarter);
	       		var url = "jsp/cams/drel/manage/rpt/Rpt_CountryMedicalAssistanceReportInsert.jsp";
	       		var text = "农村医疗救助工作情况填报";
	        	L5.forward(url, text, data);
			}else{
				//修改
				if(msg == "已上报的数据不能再进行修改！") {
					L5.Msg.alert("提示", "已上报的数据不能再进行修改！");
				}else {
					var data = new L5.Map();
					data.put("year", document.getElementById("reportyear").value);
					data.put("quarter", quarter);
					data.put("id", command.getReturn("id", false));
					var url = "jsp/cams/drel/manage/rpt/Rpt_CountryMedicalAssistanceReportUpdate.jsp";
		       		var text = "农村医疗救助工作情况填报";
		        	L5.forward(url, text, data);
				}
			}
		}
		command.execute("queryCountrymedicalassistance");
	}
	//校验是否数字
function _isNum(s){
	return /^[0-9]+$/.test(s);
}	
</script>
</html>
