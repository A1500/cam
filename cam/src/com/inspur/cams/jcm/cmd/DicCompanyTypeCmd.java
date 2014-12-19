package com.inspur.cams.jcm.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.DicCompanyMoneyType;
import com.inspur.cams.jcm.data.DicCompanyType;
import com.inspur.cams.jcm.data.DicOfficeEquipmentType;
import com.inspur.cams.jcm.domain.IDicCompanyTypeDomain;

/**
 * 单位所属类别cmd
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyTypeCmd extends BaseAjaxCommand {

	private IDicCompanyTypeDomain dicCompanyTypeDomain = ScaComponentFactory
			.getService(IDicCompanyTypeDomain.class, "dicCompanyTypeDomain/dicCompanyTypeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCompanyType dicCompanyType = (DicCompanyType) record.toBean(DicCompanyType.class);
		dicCompanyTypeDomain.insert(dicCompanyType);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCompanyType dicCompanyType = (DicCompanyType) record.toBean(DicCompanyType.class);
		dicCompanyTypeDomain.update(dicCompanyType);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicCompanyTypeDomain.delete(code);
	}
	
	public void save(){
		List<DicOfficeEquipmentType> equList = new ArrayList<DicOfficeEquipmentType>();
		List<DicCompanyType> comList = new ArrayList<DicCompanyType>();
		List<DicCompanyMoneyType> monList = new ArrayList<DicCompanyMoneyType>();
		
		
		Record[] equRds = (Record[]) getParameter("equRds");
		Record[] comRds = (Record[]) getParameter("comRds");
		Record[] monRds = (Record[]) getParameter("monRds");
		if(equRds!=null){
			for(int i=0;i<equRds.length;i++){
				DicOfficeEquipmentType dicOfficeEquipmentType = (DicOfficeEquipmentType) equRds[i].toBean(DicOfficeEquipmentType.class);
				equList.add(dicOfficeEquipmentType);
			}
		}
		if(comRds!=null){
			for(int i=0;i<comRds.length;i++){
				DicCompanyType dicCompanyType = (DicCompanyType) comRds[i].toBean(DicCompanyType.class);
				comList.add(dicCompanyType);
			}
		}
		if(monRds!=null){
			for(int i=0;i<monRds.length;i++){
				DicCompanyMoneyType dicCompanyMoneyType = (DicCompanyMoneyType) monRds[i].toBean(DicCompanyMoneyType.class);
				monList.add(dicCompanyMoneyType);
			}
		}
		dicCompanyTypeDomain.save(equList,comList,monList);
	}
	
}