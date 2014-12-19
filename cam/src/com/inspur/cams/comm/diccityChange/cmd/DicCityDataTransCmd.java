package com.inspur.cams.comm.diccityChange.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.diccityChange.data.DicCityDataTrans;
import com.inspur.cams.comm.diccityChange.domain.IDicCityDataTransDomain;

/**
 * 数据迁移cmd
 * @author 
 * @date 2013-12-23
 */
public class DicCityDataTransCmd extends BaseAjaxCommand {

	private IDicCityDataTransDomain dicCityDataTransDomain = ScaComponentFactory
			.getService(IDicCityDataTransDomain.class, "dicCityDataTransDomain/dicCityDataTransDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCityDataTrans dicCityDataTrans = (DicCityDataTrans) record.toBean(DicCityDataTrans.class);
		dicCityDataTransDomain.insert(dicCityDataTrans);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCityDataTrans dicCityDataTrans = (DicCityDataTrans) record.toBean(DicCityDataTrans.class);
		dicCityDataTransDomain.update(dicCityDataTrans);
	}
	
	// 删除
	public void delete() {
		String transId = (String) getParameter("transId");
		dicCityDataTransDomain.delete(transId);
	}
	
}