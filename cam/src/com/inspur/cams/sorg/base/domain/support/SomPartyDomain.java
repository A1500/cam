package com.inspur.cams.sorg.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomPartyDao;
import com.inspur.cams.sorg.base.data.SomParty;
import com.inspur.cams.sorg.base.domain.ISomPartyDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public class SomPartyDomain implements ISomPartyDomain{
	
	@Reference
	private ISomPartyDao somPartyDao;
	/**
	 * 查询党建信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		
		return somPartyDao.query(pset);
	}
	/**
	 * 增加党建信息
	 * @param somParty
	 */
	public void insert(SomParty somParty) {
		somPartyDao.insert(somParty);
		
	}
	/**
	 * 修改党建信息
	 * @param somParty
	 */
	public void update(SomParty somParty) {
		somPartyDao.update(somParty);
	}

}
