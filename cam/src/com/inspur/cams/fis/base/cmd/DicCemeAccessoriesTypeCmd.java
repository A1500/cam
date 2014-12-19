package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.data.DicCemeAccessoriesType;
import com.inspur.cams.fis.base.domain.IDicCemeAccessoriesTypeDomain;

/**
 * 公墓年检附件类型字典cmd
 * @author 
 * @date 2013-08-01
 */
public class DicCemeAccessoriesTypeCmd extends BaseAjaxCommand {

	private IDicCemeAccessoriesTypeDomain dicCemeAccessoriesTypeDomain = ScaComponentFactory
			.getService(IDicCemeAccessoriesTypeDomain.class, "dicCemeAccessoriesTypeDomain/dicCemeAccessoriesTypeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DicCemeAccessoriesType dicCemeAccessoriesType = (DicCemeAccessoriesType) record.toBean(DicCemeAccessoriesType.class);
		dicCemeAccessoriesTypeDomain.insert(dicCemeAccessoriesType);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DicCemeAccessoriesType dicCemeAccessoriesType = (DicCemeAccessoriesType) record.toBean(DicCemeAccessoriesType.class);
		dicCemeAccessoriesTypeDomain.update(dicCemeAccessoriesType);
	}
	
	// 删除
	public void delete() {
		String code = (String) getParameter("code");
		dicCemeAccessoriesTypeDomain.delete(code);
	}
	
}