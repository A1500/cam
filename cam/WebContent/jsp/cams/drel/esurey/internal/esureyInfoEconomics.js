//社保信息
//添加
function addSocial(){
	var SamEsureySocialDS=L5.DatasetMgr.lookup("SamEsureySocialDS");
	var num=SamEsureySocialDS.getAllRecords().length;
	if(num==1){
		L5.Msg.alert("提示","社保信息只能添加一条！");
		return;
	}
	var record=SamEsureySocialDS.newRecord();
}
//删除
function deleteSocial(){
	var SamEsureySocialDS=L5.DatasetMgr.lookup("SamEsureySocialDS");
	var soPanel = L5.getCmp('social_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
				SamEsureySocialDS.remove(cells[0]);		
				}
				else return;
			});
}
//删除2
function deleteSocial2(){
	var SamEsureySocialDS=L5.DatasetMgr.lookup("SamEsureySocialDS");
	var soPanel = L5.getCmp('wsocial_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
				SamEsureySocialDS.remove(cells[0]);		
				}
				else return;
			});
}
//财产收入信息
//添加
function add_estate(){
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	var record=SamEsureyPeopleEstateDS.newRecord();
}

//删除
function delete_estate(){
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup("SamEsureyPeopleEstateDS");
	var soPanel = L5.getCmp('estate_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyPeopleEstateDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_estate2(){
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup("SamEsureyPeopleEstateDS");
	var soPanel = L5.getCmp('westate_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyPeopleEstateDS.remove(cells[0]);
				}
				else return ;
			});
}
//房管信息
//添加
function add_house(){
	var SamEsureyHouseDS=L5.DatasetMgr.lookup('SamEsureyHouseDS');
	var record=SamEsureyHouseDS.newRecord();
}
//删除
function delete_house(){
	var SamEsureyHouseDS=L5.DatasetMgr.lookup("SamEsureyHouseDS");
	var soPanel = L5.getCmp('house_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyHouseDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_house2(){
	var SamEsureyHouseDS=L5.DatasetMgr.lookup("SamEsureyHouseDS");
	var soPanel = L5.getCmp('whouse_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyHouseDS.remove(cells[0]);
				}
				else return ;
			});
}
//工商信息
//添加
function add_business(){
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup('SamEsureyBusinessDS');
	var record=SamEsureyBusinessDS.newRecord();
}
//删除
function delete_business(){
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup("SamEsureyBusinessDS");
	var soPanel = L5.getCmp('business_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyBusinessDS.remove(cells[0]);
					}
				else return ;
			});
}
//删除2
function delete_business2(){
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup("SamEsureyBusinessDS");
	var soPanel = L5.getCmp('wbusiness_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyBusinessDS.remove(cells[0]);
					}
				else return ;
			});
}
//车管信息
//添加
function add_car(){
	var SamEsureyCarDS=L5.DatasetMgr.lookup('SamEsureyCarDS');
	var record=SamEsureyCarDS.newRecord();
}
//删除
function delete_car(){
	var SamEsureyCarDS=L5.DatasetMgr.lookup("SamEsureyCarDS");
	var soPanel = L5.getCmp('car_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyCarDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_car2(){
	var SamEsureyCarDS=L5.DatasetMgr.lookup("SamEsureyCarDS");
	var soPanel = L5.getCmp('wcar_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyCarDS.remove(cells[0]);
				}
				else return ;
			});
}
//国税
//添加
function add_tax(){
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	if(SamEsureyTaxDS.getAllRecords().length==1){
		L5.Msg.alert("提示","国税信息只能有一条信息！");
		return;
	}
	var record=SamEsureyTaxDS.newRecord();
}
//删除
function delete_tax(){
	var SamEsureyTaxDS=L5.DatasetMgr.lookup("SamEsureyTaxDS");
	var soPanel = L5.getCmp('tax_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyTaxDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_tax22(){
	var SamEsureyTaxDS=L5.DatasetMgr.lookup("SamEsureyTaxDS");
	var soPanel = L5.getCmp('wtax_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyTaxDS.remove(cells[0]);
				}
				else return ;
			});
}
//地税
//添加
function add_tax2(){
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup('SamEsureyTaxDS2');
	if(SamEsureyTaxDS2.getAllRecords().length==1){
		L5.Msg.alert("提示","地税信息只能有一条信息！");
		return;
	}
	var record=SamEsureyTaxDS2.newRecord();
}
//删除
function delete_tax2(){
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup("SamEsureyTaxDS2");
	var soPanel = L5.getCmp('tax2_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyTaxDS2.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_tax22(){
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup("SamEsureyTaxDS2");
	var soPanel = L5.getCmp('wdtax_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
						SamEsureyTaxDS2.remove(cells[0]);
				}
				else return ;
			});
}
//公积金信息
//添加
function add_fund(){
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup('SamEsureyHousingFundDS');
	if(SamEsureyHousingFundDS.getAllRecords().length==1){
 		return;
	}
	var record=SamEsureyHousingFundDS.newRecord();
}
//删除
function delete_fund(){
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup("SamEsureyHousingFundDS");
	var soPanel = L5.getCmp('fund_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyHousingFundDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_fund2(){
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup("SamEsureyHousingFundDS");
	var soPanel = L5.getCmp('wfund_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyHousingFundDS.remove(cells[0]);
				}
				else return ;
			});
}
//人民银行信息
//添加
function add_bank(){
	var SamEsureyBankDS=L5.DatasetMgr.lookup('SamEsureyBankDS');
	if(SamEsureyBankDS.getAllRecords().length==1){
		L5.Msg.alert("提示","只能有一条银行信息！");
		return;
	}
	var record=SamEsureyBankDS.newRecord();
}
//删除
function delete_bank(){
	var SamEsureyBankDS=L5.DatasetMgr.lookup("SamEsureyBankDS");
	var soPanel = L5.getCmp('bank_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyBankDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_bank2(){
	var SamEsureyBankDS=L5.DatasetMgr.lookup("SamEsureyBankDS");
	var soPanel = L5.getCmp('wbank_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyBankDS.remove(cells[0]);
				}
				else return ;
			});
}
//证监信息
//添加
function add_securities(){
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup('SamEsureySecuritiesDS');
	if(SamEsureySecuritiesDS.getAllRecords().length==1){
		L5.Msg.alert("提示","证监信息只能有一条！");
		return;
	}
	var record=SamEsureySecuritiesDS.newRecord();
}
//删除
function delete_securities(){
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup("SamEsureySecuritiesDS");
	var soPanel = L5.getCmp('securities_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureySecuritiesDS.remove(cells[i]);
				}
				else return ;
			});
}
//删除2
function delete_securities2(){
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup("SamEsureySecuritiesDS");
	var soPanel = L5.getCmp('wsecurities_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureySecuritiesDS.remove(cells[i]);
				}
				else return ;
			});
}

//保监信息
//添加
function add_insurance(){
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup('SamEsureyInsuranceDS');
	var record=SamEsureyInsuranceDS.newRecord();
}
//删除
function delete_insurance(){
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup("SamEsureyInsuranceDS");
	var soPanel = L5.getCmp('insurance_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyInsuranceDS.remove(cells[0]);
				}
				else return ;
			});
}
//删除2
function delete_insurance2(){
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup("SamEsureyInsuranceDS");
	var soPanel = L5.getCmp('winsurance_grid');
	soPanel.stopEditing();
	var cells= soPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要删除该记录！",
			function(sta){
				if(sta=="yes"){
					SamEsureyInsuranceDS.remove(cells[0]);
				}
				else return ;
			});
}








