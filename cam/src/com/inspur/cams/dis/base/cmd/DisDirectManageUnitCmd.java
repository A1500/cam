package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisDirectManageUnit;
import com.inspur.cams.dis.base.domain.IDisDirectManageUnitDomain;

/**
 * 直管单位配置表cmd
 * @author 
 * @date 2012-11-19
 */
public class DisDirectManageUnitCmd extends BaseAjaxCommand {

	private IDisDirectManageUnitDomain disDirectManageUnitDomain = ScaComponentFactory
			.getService(IDisDirectManageUnitDomain.class, "disDirectManageUnitDomain/disDirectManageUnitDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		DisDirectManageUnit disDirectManageUnit = (DisDirectManageUnit) record.toBean(DisDirectManageUnit.class);
		disDirectManageUnitDomain.insert(disDirectManageUnit);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		DisDirectManageUnit disDirectManageUnit = (DisDirectManageUnit) record.toBean(DisDirectManageUnit.class);
		disDirectManageUnitDomain.update(disDirectManageUnit);
	}
	
	// 删除
	public void delete() {
		String rId = (String) getParameter("rId");
		disDirectManageUnitDomain.delete(rId);
	}
	
	/**
	 * 保存
	 */
	public void save(){
		ParameterSet pset = getParameterSet();
		disDirectManageUnitDomain.save(pset);
	}
	
	/**
	 * 删除（将inUse字段改为0，并为删除数据库）
	 */
	public void deleteInUse(){
		ParameterSet pset = getParameterSet();
		disDirectManageUnitDomain.deleteInUse(pset);
	}
	
}