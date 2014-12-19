package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptStateChangeDao;
import com.inspur.cams.bpt.base.data.BptStateChange;
import com.inspur.cams.bpt.base.domain.IBptStateChangeDomain;

/**
 * 状态变更Doamin
 */
public class  BptStateChangeDomain implements IBptStateChangeDomain {
	@Reference
	IBptStateChangeDao bptStateChangeDao;
	
	/**
	 * 添加状态变更信息
	 */
	public void insertBptStateChange(BptStateChange bptStateChange){
		List<BptStateChange> list = new ArrayList<BptStateChange>();
		list.add(bptStateChange);
		bptStateChangeDao.save(list);
	}

	public void insert(BptStateChange bptStateChange) {
		bptStateChangeDao.insert(bptStateChange);
	}
	
	public void update(BptStateChange bptStateChange){
		
		bptStateChangeDao.updateStateChange(bptStateChange);
	}
	public void updateClass(BptStateChange bptStateChange){
		
		bptStateChangeDao.updateClass(bptStateChange);
	}
	/**
	 * 获取最新的变更前信息
	 * @return
	 */
	public String queryPreStateChange(String peopleId){
		return bptStateChangeDao.queryPreStateChange(peopleId);
	}
}