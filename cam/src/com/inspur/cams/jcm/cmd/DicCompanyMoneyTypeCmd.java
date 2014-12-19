package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.DicCompanyMoneyType;
import com.inspur.cams.jcm.domain.IDicCompanyMoneyTypeDomain;

/**
 * 单位经费类别cmd
 * @author 
 * @date 2014-05-21
 */
public class DicCompanyMoneyTypeCmd extends BaseAjaxCommand {

	private IDicCompanyMoneyTypeDomain dicCompanyMoneyTypeDomain = ScaComponentFactory
			.getService(IDicCompanyMoneyTypeDomain.class, "dicCompanyMoneyTypeDomain/dicCompanyMoneyTypeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCompanyMoneyType dicCompanyMoneyType = (DicCompanyMoneyType) record.toBean(DicCompanyMoneyType.class);
		dicCompanyMoneyTypeDomain.insert(dicCompanyMoneyType);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCompanyMoneyType dicCompanyMoneyType = (DicCompanyMoneyType) record.toBean(DicCompanyMoneyType.class);
		dicCompanyMoneyTypeDomain.update(dicCompanyMoneyType);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicCompanyMoneyTypeDomain.delete(code);
	}
	
}