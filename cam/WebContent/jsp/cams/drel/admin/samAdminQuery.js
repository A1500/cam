function init(){ 
	_tId = 'main';
	_tData = pieData;
	tRenderPieChart();
	initCity();
	initCountry();
//	initCountryFive();
//	initFisGrid();
	 initBptGrid();
	 initSorgGrid();
//	 initOrganGrid();
//	 initAnZhiGrid();
//	 initSorgChart();
//	 initMarryChart();
//	 initJZChart();
//	 initSHFLChart();
	 initMarryGrid();
	 initMarryYearChart();
	showMarry();
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
//优抚
function initBptGrid(){
	var ops={
			height:127,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'bpt_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:60}
			]],
			columns:[[
				{field:'伤残人员',title:'伤残人员',align:'right',width:85},
				{field:'三属',title:'三属',align:'right',width:85},
				{field:'在乡复员',title:'在乡复员',align:'right',width:85},
				{field:'带病回乡',title:'带病回乡',align:'right',width:85},
				{field:'参战',title:'参战',align:'right',width:85},
				{field:'参核',title:'参核',align:'right',width:85},
				{field:'老兵',title:'老兵',align:'right',width:85},
				{field:'老烈子',title:'老烈子',align:'right',width:85}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#bptDiv').datagrid(ops);

}
//社会组织
function initSorgGrid(){
	var ops={
			height:127,
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
	var ops={
			height:127,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			url:'marry_data.json',
			remoteSort: false,
			idField:'DIM',
				frozenColumns:[[	              
				{field:'地区',title:'地区',width:50}
			]],
			columns:[[
				{field:'结婚登记',title:'结婚登记',align:'right',width:85},
				{field:'离婚登记',title:'离婚登记',align:'right',width:85},
				{field:'开具证明',title:'开具证明',align:'right',width:85}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#marryGridDiv').datagrid(ops);
}

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

function showMarry(){
	var analysisDs = L5.DatasetMgr.lookup("analysisDs");
	analysisDs.on('load',function(){
		showLineChart(analysisDs,'MarryChart','SUM_DATE',[{name:"结婚总数",key:'MARRY_NUM'},{name:"离婚总数",key:'DIVORCE_NUM'}]);//图表展现
	});
	analysisDs.load();
}