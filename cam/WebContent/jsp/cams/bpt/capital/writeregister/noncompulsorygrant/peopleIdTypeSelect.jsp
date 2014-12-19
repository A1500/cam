<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>选择人员</title>
<next:ScriptManager/>
<script type="text/javascript">
	function init() {
		changeTab();
	}
	function changeTab() {
		var type = document.getElementById("objectType").value;
		var options = document.getElementById("objectType");
		var title = "";
		var url = "";
		for(var i=0;i<options.length;i++) {
			if(options[i].value == type) {
				title = options[i].text;
				break;
			}
		}
		if(type == "11") { //伤残人员
			url = L5.webPath + "/jsp/cams/bpt/capital/writeregister/disabilitygrant/peopleSelect.jsp";
		} else if(type == "21") {//三属人员
			url = L5.webPath + "/jsp/cams/bpt/capital/writeregister/depandentgrant/idCardSelect.jsp";
		} else if(type == "41") {//在乡复员军人
			url = L5.webPath + "/jsp/cams/bpt/capital/writeregister/demobilizedgrant/demobilizedSelect.jsp";
		} else if(type == "42") {//带病回乡退伍军人
			url = L5.webPath + "/jsp/cams/bpt/capital/writeregister/livingallowancegrant/demobilizedIllnessSelect.jsp";
		} 
		document.getElementById("disabilitySelect").src=url;
		L5.getCmp("pageTab").setTitle(title);
	}
</script>
</head>
<body>
<next:Panel width="100%" border="0" autoScroll="true" autoHeight="true" >
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">请选择</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table border="1" width="100%">
						<tr>		
								<td class="FieldLabel" width="20%" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<select id="objectType" style="width:180px;" onchange="changeTab()">
								   		<option value="11" selected="selected">伤残人员</option>
								   		<option value="21">三属人员</option>
								   		<option value="41">在乡复员军人</option>
								   		<option value="42">带病回乡退伍军人</option>
		   							</select>
						 			</td>
						</tr>		
						</table>
					</form>
				</div>
				</fieldset>
	 </next:Html>
</next:Panel> 
<next:Panel title="伤残人员" id="pageTab"  width="100%"   autoScroll="true"    height="100%"> 
 	<next:Html>
		   <iframe id="disabilitySelect" src=""
				frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	 	   </iframe>
	 </next:Html>
</next:Panel>   
</body>
</html>
