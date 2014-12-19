package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptApplyDisabilityNoticeDao;
import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;

/**
 * @description:添加和查询伤残受理通知书的Domain层
 * @author 王宝才
 * @since:2011-05-18
 */

public class DisabilityNoticeDomain implements IDisabilityNoticeDomain{
	
	@Reference
	private IBptApplyDisabilityNoticeDao bptApplyDisabilityNoticeDao;
	
	/**
	 * 添加伤残受理通知书
	 */
	public void insert(BptApplyDisabilityNotice bptApplyDisabilityNotice) {
		bptApplyDisabilityNoticeDao.insert(bptApplyDisabilityNotice);
	}
	
	/**
	 * 更新
	 */
	public void update(BptApplyDisabilityNotice bptApplyDisabilityNotice){
		bptApplyDisabilityNoticeDao.update(bptApplyDisabilityNotice);
	}

	/**
	 * 查询
	 */	
	public DataSet query(ParameterSet pset){
		return bptApplyDisabilityNoticeDao.query(pset);
	}
}