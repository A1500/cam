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
		if(type == "51") {//参战人员
			url = "warSelect.jsp";
		} else if(type == "61") {//参试人员
			url = "testedSelect.jsp";
		}
		document.getElementById("warSelect").src=url;
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
								   		<option value="51">参战人员</option>
								   		<option value="61">参试人员</option>
		   							</select>
						 			</td>
						</tr>		
						</table>
					</form>
				</div>
				</fieldset>
	 </next:Html>
</next:Panel> 
<next:Panel title="参战人员" id="pageTab"  width="100%"   autoScroll="true"    height="100%"> 
 	<next:Html>
		   <iframe id="warSelect" src=""
				frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	 	   </iframe>
	 </next:Html>
</next:Panel>   
</body>
</html>
