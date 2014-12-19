package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptApplyCountrysideDao;
import com.inspur.cams.bpt.base.data.BptApplyCountryside;
import com.inspur.cams.bpt.base.domain.IBptApplyCountrysideDomain;

/**
 * 在乡复员军人【带病回乡退伍军人】审批
 */

public class BptApplyCountrysideDomain implements  IBptApplyCountrysideDomain{
	@Reference
	IBptApplyCountrysideDao bptApplyCountrysideDao;
	
	/**
	 * 添加一条审批记录
	 */
	public void insert(BptApplyCountryside bptApplyCountryside){
		bptApplyCountrysideDao.insert(bptApplyCountryside);
	}
	
	/**
	 * 更新一条审批记录
	 */
	public void update(BptApplyCountryside bptApplyCountryside){
		bptApplyCountrysideDao.update(bptApplyCountryside);
	}
	
	/**
	 * 查询审批记录
	 */
	public DataSet query(ParameterSet pset){
		return bptApplyCountrysideDao.query(pset);
	}
	
}