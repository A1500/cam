<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
	<head>
		<title>选择环节和参与者</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
	<div style="display:none">
	<xml id="datasetDiv" >
		<datasets>
			<dataset id="activityDataset" pageSize="2" >
				<record>
					<field name="name"  type="string" ></field>
					<field name="actDefId"  type="string" ></field>
					<field name="actDefUniqueId"  type="string" ></field>
				</record>
			</dataset>
			<dataset id="participantDataset" pageSize="2" >
				<record>
					<field name="name"  type="string" ></field>
					<field name="actDefId"  type="string" ></field>
				</record>
			</dataset>
		</datasets>
	</xml>
	</div>
<body>
<div style="background-color: #D1DFF0">
	<button onclick="confirmSelect()" class="button">确定</button><button onclick="window.close()" class="button">取消</button>
</div>
<next:Panel name="column-div" bodyStyle="padding:0px">
	<next:ColumnLayout>		
			<next:GridPanel columnWidth=".55" id="activityGrid" notSelectFirstRow="true" name="activityGrid" stripeRows="true" height="100%" dataset="activityDataset" title="环节信息">
				<next:Columns>
					<next:RowNumberColumn width="20" />
					<next:Column header="名称" field="name" width="50%" />
					<next:Column header="环节定义Id" field="actDefId"  hidden="true" />
					<next:Column header="环节定义唯一Id" field="actDefUniqueId" hidden="true" />
					<next:Column header="流程定义唯一Id" field="procDefUniqueId" hidden="true" />						
				</next:Columns>
			</next:GridPanel>			
			<next:GridPanel columnWidth=".45" id="participantGrid" notSelectFirstRow="true" name="participantGrid" stripeRows="true" height="100%" dataset="participantDataset" title="参与者信息">
				<next:Columns>
					<next:RowNumberColumn width="20" />
					<next:CheckBoxColumn/>
					<next:Column header="参与者ID" field="organId" hidden="true" />					
					<next:Column header="参与者名称" field="organName" width="30%" />
				</next:Columns>
			</next:GridPanel>
	</next:ColumnLayout>
</next:Panel>
</body>
</html>
<script type="text/javascript">	
	//全局变量，调用页面传过来的参数列表
	var paramsArray=[];
	//全局变量，需要执行的，例如send，create等
	var method;
	//加载环节信息，methodName为cmd需要调用的方法名，paramsArray为查询参数的数组，结构为[["name",value],["name",value].....]
	function loadActivity()
	{
		var activityDataset=L5.DatasetMgr.lookup("activityDataset");
		//注册行单击处理函数，使得选择环节改变之后参与者相关信息也进行更新
		var activityGrid=L5.getCmp("activityGrid");	
	    activityGrid.getSelectionModel().on("rowselect",loadParticipant);			
	    addRecordToDataset(activityDataset);
	}

	//向dataset中增加数据
	function addRecordToDataset(dataset){
		var methodName=window.dialogArguments.methodName;
		var ret=window.dialogArguments.activityList;
		dataset.removeAll();
        for(i=0;i<ret.size();i++)
        {
	        //var j=i;和i=j;修复了因为不带该语句，每次for循环i增2的bug
	        var j=i;
	        var rcd=ret.get(i);
			dataset.newRecord({name:rcd.get("actDefName"),actDefId:rcd.get("actDefId"),actDefUniqueId:rcd.get("actDefUniqueId"),procDefUniqueId:""});
			i=j;
		}
	}

	//加载参与者信息
	function loadParticipant()
	{
		//获取选择的环节信息
		var activityGrid=L5.getCmp("activityGrid");
		var selected=activityGrid.getSelectionModel().getSelections();	
		//初始化command信息	
		var command=new L5.Command("org.loushang.workflow.tasklist.help.cmd.TaskHelpCmd"); 
		command.setParameter("curActDefUniqueId", selected[0].get("actDefUniqueId"));
		//如果查询条件不为空那么将查询条件设置到command中
		if(paramsArray!=undefined)
		{
			for(i=0;i<paramsArray.length;i++)
			{
				//paramsArray[i][0]为查询字段名，paramsArray[i][1]为查询字段值，分别对应之前数组元素中的name,value
				command.setParameter(paramsArray[i][0],paramsArray[i][1] );
			}
		}
		command.execute("getActivityDefEmployeeList");
		if (!command.error) {
	        var ret=command.getReturn("result");
	        var participantDataset=L5.DatasetMgr.lookup("participantDataset");
	        participantDataset.removeAll();
	        for(i=0;i<ret.size();i++)
	        {
		        var j=i;
		        var rcd=ret.get(i);
	        	participantDataset.newRecord({organId:rcd.get("organId"),organName:rcd.get("organName")});
				i=j;
			    }
		}else{
			alert(command.error);
		}
	}
	//页面加载完成后初始化信息，主要是加载环节信息
	function init(){	
		setParamsArray();
		loadActivity();
	}

	//获得commad需要执行的方法参数，该参数通过查询页面传入
	//返回值为数组，结构为：[["name",value],["name",value].....]
	function setParamsArray()
	{
		//从URL中获取相关参数，并设置到command中
		var urlString=document.URL.split("?")[1];
		var urlParams=urlString.split("&");
		for(i=0;i<urlParams.length;i++)
		{
			var temp=urlParams[i].split("=");
			paramsArray[i]=[temp[0],temp[1]];
		}
	}

	//选择完成返回值设定
	function confirmSelect(){
		//获得选中的环节信息
		var activityGrid=L5.getCmp("activityGrid");
		var selected=activityGrid.getSelectionModel().getSelections();
		if(selected.length<1)
		{
			alert("请选择要发送到的环节！");
			return ;
		}
		var actDefUniqueId=selected[0].get("actDefUniqueId");
		var actDefId=selected[0].get("actDefId");
		//获得选中的参与者信息
		var participantGrid=L5.getCmp("participantGrid");
		var selectedParticipants=participantGrid.getSelectionModel().getSelections();
		if(selectedParticipants.length<1)
		{
			alert("请选择至少一个参与者！");
			return;
		}
		//将参与者信息拼装成[{organId:value,organName:value},{organId:value,organName:value},....]的形式
		var participants="nextActOrgans:[";
		for(i=0;i<selectedParticipants.length;i++)
		{
			participants+="{organId:"+selectedParticipants[i].get("organId")+"#organName:"+selectedParticipants[i].get("organName")+"}";
			if(i!=selectedParticipants.length-1)
			{
				participants+="&";
			}
		}
		participants+="]";
		//将环节信息和参与者信息放到数组中并返回
		var returnValue=[actDefId,actDefUniqueId,participants];
		window.returnValue=returnValue;
		window.close();
	}
		
</script>
