var svColor = "1|174";
var pieData = value = "<pieSource> </pieSource>";
function init(){ 
	var cityMapDataSet = L5.DatasetMgr.lookup("cityMapDataSet");
	cityMapDataSet.load();
	cityMapDataSet.on("load",function(){
		pieData = value = "<pieSource> ";
		cityMapDataSet.each(function(record,index){
		pieData+="<root key=\""+record.get("NAME")+"\">"
		+ "<node field=\"结婚\" value=\""+record.get("MARRY_NUM")+"\" />"
		+" <node field=\"离婚\" value=\""+record.get("DIVORCE_NUM")+"\" />"
		+ "</root>"
		});
		pieData+="</pieSource>";
		_tId = 'main';
		_tData = pieData;
		tRenderPieChart();
	});
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.load();
	analysisDs.on('load',function(){
		showLineChart(analysisDs,'MarryChart','SUM_DATE',[{name:"结婚总数",key:'MARRY_NUM'},{name:"离婚总数",key:'DIVORCE_NUM'}]);//图表展现
	});
//	initFis();
//	initBptGrid();
//	initCity();
//	initCountry();
	
//	initCountryFive();
//	initFisGrid();
//	initSorgGrid();
//	 initOrganGrid();
//	 initAnZhiGrid();
//	 initSorgChart();
//	 initMarryChart();
//	 initJZChart();
//	 initSHFLChart();
	initMarryGrid();
	initMarryDeptGrid();
	//initMarryYearChart();
	
}
function showMarryDetail(){
	var data=null;
	var url='jsp/cams/adm/marry/marry.jsp';
	var text = '婚姻数据分析';
	L5.forward(url,text,data);
	
}
//城市低保
function initCity(){
	var ops={
			height:127,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			remoteSort: false,
			url:'city_data.json',
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:50}
			]],
			columns:[
			[ 
				{field:'本月新增',title:'本月新增',width:60,align:'right'},
				{field:'本月停保',title:'本月停保',width:55,align:'right'},
				{field:'当前户数',title:'当前户数',width:55,align:'right'},
				{field:'当前人数',title:'当前人数',width:55,align:'right'},
				{field:'本年累计救助金额',title:'本年累计救助金',width:90,align:'right'},
				{field:'人均支出',title:'月均户救助金',width:80,align:'right'},
				{field:'平均保障标准',title:'月均人救助金',width:80,align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#chengshi').datagrid(ops);
}
//农村低保
function initCountry(){
	var ops={
			height:127,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'country_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:50}
			]],
			columns:[
			[ 
				{field:'本月新增',title:'本月新增',width:60,align:'right'},
				{field:'本月停保',title:'本月停保',width:55,align:'right'},
				{field:'当前户数',title:'当前户数',width:55,align:'right'},
				{field:'当前人数',title:'当前人数',width:55,align:'right'},
				{field:'本年累计救助金额',title:'本年累计救助金',width:90,align:'right'},
				{field:'人均支出',title:'月均户救助金',width:80,align:'right'},
				{field:'平均保障标准',title:'月均人救助金',width:80,align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#nongcun').datagrid(ops);

}
//农村五保
function initCountryFive(){
	var ops={
			height:395,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'countryfive_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:50}
			]],
			columns:[
			[ 
				{field:'本月新增',title:'本月新增',width:60,align:'right'},
				{field:'本月停保',title:'本月停保',width:55,align:'right'},
				{field:'当前户数',title:'当前户数',width:55,align:'right'},
				{field:'当前人数',title:'当前人数',width:55,align:'right'},
				{field:'本年累计救助金额',title:'本年累计救助金',width:90,align:'right'},
				{field:'人均支出',title:'月均户救助金',width:80,align:'right'},
				{field:'平均保障标准',title:'月均人救助金',width:80,align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#nongcunFive').datagrid(ops);
}

//社会组织
function initSorgGrid(){
	var ops={
			height:347,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'sorg_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:60}
			]],
			columns:[[
				{field:'社团',title:'社团',align:'right',width:85},
				{field:'民非',title:'民非',align:'right',width:85},
				{field:'基金会',title:'基金会',align:'right',width:85}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#sorgGridDiv').datagrid(ops);
	
}
//婚姻工作量
function initMarryGrid(){
	var ops = {
			height : 500,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			sortName : 'code',
			sortOrder : 'desc',
			loader : dcLoader,
			url : '/command/ajax/com.inspur.cams.adm.marry.cmd.AdmMarryQueryCmd/queryMarry',
			remoteSort : false,
			idField : 'DIM',
			frozenColumns : [[{
						field : 'NAME',
						title : '地区',
						width : 145,
						align : 'center'
					}]],	
			columns : [[{
						field : 'MARRY_NUM',
						title : '结婚数',
						width : 220,
						align : 'center'
					}, {
						field : 'DIVORCE_NUM',
						title : '离婚数',
						width : 220,
						align : 'center'
					}]],
			pagination : false,
			rownumbers : true
		};
	$('#marryGridDiv').datagrid(ops);
}

function initMarryDeptGrid(){
	var ops = {
			height : 500,
			nowrap : true,
			autoRowHeight : false,
			striped : true,
			sortName : 'ORGAN_CODE',
			sortOrder : 'desc',
			loader : dcLoader,
			url : '/command/ajax/com.inspur.cams.adm.marry.cmd.AdmMarryQueryCmd/query',
			remoteSort : false,
			idField : 'DIM',
			frozenColumns : [[{
						field : 'ORGAN_NAME',
						title : '地区',
						width : 145,
						align : 'center'
					}]],	
			columns : [[{
						field : 'TOTAL_NUM',
						title : '登记机关总数',
						width : 220,
						align : 'center'
					}]],
			pagination : false,
			rownumbers : true
		};
	$('#marryDeptGridDiv').datagrid(ops);
}
/*
//殡葬
function initFisGrid(){
	var ops={
			height:272,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'fis_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:50}
			]],
			columns:[[
				{field:'火化数',title:'火化数',align:'right'},
				{field:'安葬数',title:'安葬数',align:'right'},
				{field:'安放数',title:'安放数',align:'right'},
				{field:'火化率',title:'火化率',align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#fisDiv').datagrid(ops);
}
*/
//行政区划
function initOrganGrid(){
	var ops={
			height:142,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'organ_data.json',
			remoteSort: false,
			idField:'行政区划',
				frozenColumns:[[	              
				{field:'行政区划',title:'行政区划',width:100}
			]],
			columns:[[
				{field:'山东省',title:'山东省',align:'right',width:80},
				{field:'济南市',title:'济南市',align:'right',width:80},
				{field:'青岛市',title:'青岛市',align:'right',width:80},
				{field:'淄博市',title:'淄博市',align:'right',width:80},
				{field:'枣庄市',title:'枣庄市',align:'right',width:80},
				{field:'东营市',title:'东营市',align:'right',width:80},
				{field:'烟台市',title:'烟台市',align:'right',width:80},
				{field:'潍坊市',title:'潍坊市',align:'right',width:80},
				{field:'济宁市',title:'济宁市',align:'right',width:80},
				{field:'泰安市',title:'泰安市',align:'right',width:80},
				{field:'威海市',title:'威海市',align:'right',width:80},
				{field:'日照市',title:'日照市',align:'right',width:80},
				{field:'莱芜市',title:'莱芜市',align:'right',width:80},
				{field:'临沂市',title:'临沂市',align:'right',width:80},
				{field:'德州市',title:'德州市',align:'right',width:80},
				{field:'聊城市',title:'聊城市',align:'right',width:80},
				{field:'滨州市',title:'滨州市',align:'right',width:80},
				{field:'菏泽市',title:'菏泽市',align:'right',width:80}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#organDiv').datagrid(ops);

}


//安置
function initAnZhiGrid(){
	var ops={
			height:395,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'az_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:100}
			]],
			columns:[[
				{field:'退伍义务兵',title:'退伍义务兵',align:'right',width:80},
				{field:'转业、复员士官',title:'转业、复员士官',align:'right',width:100},
				{field:'复员干部',title:'复员干部',align:'right',width:80}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#anzhiDiv').datagrid(ops);

}
//殡葬
function initFis() {
	var ops = {
		height : 227,
		nowrap : true,
		autoRowHeight : false,
		striped : true,
		sortName : 'code',
		sortOrder : 'desc',
		loader : dcLoader,
		url : '/command/ajax/com.inspur.cams.fis.base.cmd.FisCremationInfoSumQueryCommand/queyAllSum',
		remoteSort : false,
		idField : 'DIM',
		frozenColumns : [[{
					field : 'ORGAN_NAME',
					title : '地区',
					width : 50
				}]],	
		columns : [[
				{
					title : '<font style="font-weight: bold;">殡仪馆</font>',
					colspan : 7
				}, {
					title : '<font style="font-weight: bold;">公墓</font>',
					colspan : 4
				}
		        ],[
				{
					field : 'B_NUMS',
					title : '单位数(个)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_PERSON',
					title : '职工人数(人)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATION_MACHINE',
					title : '火化炉数(台)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATIONS',
					title : '全年处理遗体数(具)',
					width : 120,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CREMATIONS_RATE',
					title : '火化率(％)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_EMPLACING',
					title : '穴位数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'B_CEMETERY',
					title : '安葬数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_NUMS',
					title : '单位数(个)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_PERSON',
					title : '职工人数(人)',
					width : 80,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_EMPLACING',
					title : '穴位数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}, {
					field : 'G_CEMETERY',
					title : '安葬数(穴)',
					width : 75,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				}]],
		pagination : false,
		rownumbers : true
	};
	$('#fisDiv').datagrid(ops);
	//$('#fisDiv').datagrid('load');//Grid列表数据加载
}
//优抚
function initBptGrid(){
	var ops={
			height:335,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			loader : dcLoader,
			url: '/command/ajax/com.inspur.cams.bpt.query.cmd.CollectQueryCmd/queryAllProvince',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'ORGAN_NAME',title:'地区',width:60}
			]],
			columns:[[
				{
					field : 'DISABILITY',
					title : '伤残人员',
					width : 85,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				},
				{
					field : 'DEPENDANT',
					title : '三属',
					width : 85,
					align : 'right',
					formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}
				},
				{field:'DEMOBILIED',title:'在乡复员',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}},
				{field:'DEMOBILIZEDILLNESS',title:'带病回乡',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}},
				{field:'WAR',title:'参战',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}},
				{field:'TESTED',title:'参核',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}},
				{field:'SOLDIER',title:'老兵',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}},
				{field:'MARTYR',title:'老烈子',align:'right',width:85,formatter:function(value,rec){
						if(value==0)
							return '';
						return value;
					}}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#bptDiv').datagrid(ops);
	//$('#bptDiv').datagrid('load');

}
//获取项目根路径
function getProjectName(){
	var curWwwPath=window.document.location.href;
	var pathName=window.document.location.pathname;
	var pos=curWwwPath.indexOf(pathName);
	var localhostPaht=curWwwPath.substring(0,pos);
	var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	return projectName;
}