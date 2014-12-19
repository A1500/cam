$(document).ready(function(){ 
//	renderSingleValue('main', '', svData, '0xD0F4F4|0x0600F7');
	setTimeout(initPage,500);
	alert(1);
	_tId = 'main';
	alert(1);
	_tData = pieData;
	alert(2);
	tRenderPieChart();
	alert(3);
	initCity();
	alert(4);
	initCountry();
	alert(5);
});
function initCity(){
	var ops={
			height:150,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			sortName: 'code',
			sortOrder: 'desc',
			remoteSort: false,
			url:'city_data.json',
			idField:'DIM',
			columns:[
			[ 

				{field:'地区',title:'地区',width:50},
				{field:'本月新增',title:'本月新增',width:60,align:'right'},
				{field:'本月停保',title:'本月停保',width:55,align:'right'},
				{field:'当前户数',title:'当前户数',width:55,align:'right'},
				{field:'当前人数',title:'当前人数',width:55,align:'right'},
				{field:'本年累计救助金额',title:'本年累计救助金',width:90,align:'right'},
				{field:'月均救助金',title:'月均户救助金',width:80,align:'right'},
				{field:'月均救助金',title:'月均人救助金',width:80,align:'right'}
		       
			]],
			pagination:false,
			rownumbers:true
		};
	$('#chengshi').datagrid(ops);
}
function initCountry(){
	var ops={
			height:150,
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
			columns:[[
			{title:'自主就业',colspan:3},
			{title:'政府指导自谋职业',colspan:3}
					
				],[
				{field:'本月新增',title:'人数',align:'right'},
				{field:'月均救助金',title:'经济补助金',align:'right'},
				{field:'月均救助金',title:'人均发放额',align:'right'},
				{field:'当前人数',title:'人数',align:'right'},
				{field:'本年累计救助金额',title:'经济补助金',align:'right'},
				{field:'月均救助金',title:'人均发放额',align:'right'}
			]],
			pagination:false,
			rownumbers:true
		};
	$('#nongcun').datagrid(ops);

}