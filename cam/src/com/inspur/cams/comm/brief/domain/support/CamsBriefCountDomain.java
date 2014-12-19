package com.inspur.cams.comm.brief.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.brief.dao.ICamsBriefCountDao;
import com.inspur.cams.comm.brief.data.CamsBriefCount;
import com.inspur.cams.comm.brief.domain.ICamsBriefCountDomain;


/**
 * 快报简报数量表domain
 * @author 
 * @date 2014-03-04
 */
public class CamsBriefCountDomain implements ICamsBriefCountDomain {

	@Reference
	private ICamsBriefCountDao camsBriefCountDao;

	/**
	 * 查询 快报简报数量表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return camsBriefCountDao.query(pset);
	}

	/**
	 * 获取 快报简报数量表
	 * @param pset
	 * @return
	 */
	public CamsBriefCount get(String countId) {
		return camsBriefCountDao.get(countId);
	}

	/**
	 * 增加 快报简报数量表
	 * @param camsBriefCount
	 */
	public void insert(CamsBriefCount camsBriefCount) {
		camsBriefCountDao.insert(camsBriefCount);
	}
	
	/**
	 * 修改 快报简报数量表
	 * @param camsBriefCount
	 */
	public void update(CamsBriefCount camsBriefCount) {
		camsBriefCountDao.update(camsBriefCount);
	}
	
	/**
	 * 删除 快报简报数量表
	 * @param countId
	 */
	public void delete(String countId) {
		camsBriefCountDao.delete(countId);
	}

	public void saveBrief(CamsBriefCount camsBriefCount) {
		if(camsBriefCount.getState()==Record.STATE_MODIFIED){
			camsBriefCountDao.update(camsBriefCount);
		}else if(camsBriefCount.getState()==Record.STATE_DELETED){
			camsBriefCountDao.delete(camsBriefCount.getCountId());
		}else if(camsBriefCount.getState()==Record.STATE_NEW){
			camsBriefCountDao.insert(camsBriefCount);
		}
	}
}